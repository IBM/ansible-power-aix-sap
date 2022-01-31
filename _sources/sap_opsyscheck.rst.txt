.. _IBM.ansible-power-aix-sap.docsite.sap_opsyscheck:

Role sap_opsyscheck
===================

The role sap_opsyscheck is checking some basic operating system settings that are required to run SAP applications on the operating system AIX smoothly. It can be executed prior to the first SAP installation on a new system or partition with the operating system AIX or as a "health check" on systems or partitions where SAP is already installed. The following checks are performed:

* Check if the nimsh service is running (nimsh is using port 3901 which is used very often in a SAP installation).
* Check if there are 5 GB free space available on the mount point to extract SAP Archives.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

Variables
---------

+-------------------------------------------+-----------------------------------------------------------------+----------+
| Variable                                  | Usage                                                           | Required |
+===========================================+=================================================================+==========+
| ``sap_opsyscheck_dir_mount_managed_node`` | Directory path on the target host for mounting file systems     | Yes [1]_ |
+-------------------------------------------+-----------------------------------------------------------------+----------+

Remarks:
^^^^^^^^

.. [1] Default provided.

Defaults
--------

Suggested default values are provided in defaults/main.yml:

+-------------------------------------------+---------------------+
| Variable                                  | Default             |
+===========================================+=====================+
| ``sap_opsyscheck_dir_mount_managed_node`` | ``"/sapmnt"``       |
+-------------------------------------------+---------------------+

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
