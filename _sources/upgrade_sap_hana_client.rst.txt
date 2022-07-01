.. _IBM.ansible-power-aix-sap.docsite.upgrade_sap_hana_client:

Role upgrade_sap_hana_client
============================

The SAP HANA client provides a set of utilities and drivers to connect to and query a SAP HANA database from multiple programming APIs, such as Node.js, Python or Java as shown below.


SAP is providing bug fixes and enhancements for all their components. Updates for the SAP HANA client are provided by shipping the content in a SAP HANA Client SAR file provided on the the SAP Support Portal (`SWDC <https://support.sap.com/swdc>`_). It is advised to update the SAP HANA Client with the current version from time to time as preventive action.  The role upgrade_sap_HANA_client can be used to upgrade the SAP HANA Client.

This role is used with the tag ``-t upgrade_sap_hana_client``. The role needs a couple of variables described below.
Let's assume you plan to upgrade your SAP HANA client with the newest version: ``IMDB_CLIENT20_013_13-80002090.SAR``.
The you have to provide this SAR file as well as the SAPCAR utility on the target host (the host where you plan to upgrade your SAP HANA Client).
You can specify the location of these files as well as the names. The SAP HANA Client SAR file name as well as the SAPCAR utility name change over time.
Then the role is checking some prerequisites like:
- does the specified SAPCAR Utility exists
- does the specified SAP HANA Client SAR file exist
- does the owner of the SAP HANA Client directory exists
.....

If all these checks are successful, the SAP HANA Client directory will be tarred, compressed and backuped with the following file name pattern:
__save_HDB_Client.<Timestamp-Year-Month-Day-Hour-Minute-Second>.tar.Z

After creation of the backup the ``IMDB_CLIENT20_013_13-80002090.SAR`` will be extracted to a temporary directory. Then it will be checked that the extracted file was really a
HANA Client SAR file. If all this is ok, then the HANA Client will be updated.
The update will fail if an Application Server (AS) is using the HANA Client to be updated. An error is issued as well as the hint that an AS using this client might be active.
Then you have to shutdown all the SAP instances using this Client.



You can find more information about the SAP HANA Client Installation and Update ind the SAP blog: (`SAP HANA Client Installation and Update <https://blogs.sap.com/2017/12/14/sap-hana-2.0-client-installation-and-update-by-the-sap-hana-academy>`_)

.. contents:: Table of contents
   :depth: 2

Requirements
------------


This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

Checking prerequisites for installing the SAP HANA Client
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Check that ``/usr/sap`` has enough free diskspace for creating and holding the backup files as well as the temporary file.
All these files and directories will be created under ``/usr/sap/ansible``


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
| ``upgowner_of_client_dir``                     | Owner of the SAP HANA Client directory                                                                | No  [1]_ |
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
| ``upglocation_of_SAPCAR utility_managednode``     | ``"/usr/sap/ansible/downloads"``               |
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

You plan to install a new version (IMDB_CLIENT20_013_13-80002090.SAR) of the SAP HANA Client  on LPAR ibmaix_servers.

ibmaix_servers has been defined in the inventory file as shown in the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>`.

The example playbook in the current directory is named  upg_hdb_client.yaml and has the following contents:

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

Run the installation by:

.. code:: yaml

   ansible-playbook --verbose -t upgrade_sap_hana_client upg_hdb_client.yaml

-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022

