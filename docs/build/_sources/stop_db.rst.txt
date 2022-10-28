.. _IBM.ansible-power-aix-sap.docsite.stop_db:

Role stop_db
============

The role stop_db is used to stop a database instance. Currently supported databases are IBM Db2 for Linux, Unix and Windows (LUW), Oracle and SAP HANA. When using this role, you must specify the database system id in a variable and select the database type through a tag. If the requested database is not active, the request will be ignored and an informational message will be sent. A description of the tags and variables can be found in the related sections of this document.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

The requested database instance must be installed on the managed node and operational.

Tags
----

Specify one of the following tags to specify the database type to be stopped. If you do not specify a tag, an error message will be sent.

+--------------+------------------------+--------------------------------------------------------------------------+
| DB type      | Tag                    | Description                                                              |
+==============+========================+==========================================================================+
| IBM Db2 LUW  | ``sap_stop_db2``       | Stop a database instance of type IBM Db2 LUW                             |
+--------------+------------------------+--------------------------------------------------------------------------+
| SAP HANA     | ``sap_stop_hana``      | Stop a database instance of type SAP HANA                                |
+--------------+------------------------+--------------------------------------------------------------------------+
| Oracle       | ``sap_stop_oracle``    | Stop a database instance of type Oracle                                  |
+--------------+------------------------+--------------------------------------------------------------------------+

Variables
---------

+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+
| DB Type     |Variable                               | Usage                                                                        | Required |
+=============+=======================================+==============================================================================+==========+
| IBM Db2 LUW | ``stopdb_input_db_sid``               | DB system ID                                                                 | Yes      |
+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+
| SAP HANA    | ``stopdb_input_db_sid``               | DB system ID                                                                 | Yes      |
+             +---------------------------------------+------------------------------------------------------------------------------+----------+
|             | ``stopdb_input_hdb_instance_number``  | Instance number of SAP HANA DB                                               | Yes      |
+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+
| Oracle      | ``stopdb_input_db_sid``               | DB system ID                                                                 | Yes      |
+             +---------------------------------------+------------------------------------------------------------------------------+----------+
|             | ``stopdb_input_sap_sid``              | SAP system ID                                                                | Yes      |
+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+

Defaults
--------

None

Dependencies
------------

None.

Example Playbook
----------------

The example playbook is used to stop instance number 00 of an SAP HANA database with the database system ID PRD on host ibmaixserver01.mycorp.com. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The example playbook in the current directory is named stop_hana_db.yml and has the following contents:

.. code:: yaml

       - hosts: ibmaixserver01.mycorp.com
         vars:
         - stopdb_input_db_sid: "PRD"
         - stopdb_input_hdb_instance_number: 00
         roles:
         - role: <ansible_dir>/roles/stop_db

To execute this playbook, enter the command:

.. code:: YAML

   ansible-playbook --verbose -t sap_stop_hana stop_hana_db.yml


License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2022

