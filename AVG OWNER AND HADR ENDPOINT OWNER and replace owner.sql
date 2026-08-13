--Below can be used to see the owner, and below that is the alter to adjust
SELECT 
    ar.replica_server_name, 
    ag.name AS ag_name, 
    ar.owner_sid, 
    sp.name AS owner_name
FROM 
    sys.availability_replicas ar
LEFT JOIN 
    sys.server_principals sp ON sp.sid = ar.owner_sid
INNER JOIN 
    sys.availability_groups ag ON ag.group_id = ar.group_id
WHERE 
    ar.replica_server_name = SERVERPROPERTY('ServerName');
 
--ALTER AUTHORIZATION ON AVAILABILITY GROUP::[PROD_AVG_NCR] TO [SA];

--CHANGE HADR END POINT BELOW-----
SELECT 
name, 
SUSER_NAME(principal_id) AS OwnerName, 
type_desc

FROM sys.endpoints
WHERE  name = 'Hadr_endpoint';


--modify:


--ALTER AUTHORIZATION ON AVAILABILITY GROUP::[PROD_AVG_ETO] TO [SA]; ----CHANGE AG OWNER UPDATE AG NAME
------ALTER AUTHORIZATION ON AVAILABILITY GROUP::[PROD_AVG_RPA] TO [SA]; ----CHANGE AG OWNER UPDATE AG NAME
------ALTER AUTHORIZATION ON AVAILABILITY GROUP::[PROD_AVG_EV] TO [SA]; ----CHANGE AG OWNER UPDATE AG NAME

--USE master;
--GO
--ALTER AUTHORIZATION ON ENDPOINT::Hadr_endpoint TO [sa]; ----UPDATE HADR ENDPOINT OWNER


