-- IT inzeraty - DML3 (data pre tabulky technologii a benefitov)
-- Spustite po DDL.sql, DML.sql a DDL3.sql.

USE it_inzeraty;
GO

INSERT INTO technologia (id, nazov, kategoria) VALUES
(1, N'Java', N'Programovacie jazyky'),
(2, N'Maven', N'Nástroje'),
(3, N'React', N'Frontend'),
(4, N'T-SQL', N'Databázy'),
(5, N'SSMS', N'Databázy'),
(6, N'SSRS', N'BI a reporting'),
(7, N'C#', N'Programovacie jazyky'),
(8, N'.NET', N'Frameworky'),
(9, N'SQL Server', N'Databázy'),
(10, N'Python', N'Programovacie jazyky'),
(11, N'Selenium', N'Testovanie'),
(12, N'SQL', N'Databázy'),
(13, N'PowerBI', N'BI a reporting'),
(14, N'Excel', N'Nástroje'),
(15, N'Docker', N'DevOps'),
(16, N'Kubernetes', N'DevOps'),
(17, N'AWS', N'Cloud'),
(18, N'Django', N'Frameworky'),
(19, N'Oracle', N'Databázy'),
(20, N'Linux', N'Operacne systemy'),
(21, N'Terraform', N'Infrastructure as Code');
GO

INSERT INTO inzerat_technologia (inzerat_id, technologia_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5), (2, 6),
(3, 7), (3, 8), (3, 9),
(4, 10), (4, 11),
(5, 12), (5, 13), (5, 14),
(6, 15), (6, 16), (6, 17),
(7, 10), (7, 18),
(8, 9), (8, 19), (8, 20);
GO

INSERT INTO benefit (id, nazov) VALUES
(1, N'Home office'),
(2, N'Stravne'),
(3, N'Rocny bonus'),
(4, N'Vzdelávanie'),
(5, N'Dodatocna dovolenka');
GO

INSERT INTO inzerat_benefit (inzerat_id, benefit_id) VALUES
(1, 2), (1, 4),
(2, 1), (2, 3), (2, 5),
(3, 2), (3, 4),
(4, 1), (4, 4),
(5, 2),
(6, 1), (6, 3), (6, 4),
(7, 1), (7, 2);
GO
