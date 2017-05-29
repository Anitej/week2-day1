#!/usr/bin/env bash

NEW_AGENT="Mozilla/5.0"
TIMESTAMP=$(date  +%s)

DL_BZX="http://www.bats.com/us/equities/market_statistics/symbols_traded/csv?mkt=bzx"
EP_BZX="bats_bzx-symbols_traded.csv"

wget --user-agent=$NEW_AGENT $DL_BZX -O $EP_BZX

sed -i '/^$/d' $EP_BZX
sed -i '1d' $EP_BZX

mkdir manifest

mv $EP_BZX manifest

python3 taskrunner.py &>> taskrunner.log

mkdir log
mkdir minute
mkdir market
mkdir symbol

mv *.csv symbol
mv symbol market
mv market minute
mv taskrunner.log log
