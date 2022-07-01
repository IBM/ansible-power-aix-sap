.. _IBM.ansible-power-aix-sap.docsite.sap_opsyscheck:

Role sap_opsyscheck
===================

The role sap_opsyscheck is checking some basic operating system settings that are required to run SAP applications on the operating system AIX smoothly. It can be executed prior to the first SAP installation on a new system or partition with the operating system AIX or as a "health check" on systems or partitions where SAP is already installed. The following checks are performed:

* Check if the nimsh service is running (nimsh is using port 3901 which, is used very often in a SAP installation).
* Check directories /usr/sap, /sapmnt, /tmp, /var, ... for available free space.
* Check if the NTP daemon is active.
* Check the user limit for the number of file descriptors.
* Check the maximum number of processes per user.
* Check the availability of I/O completion port device.
* Check the login shell.
* Check if the services needed for SAP are defined.
* Check the rootvg volume group size.
* Check the file system jfs2 on the logical volume group datavg.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

Tags
----

Specify one or multiple of the following tags (separated by comma) to specify what checks you want to perform. If you do not specify a tag or the tag ``-t all``, all checks will be performed.

+------------------------------+-------------------------------------------------------------------+
| Tag                          | Usage                                                             |
+==============================+===================================================================+
| ``nim_service_check``        | Check if the nimsh service is running (nimsh is using port 3901,  |
|                              | which is used very often in a SAP installation).                  |
+------------------------------+-------------------------------------------------------------------+
| ``mount_free_space_check``   | Check directories /usr/sap, /sapmnt, /tmp, /var, ... for          |
|                              | available free space.                                             |
+------------------------------+-------------------------------------------------------------------+
| ``ntp_check``                | Check if the NTP daemon is active.                                |
+------------------------------+-------------------------------------------------------------------+
| ``user_limit_check``         | Check the user limit for the number of file descriptors.          |
+------------------------------+-------------------------------------------------------------------+
| ``maxuproc_check``           | Check the maximum number of processes per user.                   |
+------------------------------+-------------------------------------------------------------------+
| ``io_completion_port_check`` | Check the availability of I/O completion port device.             |
+------------------------------+-------------------------------------------------------------------+
| ``login_shell_check``        | Check the login shell.                                            |
+------------------------------+-------------------------------------------------------------------+
| ``etc_services_check``       | Check if the services needed for SAP are defined.                 |
+------------------------------+-------------------------------------------------------------------+
| ``rootvg_check``             | Check the rootvg volume group size.                               |
+------------------------------+-------------------------------------------------------------------+
| ``logical_volumes_check``    | Check the file system jfs2 on the logical volume group datavg.    |
+------------------------------+-------------------------------------------------------------------+

Variables
---------

None.

Defaults
--------

None.

Dependencies
------------

None.

Example Playbook
----------------

The example playbook is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The example playbook in the current directory is named sap_opsyscheck.yml and has the following contents:

.. code:: YAML

    - hosts: ibmaix_servers
      roles:
      - role: <ansible_dir>/roles/sap_opsyscheck

To execute this playbook, enter the command:

.. code:: YAML
  
   ansible-playbook --verbose sap_opsyscheck.yml

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2022
