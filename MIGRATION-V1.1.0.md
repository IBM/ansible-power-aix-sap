# Upgrading to Ansible Content for IBM Power Systems - AIX with SAP Software Version 1.1.0

# Breaking changes

With version 1.1.0, new conventions for variable names were introduced to increase clarity about their usage. These are the guidelines:

- Each variable name has a prefix that indicates the role for which it is used, such as insshagnt_ for the role install_saphostagent.
- The second component of a variable name indicates whether the variable contains user input, a directory name, a file name or a boolean (true/false) value.
- If the variable name is referring to a directory, the suffix in the variable name indicates whether the directory is located on the Ansible controlling node or managed node.

## Role install_saphostagent

The following variables have been renamed:

| **Old name**                        | **New name**                                |
|:------------------------------------|:--------------------------------------------|
| `sap_hostagent_download_local_path` | `insshagnt_dir_download_controlnode`        |
| `sap_hostagent_sar_file_name`       | `insshagnt_input_file_saphostagent_sar`     |
| `sap_sapcar_download_local_path`    | `insshagnt_dir_download_sapcar_controlnode` |
| `sap_sapcar_local_path_default`     | `insshagnt_dir_sapcar_default_managednode`  |
| `sap_sapcar_local_path`             | `insshagnt_dir_sapcar_managednode`          |
| `sap_hostagent_sapcar_file_name`    | `insshagnt_file_sapcar`                     |
| `sap_hostagent_agent_tmp_directory` | `insshagnt_dir_temp_managednode`            |
| `sap_hostagent_clean_tmp_directory` | `insshagnt_bool_clean_dir_temp_managednode` |

## Role start_sap

The following variables have been renamed:

| **Old name**     | **New name**                       |
|:-----------------|:-----------------------------------|
| `sap_sid`        | `startsap_input_sap_sid`           |
| `sap_nr`         | `startsap_input_sap_instance_nr`   |
| `sapctr_exe_dir` | `startsap_dir_sapctrl_managednode` |

## Role stop_sap

The following variables have been renamed:

| **Old name**      | **New name**                      |
|:------------------|:----------------------------------|
| `sap_sid`         | `stopsap_input_sap_sid`           |
| `sap_nr`          | `stopsap_input_sap_instance_nr`   |
| `sapctr_exe_dir`  | `stopsap_dir_sapctrl_managednode` |
| `sap_softtimeout` | `stopsap_softtimeout`             |

## Role upgrade_sap_kernel

The following variables have been renamed:

| **Old name**                             | **New name**                                      |
|:-----------------------------------------|:--------------------------------------------------|
| `sap_sid`                                | `upgsapkrn_input_sap_sid`                         |
| `sap_adm`                                | `upgsapkrn_input_sap_adm`                         |
| `sap_sys`                                | `upgsapkrn_input_sap_sys`                         |
| `sap_kernel_upgrade_download_local_path` | `upgsapkrn_dir_download_sar_controlnode`          |
| `sap_sapcar_download_local_path`         | `upgsapkrn_dir_download_sapcar_controlnode`       |
| `sap_sapcar_local_path_default`          | `upgsapkrn_dir_sapcar_default_managednode`        |
| `sap_kernel_upgrade_dest_dir`            | `upgsapkrn_dir_upload_managednode`                |
| `sap_sapcar_file_name`                   | `upgsapkrn_file_sapcar`                           |
| (new)                                    | `upgsapkrn_dir_extracted_sar_managednode`         |
| (new)                                    | `upgsapkrn_dir_kernel_backup_managednode`         |
| `sap_kernel_upgrade_tmp_dir`             | (obsolete)                                        |
| `sap_kernel_upgrade_dir`                 | `upgsapkrn_dir_upgrade_kernel`                    |
