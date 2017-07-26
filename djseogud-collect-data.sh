#!/bin/bash
GHUSERNAME="djseogud"
# 5 Survey Questions
 
echo "In which country were you born?"
read BORNCOUNTRY

echo "How old are you?"
read AGE

echo "Which country, that you haven't visited, do you want to visit the most?"
read VISITCOUNTRY

echo "What is your favorite ice cream flavor?"
read ICECREAM

echo "How many siblings do you have?"
read SIBLINGNO

# records current time and date
TIMESTAMP=`date --iso-8601=seconds`
 
# creates unique identifier
IDENTIFIER="`echo $RANDOM$RANDOM$RANDOM | sha256sum | sed 's/[^0-9a-fA-F]//g' | sed -e 's/^/0x/'`"

# writes data to temporary csv file
echo "$IDENTIFIER,$TIMESTAMP,$BORNCOUNTRY,$AGE,$VISITCOUNTRY,$ICECREAM,$SIBLINGNO" > ./tmp.csv

# reads data out to csv file
cat ./tmp.csv

# w0rites data to database
bash ./$GHUSERNAME-write-to-db.sh

# backs up data
cat ./tmp.csv >> data-backup.csv

# removes temp file
rm tmp.csv
