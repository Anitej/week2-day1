#!/usr/bin/env bash

NEW_AGENT="Mozilla/5.0" #new agent is an abbrev. Mozzila is used as the browser to scrape. Fed to weget.
TIMESTAMP=$(date  +%s) #time of the current date in seconds format

DL_BZX="http://www.bats.com/us/equities/market_statistics/symbols_traded/csv?mkt=bzx" 
DL_BYX="http://www.bats.com/us/equities/market_statistics/symbols_traded/csv?mkt=byx"
DL_EDGA="http://www.bats.com/us/equities/market_statistics/symbols_traded/csv?mkt=edga"
DL_EDGX="http://www.bats.com/us/equities/market_statistics/symbols_traded/csv?mkt=edgx"
EP_BZX="bats_bzx-symbols_traded.csv"
EP_BYX="bats_byx-symbols_traded.csv"
EP_EDGA="bats_edga-symbols_traded.csv"
EP_EDGX="bats_edgx-symbols_traded.csv"

wget --user-agent=$NEW_AGENT $DL_BZX -O $EP_BZX # --user-agent is a switch. $NEW_AGENT is referring the browser. $DL_BZX -O $EP_BZX outputs from deep link to end point file as csv
wget --user-agent=$NEW_AGENT $DL_BYX -O $EP_BYX
wget --user-agent=$NEW_AGENT $DL_EDGA -O $EP_EDGA
wget --user-agent=$NEW_AGENT $DL_EDGX -O $EP_EDGX

sed -i '/^$/d' $EP_BZX #deletes whitespace
sed -i '/^$/d' $EP_BYX
sed -i '/^$/d' $EP_EDGA
sed -i '/^$/d' $EP_EDGX
sed -i '1d' $EP_BZX #delete the csv header (it says 'symbols')
sed -i '1d' $EP_BYX
sed -i '1d' $EP_EDGA
sed -i '1d' $EP_EDGX

mkdir manifest #creates directory manifest

mv $EP_BZX manifest #sends csv files to manifest
mv $EP_BYX manifest
mv $EP_EDGA manifest
mv $EP_EDGX manifest

python3 taskrunner.py &>> taskrunner.log

mkdir log
mkdir minute
mkdir market
mkdir symbol

mv *.csv symbol
mv symbol market
mv market minute
mv taskrunner.log log
