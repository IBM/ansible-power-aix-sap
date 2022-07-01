# Role upgrade_sap_kernel

The role upgrade_sap_kernel is used to upgrade the kernel of an already installed SAP system with new code that has been downloaded from the SAP Sowftware Distribution Center ([SWDC](https://support.sap.com/swdc)) in SAP Archive (SAR) files. The SAR files must be available in the directory that is specified in variable `upgsapkrn_dir_download_sar_controlnode`.

The role upgrade_sap_kernel needs the SAP System ID as input in variable `upgsapkrn_input_sap_sid`, `upgsapkrn_input_sap_adm` and `upgsapkrn_input_sap_sys`.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Requirements

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM AIX systems.

The role upgrade_sap_kernel will create a backup of directory `upgsapkrn_dir_upgrade_kernel` on the managed node into directory `upgsapkrn_dir_kernel_backup_managednode` on the managed node.

All provided SAR files will be extracted into directory on the managed node specified in variable `upgsapkrn_dir_extracted_sar_managednode`.
The extracted files will be copied into directory on the managed node specified in variable `upgsapkrn_dir_upgrade_kernel`.

## Dependencies

None.

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
