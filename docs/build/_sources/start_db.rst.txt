.. _IBM.ansible-power-aix-sap.docsite.start_db:

Role start_db
=============

The role start_db is used to start a database instance. Currently supported databases are IBM Db2 for Linux, Unix and Windows (LUW), Oracle and SAP HANA. When using this role, you must specify the database system id in a variable and select the database type through a tag. If the requested database is already started, the request will be ignored and an informational message will be sent. A description of the tags and variables can be found in the related sections of this document.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

The requested database instance must be installed on the managed node and operational.

Tags
----

Specify one of the following tags to specify the database type to be started. If you do not specify a tag, an error message will be sent.

+--------------+------------------------+--------------------------------------------------------------------------+
| DB type      | Tag                    | Description                                                              |
+==============+========================+==========================================================================+
| IBM Db2 LUW  | ``sap_start_db2``      | Start a database instance of type IBM Db2 LUW                            |
+--------------+------------------------+--------------------------------------------------------------------------+
| SAP HANA     | ``sap_start_hana``     | Start a database instance of type SAP HANA                               |
+--------------+------------------------+--------------------------------------------------------------------------+
| Oracle       | ``sap_start_oracle``   | Start a database instance of type Oracle and a listener                  |
+--------------+------------------------+--------------------------------------------------------------------------+

Variables
---------

+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+
| DB Type     |Variable                               | Usage                                                                        | Required |
+=============+=======================================+==============================================================================+==========+
| IBM Db2 LUW | ``startdb_input_db_sid``              | DB system ID                                                                 | Yes      |
+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+
| SAP HANA    | ``startdb_input_db_sid``              | DB system ID                                                                 | Yes      |
+             +---------------------------------------+------------------------------------------------------------------------------+----------+
|             | ``startdb_input_hdb_instance_number`` | Instance number of SAP HANA DB                                               | Yes      |
+             +---------------------------------------+------------------------------------------------------------------------------+----------+
|             | ``startdb_force``                     | The startdb command is executed even if the database is already started.     | No       |
+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+
| Oracle      | ``startdb_input_db_sid``              | DB system ID                                                                 | Yes      |
+             +---------------------------------------+------------------------------------------------------------------------------+----------+
|             | ``startdb_input_sap_sid``             | SAP system ID                                                                | Yes      |
+-------------+---------------------------------------+------------------------------------------------------------------------------+----------+

Defaults
--------

None

Dependencies
------------

None.

Example Playbook
----------------

The example playbook is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The example playbook in the current directory is named start_hana_db.yml and has the following contents:

.. code:: yaml

       - hosts: ibmaix_servers
         vars:
         - startdb_input_db_sid: "PRD"
         - startdb_input_hdb_instance_number: 00
         - startdb_force: "Y"
         roles:
         - role: <ansible_dir>/roles/start_db

To execute this playbook, enter the command:

.. code:: YAML

   ansible-playbook --verbose -t sap_start_hana start_hana_db.yml


License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2022
