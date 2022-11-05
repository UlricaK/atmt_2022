import sentencepiece as spm
import re

SPACE_NORMALIZER = re.compile("\s+")

def word_tokenize(line):
    line = SPACE_NORMALIZER.sub(" ", line)
    line = line.strip()
    return line.split()

src_file = 'data/en-fr/raw/tiny_train.en'

print("# Preprocessing")
preprocessed = []
with open(src_file, 'r') as file:
    for line in file:
        preprocessed.append(word_tokenize(line))

print(preprocessed)