# Role sap_install_app_server

After the initial install of an SAP system, you can add or remove additional application servers for that SAP system to distribute the workload better when the usage of the SAP system increases or decreases. The SAP Software Provisioning Manager (SWPM) is offering options to install or uninstall SAP application servers for an existing SAP system. For more information about the SWPM, see the SAP documentation at the link <a href="https://support.sap.com/en/tools/software-logistics-tools.html#section_622087154>">SAP Software Logistics - Software Provisioning</a>.

Typically, the SWPM is used as an interactive tool which takes the input from the SAP administrator to perform the selected installation activity. Besides that, the SWPM can be executed in unattended mode and process a parameter input file that has been prepared prior to the actual execution. For more information about the unattended mode for the SWPM, see <a href="https://launchpad.support.sap.com/#/notes/2230669">SAP Note 2230669</a> and the <a href="https://help.sap.com/docs/SOFTWARE_PROVISIONING_MANAGER/30839dda13b2485889466316ce5b39e9/c8ed609927fa4e45988200b153ac63d1.html>">SAP Installation Documentation SWPM 1.0</a> / <a href="https://help.sap.com/docs/SOFTWARE_PROVISIONING_MANAGER/30839dda13b2485889466316ce5b39e9/6865029dacbe473fadd8eff339bfa568.html>">SAP Installation Documentation SWPM 2.0</a>, section "System Provisioning Using a Parameter Input File".

The role sap_install_app_server is installing or uninstalling additional application servers on AIX using the SWPM in unattended mode. Currently, the databases SAP HANA and IBM Db2 for LUW (Linux, UNIX, and Windows) are supported by this role. To execute the SWPM in unattended mode, the role is using a parameter input file called "inifile.params". The role sap_install_app_server can create its own input file based on Ansible input variables during its execution or use an already existing input file that has been created by the SWPM previously.

Currently, installations for additional SAP ABAP application servers based on SAP NetWeaver 7.4 and higher are supported with a database of type SAP HANA or IBM Db2 for LUW. Both SWPM versions 1.0 and 2.0 can be used in accordance with SAP's guidelines. For IBM Db2 for LUW, only SWPM version 1.0 is available. Make sure you are using the right SWPM version for your SAP product when installing an additional SAP ABAP application server.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system AIX. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on AIX systems.

The role sap_install_app_server must be executed by a user with UID 0. The SAP installation on AIX will not work for a user with a different UID.

The host must have enough free space on disk to store and execute an SAP application server. The amount of storage needed depends on many factors, such as number of active SAP users, the number of SAP work processes and SAP buffer sizes.

A current version of the SAP Host Agent must be installed.

The database, ASCS instance and primary application server instance (or the central instance) of the SAP system must be installed. At least the ASCS instance of the SAP system must be active.

The global directories of the SAP system (``/sapmnt/<sid>/exe``, ``/sapmnt/<sid>/global``, ``/sapmnt/<sid>/j2ee`` and ``/sapmnt/<sid>/profile``)  must be accessible by the installation user from the managed node.

## Dependencies

None.

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
