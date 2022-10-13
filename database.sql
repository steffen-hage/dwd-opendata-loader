PRAGMA foreign_keys = OFF;

CREATE TABLE IF NOT EXISTS Stations (
    StationIdent INTEGER PRIMARY KEY,
    Description TEXT,
    State TEXT,
    SeaLevel REAL,
    Latitude REAL,
    Longitude REAL
);

CREATE TABLE IF NOT EXISTS WeatherPhenomena (
    WeatherPhenomenonIdent INTEGER PRIMARY KEY,
    Description TEXT
);

CREATE TABLE IF NOT EXISTS QualityLevels (
    QLIdent INTEGER PRIMARY KEY,
    Description TEXT
);

CREATE TABLE IF NOT EXISTS QualityBytes (
    QBIdent INTEGER PRIMARY KEY,
    Description TEXT
);

CREATE TABLE IF NOT EXISTS AirTemperature (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    TT_TU REAL,
    RF_TU REAL,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS Cloudiness (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    V_N_I TEXT,
    V_N INTEGER,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS DewPoint (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    TT REAL,
    TD REAL,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS Moisture (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    ABSF_STD REAL,
    VP_STD REAL,
    TF_STD REAL,
    P_STD REAL,
    TT_STD REAL,
    RF_STD REAL,
    TD_STD REAL,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS Precipitation (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    R1 REAL,
    RS_IND INTEGER,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS Pressure (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    P REAL,
    P0 REAL,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS SoilTemperature (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    V_TE002 REAL,
    V_TE005 REAL,
    V_TE010 REAL,
    V_TE020 REAL,
    V_TE050 REAL,
    V_TE100 REAL,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS Sun (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    SD_SO REAL,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS WeatherPhenomenaData (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    WW INTEGER,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    FOREIGN KEY (WW) REFERENCES WeatherPhenomena(WeatherPhenomenonIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE TABLE IF NOT EXISTS Wind (
    StationIdent INTEGER NOT NULL,
    QLIdent INTEGER NOT NULL,    
    DateMeasuredUTC TEXT,
    DateMeasuredUnixUTC INTEGER,
    FF REAL,
    DD INTEGER,
    FOREIGN KEY (StationIdent) REFERENCES Stations(StationIdent),
    FOREIGN KEY (QLIdent) REFERENCES QualityLevels(QLIdent),
    PRIMARY KEY (StationIdent, DateMeasuredUnixUTC)
);

CREATE VIEW WeatherData AS
SELECT
    AirTemperature.StationIdent,
    Stations.SeaLevel,
    Stations.Latitude,
    Stations.Longitude,
    AirTemperature.QLIdent AS AirTemperature_QL,
    AirTemperature.TT_TU AS AirTemperature_TT_TU,
    AirTemperature.RF_TU AS AirTemperature_RF_TU,
    Cloudiness.QLIdent AS Cloudiness_QL,
    Cloudiness.V_N_I AS Cloudiness_V_N_I,
    Cloudiness.V_N AS Cloudiness_V_N,
    DewPoint.QLIdent AS DewPoint_QL,
    DewPoint.TT AS DewPoint_TT,
    DewPoint.TD AS DewPoint_TD,
    Moisture.QLIdent AS Moisture_QL,
    Moisture.ABSF_STD AS Moisture_ABSF_STD,
    Moisture.VP_STD AS Moisture_VP_STD,
    Moisture.TF_STD AS Moisture_TF_STD,
    Moisture.P_STD AS Moisture_P_STD,
    Moisture.TT_STD AS Moisture_TT_STD,
    Moisture.RF_STD AS Moisture_RF_STD,
    Moisture.TD_STD AS Moisture_TD_STD,
    Precipitation.QLIdent AS Precipitation_QL,
    Precipitation.R1 AS Precipitation_R1,
    Precipitation.RS_IND AS Precipitation_RS_IND,
    Pressure.QLIdent AS Pressure_QL,
    Pressure.P AS Pressure_P,
    Pressure.P0 AS Pressure_P0,
    SoilTemperature.QLIdent AS SoilTemperature_QL,
    SoilTemperature.V_TE002 AS SoilTemperature_V_TE002,
    SoilTemperature.V_TE005 AS SoilTemperature_V_TE005,
    SoilTemperature.V_TE010 AS SoilTemperature_V_TE010,
    SoilTemperature.V_TE020 AS SoilTemperature_V_TE020,
    SoilTemperature.V_TE050 AS SoilTemperature_V_TE050,
    SoilTemperature.V_TE100 AS SoilTemperature_V_TE100,
    Sun.QLIdent AS Sun_QL,
    Sun.SD_SO AS Sun_SD_SO,
    WeatherPhenomenaData.QLIdent AS WeatherPhenomena_QL,
    WeatherPhenomenaData.WW AS WeatherPhenomena_WW,
    Wind.QLIdent AS Wind_QL,
    Wind.FF AS Wind_FF,
    Wind.DD AS Wind_DD,
    AirTemperature.DateMeasuredUnixUTC,
    AirTemperature.DateMeasuredUTC
FROM AirTemperature
INNER JOIN Stations ON Stations.StationIdent = AirTemperature.StationIdent
INNER JOIN Cloudiness ON Cloudiness.StationIdent = AirTemperature.StationIdent AND Cloudiness.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN DewPoint ON DewPoint.StationIdent = AirTemperature.StationIdent AND DewPoint.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN Moisture ON Moisture.StationIdent = AirTemperature.StationIdent AND Moisture.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN Precipitation ON Precipitation.StationIdent = AirTemperature.StationIdent AND Precipitation.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN Pressure ON Pressure.StationIdent = AirTemperature.StationIdent AND Pressure.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN SoilTemperature ON SoilTemperature.StationIdent = AirTemperature.StationIdent AND SoilTemperature.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN Sun ON Sun.StationIdent = AirTemperature.StationIdent AND Sun.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN WeatherPhenomenaData ON WeatherPhenomenaData.StationIdent = AirTemperature.StationIdent AND WeatherPhenomenaData.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC
INNER JOIN Wind ON Wind.StationIdent = AirTemperature.StationIdent AND Wind.DateMeasuredUnixUTC = AirTemperature.DateMeasuredUnixUTC;

PRAGMA foreign_keys=on;