-- IT inzeraty - DQL3 (prepajanie tabuliek)
-- Spustite po DDL.sql, DML.sql, DDL3.sql a DML3.sql.
-- MS SQL Server

USE it_inzeraty;
GO

-- Úloha 1: Zobrazte pozície a ich technológie pre inzeráty v Košiciach.
-- Zoraďte podľa pozície a názvu technológie.

-- pomocou INNER JOIN
SELECT i.pozicia,
       i.firma,
       t.nazov AS technologia
FROM inzerat AS i
INNER JOIN inzerat_technologia AS it ON it.inzerat_id = i.id
INNER JOIN technologia AS t ON t.id = it.technologia_id
WHERE i.mesto = N'Košice'
ORDER BY i.pozicia, t.nazov;

-- alebo pomocou spojenia vo WHERE
SELECT i.pozicia,
       i.firma,
       t.nazov AS technologia
FROM inzerat AS i, inzerat_technologia AS it, technologia AS t
WHERE it.inzerat_id = i.id
  AND t.id = it.technologia_id
  AND i.mesto = N'Košice'
ORDER BY i.pozicia, t.nazov;

-- Úloha 2: Zobrazte remote inzeráty a ich benefity.
-- Zoraďte podľa firmy a benefitu.
SELECT i.firma,
       i.pozicia,
       b.nazov AS benefit
FROM inzerat AS i
INNER JOIN inzerat_benefit AS ib ON ib.inzerat_id = i.id
INNER JOIN benefit AS b ON b.id = ib.benefit_id
WHERE i.remote = 1
ORDER BY i.firma, b.nazov;

-- Úloha 3: Pre každú kategóriu technológií zobrazte počet inzerátov.
-- Zahrňte aj kategórie bez inzerátov.

-- pomocou LEFT JOIN
SELECT t.kategoria,
       COUNT(DISTINCT it.inzerat_id) AS pocet_inzeratov
FROM technologia AS t
LEFT JOIN inzerat_technologia AS it ON it.technologia_id = t.id
GROUP BY t.kategoria
ORDER BY pocet_inzeratov DESC, t.kategoria;

-- alebo pomocou RIGHT JOIN
SELECT t.kategoria,
       COUNT(DISTINCT it.inzerat_id) AS pocet_inzeratov
FROM inzerat_technologia AS it
RIGHT JOIN technologia AS t ON t.id = it.technologia_id
GROUP BY t.kategoria
ORDER BY pocet_inzeratov DESC, t.kategoria;

-- Úloha 4: Zobrazte všetky inzeráty a všetky benefity – aj inzeráty bez benefitu,
-- aj benefity, ktoré nemá žiadny inzerát. Zoraďte podľa firmy a benefitu.

-- pomocou FULL OUTER JOIN
SELECT i.firma,
       i.pozicia,
       b.nazov AS benefit
FROM inzerat AS i
FULL OUTER JOIN inzerat_benefit AS ib ON ib.inzerat_id = i.id
FULL OUTER JOIN benefit AS b ON b.id = ib.benefit_id
ORDER BY i.firma, b.nazov;

-- alebo pomocou LEFT JOIN a RIGHT JOIN spojených cez UNION
SELECT i.firma, i.pozicia, b.nazov AS benefit
FROM inzerat AS i
LEFT JOIN inzerat_benefit AS ib ON ib.inzerat_id = i.id
LEFT JOIN benefit AS b ON b.id = ib.benefit_id
UNION
SELECT i.firma, i.pozicia, b.nazov AS benefit
FROM inzerat AS i
INNER JOIN inzerat_benefit AS ib ON ib.inzerat_id = i.id
RIGHT JOIN benefit AS b ON b.id = ib.benefit_id
ORDER BY firma, benefit;

-- Úloha 5: Pre každý remote senior inzerát zobrazte počet technológií a počet benefitov.
-- Zoraďte od inzerátu s najviac technológiami.
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
