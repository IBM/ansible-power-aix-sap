# Ansible Content for IBM Power Systems - AIX with SAP Software

The <b>Ansible Content for IBM Power Systems - AIX with SAP Software</b> provides roles to automate administrator tasks for SAP installations on AIX, such installing the SAP Host Agent, starting and stopping SAP instances, upgrading the SAP kernel, etc.

IBM Power Systems is a family of enterprise servers that helps transform your organization by delivering industry leading resilience, scalability and accelerated performance for the most sensitive, mission critical workloads and next-generation AI and edge solutions. The Power platform also leverages open source technologies that enable you to run these workloads in a hybrid cloud environment with consistent tools, processes and skills.

Ansible Content for IBM Power Systems - AIX with SAP Software, as part of the broader offering of <b>Ansible Content for IBM Power Systems</b>, is available from Ansible Galaxy and has community support.

For detail guides and reference, please visit the <a href="https://ibm.github.io/ansible-power-aix-sap/">Documentation</a> site.

## Prerequisites

To execute Ansible playbooks for SAP on IBM AIX, the following is required:

Control node (if on AIX):

    OS: AIX 7.1 TL5 or AIX 7.2 TL4 and higher
    Ansible version: 2.9 or later
    Python: 3.7 or later
    AIX OpenSSH

Managed node:

    OS: AIX 7.1 TL5 or AIX 7.2 TL4 and higher
    Python on AIX: 2.7 or later
    AIX OpenSSH
    sudo 1.9.5 (or higher)

Remark: All the packages can be downloaded from:
        AIX Toolbox for Linux Applications (https://www.ibm.com/support/pages/aix-toolbox-linux-applications-downloads-alpha)

## Usage

The following roles for administrator tasks with SAP on IBM AIX are provided:

- Install or upgrade the SAP Host Agent
- Install additional application servers for SAP HANA or IBM Db2 LUW databases
- Check basic operating system settings
- Save the SAP work directories
- Start database instances for IBM Db2, SAP HANA, and Oracle databases
- Start SAP instances or SAP start services
- Stop database instances for IBM Db2, SAP HANA, and Oracle databases
- Stop SAP instances or SAP start services
- Upgrade the database client software for an IBM Db2 LUW database
- Upgrade the database client software for an SAP HANA database
- Upgrade the SAP kernel

# License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

# Author Information

SAP on IBM Power Development Team

# Copyright

Copyright IBM Corporation 2021,2022
