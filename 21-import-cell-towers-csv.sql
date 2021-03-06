DROP INDEX IF EXISTS CELL_TOWERS_POINT_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_RADIO_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_MCC_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_NET_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_AREA_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_CELL_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_UNIT_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_RANGE_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_SAMPLES_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_CHANGEABLE_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_CREATED_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_UPDATED_INDEX;
DROP INDEX IF EXISTS CELL_TOWERS_AVERAGESIGNAL_INDEX;
DROP TABLE IF EXISTS CELL_TOWERS;
DROP TYPE IF EXISTS RADIO_TYPE;

CREATE TYPE RADIO_TYPE AS ENUM ('LTE', 'UMTS', 'GSM', 'CDMA');

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

COPY
	CELL_TOWERS (
		radio,
		mcc,
		net,
		area,
		cell,
		unit,
		lon,
		lat,
		range,
		samples,
		changeable,
		created,
		updated,
		averageSignal)
FROM
	:CELL_TOWERS_INPUT
	DELIMITER ','
	CSV
		HEADER;

DELETE FROM
	CELL_TOWERS
WHERE
	lon < 5.8 OR
	lat < 47.2 OR
	lon > 15.1 OR
	lat > 55.2;


UPDATE CELL_TOWERS SET point = ST_SetSRID(ST_MakePoint(lon, lat), 4326);

CREATE INDEX CELL_TOWERS_POINT_INDEX ON CELL_TOWERS USING GIST(point);
CREATE INDEX CELL_TOWERS_RADIO_INDEX ON CELL_TOWERS (radio);
CREATE INDEX CELL_TOWERS_MCC_INDEX ON CELL_TOWERS (mcc);
CREATE INDEX CELL_TOWERS_NET_INDEX ON CELL_TOWERS (net);
CREATE INDEX CELL_TOWERS_AREA_INDEX ON CELL_TOWERS (area);
CREATE INDEX CELL_TOWERS_CELL_INDEX ON CELL_TOWERS (cell);
CREATE INDEX CELL_TOWERS_UNIT_INDEX ON CELL_TOWERS (unit);
CREATE INDEX CELL_TOWERS_RANGE_INDEX ON CELL_TOWERS (range);
CREATE INDEX CELL_TOWERS_SAMPLES_INDEX ON CELL_TOWERS (samples);
CREATE INDEX CELL_TOWERS_CHANGEABLE_INDEX ON CELL_TOWERS (changeable);
CREATE INDEX CELL_TOWERS_CREATED_INDEX ON CELL_TOWERS (created);
CREATE INDEX CELL_TOWERS_UPDATED_INDEX ON CELL_TOWERS (updated);
CREATE INDEX CELL_TOWERS_AVERAGESIGNAL_INDEX ON CELL_TOWERS (averageSignal);