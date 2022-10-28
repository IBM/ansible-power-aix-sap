.. _IBM.ansible-power-aix-sap.docsite.upgrade_sap_hana_client:

Role upgrade_sap_hana_client
============================

The SAP HANA client is needed to access a remote SAP HANA database from an SAP Application Server ABAP running on AIX. It can be downloaded from the Software Distribution Center in the SAP Support Portal (`SWDC <https://support.sap.com/swdc>`_) as an SAP Archive (SAR) file. For preventive maintenance, it is advised to upgrade the SAP HANA client from time to time with the latest version. The role upgrade_sap_hana_client is used to upgrade an existing SAP HANA client from a downloaded SAR file. The role is not intended to install the SAP HANA client on a system where it has not been installed previously. Both SAP HANA client versions are supported, version 1 and version 2.

To extract the downloaded SAR file, you must provide the SAP utility SAPCAR and provide it's location in variable ``upglocation_of_SAPCAR_utility_managednode``. By default, SAPCAR is being searched in directory ``/usr/sap/ansible/downloads``.

Before the already installed SAP HANA client is updated, the currently installed version is backed up into a compressed file that follows the naming pattern ``__save_HDB_Client.<Timestamp-Year-Month-Day-Hour-Minute-Second>.tar.Z``. By default, the backup file is saved in directory ``/usr/sap/ansible/hdb_client_backup``. Older backups in this directory are not cleaned up automatically, so you may want to check and clean up the directory manually from time to time.

When you upgrade an SAP HANA client, the downloaded SAR file is extracted into a temporary directory, by default ``/usr/sap/ansible/working_dir/hdb_client``. After a successful installation of the SAP HANA client, this directory will be deleted. After some consistency checks, the upgrade of the SAP HANA client will be performed by executing the program ``hdbinst`` with the parameter ``--path`` and the path name specified in variable ``upgdir_of_HANA_client_managednode``. The default target path name is ``/usr/sap/hdbclient``.

The upgrade operation will fail if an SAP instance is active that is using the currently installed SAP HANA client. In this case, you need to stop the active SAP application server instances and repeat the upgrade.

You can find more information about the SAP HANA Client Installation and Update in the SAP blog: (`SAP HANA Client Installation and Update <https://blogs.sap.com/2017/12/14/sap-hana-2.0-client-installation-and-update-by-the-sap-hana-academy>`_)

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

Make sure that the file system that holds the directory ``/usr/sap`` has enough free diskspace for creating and holding the backup files as well as the temporary file. By default, these files will be created in directory ``/usr/sap/ansible``.

Tags
----

The following tag can be specified optionally. Omitting the tag or specifying tag ``-t all`` has the same effect.

+-------------------------------+-----------------------------------------------------------------------------------------------------+
| Tag                           | Usage                                                                                               |
+===============================+=====================================================================================================+
| ``upgrade_sap_hana_client``   |  The HANA Client will be updated by the version stored in ``upgfile_name_of_HANA_client_SAR_file``  |
+-------------------------------+-----------------------------------------------------------------------------------------------------+



Variables
---------

+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| Variable                                       | Usage                                                                                                 | Required |
+================================================+=======================================================================================================+==========+
| ``upgbackup_for_dir_hana_client_managednode``  | Backup directory to backup the HANA client directory                                                  | Yes [1]_ |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``upgowner_of_client_dir``                     | Owner of the SAP HANA Client directory                                                                | No       |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``upgtemp_working_dir_managednode``            | Temporary directory, that will be created on the target host for extracting the HANA Client SAR file  | Yes [1]_ |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``upglocation_of_HANA_Client_SAR_managednode`` | Directory on the target node where the SAR file of the HANA Client is provided                        | Yes [1]_ |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``upglocation_of_SAPCAR utility_managednode``  | Directory on the target host where SAPCAR utility is provided                                         | Yes [1]_ |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``upgsapcar_file_name``                        | SAPCAR utility file name                                                                              | Yes [1]_ |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``upgdir_of_HANA_client_managednode``          | Directory on the target host where the HANA client resides and should be upgraded                     | Yes [1]_ |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``upgfile_name_of_HANA_client_SAR_file``       | Name of the SAP HANA Client SAR file                                                                  | Yes [1]_ |
+------------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+

Remarks:
^^^^^^^^

.. [1] Default provided.

Defaults
--------

Suggested default values are provided in defaults/main.yml:

+---------------------------------------------------+------------------------------------------------+
| Variable                                          |                    Default                     |
+===================================================+================================================+
| ``upgbackup_for_dir_hana_client_managednode``     | ``"/usr/sap/ansible/hdb_client_backup"``       |
+---------------------------------------------------+------------------------------------------------+
| ``upgtemp_working_dir_managednode``               | ``"/usr/sap/ansible/working_dir/hdb_client"``  |
+---------------------------------------------------+------------------------------------------------+
| ``upglocation_of_HANA_Client_SAR_managednode``    | ``"/usr/sap/ansible/downloads"``               |
+---------------------------------------------------+------------------------------------------------+
| ``upglocation_of_SAPCAR_utility_managednode``     | ``"/usr/sap/ansible/downloads"``               |
+---------------------------------------------------+------------------------------------------------+
| ``upgsapcar_file_name``                           | ``"SAPCAR"``                                   |
+---------------------------------------------------+------------------------------------------------+
| ``upgfile_name_of_HANA_client_SAR_file``          | ``"HANA_CLIENT.SAR"``                          |
+---------------------------------------------------+------------------------------------------------+
| ``upgdir_of_HANA_client_managednode``             | ``"/usr/sap/hdbclient"``                       |
+---------------------------------------------------+------------------------------------------------+



Dependencies
------------

None.

Example Playbook
----------------

The example playbook is used to upgrade the SAP HANA client software for an SAP system named HDA on several hosts. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The necessary SAP archive file IMDB_CLIENT20_013_13-80002090.SAR and the SAPCAR tool must have been downloaded from the SAP Software Distribution Center and stored in directory /usr/sap/ansible/HDA/hdbclient_work. The playbook is located in the current directory, named upg_hdb_client.yaml and has the following contents:

.. code:: yaml

    - name: Upgrade SAP HANA Client
      hosts: ibmaix_servers
       vars:
       - upgowner_of_client_dir: "hdaadm"
       - upgfile_name_of_HANA_client_SAR_file: "IMDB_CLIENT20_013_13-80002090.SAR"
       - upgsapcar_file_name: "SAPCAR"
       - upgdir_of_HANA_client_managednode: "/usr/sap/HDA/hdbclient"
       - upglocation_of_HANA_Client_SAR_managednode: "/usr/sap/ansible/HDA/hdbclient_work"
       - upglocation_of_SAPCAR_utility_managednode: "/usr/sap/ansible/HDA/hdbclient_work"
       - upgbackup_for_dir_hana_client_managednode: "/usr/sap/ansible/HDA/baackup_dir"
      roles:
       - role: <ansible_dir>/roles/upgrade_sap_hana_client

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose -t upgrade_sap_hana_client upg_hdb_client.yaml


License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022

