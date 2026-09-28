-- IT inzeraty
-- MS SQL Server

USE master;
GO
DROP DATABASE IF EXISTS it_inzeraty;
GO

CREATE DATABASE it_inzeraty;
GO

USE it_inzeraty;
GO

CREATE TABLE inzerat
(
   id INT,
   pozicia NVARCHAR(100),
   firma NVARCHAR(100),
   mesto NVARCHAR(50),
   seniorita NVARCHAR(20),
   plat_od DECIMAL(8,2),
   plat_do DECIMAL(8,2),
   technologie NVARCHAR(200),
   datum_zverejnenia DATE,
   remote BIT -- 1 ano, 0 nie
);
GO

-- tento inzerat je len vymysleny priklad, dalej by sme mali pridavat realne (napr. z profesia.sk)
INSERT INTO inzerat VALUES
(1, N'Junior Data Engineer', N'DataNest s.r.o.', N'Košice', N'junior', 1400, 1900, N'Python, SQL, Airflow', '2026-09-02', 0);
GO

-- dalsie inzeraty

SELECT * FROM inzerat;
GO
