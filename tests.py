import pickle
import itertools
import math
import numpy as np
import torch
import random

src_file = 'data/en-de/prepared/tiny_train.en'
tgt_file = 'data/en-de/prepared/tiny_train.de'

combined_src = []
with open(src_file, 'rb') as f:
    combined_src.extend(pickle.load(f))
with open(tgt_file, 'rb') as f:
    combined_src.extend(pickle.load(f))
# print(combined_src[0])

combined_tgt = []
with open(tgt_file, 'rb') as f:
    combined_tgt.extend(pickle.load(f))
with open(tgt_file, 'rb') as f:
    combined_tgt.extend(pickle.load(f))
# print(combined_tgt)

# print(len(combined_src))
# print(len(combined_tgt))
indexes = [i for i in range(20)]
random.shuffle(indexes)
print(indexes)

# dic = {'a':0,'b':1}
# for word in dic:
#     print(dic.keys())

