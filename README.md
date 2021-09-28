# Ansible Content for IBM Power Systems - AIX with SAP Software

The <b>Ansible Content for IBM Power Systems - AIX with SAP Software</b> provides roles to automate administrator tasks for SAP installations on AIX, such installing the SAP Host Agent, starting and stopping SAP instances, upgrading the SAP kernel, etc.

IBM Power Systems is a family of enterprise servers that helps transform your organization by delivering industry leading resilience, scalability and accelerated performance for the most sensitive, mission critical workloads and next-generation AI and edge solutions. The Power platform also leverages open source technologies that enable you to run these workloads in a hybrid cloud environment with consistent tools, processes and skills.

Ansible Content for IBM Power Systems - AIX with SAP Software, as part of the broader offering of <b>Ansible Content for IBM Power Systems</b>, is available from Ansible Galaxy and has community support.


## Prerequisites

To execute Ansible playbooks for SAP on IBM AIX, the following is required:

Control node (if on AIX)

    OS: AIX 7.1 TL5 or AIX 7.2 TL4 and higher
    Ansible version: 2.9 or later
    Python: 3.7 or later
    AIX OpenSSH

Managed node

    OS: AIX 7.1 TL5 or AIX 7.2 TL4 and higher
    Python on AIX: 2.7 or later
    AIX OpenSSH

Remark: All the packages can be downloaded from:
        AIX Toolbox for Linux Applications (https://www.ibm.com/support/pages/aix-toolbox-linux-applications-downloads-alpha)


## Installation



1. Install Ansible:
   ```bash
   yum install ansible
   ```
2.
 ```bash
   add /opt/freeware/bin to your environment (PATH variable)
   ```

3. Install the Ansible roles that you want to use:
   ```bash
   ansible-galaxy install <path to ansible role>
   ```

## Configuration

1. On the controlling node create an Ansible configuration file:

   ```bash
   cat ~/.ansible.cfg
   
   #remote_tmp     = ~/.ansible/tmp
   #local_tmp      = ~/.ansible/tmp
   inventory       = ~/.ansible/hosts
   library         = ~/.ansible/modules
   roles_path      = ~/.ansible/roles
   ssh_args        = -i /home/johndoe/ssh/id_rsa
   transfer_method = scp
   ```
 
2. On the controlling node create an inventory file:
   ```bash
   cat ~/.ansible/hosts
   
   [ibmaix_servers]
   ibmaixserver01.mycorp.com
   ibmaixserver02.mycorp.com
   ibmaixserver03.mycorp.com
   
   [ibmaix_servers:vars]
   ansible_python_interpreter=/opt/freeware/bin/python
   ```
## Security:
If you plan to use AIX security concept RBAC (Role Bases Access Control) with Ansible, see:
[Using RBAC with Ansible](README_AIX-RBAC_FOR_ANSIBLE.MD)
## Usage

The following roles for administrator tasks with SAP on IBM aix are provided:

### [Installing or upgrading the SAP Host Agent](roles/install_saphostagent)

### [Start SAP instances](roles/start_sap)

### [Stop SAP instances](roles/stop_sap)

### [Upgrade the kernel of an already existing SAP system](roles/upgrade_sap_kernel)

Follow the links for a detailed description of the roles.

# License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

# Author Information

SAP on IBM Power Development Team

# Copyright

© Copyright IBM Corporation 2021
