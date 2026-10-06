USE it_inzeraty;
GO

-- =========================================================================
-- ČASŤ 1: 5 VLASTNÝCH ZADANÍ S VYUŽITÍM FUNKCIÍ V SELECT, WHERE A ORDER BY
-- =========================================================================

-- -------------------------------------------------------------------------
-- ÚLOHA 1: Formátovanie textu a výpočet dĺžky technológií
-- Zadanie: Zobrazte názov pozície veľkými písmenami, názov firmy a dĺžku (počet znakov) 
-- v stĺpci "technologie". Vyberte len ponuky z Košíc a výsledok usporiadajte 
-- podľa dĺžky technológií od najdlhšej.
-- -------------------------------------------------------------------------
SELECT UPPER(pozicia) AS pozicia_velkym, 
       firma, 
       LEN(technologie) AS dlzka_technologii           -- MariaDB/MySQL: CHAR_LENGTH(technologie) AS dlzka_technologii
FROM inzerat
WHERE mesto = N'Košice'
ORDER BY LEN(technologie) DESC;                        -- MariaDB/MySQL: ORDER BY CHAR_LENGTH(technologie) DESC
GO


-- -------------------------------------------------------------------------
-- ÚLOHA 2: Práca s dátumom a časom (Vek inzerátu v dňoch)
-- Zadanie: Zobrazte pozíciu, firmu, dátum zverejnenia a vypočítajte, pred koľkými 
-- dňami bol inzerát zverejnený vzhľadom na dnešný dátum. Zobrazte len inzeráty, 
-- ktoré nie sú staršie ako 10 dní, a zoraďte ich od najnovšieho.
-- -------------------------------------------------------------------------
SELECT pozicia, 
       firma, 
       datum_zverejnenia, 
       DATEDIFF(day, datum_zverejnenia, GETDATE()) AS vek_inzeratu_dni -- MariaDB/MySQL: DATEDIFF(NOW(), datum_zverejnenia)
FROM inzerat
WHERE DATEDIFF(day, datum_zverejnenia, GETDATE()) <= 10                 -- MariaDB/MySQL: WHERE DATEDIFF(NOW(), datum_zverejnenia) <= 10
ORDER BY datum_zverejnenia DESC;
GO

-- -------------------------------------------------------------------------
-- ÚLOHA 3: Použitie podmienkovej logiky (CASE WHEN) v SELECT a WHERE
-- Zadanie: Zobrazte firmu, pozíciu a nový stĺpec "typ_prace", kde na základe 
-- stĺpca "remote" vypíšete text 'Home Office' (ak remote = 1) alebo 'On-site' (ak remote = 0).
-- Do výberu vezmite len tie ponuky, ktoré majú v názve pozície slovo 'Developer' 
-- a ponúkajú prácu na diaľku. Výsledok zoraďte podľa firmy.
-- -------------------------------------------------------------------------
SELECT firma, 
       pozicia, 
       CASE 
           WHEN remote = 1 THEN 'Home Office'
           ELSE 'On-site'
       END AS typ_prace
FROM inzerat
WHERE pozicia LIKE N'%Developer%' AND remote = 1
ORDER BY firma ASC;


-- -------------------------------------------------------------------------
-- ÚLOHA 4: Matematické zaokrúhľovanie a úprava platu
-- Zadanie: Predpokladajme zavedenie novej dane, ktorá zníži hornú hranicu platu (plat_do) o 15%. 
-- Zobrazte pozíciu, pôvodný maximálny plat a stĺpec "cisty_plat_do", ktorý bude zaokrúhlený 
-- na 1 desatinné miesto. Filtrujte len senior pozície a zoraďte podľa výšky čistého platu.
-- -------------------------------------------------------------------------
SELECT pozicia, 
       plat_do AS povodny_plat_max, 
       ROUND(plat_do * 0.85, 1) AS cisty_plat_do
FROM inzerat
WHERE seniorita = N'senior'
ORDER BY cisty_plat_do DESC;


-- -------------------------------------------------------------------------
-- ÚLOHA 5: Extrakcia časti dátumu (Mesiac zverejnenia inzerátu)
-- Zadanie: Zobrazte názov firmy, pozíciu a textový názov mesiaca, kedy bol inzerát 
-- zverejnený. Filtrujte len inzeráty, ktoré boli zverejnené v aktuálnom roku 
-- (dynamicky podľa dnešného roka) a usporiadajte ich podľa názvu pozície.
-- -------------------------------------------------------------------------
SELECT firma, 
       pozicia, 
       DATENAME(month, datum_zverejnenia) AS mesiac_zverejnenia -- MariaDB/MySQL: MONTHNAME(datum_zverejnenia)
FROM inzerat
WHERE YEAR(datum_zverejnenia) = YEAR(GETDATE())        -- MariaDB/MySQL: WHERE YEAR(datum_zverejnenia) = YEAR(NOW())
ORDER BY pozicia ASC;
GO


-- =========================================================================
-- ČASŤ 2: POKROČILÉ ZADANIE S AGREGAČNÝMI FUNKCIAMI, GROUP BY A HAVING
-- =========================================================================

-- -------------------------------------------------------------------------
-- ÚLOHA 6: Štatistika platov podľa miest s podmienkou na priemer
-- Zadanie: Pre každé mesto vypočítajte celkový počet aktívnych IT inzerátov, 
-- minimálny plat (z plat_od) a priemerný maximálny plat (z plat_do) zaokrúhlený na celé eurá.
-- Do analýzy započítajte len ponuky od stredne pokročilých a skúsených špecialistov (middle, senior).
-- Výsledky zoskupte podľa miest, ale zobrazte iba tie mestá, kde je priemerný maximálny plat 
-- vyšší ako 2500 EUR. Výslednú tabuľku zoraďte podľa počtu inzerátov od najväčšieho.
-- -------------------------------------------------------------------------
SELECT mesto, 
       COUNT(*) AS pocet_inzeratov, 
       MIN(plat_od) AS minimalny_nastupny_plat, 
       ROUND(AVG(plat_do), 0) AS priemerny_maximalny_plat
FROM inzerat
WHERE seniorita IN (N'middle', N'senior')
GROUP BY mesto
HAVING AVG(plat_do) > 2500.00
ORDER BY pocet_inzeratov DESC;
