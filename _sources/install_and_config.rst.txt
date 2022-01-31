.. _IBM.ansible-power-aix-sap.docsite.install_and_config:

Installation and configuration
==============================

Ansible is a tool to automate IT administration tasks. It comprises one *controlling node*, on which the Ansible collections are stored and executed, and one or multiple *managed nodes*, for which the administration tasks are performed. The general concept of Ansible assumes agent-less operations, i.e. the Ansible collections are only installed on the controlling node, but not on the managed nodes. Whenever updates are applied to the Ansible collections, they only need to be applied to the controlling node.

Nevertheless, the usage of Ansible collections requires a one-time setup on both the controlling node and the managed nodes. All nodes need to be enabled to run Open Source packages and have Python 3 installed. Beginning with AIX 7.3, Python 3 is automatically pre-installed with the operating system. On the controlling node, also Ansible version 2.9 or higher must be installed.

.. _IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites:

Prerequisites
-------------

To execute Ansible playbooks for SAP on IBM AIX, the following is required:

Control node (if on AIX)

::

   OS: AIX 7.1 TL5 or AIX 7.2 TL4 and higher
   Ansible version: 2.9 or later
   Python: 3.7 or later
   AIX OpenSSH

Managed node

::

   OS: AIX 7.1 TL5 or AIX 7.2 TL4 and higher
   Python on AIX: 2.7 or later
   AIX OpenSSH
   sudo

Remark: All the packages can be downloaded from: AIX Toolbox for Linux Applications (https://www.ibm.com/support/pages/aix-toolbox-linux-applications-downloads-alpha).

Installation
------------

1. Install Ansible:

   .. code:: bash

      yum install ansible

2. Add /opt/freeware/bin to your environment (PATH variable).

3. Install the Ansible roles that you want to use:

   .. code:: bash

      ansible-galaxy install <path to ansible role>

.. _IBM.ansible-power-aix-sap.docsite.install_and_config.configuration:

Configuration
-------------

1. On the controlling node create an Ansible configuration file:

   .. code:: bash

      cat ~/.ansible.cfg

      #remote_tmp     = ~/.ansible/tmp
      #local_tmp      = ~/.ansible/tmp
      inventory       = ~/.ansible/hosts
      library         = ~/.ansible/modules
      roles_path      = ~/.ansible/roles
      ssh_args        = -i /home/johndoe/ssh/id_rsa
      transfer_method = scp

2. On the controlling node create an inventory file:

   .. code:: bash

      cat ~/.ansible/hosts

      [ibmaix_servers]
      ibmaixserver01.mycorp.com
      ibmaixserver02.mycorp.com
      ibmaixserver03.mycorp.com

      [ibmaix_servers:vars]
      ansible_python_interpreter=/opt/freeware/bin/python

Security
--------

If you plan to use the AIX security concept RBAC (Role Bases Access Control) with Ansible, see: :ref:`Using RBAC with Ansible <IBM.ansible-power-aix-sap.docsite.AIX_RBAC_for_Ansible>`.

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022
