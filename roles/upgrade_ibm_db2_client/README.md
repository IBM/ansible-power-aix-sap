# Role upgrade_ibm_db2_client

The client software for IBM Db2 for LUW is needed to access a remote Db2 database from an SAP Application Server running on IBM AIX. It can be downloaded from the Software Distribution Center in the SAP Support Portal ([SWDC] (https://support.sap.com/swdc) as a zip file or as ISO image (DVD). For preventive maintenance, it is advised to upgrade the IBM Db2 client from time to time with the latest version. The role upgrade_ibm_db2_client is used to upgrade an existing IBM Db2 client from a downloaded zip file or DVD. The role is not intended to install the IBM Db2 client on a system where it has not been installed previously.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM AIX systems.

## Dependencies

None.

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
