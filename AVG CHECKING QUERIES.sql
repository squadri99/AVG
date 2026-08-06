
--sp_whoisactive

--kill 65 with statusonly

---AVG CHECK IF ACTUALLY JOINED

SELECT NAME,STATE_DESC,RECOVERY_MODEL_DESC,IS_IN_STANDBY
FROM SYS.DATABASES
WHERE NAME IN ('ACVSUJournal_00011018','ACVSUJournal_00012023','ADSyncPrimary','ADSyncStaging','ACVSJournal');
---------------------
--CHECK REPLICA CONNECTION STATE

SELECT *
--NAME, STATE_DESC, PORT,
FROM SYS.TCP_ENDPOINTS
WHERE TYPE_DESC ='DATABASE_MIRRORING'
---------------------------------------------

SELECT d.name, drs.is_local, drs.synchronization_state_desc
FROM sys.databases d
LEFT JOIN sys.dm_hadr_database_replica_states drs
  ON drs.database_id = d.database_id AND drs.is_local = 1
WHERE d.name IN ('ACVSUJournal_00011018','ACVSUJournal_00012023','ADSyncPrimary','ADSyncStaging','ACVSJournal');

SELECT DB_NAME(drs.database_id) AS db_name,
       ar.replica_server_name,
       drs.synchronization_state_desc,
       drs.synchronization_health_desc,
       drs.database_state_desc,
       drs.is_suspended,
       drs.suspend_reason_desc,
       drs.last_hardened_time,
       drs.log_send_queue_size,
       drs.redo_queue_size
FROM sys.dm_hadr_database_replica_states drs
JOIN sys.availability_replicas ar ON ar.replica_id = drs.replica_id
WHERE DB_NAME(drs.database_id) IN ('ACVSUJournal_00011018','ACVSUJournal_00012023','ADSyncPrimary','ACVSJournal');
--'ACVSUJournal_00011018,ACVSUJournal_00012023,ADSyncPrimary,ADSyncStaging',
--------------------------------------------------------------------------------------------------------
SELECT ag.name AS ag_name,
       ag.automated_backup_preference_desc,
       adc.database_name,
       ar.replica_server_name,
       ar.backup_priority,
       ar.secondary_role_allow_connections_desc
FROM sys.availability_groups ag
JOIN sys.availability_databases_cluster adc ON adc.group_id = ag.group_id
JOIN sys.availability_replicas ar ON ar.group_id = ag.group_id
ORDER BY ag.name, adc.database_name;
------------------------------------------------------------------
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
  -------------------------
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