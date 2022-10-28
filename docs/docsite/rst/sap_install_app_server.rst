.. _IBM.ansible-power-aix-sap.docsite.sap_install_app_server:

Role sap_install_app_server
===========================

After the initial install of an SAP system, you can add or remove additional application servers for that SAP system to distribute the workload better when the usage of the SAP system increases or decreases. The SAP Software Provisioning Manager (SWPM) is offering options to install or uninstall SAP application servers for an existing SAP system. For more information about the SWPM, see the SAP documentation at the link `SAP Software Logistics - Software Provisioning <https://support.sap.com/en/tools/software-logistics-tools.html#section_622087154>`_.

Typically, the SWPM is used as an interactive tool which takes the input from the SAP administrator to perform the selected installation activity. Besides that, the SWPM can be executed in unattended mode and process a parameter input file that has been prepared prior to the actual execution. For more information about the unattended mode for the SWPM, see `SAP Note 2230669 <https://launchpad.support.sap.com/#/notes/2230669>`_ and the `SAP Installation Documentation SWPM 1.0 <https://help.sap.com/docs/SOFTWARE_PROVISIONING_MANAGER/30839dda13b2485889466316ce5b39e9/c8ed609927fa4e45988200b153ac63d1.html>`_ / `SAP Installation Documentation SWPM 2.0 <https://help.sap.com/docs/SOFTWARE_PROVISIONING_MANAGER/30839dda13b2485889466316ce5b39e9/6865029dacbe473fadd8eff339bfa568.html>`_, section "System Provisioning Using a Parameter Input File".

The role sap_install_app_server is installing or uninstalling additional application servers on AIX using the SWPM in unattended mode. Currently, the databases SAP HANA and IBM Db2 for LUW (Linux, UNIX, and Windows) are supported by this role. To execute the SWPM in unattended mode, the role is using a parameter input file called "inifile.params". The role sap_install_app_server can create its own input file based on Ansible input variables during its execution or use an already existing input file that has been created by the SWPM previously.

Currently, installations for additional SAP ABAP application servers based on SAP NetWeaver 7.4 and higher are supported with a database of type SAP HANA or IBM Db2 for LUW. Both SWPM versions 1.0 and 2.0 can be used in accordance with SAP's guidelines. For IBM Db2 for LUW, only SWPM version 1.0 is available. Make sure you are using the right SWPM version for your SAP product when installing an additional SAP ABAP application server.

If the SWPM is executed in unattended mode by Ansible and an error occurs, you will have to check the SWPM installation directory for the cause, like in a manual installation. After correcting the error, you can restart the Ansible playbook again, and the SWPM will continue the current installation in unattended mode at the point of the failure.

.. contents:: Table of contents
   :depth: 3

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

The role sap_install_app_server must be executed by a user with UID 0. The SAP installation on AIX will not work for a user with a different UID.

The host must have enough free space on disk to store and execute an SAP application server. The amount of storage needed depends on many factors, such as number of active SAP users, the number of SAP work processes and SAP buffer sizes.

A current version of the SAP Host Agent must be installed.

The database, ASCS instance and primary application server instance (or the central instance) of the SAP system must be installed. At least the ASCS instance of the SAP system must be active.

The global directories of the SAP system (``/sapmnt/<sid>/exe``, ``/sapmnt/<sid>/global``, ``/sapmnt/<sid>/j2ee`` and ``/sapmnt/<sid>/profile``) must be accessible by the installation user from the managed node.

Tags
----

Specify one of the following tags to specify if you want to install or uninstall an additional application server. If you do not specify a tag, an error message will be sent.

+------------------------------+-------------------------------------------------------------------+
| Tag                          | Usage                                                             |
+==============================+===================================================================+
| ``sap_install_app_server``   | Install an additional SAP application server.                     |
+------------------------------+-------------------------------------------------------------------+
| ``sap_uninstall_app_server`` | Remove an existing SAP application server and its components.     |
+------------------------------+-------------------------------------------------------------------+

Variables
---------

+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| Variable                                              | Usage                                                                                            | Required           |
+=======================================================+==================================================================================================+====================+
| ``insappsvr_input_install_mode``                      | Variable which determines what inifile.params is taken for the Unattended Installation process:  | Yes [1]_           |
|                                                       | ``reuseInifile`` = An already prepared inifile.params of the SWPM.                               |                    |
|                                                       | ``createInifile`` = A new inifile.params created by Ansible using the input variables.           |                    |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_dir_swpm10_managednode``                  | Directory where the SWPM 1.0 software is located.                                                | Yes [2]_           |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_dir_swpm20_managednode``                  | Directory where the SWPM 2.0 software is located.                                                | Yes [2]_           |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_swpm_version``                      | The SWPM software version which will be used: ``SWPM10`` or ``SWPM20``.                          | Yes [1]_           |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_logfile_path``                            | Temporary directory path where installation and uninstall logs and data is saved.                | No [1]_            |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_sap_sid``                           | The SAP SID of the SAP system used for the installation of the additional application server.    | Yes [7]_           |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_file_inifile``                      | Directory where the prepared inifile.params and the instkey.pkey are located.                    | Yes [7]_ [3]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_initfile_NW_AS_instanceNumber``     | The SAP Instance Number of the SAP system for the installation.                                  | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_nwUsers_sapsysGID``                 | GID of the SAP user sapsys.                                                                      | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_nwUsers_sapsysGID``                 | UID of the SAP user <sapsid>adm.                                                                 | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_NW_GetMasterPassword``              | Encrypted password master password used by the SWPM.                                             | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_SAPInstDes25Hash``                  | Encryption string of the inifile.params used by the SWPM.                                        | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_instkey``                           | Encryption string of the instkey.pkey used by the SWPM.                                          | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_SAPDBType``                         | The SAP database type: ``HDB`` for SAP HANA or ``DB6`` for IBM Db2 for LUW.                      | Yes [7]_ [5]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_NW_release``                        | The SWPM Product ID needed for the SAP release of the SAP system.                                | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_dir_hdbclient_managednode``         | Directory where the HANA database client media is located when SWPM 1.0 is used.                 | Yes [7]_ [6]_ [4]_ |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_dir_downloadbasket_managednode``    | Directory where the SAP archives (SAR files) are located: IGSHELPER and HANA DB client.          | Yes [7]_ [6]_ [4]_ |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_HDB_Schema_schemaName``             | The SAP HANA database schema (only used with SAP HANA).                                          | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_HDB_Schema_schemaPassword``         | Encrypted password of SAP HANA database schema (only used with SAP HANA).                        | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_HDB_getDBInfo_instanceNumber``      | The HDB Instance Number (only used with SAP HANA).                                               | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_db6_abap_connect_user``             | The Db2 for LUW ABAP connect user (only used with IBM Db2 LUW).                                  | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_db6_abap_schema``                   | The Db2 for LUW ABAP ABAP schema (only used with IBM Db2 LUW).                                   | Yes [7]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_db6_install_AAS_on_DBHost``         | The SWPM behaves different when installing the additional application server on a host where the | Yes [7]_ [1]_      |
|                                                       | Db2 for LUW database schema is installed and where the related database users exist. The         |                    |
|                                                       | variable defines the type of the installation host:                                              |                    |
|                                                       | ``true`` = The appication server is installed on a database instance host.                       |                    |
|                                                       | ``false`` = The appication server is installed on a host without database und db users.          |                    |
|                                                       | Note: This variable has no effect on the uninstall.                                              |                    |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_nwUsers_db6_db2sidPassword``        | Encrypted password of the Db2 for LUW database administrator user db2<dbsid> (only used with IBM | Yes [7]_ [4]_      |
|                                                       | Db2 LUW and only on a database instance host).                                                   |                    |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_nwUsers_db6_sapsidPassword``        | Encrypted password of the Db2 for LUW ABAP database connect user sap<sapsid> (only used with IBM | Yes [7]_ [4]_      |
|                                                       | Db2 LUW and only on a database instance host).                                                   |                    |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``insappsvr_input_nwUsers_sidadmPassword``            | Encrypted password of the <sapsid>adm user (only used with IBM Db2 LUW and only on a database    | Yes [7]_ [4]_      |
|                                                       | instance host).                                                                                  |                    |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``uninsappsvr_input_swpm_version``                    | The SWPM software version which will be used: ``SWPM10`` or ``SWPM20``.                          | Yes [1]_           |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``uninsappsvr_input_sap_sid``                         | The SAP SID of the SAP system used for the uninstall of the additional application server.       | Yes [8]_           |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``uninsappsvr_input_file_inifile``                    | Directory where the prepared inifile.params and the instkey.pkey are located for the uninstall.  | Yes [8]_ [3]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+
| ``uninsappsvr_input_initfile_NW_AS_instanceNumber``   | The SAP Instance Number of the SAP system for the uninstall.                                     | Yes [8]_ [4]_      |
+-------------------------------------------------------+--------------------------------------------------------------------------------------------------+--------------------+

Remarks:
^^^^^^^^

.. [1] Default provided.
.. [2] Required software and the location of the software has to be provided.
.. [3] Only needed in mode reuseInifile.
.. [4] Only needed in mode createInifile. For encrypted data like passwords, the data has to be copied directly from the SWPM generated files inifile.params and instkey.pkey!
.. [5] Only needed in mode createInifile. Default provided.
.. [6] Use only SAP media and SAP archives which are compatible with the target SAP system (the most current patch level of the version which was initially used to setup the SAP system).
.. [7] Only needed for the installation of an additional application server.
.. [8] Only needed for the uninstall of an existing application server.

Defaults
--------

Suggested default values are provided in defaults/main.yml:

+-----------------------------------------------+-----------------------------+
| Variable                                      | Default                     |
+===============================================+=============================+
| ``insappsvr_input_install_mode``              | ``"reuseInifile"``          |
+-----------------------------------------------+-----------------------------+
| ``insappsvr_input_swpm_version``              | ``"SWPM20"``                |
+-----------------------------------------------+-----------------------------+
| ``insappsvr_logfile_path``                    | ``"/tmp/Ansible/SWPM"``     |
+-----------------------------------------------+-----------------------------+
| ``uninsappsvr_input_swpm_version``            | ``"SWPM20"``                |
+-----------------------------------------------+-----------------------------+
| ``insappsvr_input_SAPDBType``                 | ``"HDB"``                   |
+-----------------------------------------------+-----------------------------+
| ``insappsvr_input_db6_install_AAS_on_DBHost`` | ``"false"``                 |
+-----------------------------------------------+-----------------------------+

The file defaults/main.yml contains more entries, but the values for the other variables are set to empty strings. These entries are required to ensure complete contents in inifile.params when variable ``insappsvr_input_install_mode`` is set to ``createInifile``. It is in the responsibility of the playbook to set meaningful values as required for the selected operation.

Dependencies
------------

None.

Example Playbooks
-----------------

SAP Installation
^^^^^^^^^^^^^^^^

**Example Playbook for the installation of the SAP additional application server reusing an existing inifile.params and the related instkey.pkey**

The first example playbook is used to install an additional application server for an already installed SAP system with the SAP system ID (SID) PRD on a host named ibmaixserver02.mycorp.com. The underlying database is SAP HANA. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. During the installation, a previously prepared file name inifile.params will be used. For more information how to create an inifile.params file, see `SAP Note 2230669 <https://launchpad.support.sap.com/#/notes/2230669>`_. Make sure that the software locations defined in the file inifile.params are available, for example the SAP HANA database client. The example playbook in the current directory is named sap_install_app_server_reuseInifile_hdb.yml and has the following contents:

.. code:: yaml

    - name: Install HANA SAP Additional Application Server
      hosts: ibmaixserver02.mycorp.com
      vars:
       - insappsvr_input_install_mode: "reuseInifile"
       - insappsvr_input_sap_sid: "PRD"
       - insappsvr_dir_swpm_managednode: "/tmp/ANSIBLE/SWPM/SWPM20"
       - insappsvr_input_swpm_version: "SWPM20"
       - insappsvr_input_SAPDBType: "HDB"
       - insappsvr_input_file_inifile: "/tmp/ANSIBLE/SWPM/inifiles/PRD/inst/07/inifile.params"
      roles:
       - role: <ansible_dir>/roles/sap_install_app_server

**HANA: SWPM 1.0 only**

Note: Due to a glitch in the SWPM, the location of the SAP HANA DB client media will not be automatically saved in inifile.params after is has been specified during the installation dialog. Add the following line manually to inifile.params before using it with this Ansible role::

    SAPINST.CD.PACKAGE.RDBMS-HDB-CLIENT=<SAP_HANA_DB_Client_Media_Directory>

This is also explained in the SAP installation documentation.

**HANA: SWPM 2.0 only**

Note: After specifying the download location for the SAP archive (SAP file) of the SAP HANA DB client, it will be stored as parameter `archives.downloadBasket` in the file inifile.params. Ensure that this parameter points to a directory that contains the SAP archives, but not to a single SAP archive file. Correct the parameter, if necessary. For example, change `archives.downloadBasket=/tmp/SAP/downloadBasket/IMDB_CLIENT20_012_25-80002090.SAR` to `archives.downloadBasket=/tmp/SAP/downloadBasket`.

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose sap_install_app_server_reuseInifile_hdb.yml -t sap_install_app_server

If you want to install an additional application server for an SAP system with SAP system ID (SID) QAS running with IBM Db2 for LUW on a host named ibmaixserver02.mycorp.com instead, the playbook would look like the following example. It is located in the current directory, named sap_install_app_server_reuseInifile_db6.yml and has the following contents:

.. code:: yaml

    - name: Install DB6 SAP Additional Application Server
      hosts: ibmaixserver02.mycorp.com
      vars:
       - insappsvr_input_install_mode: "reuseInifile"
       - insappsvr_input_sap_sid: "QAS"
       - insappsvr_dir_swpm_managednode: "/tmp/ANSIBLE/SWPM/SWPM10"
       - insappsvr_input_swpm_version: "SWPM10"
       - insappsvr_input_SAPDBType: "DB6"
       - insappsvr_input_db6_install_AAS_on_DBHost: "true"
       - insappsvr_input_file_inifile: "/tmp/ANSIBLE/SWPM/inifiles/QAS/inst/06/inifile.params"
      roles:
       - role: <ansible_dir>/roles/sap_install_app_server

Note: In this example, the application server is installed on the same host where the related SAP dababase is located. For this, the variable ``insappsvr_input_db6_install_AAS_on_DBHost`` is set to ``"true"``. There will be an error message when the file inifile.params was created on a host without the SAP database.

**Db2 for LUW: Database host and DB user passwords**

Note: The SWPM behaves different when installing the additional application server on a host where the Db2 for LUW database schema is installed and where the related database users exist. Especially the SWPM asks for the passwords of the users db2<dbsid>, sap<sapsid> and <sapsis>adm. For that the handling of the input variables and the file inifile.params is different. The variable ``insappsvr_input_db6_install_AAS_on_DBHost`` defines the type of the installation host: ``"true"`` = The appication server is installed on a database instance host. ``"false"`` = The appication server is installed on a host without database und db users (default).

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose sap_install_app_server_reuseInifile_db6.yml -t sap_install_app_server


**Example Playbook for the installation of the SAP additional application server creating its own inifile.params and the related instkey.pkey**

The example playbook is used to install an additional application server for an already installed SAP system with the SAP system ID (SID) PRD on a host named ibmaixserver02.mycorp.com. The underlying database is SAP HANA. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. During the installation, the installation parameter file inifile.params will be created based on the specified parameters. For more information how to create an inifile.params file, see `SAP Note 2230669 <https://launchpad.support.sap.com/#/notes/2230669>`_. Make sure that the software locations defined in the file inifile.params are available, for example the SAP HANA database client. The example playbook in the current directory is named sap_install_app_server_createInifile.yml and has the following contents:

.. code:: yaml

    - name: Install SAP Additional Application Server
      hosts: ibmaixserver02.mycorp.com
      vars:
       - insappsvr_input_install_mode: "createInifile"
       - insappsvr_input_sap_sid: "PRD"
       - insappsvr_dir_swpm_managednode: "/tmp/ANSIBLE/SWPM/SWPM20"
       - insappsvr_input_swpm_version: "SWPM20"
       - insappsvr_input_initfile_NW_AS_instanceNumber: "07"
       - insappsvr_input_nwUsers_sapsysGID: "204"
       - insappsvr_input_nwUsers_sidAdmUID: "205"
       - insappsvr_input_NW_GetMasterPassword: "des25(71cIuqdFOxGZRkPNI3r5iAxx)"
       - insappsvr_input_SAPInstDes25Hash: "SAPInstDes25Hash=$eY3ELBT5gQ2Z$C+eS02APqADAELB7RK2SuI2rZCajRanfIv/JgPeqeAesO7SPAT9Bj1Ycxf6tV/QHkrMqW1i2QHLqPLTwy8f6xicu2fsLNQjX"
       - insappsvr_input_instkey: "5HhD4qsHDP6S+eJXsVu3xeU1dh4nu78x"
       - insappsvr_input_NW_release: "NW_DI:S4HANA2020.CORE.HDB.PD"
       - insappsvr_input_SAPDBType: "HDB"
       - insappsvr_input_dir_downloadbasket_managednode: "/tmp/ANSIBLE/SWPM/downloadbasket"
       - insappsvr_input_HDB_Schema_schemaName: "SAPHDBABAP"
       - insappsvr_input_HDB_Schema_schemaPassword: "des25(iD9vfeDFE1otL9JQbPeF6Qxx)"
       - insappsvr_input_HDB_getDBInfo_instanceNumber: "00"
      roles:
       - role: <ansible_dir>/roles/sap_install_app_server
       
To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose sap_install_app_server_createInifile_hdb.yml -t sap_install_app_server

If you want to install an additional application server for an SAP system with SAP system ID (SID) QAS running with IBM Db2 for LUW on a host named ibmaixserver02.mycorp.com instead, the playbook would look like the following example. It is located in the current directory, named sap_install_app_server_createInifile_db6.yml and has the following contents:

.. code:: yaml

    - name: Install SAP Additional Application Server
      hosts: ibmaixserver02.mycorp.com
      vars:
       - insappsvr_input_install_mode: "createInifile"
       - insappsvr_input_sap_sid: "QAS"
       - insappsvr_dir_swpm_managednode: "/tmp/ANSIBLE/SWPM/SWPM10"
       - insappsvr_input_swpm_version: "SWPM10"
       - insappsvr_input_initfile_NW_AS_instanceNumber: "06"
       - insappsvr_input_nwUsers_sapsysGID: "204"
       - insappsvr_input_nwUsers_sidAdmUID: "206"
       - insappsvr_input_NW_GetMasterPassword: "des25(56cIuqdFOxGZRkPNI3r5iAac)"
       - insappsvr_input_SAPInstDes25Hash: "SAPInstDes25Hash=$eABCLBT5gQ2Z$C+eS02APqADAELB7RK2SuI2rZCajRanfIv/JgPeqeAesO7SPAT9Bj1Ycxf6tV/QHkrMqW1i2QHLqPLTwy8f6xicu2fsLNHgR"
       - insappsvr_input_instkey: "6GTD4qsHDP6S+eJXsVu3xeU1dh4nu99y"
       - insappsvr_input_NW_release: "NW_DI:NW740SR2.DB6.PD"
       - insappsvr_input_SAPDBType: "DB6"
       - insappsvr_input_db6_abap_connect_user: "sapqas"
       - insappsvr_input_db6_abap_schema: "sapqas"
       - insappsvr_input_db6_install_AAS_on_DBHost: "true"
       - insappsvr_input_nwUsers_db6_db2sidPassword: "des25(zu2QR4pSRsdfSi3RxDqsWOjk)"
       - insappsvr_input_nwUsers_db6_sapsidPassword: "des25(erg1Z5eUu3nsv/YN1MUUjle4)"
       - insappsvr_input_nwUsers_sidadmPassword: "des25(weM5aP97L6743LWxfnIEfdt7)"
      roles:
       - role: <ansible_dir>/roles/sap_install_app_server
       
Note: In this example, the application server is installed on the same host where the related SAP dababase is located. For this, the variable ``insappsvr_input_db6_install_AAS_on_DBHost`` is set to ``"true"``. For an installation on a database host the passwords for the users db2<dbsid>, sap<sapsid> and <sapsid>adm are needed.

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose sap_install_app_server_createInifile_db6.yml -t sap_install_app_server

For some selected entries for the playbook Yaml file you must use the following mapping table to copy the needed values from the file inifile.params and the file instkey.pkey:

+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| Variable in the playbook                          | Parameter in the file inifile.params        | Remarks                                 |
+===================================================+=============================================+=========================================+
| ``insappsvr_input_sap_sid``                       | ``NW_readProfileDir.profileDir``            | Get the <SID> from the profile dir name |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_initfile_NW_AS_instanceNumber`` | ``NW_AS.instanceNumber``                    |                                         |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_nwUsers_sapsysGID``             | ``nwUsers.sapsysGID``                       |                                         |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_nwUsers_sidAdmUID``             | ``nwUsers.sidAdmUID``                       |                                         |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_NW_GetMasterPassword``          | ``NW_GetMasterPassword.masterPwd``          |                                         |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_SAPInstDes25Hash``              |                                             | Grep the Des25 hash key after the       |
|                                                   |                                             | string ``# IMPORTANT DO NOT DELETE!!!`` |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_NW_release``                    |                                             | Get the SAP product id in the third     |
|                                                   |                                             | line after the string ``product id``    |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_dir_downloadbasket_managednode``| ``archives.downloadBasket``                 | Note: This is a directory not a path to |
|                                                   |                                             | a single SAP archive (SAR) file!        |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_HDB_Schema_schemaName``         | ``HDB_Schema_Check_Dialogs.schemaName``     | HANA only                               |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_HDB_Schema_schemaPassword``     | ``HDB_Schema_Check_Dialogs.schemaPassword`` | HANA only                               |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_HDB_getDBInfo_instanceNumber``  | ``NW_HDB_getDBInfo.instanceNumber``         | HANA only                               |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_db6_abap_connect_user``         | ``NW_DB6_DB.db6.abap.connect.user``         | Db2 for LUW only                        |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_db6_abap_schema``               | ``NW_DB6_DB.db6.abap.schema``               | Db2 for LUW only                        |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_nwUsers_db6_db2sidPassword``    | ``nwUsers.db6.db2sidPassword``              | Db2 for LUW only and only on a db host  |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_nwUsers_db6_sapsidPassword``    | ``nwUsers.db6.sapsidPassword``              | Db2 for LUW only and only on a db host  |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+
| ``insappsvr_input_nwUsers_sidadmPassword``        | ``nwUsers.sidadmPassword``                  | Db2 for LUW only and only on a db host  |
+---------------------------------------------------+---------------------------------------------+-----------------------------------------+

+-----------------------------+--------------------------+-----------------------------------------------------------------+
| Variable in the playbook    | Data in the instkey.pkey | Remarks                                                         |
+=============================+==========================+=================================================================+
| ``insappsvr_input_instkey`` |                          | Grep the complete encrypted first line in the file instkey.pkey |
+-----------------------------+--------------------------+-----------------------------------------------------------------+

SAP Uninstall
^^^^^^^^^^^^^

**Example Playbook for the uninstall of the SAP additional application server reusing an existing inifile.params**

The example playbook is used to uninstall an application server with instance number 06 from an SAP system with the SAP system ID (SID) QAS on a host named ibmaixserver02.mycorp.com. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. During the installation, a previously prepared file name inifile.params will be used. For more information how to create an inifile.params file, see `SAP Note 2230669 <https://launchpad.support.sap.com/#/notes/2230669>`_. Make sure that the software locations defined in the file inifile.params are available. The example playbook in the current directory is named sap_uninstall_app_server_reuseInifile_db6.yml and has the following contents:

.. code:: yaml

    - name: Uninstall DB6 SAP Additional Application Server
      hosts: ibmaixserver02.mycorp.com
      vars:
       - insappsvr_input_install_mode: "reuseInifile"
       - insappsvr_dir_swpm_managednode: "/tmp/ANSIBLE/SWPM/SWPM10"
       - uninsappsvr_input_swpm_version: "SWPM10"
       - uninsappsvr_input_file_inifile: "/tmp/ANSIBLE/SWPM/inifiles/QAS/uninst/06/inifile.params"
      roles:
       - role: <ansible_dir>/roles/sap_install_app_server

Note: No encrypted data and no instkey.pkey are needed for an SAP uninstall reusing an existing inifile.params file. This playbook works with both IBM Db2 for LUW and SAP HANA.

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose sap_uninstall_app_server_reuseInifile_db6.yml -t sap_uninstall_app_server


**Example Playbook for the uninstall of the SAP additional application server creating its own inifile.params**

The example playbook is used to uninstall an application server with instance number 07 from an SAP system with the SAP system ID (SID) PRD on a host named ibmaixserver02.mycorp.com. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. During the installation, the installation parameter file inifile.params will be created based on the specified parameters. For more information how to create an inifile.params file, see `SAP Note 2230669 <https://launchpad.support.sap.com/#/notes/2230669>`_. Make sure that the software locations defined in the file inifile.params are available. The example playbook in the current directory is named sap_uninstall_app_server_createInifile_hdb.yml and has the following contents:

.. code:: yaml

    - name: Uninstall HANA SAP Additional Application Server
      hosts: ibmaixserver02.mycorp.com
      vars:
       - insappsvr_input_install_mode: "createInifile"
       - insappsvr_dir_swpm_managednode: "/tmp/ANSIBLE/SWPM/SWPM20"
       - uninsappsvr_input_swpm_version: "SWPM20"
       - uninsappsvr_input_sap_sid: "PRD"
       - uninsappsvr_input_initfile_NW_AS_instanceNumber: "07"
      roles:
       - role: <ansible_dir>/roles/sap_install_app_server

Note: Mainly the SAP SID and the SAP instance number are needed for the uninstall, no encrypted passwords or other details. This playbook works with both IBM Db2 for LUW and SAP HANA.

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose sap_uninstall_app_server_createInifile_hdb.yml -t sap_uninstall_app_server

Additional Information
----------------------

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022

