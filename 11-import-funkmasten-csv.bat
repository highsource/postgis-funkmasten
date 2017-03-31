psql^
 --username=postgres^
 --dbname funkmasten^
 -f 11-import-funkmasten-csv.sql^
 --set=FUNKMASTEN_INPUT="'%cd%\Alle_Funkmasten_BRD.csv'"
