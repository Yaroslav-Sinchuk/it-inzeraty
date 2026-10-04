USE it_inzeraty;
GO

INSERT INTO inzerat (id, pozicia, firma, mesto, seniorita, plat_od, plat_do, technologie, datum_zverejnenia, remote) VALUES
(1, N'Java Developer with React', N'SourceFirst International s.r.o.', N'Košice', N'middle', 2500.00, 3000.00, N'Java, Maven, React', '2026-09-22', 0),
(2, N'Senior MS SQL Developer', N'Microsoft Slovakia', N'Bratislava', N'senior', 4000.00, 5200.00, N'T-SQL, SSMS, SSRS', '2026-10-01', 1),
(3, N'Junior C#.NET Developer', N'Asseco Central Europe', N'Košice', N'junior', 1500.00, 1900.00, N'C#, .NET, SQL Server', '2026-10-03', 0),
(4, N'QA Automation Engineer', N'Eset', N'Bratislava', N'middle', 2200.00, 2800.00, N'Python, Selenium', '2026-09-15', 1),
(5, N'Data Analyst', N'T-Systems', N'Košice', N'middle', 2000.00, 2500.00, N'SQL, PowerBI, Excel', '2026-10-02', 0),
(6, N'DevOps Engineer', N'Siemens Healthineers', N'Žilina', N'senior', 3200.00, 4100.00, N'Docker, Kubernetes, AWS', '2026-09-30', 1),
(7, N'Junior Python Developer', N'IBM Slovakia', N'Bratislava', N'junior', 1600.00, 2000.00, N'Python, Django', '2026-10-04', 1),
(8, N'Database Administrator', N'Fpt Slovakia', N'Košice', N'senior', 2800.00, 3700.00, N'SQL Server, Oracle, Linux', '2026-09-28', 0);
GO