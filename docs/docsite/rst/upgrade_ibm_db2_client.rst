.. _IBM.ansible-power-aix-sap.docsite.upgrade_ibm_db2_client:

Role upgrade_ibm_db2_client
===========================

The client software for IBM Db2 for LUW is needed to access a remote Db2 database from an SAP Application Server running on IBM AIX. It can be downloaded from the Software Distribution Center in the SAP Support Portal (`SWDC <https://support.sap.com/swdc>`_) as a zip file or as ISO image (DVD).

For preventive maintenance, it is advised to upgrade the IBM Db2 client from time to time with the latest version. The role upgrade_ibm_db2_client is used to upgrade an existing IBM Db2 client from a downloaded zip file or DVD. The role is not intended to install the IBM Db2 client on a system where it has not been installed previously. For details about the IBM Db2 client and dependencies with SAP software, check the SAP documentation, for example `Upgrade to Db2 V11.5 Client <https://help.sap.com/doc/769ab46cf5ff405084e5d3a821705e52/11_5/en-US/DB6_Upgrade_11_5.pdf>`_.

To upgrade the IBM Db2 client software from a zip file, you must have downloaded the zip file into a directory <mount_DVD_Dir>. When you unzip the file, a directory with the name of the zip file will be created underneath <mount_DVD_Dir>. For example, the file 51055624.ZIP will be extracted into directory <mount_DVD_Dir>/51055624. Specify this directory as value for variable ``upgdb2_mount_dir``.

To upgrade the IBM Db2 client software from an ISO image (DVD), you must have downloaded the DVD into a directory <mount_DVD_Dir>. Specify this directory as value for variable ``upgdb2_mount_dir``.

Prior to the installation of the new client software, the role upgrade_ibm_db2_client is checking the validity of ``upgdb2_sid`` and the the existence of subdirectory DATA_UNITS/CLIENT in the directory specified by variable ``<upgdb2_mount_dir>``. The next step depends on the value of variable ``upgdb2_java_only``. If the value is ``"yes"`` (Java only system), only the JDBC driver will be updated with the command:

.. code:: sh

    ./db6_update_client.sh -j

For any other value of variable ``upgdb2_java_only``, the complete client software will be updated with the command:

.. code:: sh

    ./db6_update_client.sh -u

For more information and the latest version of the db6_update_client scripts, see `SAP Note 1365982 <https://launchpad.support.sap.com/#/notes/1365982>`_.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

Tags
----

The following tag can be specified optionally. Omitting the tag or specifying tag ``-t all`` has the same effect.

+-------------------------------+-----------------------------------------------------------------------------------------+
| Tag                           | Usage                                                                                   |
+===============================+=========================================================================================+
| ``upgrade_ibm_db2_client``    | The IBM Db2 Client will be updated                                                      |
+-------------------------------+-----------------------------------------------------------------------------------------+

Variables
---------

+------------------------------------------------+----------------------------------------------------------------------+----------+
| Variable                                       | Usage                                                                | Required |
+================================================+======================================================================+==========+
| ``upgdb2_sid``                                 | SAPSID for user <upgdb2_sid>adm                                      | Yes      |
+------------------------------------------------+----------------------------------------------------------------------+----------+
| ``upgdb2_mount_dir``                           | Directory where the IBM Db2 client software is located               | Yes      |
+------------------------------------------------+----------------------------------------------------------------------+----------+
| | ``upgdb2_java_only``                         | | "yes": Install the client for a JAVA only system.                  | | Yes    |
| |                                              | | Other value: Install the client for an ABAP or dual stack system.  | |        |
+------------------------------------------------+----------------------------------------------------------------------+----------+

Defaults
--------

None.

Dependencies
------------

None.

Example Playbook
----------------

The example playbook is used to update the IBM Db2 database client software for SAP system PD1 with a new version on several hosts. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The ISO image (DVD) for the database client software must have been downloaded from the SAP Software Distribution Center and stored in the directory /software/db2_client. The playbook is located in the current directory, named upgrade_ibm_db2_client.yml and has the following contents:

.. code:: yaml

    - name: Upgrade IBM Db2 Client
      hosts: ibmaix_servers
       vars:
       - upgdb2_sid: "PD1"
       - upgdb2_mount_dir: "/software/db2_client"
       - upgdb2_java_only: "no"
      roles:
       - role: <ansible_dir>/roles/upgrade_ibm_db2_client
       
To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook --verbose -t upgrade_ibm_db2_client upgrade_ibm_db2_client.yml

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022
