#!/usr/bin/env python3

import csv
import os
import random
import time

timestamp = int(time.time())

bzx = open('manifest/bats_bzx-symbols_traded.csv')

bzx = csv.reader(bzx)

bats_l = []

bats_l = [_[0] for _ in bzx]

bats_s = set(bats_l)
bats_l = list(bats_s)

for _ in bats_l:
    delay = random.randrange(1, 3, 1)
    time.sleep(delay)
    os.system('wget --user-agent="Mozilla/5.0" "https://www.google.com/finance/getprices?q={}&i=60&p=15d&f=d,c,h,l,o,v" -O {}-{}.csv'.format(_,_,timestamp))
print('Taskrunner is complete.')
