CREATE TABLESPACE "GENECONNECTDATA" LOGGING 
DATAFILE '$ORACLE_HOME/GENECONNECTDATA01.ora' SIZE 16384M 
EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER GENECONNECTUSER PROFILE DEFAULT IDENTIFIED BY GENECONNECTUSER DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP ACCOUNT UNLOCK;
 
GRANT CREATE ANY INDEX TO GENECONNECTUSER;
GRANT CREATE ANY TABLE TO GENECONNECTUSER;
GRANT UNLIMITED TABLESPACE TO GENECONNECTUSER;
GRANT CONNECT TO GENECONNECTUSER;