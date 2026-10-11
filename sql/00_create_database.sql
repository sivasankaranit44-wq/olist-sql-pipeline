if DB_ID('olistdb') is null
create database olistdb
go

use olistdb;
go

if schema_id('bronze') is null execute('create schema bronze');
if schema_id('silver') is null execute('create schema silver');
if schema_id('gold') is null execute('create schema gold');
go
