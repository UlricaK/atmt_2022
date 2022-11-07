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