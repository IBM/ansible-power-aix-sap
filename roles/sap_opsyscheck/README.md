# Role sap_opsyscheck

The role sap_opsyscheck is checking some basic operating system settings that are required to run SAP applications on the operating system AIX smoothly. It can be executed prior to the first SAP installation on a new system or partition with the operating system AIX or as a "health check" on systems or partitions where SAP is already installed. The following checks will be performed:

- Check if the nimsh service is running (nimsh is using port 3901 which is used very often in a SAP installation).
- Check if there are 5 GB free space available on the mount point to extract SAP Archives.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system AIX. The target system must be enabled to execute Ansible playbooks. For details, see in the general section about Ansible scripts for SAP on AIX systems.

## Dependencies

None.

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
