.. _IBM.ansible-power-aix-sap.docsite.save_dir:

Role save_dir
==============

The role save_dir can be used to save the content of a given directory. Currently the role supports saving SAP work directories, such as /usr/sap/``sid``/``instance``/work. The content of the selected directory is compressed with the tar utility and saved to a directory that is specified through an input parameter. The compressed archive will not include core files.

To protect the resulting output files from being overwritten, names consisting of the following components will be generated:

+--------------+-------------------------------------------+----------------------------+
| Component    | Source                                    |  Example                   |
+==============+===========================================+============================+
| Directory    | variable ``save_work_dir_input_save_dir`` | /backup/KD1/custhost01/00  |
+--------------+-------------------------------------------+----------------------------+
| Name pattern | variable ``save_work_dir_input_save_fn``  | KD1_00                     |
+--------------+-------------------------------------------+----------------------------+
| Timestamp    | current timestamp                         | 202204261912               |
+--------------+-------------------------------------------+----------------------------+
| Suffix       | constant                                  | tar.Z                      |
+--------------+-------------------------------------------+----------------------------+

In the previous example, the resulting file will be ``/backup/KD1/custhost01/00/KD1_00.202204261912.tar.Z``.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

The directory to be saved, which is specified in variable ``save_work_dir_input_dirname``, must exist.

The target directory for the compressed archive, which is specified in variable ``save_work_dir_input_dirname``, must have enough space to hold the backups.

Tags
----

The following tag can be specified optionally. Omitting the tag or specifying tag ``-t all`` has the same effect.

+-------------------------------+-------------------------------------------------------------------------------------------------+
| Tag                           | Usage                                                                                           |
+===============================+=================================================================================================+
| ``sap_save_work_dir``         | The specified working directory of an SAP system will be saved to the specified archive.        |
+-------------------------------+-------------------------------------------------------------------------------------------------+

Variables
---------

+--------------------------------------+------------------------------------------------------------------------------+----------+
| Variable                             | Usage                                                                        | Required |
+======================================+==============================================================================+==========+
| ``save_work_dir_input_dirname``      | Directory path of the SAP work directory to be saved.                        | Yes      |
+--------------------------------------+------------------------------------------------------------------------------+----------+
| ``save_work_dir_input_save_dir``     | Target directory where the archive will be stored                            | Yes      |
+--------------------------------------+------------------------------------------------------------------------------+----------+
| ``save_work_dir_input_save_fn``      | File name pattern for the resulting archive. It is recommended to select     | Yes      |
|                                      | a pattern that contains the SAP system ID and instance number of the         |          |
|                                      | SAP instance that owns the saved work directory.                             |          |
+--------------------------------------+------------------------------------------------------------------------------+----------+

Defaults
--------

None

Dependencies
------------

None.

Example Playbook
----------------

The example playbook is used to save the working directory ``/usr/sap/KD1/D00/work`` of SAP system KD1 on a host named ibmaixserver02.mycorp.com. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The example playbook in the current directory is named save_logs.yml and has the following contents:

.. code:: yaml

    - name: Save SAP work directory
      hosts: ibmaixserver02.mycorp.com
      vars:
       - save_work_dir_input_dirname: "/usr/sap/KD1/D00/work"
       - save_work_dir_input_save_dir: "/tmp"
       - save_work_dir_input_save_fn:  "KD1_00"
      roles:
       - role: <ansible-dir>/roles/sap_save_work_dir

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook -t sap_save_work_dir save_logs.yml

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022
