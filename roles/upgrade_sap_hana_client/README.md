# Role upgrade_sap_HANA_client

The SAP HANA client is needed to access a remote SAP HANA database from an SAP Application Server ABAP running on AIX. It can be downloaded from the Software Distribution Center in the SAP Support Portal [SWDC](https://support.sap.com/swdc) as an SAP Archive (SAR) file. For preventive maintenance, it is advised to upgrade the SAP HANA client from time to time with the latest version. The role upgrade_sap_hana_client is used to upgrade an existing SAP HANA client from a downloaded SAR file. The role is not intended to install the SAP HANA client on a system where it has not been installed previously. Both SAP HANA client versions are supported, version 1 and version 2.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system IBM aix. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM aix systems.

Make sure that the file system that holds the directory ``/usr/sap`` has enough free diskspace for creating and holding the backup files as well as the temporary file. By default, these files will be created in directory ``/usr/sap/ansible``.

## Dependencies

None.

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
