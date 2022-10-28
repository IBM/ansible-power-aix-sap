# Upgrading to Ansible Content for IBM Power Systems - AIX with SAP Software Version 1.3.0

Note: If migrating from a version less than v1.2.0, also see the [v1.2.0 migration guide wiki](https://github.com/IBM/ansible-power-aix-sap/blob/version-1.2.0/MIGRATION-V1.2.0.md).

# Breaking changes

With version 1.3.0, the Ansible collection for SAP on AIX was enabled to be executed with the Ansible Automation Platform 2. To accomplish this, the location for downloaded files had to be moved from the controlling node to the managed node in several roles. These changes affect variable names which can be specified by the users of the roles.

## Role install_saphostagent

The location of the SAPCAR tool and the downloaded SAP archive (SAR) file with the SAP Host Agent is now on the managed node. The following variables have been renamed:

| **Old name**                                | **New name**                                | **Function**                                                 |
|:--------------------------------------------|:--------------------------------------------|:-------------------------------------------------------------|
| `insshagnt_dir_download_sapcar_controlnode` | `insshagnt_dir_sapcar_managednode`          | Directory path where SAPCAR is located.                      |
| `insshagnt_dir_download_controlnode`        | `insshagnt_dir_download_managednode`        | Directory path where the SAP Host Agent SAR file is located. |

## Role upgrade_sap_kernel

The location of the SAPCAR tool and the downloaded SAP archive (SAR) file with the SAP kernel is now on the managed node. The following variables have been renamed:

| **Old name**                                | **New name**                                | **Function**                                                 |
|:--------------------------------------------|:--------------------------------------------|:-------------------------------------------------------------|
| `upgsapkrn_dir_download_sapcar_controlnode` | `upgsapkrn_dir_download_sapcar_managednode` | Directory path where SAPCAR is located.                      |
| `upgsapkrn_dir_download_sar_controlnode`    | `upgsapkrn_dir_download_sar_managednode`    | Directory path where the SAP kernel SAR file is located.     |

