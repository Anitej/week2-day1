#!/usr/bin/env python3

import csv
import os
import random
import time

timestamp = int(time.time())

bzx = open('manifest/bats_bzx-symbols_traded.csv')
byx = open('manifest/bats_byx-symbols_traded.csv')
edga = open('manifest/bats_edga-symbols_traded.csv')
edgx = open('manifest/bats_edgx-symbols_traded.csv')

bzx = csv.reader(bzx)
byx = csv.reader(byx)
edga = csv.reader(edga)
edgx = csv.reader(edgx)

bats_l = []

bats_l = [_[0] for _ in bzx]
bats_l = [_[0] for _ in byx]
bats_l = [_[0] for _ in edga]
bats_l = [_[0] for _ in edgx]

bats_s = set(bats_l)
bats_l = list(bats_s)

for _ in bats_l:
    delay = random.randrange(1, 3, 1)
    time.sleep(delay)
    os.system('wget --user-agent="Mozilla/5.0" "https://www.google.com/finance/getprices?q={}&i=60&p=15d&f=d,c,h,l,o,v" -O {}-{}.csv'.format(_,_,timestamp))
print('Taskrunner is complete.')
