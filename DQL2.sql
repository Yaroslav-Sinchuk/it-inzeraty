-- IT inzeraty - DQL2 (funkcie a agregácia)
-- MS SQL Server

USE it_inzeraty;
GO

-- Úloha 1: Zobrazte pozíciu veľkými písmenami, firmu a dĺžku textu technológií
-- pre inzeráty z Košíc. Zoraďte od najdlhšieho.
SELECT UPPER(pozicia) AS pozicia_velkym, 
       firma, 
       LEN(technologie) AS dlzka_technologii           -- MariaDB/MySQL: CHAR_LENGTH(technologie) AS dlzka_technologii
FROM inzerat
WHERE mesto = N'Košice'
ORDER BY LEN(technologie) DESC;                        -- MariaDB/MySQL: ORDER BY CHAR_LENGTH(technologie) DESC

-- Úloha 2: Zobrazte pozíciu, firmu a koľko dní je inzerát zverejnený.
-- Len inzeráty nie staršie ako 60 dní, od najnovšieho.
SELECT pozicia, 
       firma, 
       datum_zverejnenia, 
       DATEDIFF(day, datum_zverejnenia, GETDATE()) AS vek_inzeratu_dni -- MariaDB/MySQL: DATEDIFF(NOW(), datum_zverejnenia)
FROM inzerat
WHERE DATEDIFF(day, datum_zverejnenia, GETDATE()) <= 60                 -- MariaDB/MySQL: WHERE DATEDIFF(NOW(), datum_zverejnenia) <= 60
ORDER BY datum_zverejnenia DESC;

-- Úloha 3: Zobrazte firmu, pozíciu a typ práce ('Home Office' alebo 'On-site')
-- pre pozície Developer. Zoraďte podľa firmy.
SELECT firma, 
       pozicia, 
       CASE 
           WHEN remote = 1 THEN 'Home Office'
           ELSE 'On-site'
       END AS typ_prace
FROM inzerat
WHERE pozicia LIKE N'%Developer%'
ORDER BY firma ASC;

-- Úloha 4: Zobrazte pozíciu, plat_do a plat_do znížený o 15 % (zaokrúhlený)
-- pre senior pozície. Zoraďte od najvyššieho.
SELECT pozicia, 
       plat_do AS povodny_plat_max, 
       ROUND(plat_do * 0.85, 1) AS cisty_plat_do
FROM inzerat
WHERE seniorita = N'senior'
ORDER BY cisty_plat_do DESC;

-- Úloha 5: Zobrazte firmu, pozíciu a názov mesiaca zverejnenia
-- pre inzeráty z tohto roka. Zoraďte podľa pozície.
SELECT firma, 
       pozicia, 
       DATENAME(month, datum_zverejnenia) AS mesiac_zverejnenia -- MariaDB/MySQL: MONTHNAME(datum_zverejnenia)
FROM inzerat
WHERE YEAR(datum_zverejnenia) = YEAR(GETDATE())        -- MariaDB/MySQL: WHERE YEAR(datum_zverejnenia) = YEAR(NOW())
ORDER BY pozicia ASC;

-- Agregačné funkcie (GROUP BY, HAVING)

-- Úloha 6: Pre každé mesto zobrazte počet inzerátov, minimálny plat_od
-- a priemerný plat_do (len middle a senior). Len mestá s priemerom nad 3500 €.
-- Zoraďte podľa počtu inzerátov.
SELECT mesto, 
       COUNT(*) AS pocet_inzeratov, 
       MIN(plat_od) AS minimalny_nastupny_plat, 
       CAST(ROUND(AVG(plat_do), 0) AS INT) AS priemerny_maximalny_plat
FROM inzerat
WHERE seniorita IN (N'middle', N'senior')
GROUP BY mesto
HAVING AVG(plat_do) > 3500.00
ORDER BY pocet_inzeratov DESC;
