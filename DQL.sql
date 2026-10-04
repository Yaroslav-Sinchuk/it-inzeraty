-- IT inzeraty - DQL (dopyty)
-- MS SQL Server

USE it_inzeraty;
GO

-- ÚLOHA 1: Zobrazte pozície a minimálny plat (plat_od) pre inzeráty v Bratislave,
-- kde je minimálny plat vyšší ako 2000 EUR. Výsledok usporiadajte od najvyššieho platu.

-- Možnosť A: pomocou AND
SELECT pozicia, plat_od 
FROM inzerat
WHERE mesto = N'Bratislava' AND plat_od > 2000.00
ORDER BY plat_od DESC;

-- Možnosť B: pomocou NOT
SELECT pozicia, plat_od
FROM inzerat
WHERE mesto = N'Bratislava' AND NOT plat_od <= 2000.00
ORDER BY plat_od DESC;

-- ÚLOHA 2: Nájdite firmy, pozície a technológie pre inzeráty v Košiciach,
-- ktoré sú vhodné pre 'middle' alebo 'senior' úrovne. Usporiadajte podľa firmy (A-Z).

-- Možnosť A: Použitie operátora IN
SELECT firma, pozicia, technologie
FROM inzerat
WHERE mesto = N'Košice' AND seniorita IN (N'middle', N'senior')
ORDER BY firma ASC;

-- Možnosť B: Použitie logického operátora OR
SELECT firma, pozicia, technologie
FROM inzerat
WHERE mesto = N'Košice' AND (seniorita = N'middle' OR seniorita = N'senior')
ORDER BY firma ASC;

-- ÚLOHA 3: Vyberte pozície, firmy a dátum zverejnenia pre ponuky, ktoré ponúkajú
-- prácu na diaľku (remote = 1) a boli zverejnené po 25. septembri 2026. Usporiadajte podľa dátumu.

SELECT pozicia, firma, datum_zverejnenia
FROM inzerat
WHERE remote = 1 AND datum_zverejnenia > '2026-09-25'
ORDER BY datum_zverejnenia ASC;

-- ÚLOHA 4: Zobrazte inzeráty pre vývojárov (pozícia obsahuje 'Developer')
-- s informáciou o meste a maximálnom plate (plat_do), kde maximálny plat je menší ako 4000 EUR.
-- Usporiadajte podľa mesta.

SELECT pozicia, mesto, plat_do
FROM inzerat
WHERE pozicia LIKE N'%Developer%' AND plat_do < 4000.00
ORDER BY mesto ASC;

-- ÚLOHA 5: Nájdite ponuky pre začínajúcich špecialistov (junior) s informáciou 
-- o firme, pozícii a technológiách z celého Slovenska okrem Žiliny. Usporiadajte podľa pozície.

-- Možnosť A: Použitie operátora nerovnosti !=
SELECT firma, pozicia, technologie
FROM inzerat
WHERE seniorita = N'junior' AND mesto != N'Žilina'
ORDER BY pozicia ASC;

-- Možnosť B: Použitie operátora nerovnosti <>
SELECT firma, pozicia, technologie
FROM inzerat
WHERE seniorita = N'junior' AND mesto <> N'Žilina'
ORDER BY pozicia ASC;
