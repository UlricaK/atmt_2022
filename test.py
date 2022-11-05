# import sentencepiece as spm
# import re
#
# SPACE_NORMALIZER = re.compile("\s+")
#
# def word_tokenize(line):
#     line = SPACE_NORMALIZER.sub(" ", line)
#     line = line.strip()
#     return line.split()
#
# src_file = 'data/en-fr/raw/tiny_train.en'
#
# print("# Preprocessing")
# preprocessed = []
# with open(src_file, 'r') as file:
#     for line in file:
#         preprocessed.append(word_tokenize(line))
#
# print("# Train a joint BPE model with sentencepiece")
# train = '--input = iwslt2016/prepro/train --pad_id=0 --unk_id=1 \
#          --bos_id=2 --eos_id=3\
#          --model_prefix=iwslt2016/segmented/bpe --vocab_size={} \
#          --model_type=bpe'.format(hp.vocab_size)
# spm.SentencePieceTrainer.Train(train)
#
# print("# Load trained bpe model")
# sp = spm.SentencePieceProcessor()
# sp.Load("iwslt2016/segmented/bpe.model")
#
# print("# Segment")
# def _segment_and_write(sents, fname):
#     with open(fname,mode= "w",encoding="utf-8") as fout:
#         for sent in sents:
#             pieces = sp.EncodeAsPieces(sent)
#             fout.write(" ".join(pieces) + "\n")
#
