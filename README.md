# postgis-funkmasten

Scripts to import cell tower data.

Creates a Postgis database and imports following datasets:

* [Cell Towers from EMF-Database of BNetzA](https://github.com/dahilzen/Mobilfunk-Scrape)
* [OpenCellID](http://opencellid.org/downloads/)

# Usage

* `01-create-postgis-funkmasten-database.bat` - creates the Postgis database `funkmasten`
* `10-download-funkmasten.bat` - downloads [Cell Towers from EMF-Database of BNetzA](https://github.com/dahilzen/Mobilfunk-Scrape)
* `11-import-funkmasten-csv.bat` - imports `Alle_Funkmasten_BRD.csv` downloaded on the previous step
* Download of OpenCellID data is not implemented yet, you have to download and unzip manually
* `21-import-cell-towers-csv.bat` - imports `cell_tower.csv`

# Result

# EMF Cell Towers

EMF cell towers are imported into the following table:

```
CREATE TABLE FUNKMASTEN (
	fid integer,
	lon double precision,
	lat double precision,
	point geometry(POINT, 4326),
	type FUNKMASTEN_TYPE);
```

`FUNKMASTEN_TYPE` is an enum type with values `Mobilfunk`, `Sonstige Funkanlage`.

The table is indexed on `fid` and `type` and spatially indexed on `point`.

# OpenCellID Cell Towers

OpenCellID cell towers are imported into the following table:

CREATE TYPE RADIO_TYPE AS ENUM ('LTE', 'UMTS', 'GSM', 'CDMA');

```
CREATE TABLE CELL_TOWERS (
	radio RADIO_TYPE,
	mcc smallint,
	net smallint,
	area integer,
	cell integer,
	unit smallint,
	lon double precision,
	lat double precision,
	point geometry(POINT, 4326),
	range integer,
	samples integer,
	changeable boolean,
	created integer,
	updated integer,
	averageSignal smallint);
```

`RADIO_TYPE` is an enum type with values `LTE`, `UMTS`, `GSM`, `CDMA`.

Only records within the bounding box `5.8, 47.2, 15.1, 55.2` (Germany) are imported.

All fields except `lon` and `lat` are indexed, `point` is spatially indexed.

#License

Scripts are licensed under [BSD 2-clause license](LICENSE).

This repository does not contain or distribute the cell tower data, it must be downloaded separately.

The OpenCellID data is contributed and provided under the [CC-BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.

The license of the EMF data is not clear.