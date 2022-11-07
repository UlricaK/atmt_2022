#!/bin/bash
# -*- coding: utf-8 -*-

set -e

pwd=`dirname "$(readlink -f "$0")"`
base=$pwd/../..
src=fr
tgt=en
data=$base/data/$tgt-$src/

# change into base directory to ensure paths are valid
cd $base

# create preprocessed directory
mkdir -p $data/preprocessed/

# normalize and tokenize raw data
cat $data/raw/train.$src | perl moses_scripts/normalize-punctuation.perl -l $src | perl moses_scripts/tokenizer.perl -l $src -a -q > $data/preprocessed/train.$src.p
cat $data/raw/train.$tgt | perl moses_scripts/normalize-punctuation.perl -l $tgt | perl moses_scripts/tokenizer.perl -l $tgt -a -q > $data/preprocessed/train.$tgt.p

# train truecase models
perl moses_scripts/train-truecaser.perl --model $data/preprocessed/tm.$src --corpus $data/preprocessed/train.$src.p
perl moses_scripts/train-truecaser.perl --model $data/preprocessed/tm.$tgt --corpus $data/preprocessed/train.$tgt.p

# apply truecase models to splits
cat $data/preprocessed/train.$src.p | perl moses_scripts/truecase.perl --model $data/preprocessed/tm.$src > $data/preprocessed/train.$src 
cat $data/preprocessed/train.$tgt.p | perl moses_scripts/truecase.perl --model $data/preprocessed/tm.$tgt > $data/preprocessed/train.$tgt

# prepare remaining splits with learned models
for split in valid test tiny_train
do
    cat $data/raw/$split.$src | perl moses_scripts/normalize-punctuation.perl -l $src | perl moses_scripts/tokenizer.perl -l $src -a -q | perl moses_scripts/truecase.perl --model $data/preprocessed/tm.$src > $data/preprocessed/$split.$src
    cat $data/raw/$split.$tgt | perl moses_scripts/normalize-punctuation.perl -l $tgt | perl moses_scripts/tokenizer.perl -l $tgt -a -q | perl moses_scripts/truecase.perl --model $data/preprocessed/tm.$tgt > $data/preprocessed/$split.$tgt
done

# remove tmp files
rm $data/preprocessed/train.$src.p
rm $data/preprocessed/train.$tgt.p

# build bpe
subword-nmt learn-joint-bpe-and-vocab --input data/en-fr/preprocessed/train.en -s 10000 --output assignments/03/bpe/en.bpe --write-vocabulary assignments/03/bpe/dict.en.txt

subword-nmt learn-joint-bpe-and-vocab --input data/en-fr/preprocessed/train.fr -s 10000 --output assignments/03/bpe/fr.bpe --write-vocabulary assignments/03/bpe/dict.fr.txt

# apply bpe
subword-nmt apply-bpe -c assignments/03/bpe/en.bpe < data/en-fr/preprocessed/train.en > data/en-fr/bpe_processed/train.en
subword-nmt apply-bpe -c assignments/03/bpe/fr.bpe < data/en-fr/preprocessed/train.fr >  data/en-fr/bpe_processed/train.fr

subword-nmt apply-bpe -c assignments/03/bpe/en.bpe < data/en-fr/preprocessed/valid.en > data/en-fr/bpe_processed/valid.en
subword-nmt apply-bpe -c assignments/03/bpe/fr.bpe < data/en-fr/preprocessed/valid.fr > data/en-fr/bpe_processed/valid.fr

subword-nmt apply-bpe -c assignments/03/bpe/en.bpe < data/en-fr/preprocessed/test.en > data/en-fr/bpe_processed/test.en
subword-nmt apply-bpe -c assignments/03/bpe/fr.bpe < data/en-fr/preprocessed/test.fr > data/en-fr/bpe_processed/test.fr

subword-nmt apply-bpe -c assignments/03/bpe/en.bpe < data/en-fr/preprocessed/tiny_train.en > data/en-fr/bpe_processed/tiny_train.en
subword-nmt apply-bpe -c assignments/03/bpe/fr.bpe < data/en-fr/preprocessed/tiny_train.fr > data/en-fr/bpe_processed/tiny_train.fr

# preprocess all files for model training
python preprocess.py --target-lang en --source-lang fr --dest-dir data/en-fr/prepared/ --train-prefix data/en-fr/bpe_processed/train --valid-prefix data/en-fr/bpe_processed/valid --test-prefix data/en-fr/bpe_processed/test --tiny-train-prefix data/en-fr/bpe_processed/tiny_train --threshold-src 1 --threshold-tgt 1 --num-words-src 4000 --num-words-tgt 4000

echo "done!"