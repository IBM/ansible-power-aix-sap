.. _IBM.ansible-power-aix-sap.docsite.index:

Ansible Content for IBM Power Systems - AIX with SAP Software
=============================================================

The **Ansible Content for IBM Power Systems - AIX with SAP Software** provides roles to automate administrator tasks for SAP installations on AIX, such installing the SAP Host Agent, starting and stopping SAP instances, upgrading the SAP kernel, etc.

IBM Power Systems is a family of enterprise servers that helps transform your organization by delivering industry leading resilience, scalability and accelerated performance for the most sensitive, mission critical workloads and next-generation AI and edge solutions. The Power platform also leverages open source technologies that enable you to run these workloads in a hybrid cloud environment with consistent tools, processes and skills.

Ansible Content for IBM Power Systems - AIX with SAP Software, as part of the broader offering of **Ansible Content for IBM Power Systems**, is available from Ansible Galaxy and has community support.

Features
--------

The following roles for administrator tasks with SAP on IBM AIX are provided:

  - :ref:`Installing or upgrading the SAP Host Agent <IBM.ansible-power-aix-sap.docsite.install_saphostagent>`
  
  - :ref:`Check basic operating system settings <IBM.ansible-power-aix-sap.docsite.sap_opsyscheck>`

  - :ref:`Start Db2 database instances <IBM.ansible-power-aix-sap.docsite.start_db>`

  - :ref:`Start SAP instances <IBM.ansible-power-aix-sap.docsite.start_sap>`

  - :ref:`Stop Db2 database instances <IBM.ansible-power-aix-sap.docsite.stop_db>`

  - :ref:`Stop SAP instances <IBM.ansible-power-aix-sap.docsite.stop_sap>`

  - :ref:`Upgrade the kernel of an already existing SAP system <IBM.ansible-power-aix-sap.docsite.upgrade_sap_kernel>`

Follow the links for a detailed description of the roles.

System requirements, installation steps and configuration information can be found in the section :ref:`Installation and configuration <IBM.ansible-power-aix-sap.docsite.install_and_config>`. If you plan to use the AIX security concept RBAC (Role Bases Access Control) with Ansible, see: :ref:`Using RBAC with Ansible <IBM.ansible-power-aix-sap.docsite.AIX_RBAC_for_Ansible>`.

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022

.. toctree::
   :maxdepth: 3
   :caption: Installation and configuration
   :hidden:

   install_and_config

.. toctree::
   :maxdepth: 3
   :caption: Available roles
   :hidden:

   install_saphostagent
   sap_opsyscheck
   start_db
   start_sap
   stop_db
   stop_sap
   upgrade_sap_kernel

.. toctree::
   :maxdepth: 3
   :caption: Role Based Access Control
   :hidden:

   AIX_RBAC_for_Ansible
   
