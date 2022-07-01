# Role install_saphostagent

The SAP Host Agent is an agent that can accomplish several life-cycle management tasks, such as operating system monitoring, database monitoring, system instance control and provisioning.

SAP is providing bug fixes and enhancements for the SAP Host Agent several times per year. It is advised, to update the SAP Host Agent with the current version from time to time as preventive action. SAP is providing the SAP Host Agent in the SAP Software Distribution Center ([SWDC](https://support.sap.com/swdc)) as an SAP Archive (SAR) file. The role install_saphostagent can be used to install or upgrade the SAP Host Agent from a downloaded SAR file according to the SAP documentation in [SAP Note 1031096](https://launchpad.support.sap.com/#/notes/1031096).

You can find a link to the latest SAP Host Agent documentation in [SAP NOTE 1907566](https://launchpad.support.sap.com/#/notes/1907566)

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM AIX systems.

## Dependencies

None.

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
