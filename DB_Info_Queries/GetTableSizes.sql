SELECT	s.name AS SchemaName, t.NAME AS TableName, GETDATE() AS CaptureTS, p.[Rows] AS RecordCount, 
		sum(a.total_pages) AS TotalPages, sum(a.used_pages) AS UsedPages, sum(a.data_pages) AS DataPages,
		(sum(a.total_pages) * 8) / 1024 AS TotalSpaceMB, (sum(a.used_pages) * 8) / 1024 AS UsedSpaceMB, 
		(sum(a.data_pages) * 8) / 1024 AS DataSpaceMB
FROM	sys.tables t
		INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
		INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
		INNER JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
		INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
WHERE	i.index_id <= 1 and t.NAME NOT LIKE 'dt%' AND i.OBJECT_ID > 255
GROUP BY	s.name, t.NAME, p.[Rows]
ORDER BY	s.name, t.NAME