import pickle
import itertools
import math
import numpy as np
import torch
import random

src_file = 'data/en-de/prepared/tiny_train.en'
tgt_file = 'data/en-de/prepared/tiny_train.de'
src_dataset = []
tgt_dataset = []

with open(src_file, 'rb') as f:
    src_dataset = pickle.load(f)
with open(tgt_file, 'rb') as f:
    tgt_dataset = pickle.load(f)

src = src_dataset
tgt = tgt_dataset
src_dataset = src_dataset.extend(tgt)
tgt_dataset = tgt_dataset.extend(tgt)

a = [1,2]
b = [3,4]
a.extend(b)
print(a)
# combined_src = []
# with open(src_file, 'rb') as f:
#     combined_src.extend(pickle.load(f))
# with open(tgt_file, 'rb') as f:
#     combined_src.extend(pickle.load(f))
# # print(combined_src[0])
#
# combined_tgt = []
# with open(tgt_file, 'rb') as f:
#     combined_tgt.extend(pickle.load(f))
# with open(tgt_file, 'rb') as f:
#     combined_tgt.extend(pickle.load(f))
# # print(combined_tgt)
#
# # print(len(combined_src))
# # print(len(combined_tgt))
# indexes = [i for i in range(20)]
# random.shuffle(indexes)
# print(indexes)

# dic = {'a':0,'b':1}
# for word in dic:
#     print(dic.keys())

