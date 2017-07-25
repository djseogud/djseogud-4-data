#!/bin/bash
GHUSERNAME="jdmar3"
# Survey questions
# What is your native language? 
echo "What is your native language?"
read NATIVELANG
# What country were you born in?
echo "What country were you born in?"
read NATIVECOUNTRY
# What country do you presently live in?
echo "What country do you presently live in?"
read PRESENTCOUNTRY
# How many years have you lived in the country where you presently live?
echo "How many years have you lived in the country where you presently live?"
read PRESENTCOUNTRYYEARS
# What language do you speak most of the time where you presently live?
echo "What language do you speak most of the time where you presently live?"
read PRESENTLANG
# get the current time/date
TIMESTAMP=`date --iso-8601=seconds`
# Create unique identifier
IDENTIFIER="`echo $RANDOM$RANDOM$RANDOM | sha256sum | sed 's/[^0-9a-fA-F]//g' | sed -e 's/^/0x/'`"
# Write data to tmp.csv
echo "$IDENTIFIER,$TIMESTAMP,$NATIVELANG,$NATIVECOUNTRY,$PRESENTCOUNTRY,$PRESENTCOUNTRYYEARS,$PRESENTLANG" > ./tmp.csv
# Read out the data in the CSV file
cat ./tmp.csv
# Write data to database
bash ./$GHUSERNAME-write-to-db.sh
# Back up data
cat ./tmp.csv >> data-backup.csv
# Remove temp file
rm tmp.csv
