-- IT inzeraty - DQL3 (prepajanie tabuliek)
-- Spustite po DDL.sql, DML.sql, DDL3.sql a DML3.sql.
-- MS SQL Server

USE it_inzeraty;
GO

-- Úloha 1: Zobrazte pozície a ich technológie pre inzeráty v Košiciach.
-- Zoraďte podľa pozície a názvu technológie.

-- Úloha 2: Zobrazte remote inzeráty a ich benefity.
-- Výsledky zoraďte podľa firmy a benefitu.

-- Úloha 3: Pre každú kategóriu technológií zobrazte počet inzerátov.
-- Zahrňte aj kategórie bez priradených inzerátov.

-- Úloha 4: Zobrazte všetky inzeráty a ich benefity.
-- Inzeráty bez priradeného benefitu musia byť vo výsledku tiež.

-- Úloha 5: Pre každý remote senior inzerát zobrazte počet technológií
-- a počet benefitov. Zoraďte od inzerátu s najviac technológiami.




















-- Úloha 1:
SELECT i.pozicia,
       i.firma,
       t.nazov AS technologia
FROM inzerat AS i
INNER JOIN inzerat_technologia AS it ON it.inzerat_id = i.id
INNER JOIN technologia AS t ON t.id = it.technologia_id
WHERE i.mesto = N'Košice'
ORDER BY i.pozicia, t.nazov;
GO

-- Úloha 2:
SELECT i.firma,
       i.pozicia,
       b.nazov AS benefit
FROM inzerat AS i
INNER JOIN inzerat_benefit AS ib ON ib.inzerat_id = i.id
INNER JOIN benefit AS b ON b.id = ib.benefit_id
WHERE i.remote = 1
ORDER BY i.firma, b.nazov;
GO

-- Úloha 3:
SELECT t.kategoria,
       COUNT(DISTINCT it.inzerat_id) AS pocet_inzeratov
FROM technologia AS t
LEFT JOIN inzerat_technologia AS it ON it.technologia_id = t.id
GROUP BY t.kategoria
ORDER BY pocet_inzeratov DESC, t.kategoria;
GO

-- Úloha 4:
SELECT i.pozicia,
       i.firma,
       b.nazov AS benefit
FROM inzerat AS i
LEFT JOIN inzerat_benefit AS ib ON ib.inzerat_id = i.id
LEFT JOIN benefit AS b ON b.id = ib.benefit_id
ORDER BY i.firma, i.pozicia, b.nazov;
GO

-- Úloha 5:
SELECT i.firma,
       i.pozicia,
       COUNT(DISTINCT it.technologia_id) AS pocet_technologii,
       COUNT(DISTINCT ib.benefit_id) AS pocet_benefitov
FROM inzerat AS i
LEFT JOIN inzerat_technologia AS it ON it.inzerat_id = i.id
LEFT JOIN inzerat_benefit AS ib ON ib.inzerat_id = i.id
WHERE i.remote = 1
  AND i.seniorita = N'senior'
GROUP BY i.id, i.firma, i.pozicia
ORDER BY pocet_technologii DESC, i.pozicia;
GO