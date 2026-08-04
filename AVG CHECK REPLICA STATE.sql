

--CHECK REPLICA CONNECTION STATE


SELECT ar.replica_server_name,
       DB_NAME(drs.database_id) AS db_name,
       ars.role_desc,
       ars.connected_state_desc,
       ars.synchronization_health_desc,
       drs.synchronization_state_desc,
       drs.is_suspended,
       drs.suspend_reason_desc,
       drs.last_hardened_lsn
FROM sys.dm_hadr_database_replica_states drs
JOIN sys.availability_replicas ar
  ON ar.replica_id = drs.replica_id
JOIN sys.dm_hadr_availability_replica_states ars
  ON ars.replica_id = drs.replica_id;