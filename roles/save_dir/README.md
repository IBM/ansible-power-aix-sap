# Role save_dir

The role save_dir can be used to save the content of a given directory. Currently the role supports saving SAP work directories, such as /usr/sap/``sid``/``instance``/work. The content of the selected directory is compressed with the tar utility and saved to a directory that is specified through an input parameter. The compressed archive will not include core files and soft links.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system AIX. The target system must be enabled to execute Ansible playbooks. For details, see in the general section about Ansible scripts for SAP on AIX systems.

## Dependencies

None.

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
