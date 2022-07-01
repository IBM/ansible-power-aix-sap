# Upgrading to Ansible Content for IBM Power Systems - AIX with SAP Software Version 1.2.0

Note: If migrating from a version less than v1.1.0, also see the [v1.1.0 migration guide wiki](https://github.com/IBM/ansible-power-aix-sap/blob/version-1.1.0/MIGRATION-V1.1.0.md).

# Breaking changes

## Role start_db

The role start_db now requires one of the following tags to specify the database type:

| **tag**            | **Database**                   |
|:-------------------|:-------------------------------|
| `sap_start_db2`    | IBM Db2 for Linux/Unix/Windows |
| `sap_start_hana`   | SAP HANA                       |
| `sap_start_oracle` | Oracle                         |

## Role start_sap

Two of the tags have been renamed to provide more clarity:

| **Old name**               | **New name**             | **Function**                                     |
|:---------------------------|:-------------------------|:-------------------------------------------------|
| `sap_start_instance`       | `sap_start_instances`    | Start one or all instance for one SAP system ID. |
| `sap_start_all_instances`  | `sap_start_all_systems`  | Start all instances for all SAP system IDs.      |

## Role stop_db

The role stop_db now requires one of the following tags to specify the database type:

| **tag**            | **Database**                   |
|:-------------------|:-------------------------------|
| `sap_stop_db2`     | IBM Db2 for Linux/Unix/Windows |
| `sap_stop_hana`    | SAP HANA                       |
| `sap_stop_oracle`  | Oracle                         |

## Role stop_sap

Two of the tags have been renamed to provide more clarity:

| **Old name**              | **New name**            | **Function**                                    |
|:--------------------------|:------------------------|:------------------------------------------------|
| `sap_stop_instance`       | `sap_stop_instances`    | Stop one or all instance for one SAP system ID. |
| `sap_stop_all_instances`  | `sap_stop_all_systems`  | Stop all instances for all SAP system IDs.      |
