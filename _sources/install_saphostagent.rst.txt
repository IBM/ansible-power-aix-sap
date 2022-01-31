.. _IBM.ansible-power-aix-sap.docsite.install_saphostagent:

Role install_saphostagent
=========================

The SAP Host Agent is an agent that can accomplish several life-cycle management tasks, such as operating system monitoring, database monitoring, system instance control and provisioning.

SAP is providing bug fixes and enhancements for the SAP Host Agent several times per year. It is advised to update the SAP Host Agent with the current version from time to time as preventive action. SAP is providing the SAP Host Agent in the SAP Software Distribution Center (`SWDC <https://support.sap.com/swdc>`_) as an SAP Archive (SAR) file. The role install_saphostagent can be used to install or upgrade the SAP Host Agent from a downloaded SAR file according to the SAP documentation in `SAP Note 1031096 <https://launchpad.support.sap.com/#/notes/1031096>`_.

You can find a link to the latest SAP Host Agent documentation in `SAP Note 1907566 <https://launchpad.support.sap.com/#/notes/1907566>`_.

.. contents:: Table of contents
   :depth: 2

Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

Checking prerequisites for installing the SAP Host Agent
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Check if the target system has enough free storage.

Variables
---------

+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| Variable                                      | Usage                                                                                                 | Required |
+===============================================+=======================================================================================================+==========+
| ``insshagnt_dir_download_controlnode``        | Directory path on the Ansible host where SAR file is located                                          | Yes [1]_ |
+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``insshagnt_dir_download_sapcar_controlnode`` | Directory path on the Ansible host where SAPCAR is located                                            | No [3]_  |
+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``insshagnt_input_file_saphostagent_sar``     | Name of the SAR file in the download directory on the target host that contains the SAP Host Agent    | No [2]_  |
+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``insshagnt_dir_sapcar_default_managednode``  | Directory on the target host where SAPCAR is searched                                                 | No [1]_  |
+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``insshagnt_file_sapcar``                     | Local SAPCAR file name                                                                                | Yes [1]_ |
+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``insshagnt_dir_temp_managednode``            | Temporary directory path that will be created on the target host                                      | Yes [1]_ |
+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+
| ``insshagnt_bool_clean_dir_temp_managednode`` | Boolean variable to indicate if the temporary directory will be removed or not after the installation | Yes [1]_ |
+-----------------------------------------------+-------------------------------------------------------------------------------------------------------+----------+

Remarks:
^^^^^^^^

.. [1] Default provided.
.. [2] Defaults to the alphanumerically last filename in ``insshagnt_dir_download_controlnode`` that is matching the pattern "\*.SAR" or "\*.sar".
.. [3] SAPCAR will be searched in following sequence: ``insshagnt_dir_download_sapcar_controlnode`` and ``insshagnt_dir_download_controlnode`` and ``insshagnt_dir_sapcar_default_managednode``.

Defaults
--------

Suggested default values are provided in defaults/main.yml:

+-----------------------------------------------+-----------------------------+
| Variable                                      | Default                     |
+===============================================+=============================+
| ``insshagnt_dir_download_controlnode``        | ``"/tmp/downloads"``        |
+-----------------------------------------------+-----------------------------+
| ``insshagnt_dir_download_sapcar_controlnode`` | ``"/tmp/sapcar"``           |
+-----------------------------------------------+-----------------------------+
| ``insshagnt_dir_sapcar_default_managednode``  | ``"/usr/sap/hostctrl/exe"`` |
+-----------------------------------------------+-----------------------------+
| ``insshagnt_file_sapcar``                     | ``"SAPCAR"``                |
+-----------------------------------------------+-----------------------------+
| ``insshagnt_dir_temp_managednode``            | ``"/tmp/hostctrl"``         |
+-----------------------------------------------+-----------------------------+
| ``insshagnt_bool_clean_dir_temp_managednode`` | ``True``                    |
+-----------------------------------------------+-----------------------------+

Dependencies
------------

None.

Example Playbook
----------------

You plan to install a new version (SAPHOSTAGENT50_50-20009388.SAR) of the SAP Host Agent on LPAR ibmaixserver01.mycorp.com.

ibmaixserver01.mycorp.com has been defined in the inventory file as shown in the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>`.

The example playbook in the current directory is named install_saphostagent.yml and has the following contents:

.. code:: yaml

    - name: Install SAPHOST Agent
      hosts: ibmaix_servers
      vars:
       - insshagnt_input_file_saphostagent_sar: "SAPHOSTAGENT50_50-20009388.SAR"
       - insshagnt_dir_download_controlnode: "/tmp/downloads_sar"
       - insshagnt_dir_download_sapcar_controlnode:    "/tmp/downloads_sapcar"
       - insshagnt_file_sapcar:    "SAPCAR"
       - insshagnt_dir_temp_managednode: "/tmp/hostctrl"
       - insshagnt_bool_clean_dir_temp_managednode: True
      roles:
       - role: <ansible_dir>/roles/install_saphostagent

Run the installation by:

.. code:: yaml

   ansible-playbook --verbose install_saphostagent.yml

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022
