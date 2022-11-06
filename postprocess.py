import re
f=open('assignments/03/baseline/translations.p.txt','r')
alllines=f.readlines()
f.close()
f=open('assignments/03/baseline/translations.p.txt','w+')
for eachline in alllines:
    a=re.sub('@@ ','',eachline)
    f.writelines(a)
f.close()