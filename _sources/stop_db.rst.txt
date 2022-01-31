.. _IBM.ansible-power-aix-sap.docsite.stop_db:

Role stop_db
============

The role stop_db is used to stop a database instance. Currently supported DBs are Db2 LUW. The role is used to stop a Db2 instance for a given Database System ID (DBSID). If a requested database is already stopped, the request will be ignored and an info message will be sent. Before calling this role, all SAP instances belonging to this SAP system should be down.

The role stop_db requires 1 variable as input (see section Variables).

.. contents:: Table of contents
   :depth: 2
   
Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

Variables
---------

+--------------------------------+------------------------------------------------------------------------------+----------+
| Variable                       | Usage                                                                        | Required |
+================================+==============================================================================+==========+
| ``stopdb_input_db_sid``        | DB system ID                                                                 | Yes      |
+--------------------------------+------------------------------------------------------------------------------+----------+

Remarks:
^^^^^^^^

None

Defaults
--------

None

Dependencies
------------

None.

Example Playbook
----------------

The example playbook is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The example playbook in the current directory is named stop_db.yml and has the following contents:

.. code:: yaml

       - hosts: ibmaix_servers
         vars:
         - stopdb_input_db_sid: "PRD"
         roles:
         - role: <ansible_dir>/roles/stop_db
         
 
To execute this playbook, enter the command:

.. code:: YAML

   ansible-playbook --verbose stop_db.yml

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022
