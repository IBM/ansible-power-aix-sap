.. _IBM.ansible-power-aix-sap.docsite.upgrade_sap_kernel:

Role upgrade_sap_kernel
=======================

The role upgrade_sap_kernel is used to upgrade the kernel of an already installed SAP system with new code that has been downloaded from the SAP Sowftware Distribution Center (`SWDC <https://support.sap.com/swdc>`_) in SAP Archive (SAR) files. The SAR files must be available in the directory that is specified in variable ``upgsapkrn_dir_download_sar_managednode``.

The role upgrade_sap_kernel needs the SAP System ID as input in variable ``upgsapkrn_input_sap_sid``, ``upgsapkrn_input_sap_adm`` and ``upgsapkrn_input_sap_sys``.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

The role upgrade_sap_kernel will create a backup of directory ``upgsapkrn_dir_upgrade_kernel`` on the managed node into directory ``upgsapkrn_dir_kernel_backup_managednode`` on the managed node.

All provided SAR files will be extracted into directory on the managed node specified in variable ``upgsapkrn_dir_extracted_sar_managednode``.

The extracted files will be copied into directory on the managed node specified in variable ``upgsapkrn_dir_upgrade_kernel``.

Checking prerequisites for SAP kernel upgrade
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

SAP has a number of requirements:

* Check if a system has enough free storage. Exceeding a certain treshold could lead to performance or other problems.
* Directory Structure for an ABAP System Based on SAP NetWeaver 7.5.

Variables
---------

+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| Variable                                      | Usage                                                               | Required      |
+===============================================+=====================================================================+===============+
| ``upgsapkrn_input_sap_sid``                   | SAP system ID                                                       | Yes           |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_input_sap_adm``                   | SAP admin ID                                                        | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_input_sap_sys``                   | SAP system group ID                                                 | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_dir_download_sar_managednode``    | Directory path on the Ansible host where SAR file is located.       | Yes [1]_ [2]_ |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_dir_download_sapcar_managednode`` | Directory path on the Ansible host where SAPCAR file is located.    | Yes [1]_ [3]_ |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_dir_sapcar_default_managednode``  | Fallback directory on the target host where SAPCAR is searched.     | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_dir_upload_managednode``          | Temporary directory path that will be created on the target host.   | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_file_sapcar``                     | Local SAPCAR file name                                              | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_dir_extracted_sar_managednode``   | Temporary directory path that will be created on the target host.   | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_dir_kernel_backup_managednode``   | Temporary directory path that will be created on the target host.   | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+
| ``upgsapkrn_dir_upgrade_kernel``              | Directory path of SAP working directory.                            | Yes [1]_      |
+-----------------------------------------------+---------------------------------------------------------------------+---------------+

Remarks:
^^^^^^^^

.. [1] Default provided.
.. [2] At least one sar file is required in ``upgsapkrn_dir_download_sar_managednode`` matching the pattern "\*.SAR" or "\*.sar".
.. [3] When ``upgsapkrn_dir_download_sapcar_managednode`` is undefined, SAPCAR will be searched in ``upgsapkrn_dir_download_sar_managednode`` and ``upgsapkrn_dir_sapcar_default_managednode``.

Defaults
--------

Suggested default values are provided in defaults/main.yml:

+-----------------------------------------------+-----------------------------------------------------------------------+
| Variable                                      | Default                                                               |
+===============================================+=======================================================================+
| ``upgsapkrn_input_sap_adm``                   | ``"{{ upgsapkrn_input_sap_sid|lower }}adm"``                          |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_input_sap_sys``                   | ``"sapsys"``                                                          |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_dir_download_sar_managednode``    | ``"/tmp/sar_prov_dir"``                                               |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_dir_download_sapcar_managednode`` | ``"/tmp/sapcar_prov_dir"``                                            |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_dir_sapcar_default_managednode``  | ``"/usr/sap/hostctrl/exe"``                                           |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_dir_upload_managednode``          | ``"/usr/sap/tmp/sar_upload_dir"``                                     |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_file_sapcar``                     | ``"SAPCAR"``                                                          |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_dir_extracted_sar_managednode``   | ``"/usr/sap/tmp/sar_extracted_dir"``                                  |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_dir_kernel_backup_managednode``   | ``"/sapmnt/{{ upgsapkrn_input_sap_sid }}/exe/uc/kernel_backup_dir"``  |
+-----------------------------------------------+-----------------------------------------------------------------------+
| ``upgsapkrn_dir_upgrade_kernel``              | ``"/sapmnt/{{ upgsapkrn_input_sap_sid }}/exe/uc/rs6000_64"``          |
+-----------------------------------------------+-----------------------------------------------------------------------+

Dependencies
------------

None.

Example Playbook
----------------

The example playbook is used to replace the existing kernel of SAP system PRD with a new stack kernel on several hosts. It is based on the assumption that a configuration file and an inventory file with contents similar to the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>` exist in the current directory. The necessary archives and the SAPCAR tool must have been downloaded from the SAP Software Distribution Center and stored in the NFS share mounted on /mnt/a. The files will be copied into directory /usr/sap/tmp/sar_upload_dir (default value for variable ``upgsapkrn_dir_upload_managednode``). The playbook is located in the current directory, named MYupgrade_sap_kernel.yml and has the following contents:

.. code:: yaml

       - hosts: ibmaix_servers
         vars:
         - upgsapkrn_input_sap_sid: PRD
         - upgsapkrn_dir_download_sar_managednode: /mnt/a
         - upgsapkrn_dir_download_sapcar_managednode: /mnt/a
         - ansible_become_method: su
         roles:
         - role: upgrade_sap_kernel

Note: By specifying variable ``ansible_become_user: su``, you select a method that is available on any AIX server. The default value would be ``sudo``, which may or may not be available on your server (see `Ansible User Guide: Understanding privilege escalation: become <https://docs.ansible.com/ansible/latest/user_guide/become.html>`_). If you want to use RBAC, you must specify ``ansible_become_method: swrole``.

To execute this playbook, enter the command:

.. code:: yaml

   ansible-playbook -i my_inventory.yaml MYupgrade_sap_kernel.yml

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022
