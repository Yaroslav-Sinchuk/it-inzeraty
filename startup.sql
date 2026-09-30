-- IT inzeraty
-- MS SQL Server

USE master;
GO
-- odpojenie ostatnych pouzivatelov, aby sa dala databaza zmazat
ALTER DATABASE it_inzeraty SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
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

INSERT INTO inzerat VALUES
(1, N'Java Developer with React', N'SourceFirst International s.r.o.', N'Košice', N'middle', 2500, 3000, N'Java, Maven, React', '2026-09-22', 0);
GO

SELECT * FROM inzerat;
GO
