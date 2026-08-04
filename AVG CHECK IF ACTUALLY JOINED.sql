
---AVG CHECK IF ACTUALLY JOINED


SELECT d.name, drs.is_local, drs.synchronization_state_desc
FROM sys.databases d
LEFT JOIN sys.dm_hadr_database_replica_states drs
  ON drs.database_id = d.database_id AND drs.is_local = 1
WHERE d.name IN ('DB1','DB2','DB3','DB4');