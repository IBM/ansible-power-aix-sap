.. _IBM.ansible-power-aix-sap.docsite.stop_sap:

Role stop_sap
=============

The role stop_sap is used to stop one or multiple SAP instances, either for a given SAP system ID (tag ``-t sap_stop_instance``) or for all SAP systems that are configured in file /usr/sap/sapservices (tag ``-t sap_stop_all_instances``). If a requested SAP instance is already inactive, the request will be ignored and no error message will be sent. The role stop_sap is using the sapcontrol command of the SAP Host Agent as suggested in `SAP Note 1763593 <https://launchpad.support.sap.com/#/notes/1763593>`_. It requires that the SAP start services for the selected instances are active. By default, the SAP start services are started automatically after a system restart. If the SAP start services are not active, they can be started by using this role with the tag ``-t sap_start_services``.

If the role stop_sap is used with tag ``-t sap_stop_instance``, it needs the SAP system ID as input in variable ``stopsap_input_sap_sid``. An SAP instance number can be provided optionally in variable ``stopsap_input_sap_instance_nr``. If an instance number is provided, only this instance is stopped. If no instance number is provided, stop_sap will stop all configured instances for the given SID, also on remote servers in a distributed landscape. It is recommended that the role stop_sap is executed on the logical partition or server that hosts the central services instance (ASCS, SCS), the primary application server instance, or the central instance.

If the role stop_sap is used with tag ``-t sap_stop_all_instances``, the values in the variables ``stopsap_input_sap_sid`` and ``stopsap_input_sap_instance_nr`` are ignored. Instead, all SAP systems that are configured in file /usr/sap/sapservices will be stopped with all their instances.

If the role stop_sap is used with tag ``-t sap_stop_services``, you can specify a SAP system ID in variable ``stopsap_input_sap_sid`` or the special value ``"*"``. If you specify ``"*"``, SAP start services will be stopped for all SAP systems that are configured in /usr/sap/sapservices.

.. contents:: Table of contents
   :depth: 2
   
Requirements
------------

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see the prerequisites section in :ref:`Ansible Content for IBM Power Systems - AIX with SAP Software <IBM.ansible-power-aix-sap.docsite.install_and_config.prerequisites>`.

The SAP Start Services for the requested SAP system must be configured in file /usr/sap/sapservices and started. In a standard installation, they are started automatically after a system restart. They can be started manually by executing the role start_sap with tag ``-t sap_start_services``.

Tags
----

Specify one of the following tags to specify what parts of an SAP system you want to stop. If you do not specify a tag, ``-t sap_stop_instance`` will be assumed as default. If you misspell the tag, no steps in the role will be executed.

+-------------------------------+-------------------------------------------------------------------------------------------------+
| Tag                           | Usage                                                                                           |
+===============================+=================================================================================================+
| ``sap_stop_instance``         | One or all instances for a specific SAP system ID are stopped. The SAP system ID must be        |
|                               | specified in variable ``stopsap_input_sap_sid``, the instance number can optionally be          |
|                               | specified in variable ``stopsap_input_sap_instance_nr``.                                        |
+-------------------------------+-------------------------------------------------------------------------------------------------+
| ``sap_stop_all_instances``    | All instances are stopped for all SAP systems that are configured in file /usr/sap/sapservices. |
+-------------------------------+-------------------------------------------------------------------------------------------------+
| ``sap_stop_services``         | Stop SAP start services for the SAP system ID specified in variable ``stopsap_input_sap_sid``   |
|                               | or for all SAP systems that are configured in file /usr/sap/sapservices when variable           |
|                               | ``stopsap_input_sap_sid`` is set to ``"*"``.                                                    |
+-------------------------------+-------------------------------------------------------------------------------------------------+

Variables
---------

+-------------------------------------+------------------------------------------------------------------------------+----------+
| Variable                            | Usage                                                                        | Required |
+=====================================+==============================================================================+==========+
| ``stopsap_dir_sapctrl_managednode`` | Directory path on the target host where the sapcontrol executable is located | Yes [1]_ |
+-------------------------------------+------------------------------------------------------------------------------+----------+
| ``stopsap_input_sap_sid``           | SAP system ID                                                                | Yes [2]_ |
+-------------------------------------+------------------------------------------------------------------------------+----------+
| ``stopsap_input_sap_instance_nr``   | SAP instance number                                                          | No [3]_  |
+-------------------------------------+------------------------------------------------------------------------------+----------+
| ``stopsap_softtimeout``             | softtimeout in seconds: -1 = infinite wait, 0 = hard shutdown                | No [4]_  |
+-------------------------------------+------------------------------------------------------------------------------+----------+
| ``stopsap_input_waitforstopped``    | Timeout in seconds when waiting for instance to be completely stopped        | Yes [1]_ |
+-------------------------------------+------------------------------------------------------------------------------+----------+

Remarks:
^^^^^^^^

.. [1] Default provided.
.. [2] The variable is only evaluated when the tags ``-t sap_stop_instance`` or ``-t sap_stop_services`` are set.
.. [3] The variable is only evaluated when the tag ``-t sap_stop_instance`` is set. If the variable is omitted, all instances of the specified SAP system ID will be stopped.
.. [4] When the parameter is omitted, a hard shutdown is executed.

Defaults
--------

Suggested default values are provided in defaults/main.yml:

+-----------------------------------------+-----------------------------+
| Variable                                | Default                     |
+=========================================+=============================+
| ``stopsap_dir_sapctrl_managednode``     | ``"/usr/sap/hostctrl/exe"`` |
+-----------------------------------------+-----------------------------+
| ``stopsap_softtimeout``                 | ``""``                      |
+-----------------------------------------+-----------------------------+
| ``stopsap_input_waitforstopped``        | ``"1200"``                  |
+-----------------------------------------+-----------------------------+

Dependencies
------------

None.

Example Playbook
----------------

You plan to stop a SAP system with SAP SID (``stopsap_input_sap_sid``) PRD having at least one instance on LPAR ibmaixserver01.mycorp.com

ibmaixserver01.mycorp.com has been defined in the inventory file as shown in the :ref:`configuration documentation <IBM.ansible-power-aix-sap.docsite.install_and_config.configuration>`.

You have created the following file stop_sap.yml

.. code:: yaml

       - hosts: ibmaix_servers
         vars:
         - stopsap_input_sap_sid: "PRD"
         roles:
         - role: <ansible_dir>/roles/stop_sap

Run the Stop of SAP System PRD by:

.. code:: yaml

   ansible-playbook --verbose stop_sap.yml -t sap_stop_instance

License
-------

This collection is licensed under the `Apache 2.0 license <https://www.apache.org/licenses/LICENSE-2.0>`_.

Author Information
------------------

SAP on IBM Power Development Team

Copyright
---------

Copyright IBM Corporation 2021,2022
