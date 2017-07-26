#!/bin/bash

# sets MySQL credentials
MYSQLUSER=root
MYSQLPASS=root

# sets database and table names
MYDATABASE=randomsurvey 
MYTABLE=tblSurveyQuestions

# places data in the MySQL secure directory
sudo cp ./tmp.csv /var/lib/mysql-files/
echo "Data copied to secure directory."

# creates database
echo "Creating database..."
mysql -u"$MYSQLUSER" -p"$MYSQLPASS" -e "CREATE DATABASE $MYDATABASE"
echo "Database created."

# creates table
echo "Creating table..."
mysql -u"$MYSQLUSER" -p"$MYSQLPASS" -e "CREATE TABLE $MYTABLE (ID VARCHAR(255), Date TIMESTAMP, NativeLang VARCHAR(255), NativeCountry VARCHAR(255), PresentCountry VARCHAR(255), PresentCountryYears NUMERIC(5,2), PresentLang VARCHAR(255)); ALTER TABLE $MYTABLE ADD PRIMARY KEY (ID);" $MYDATABASE
echo  "Table created."

# writes data from tmp.csv into database table
echo "Writing new data to $MYTABLE in database $MYDATABASE..."
mysql -u"$MYSQLUSER" -p"$MYSQLPASS" -e "LOAD DATA INFILE '/var/lib/mysql-files/tmp.csv' INTO TABLE $MYTABLE FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"';" $MYDATABASE
echo "Data written successfully."

# dumps current version of database into export file
mysqldump -u"$MYSQLUSER" -p"$MYSQLPASS" $MYDATABASE > `date --iso-8601`-$MYDATABASE.sql
echo "Survey data dumped to file `date --iso-8601`-$MYDATABASE.sql"

# removes /var/lib/mysql-files/tmp.csv
sudo rm /var/lib/mysql-files/tmp.csv