# Role start_db

The role start_db is used to start a database instance. Currently supported databases are IBM Db2 for Linux, Unix and Windows (LUW), Oracle and SAP HANA. When using this role, you must specify some information about the database in variables and select the database type through a tag. If the requested database is already started, the request will be ignored and an informational message will be sent.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM AIX systems.

The requested database instance must be installed on the managed node and operational.

## Dependencies

None

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
