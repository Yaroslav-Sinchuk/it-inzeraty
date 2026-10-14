-- IT inzeraty - DQL (dopyty)
-- MS SQL Server

USE it_inzeraty;
GO

-- Úloha 1: Zobrazte pozíciu a plat_od pre inzeráty v Bratislave s platom nad 2000 €.
-- Zoraďte od najvyššieho platu.

-- pomocou AND
SELECT pozicia, plat_od 
FROM inzerat
WHERE mesto = N'Bratislava' AND plat_od > 2000.00
ORDER BY plat_od DESC;

-- alebo pomocou NOT
SELECT pozicia, plat_od
FROM inzerat
WHERE mesto = N'Bratislava' AND NOT plat_od <= 2000.00
ORDER BY plat_od DESC;

-- Úloha 2: Zobrazte firmu, pozíciu a technológie middle alebo senior inzerátov v Košiciach.
-- Zoraďte podľa firmy.

-- pomocou IN
SELECT firma, pozicia, technologie
FROM inzerat
WHERE mesto = N'Košice' AND seniorita IN (N'middle', N'senior')
ORDER BY firma ASC;

-- alebo pomocou OR
SELECT firma, pozicia, technologie
FROM inzerat
WHERE mesto = N'Košice' AND (seniorita = N'middle' OR seniorita = N'senior')
ORDER BY firma ASC;

-- Úloha 3: Zobrazte pozíciu, firmu a dátum zverejnenia remote inzerátov zverejnených po 25. 9. 2026.
-- Zoraďte podľa dátumu.

SELECT pozicia, firma, datum_zverejnenia
FROM inzerat
WHERE remote = 1 AND datum_zverejnenia > '2026-09-25'
ORDER BY datum_zverejnenia ASC;

-- Úloha 4: Zobrazte pozíciu, mesto a plat_do pre pozície Developer s plat_do pod 4000 €.
-- Zoraďte podľa mesta.

SELECT pozicia, mesto, plat_do
FROM inzerat
WHERE pozicia LIKE N'%Developer%' AND plat_do < 4000.00
ORDER BY mesto ASC;

-- Úloha 5: Zobrazte firmu, pozíciu a technológie junior inzerátov mimo Žiliny.
-- Zoraďte podľa pozície.

-- pomocou !=
SELECT firma, pozicia, technologie
FROM inzerat
WHERE seniorita = N'junior' AND mesto != N'Žilina'
ORDER BY pozicia ASC;

-- alebo pomocou <>
SELECT firma, pozicia, technologie
FROM inzerat
WHERE seniorita = N'junior' AND mesto <> N'Žilina'
ORDER BY pozicia ASC;
