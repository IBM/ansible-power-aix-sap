# Role install_saphostagent

The SAP Host Agent is an agent that can accomplish several life-cycle management tasks, such as operating system monitoring, database monitoring, system instance control and provisioning.

SAP is providing bug fixes and enhancements for the SAP Host Agent several times per year. It is advised, to update the SAP Host Agent with the current version from time to time as preventive action. SAP is providing the SAP Host Agent in the SAP Software Distribution Center ([SWDC](https://support.sap.com/swdc)) as an SAP Archive (SAR) file. The role install_saphostagent can be used to install or upgrade the SAP Host Agent from a downloaded SAR file according to the SAP documentation in [SAP Note 1031096](https://launchpad.support.sap.com/#/notes/1031096).

Please find the latest Documentation in [SAP NOTE 1907566](https://launchpad.support.sap.com/#/notes/1907566)

## Requirements

This role is intended for the operating system IBM aix. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM aix systems.

### Checking prerequisites for installing the SAP Host Agent

   * Check if a target system has enough free storage.


## Variables

| **Variable** | **Usage** | **Required** |
|:-------------|:----------|:-------------|
|`sap_hostagent_download_local_path`|Directory path on the Ansible host where SAR file is located|Yes [(1)](#Remarks)|
|`sap_sapcar_download_local_path`|Directory path on the Ansible host where SAPCAR is located|No [(3)](#Remarks)|
|`sap_hostagent_sar_file_name`|Name of the SAR file in the download directory on the target host that contains the SAP Host Agent|No [(2)](#Remarks)|
|`sap_sapcar_download_local_path`|Directory path on the Ansible host where SAPCAR is located|No [(3)](#Remarks)|
|`sap_sapcar_local_path_default`|Directory on the target host where SAPCAR is searched|No [(1)](#Remarks)|
|`sap_hostagent_sapcar_file_name`|Local SAPCAR file name|Yes [(1)](#Remarks)|
|`sap_hostagent_agent_tmp_directory`|Temporary directory path that will be created on the target host|Yes [(1)](#Remarks)|
|`sap_hostagent_clean_tmp_directory`|Boolean variable to indicate if the temporary directory will be removed or not after the installation|Yes [(1)](#Remarks)|


#### Remarks:
1. Default provided
2. Defaults to the alphanumerically last filename in `sap_hostagent_download_local_path` that is matching the pattern "\*.SAR" or "\*.sar"
3. SAPCAR will be searched in following sequence: `sap_sapcar_download_local_path` and `sap_hostagent_download_local_path` and `sap_sapcar_local_path_default`.

## Defaults

Suggested default values are provided in defaults/main.yml:

| **Variable** | **Default** |
|:-------------|:------------|
|`sap_hostagent_download_local_path` | "/tmp/downloads" |
|`sap_sapcar_download_local_path` | "/tmp/sapcar" |
|`sap_sapcar_local_path_default` | "/usr/sap/hostctrl/exe" |
|`sap_hostagent_sapcar_file_name` | "SAPCAR" |
|`sap_hostagent_agent_tmp_directory` | "/tmp/hostctrl" |
|`sap_hostagent_clean_tmp_directory` | True |

## Dependencies

None.

## Example Playbook

You plan to install a new version (SAPHOSTAGENT50_50-20009388.SAR) of the SAP HostAgent on LPAR ibmaixserver01.mycorp.com

ibmaixserver01.mycorp.com has been defined in the inventory file.

You have created the following file <playbook_path>/customer_playbook>.yml

```YAML
    ---
 - name: Install SAPHOST Agent
   hosts: ibmaixserver01.mycorp.com
   vars:
    sap_hostagent_sar_file_name: "SAPHOSTAGENT50_50-20009388.SAR"
    sap_hostagent_download_local_path: "/tmp/downloads"
    sap_sapcar_download_local_path:    "/tmp/downloads"
    sap_hostagent_sapcar_file_name:    "SAPCAR"
    sap_hostagent_agent_tmp_directory: "/tmp/hostctrl"
    sap_hostagent_clean_tmp_directory: True
   roles:
    - { role: <ansible_dir>/roles/install_saphostagent }

```

Run the installation by:
```YAML
ansible-playbook --verbose <playbook_path>/<customer_playbook>.yml
```


## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
