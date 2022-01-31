# Role start_db

The role start_db is used to start a database instance.  Currently supported DBs are Db2 LUW. The role is used to start a Db2 instance for a given Database System ID (DBSID). If a requested database is already started, the request will be ignored and an info message will be sent.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM AIX systems.

The SAP Start Services for the requested SAP system must be configured in file /usr/sap/sapservices and started. In a standard installation, they are started automatically after a reboot.

## Dependencies

DBSID and SAPSID are the same

## License

Apache License 2.0

## Author Information

SAP on IBM Power Development Team
