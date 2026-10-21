-- IT inzeraty - DDL3 (technologie a benefity)
-- Spustite po DDL.sql. MS SQL Server

USE it_inzeraty;
GO

CREATE TABLE technologia
(
    id INT PRIMARY KEY,
    nazov NVARCHAR(50) NOT NULL UNIQUE,
    kategoria NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE inzerat_technologia
(
    inzerat_id INT NOT NULL,
    technologia_id INT NOT NULL,
    PRIMARY KEY (inzerat_id, technologia_id),
    FOREIGN KEY (inzerat_id) REFERENCES inzerat(id),
    FOREIGN KEY (technologia_id) REFERENCES technologia(id)
);
GO

CREATE TABLE benefit
(
    id INT PRIMARY KEY,
    nazov NVARCHAR(80) NOT NULL UNIQUE
);
GO

CREATE TABLE inzerat_benefit
(
    inzerat_id INT NOT NULL,
    benefit_id INT NOT NULL,
    PRIMARY KEY (inzerat_id, benefit_id),
    FOREIGN KEY (inzerat_id) REFERENCES inzerat(id),
    FOREIGN KEY (benefit_id) REFERENCES benefit(id)
);
GO
