# Role upgrade_sap_kernel

The role upgrade_sap_kernel is used to upgrade the kernel of an already installed SAP system with new code that has been downloaded from the SAP Sowftware Distribution Center ([SWDC](https://support.sap.com/swdc)) in SAP Archive (SAR) files. The SAR files must be available in the directory that is specified in variable `sap_kernel_upgrade_download_local_path`.

The role upgrade_sap_kernel needs the SAP System ID as input in variable `sap_sid`, `sap_adm` and `sap_sys`.

## Requirements

This role is intended for the operating system IBM aix. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM aix systems.

The role upgrade_sap_kernel will install the contents of all SAR files in the directory specified in variable `sap_kernel_upgrade_tmp_dir`.
Then directory `sap_kernel_upgrade_dir`will be renamed to `sap_kernel_upgrade_dir_original` and then directory `sap_kernel_upgrade_tmp_dir` will be renamed to `sap_kernel_upgrade_dir`.


### Checking prerequisites for SAP kernel upgrade

SAP has a number of requirements:
   * Check if a system has enough free storage. Exceeding a certain treshold could lead to performance or other problems.
   * Directory Structure for an ABAP System Based on SAP NetWeaver 7.5
   

## Variables

| **Variable** | **Usage** | **Required** |
|:-------------|:----------|:-------------|
|`sap_sid`|SAP system ID|Yes|
|`sap_adm`|SAP admin ID|Yes [(1)](#Remarks)|
|`sap_sys`|SAP system group ID|Yes [(1)](#Remarks)|
|`sap_kernel_upgrade_download_local_path`|Directory path on the Ansible host where SAR file is located|Yes [(1)(2)](#Remarks)|
|`sap_sapcar_download_local_path`|Directory path on the Ansible host where SAPCAR is located|No [(3)](#Remarks)|
|`sap_sapcar_local_path_default`|Fallback directory on the target host where SAPCAR is searched|No [(1)](#Remarks)|
|`sap_kernel_upgrade_dest_dir`|Temporary directory path that will be created on the target host|Yes [(1)](#Remarks)|
|`sap_sapcar_file_name`|Local SAPCAR file name|Yes [(1)](#Remarks)|
|`sap_kernel_upgrade_tmp_dir`|Temporary directory path that will be created on the target host|Yes [(1)(4)](#Remarks)|
|`sap_kernel_upgrade_dir`|Directory path of SAP working directory|Yes [(1)(5)](#Remarks)|

#### Remarks:
1. Default provided
2. 4 sar files are required in `sap_kernel_upgrade_download_local_path` matching the pattern "\*.SAR" or "\*.sar":
   - SAPEXE_nn_xxx.SAR
   - SAPEXEDB_nn_xxx.SAR
   - igsexe_nn_xxx.sar
   - igshelper_nn_xxx.sar
3. SAPCAR will be searched in `sap_sapcar_download_local_path`, `sap_kernel_upgrade_download_local_path` and `sap_sapcar_local_path_default`.
4. Directory 'sap_kernel_upgrade_tmp_dir' will be renamed to 'sap_kernel_upgrade_dir'.
4. Directory 'sap_kernel_upgrade_dir' will be renamed to 'sap_kernel_upgrade_dir'_original.



## Defaults

Suggested default values are provided in defaults/main.yml:

| **Variable** | **Default** |
|:-------------|:------------|
|`sap_adm`|"{{ sap_sid\|lower }}adm"|
|`sap_sys`|"sapsys"|
|`sap_kernel_upgrade_download_local_path`|"/tmp/sar_prov_dir"|
|`sap_sapcar_download_local_path`|"/tmp/sapcar_prov_dir"|
|`sap_sapcar_local_path_default`|"/usr/sap/hostctrl/exe"|
|`sap_kernel_upgrade_dest_dir`|"/usr/sap/tmp/kernel_temp_dir"|
|`sap_sapcar_file_name`|"SAPCAR"|
|`sap_kernel_upgrade_tmp_dir`|"/sapmnt/{{ sap_sid }}/exe/uc/kernel_interims_dir"|
|`sap_kernel_upgrade_dir`|"/sapmnt/{{ sap_sid }}/exe/uc/kernel_working_dir"|

## Dependencies

None.

## Example Playbook
You plan to upgrade a SAP system with SAP SID (sap_sid) PRD having at least one instance on LPAR ibmaixserver01.mycorp.com

ibmaixserver01.mycorp.com has been defined in the inventory file.

You have created the following file <playbook_path>/customer_playbook>.yml

```YAML
    - hosts: ibmaixserver01.mycorp.com
      vars:
      - sap_sid: "PRD"
      roles:
      - role: <ansible_dir>/roles/upgrade_sap_kernel
```

Run the Upgrade of SAP System PRD by:
```YAML
ansible-playbook --verbose <playbook_path>/<customer_playbook>.yml
```

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
