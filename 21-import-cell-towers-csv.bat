psql^
 --username=postgres^
 --dbname funkmasten^
 -f 21-import-cell-towers-csv.sql^
 --set=CELL_TOWERS_INPUT="'%cd%\cell_towers.csv'"
