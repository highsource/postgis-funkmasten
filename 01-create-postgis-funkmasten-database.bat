createdb --username=postgres funkmasten
psql --username=postgres --dbname funkmasten -c "CREATE EXTENSION postgis;"