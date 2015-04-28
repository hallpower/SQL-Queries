/*
Return all table names of schema
*/

SELECT '['+SCHEMA_NAME(schema_id)+'].['+name+']'
AS SchemaTable
FROM sys.tables

order by '['+SCHEMA_NAME(schema_id)+'].['+name+']' asc