# Role stop_sap

The role stop_sap is used to stop one or multiple SAP instances for a given SAP System ID (SID). If a requested SAP instance is already inactive, the request will be ignored and no error message will be sent. The role stop_sap is using the sapcontrol command of the SAP Host Agent as suggested in [SAP Note 1763593](https://launchpad.support.sap.com/#/notes/1763593).

The role stop_sap needs the SAP System ID as input in variable `sap_sid`. An SAP instance number can be provided optionally in variable `sap_nr`. If an instance number is provided, only this instance is stoped. If no instance number is provided, stop_sap will stop all configured instances for the given SID, also on remote servers in a distributed landscape. It is recommended that the role stop_sap is executed on the logical partition or server that hosts the central services instance (ASCS, SCS), the primary application server instance, or the central instance.

## Requirements

This role is intended for the operating system IBM AIX. The target system must be enabled to execute Ansible playbooks. For details, see [README.md](../../README.md) in the general section about Ansible scripts for SAP on IBM AIX systems.

The SAP Start Services for the requested SAP system must be configured in file /usr/sap/sapservices and started. In a standard installation, they are started automatically after a reboot (autostart job entry SAPINIT).

## Variables

| **Variable** | **Usage** | **Required** |
|:-------------|:----------|:-------------|
|`sapctr_exe_dir`|Directory path on the target host where the sapcontrol executable is located|Yes [(1)](#Remarks)|
|`sap_sid`|SAP system ID|Yes|
|`sap_nr`|SAP instance number|No [(2)](#Remarks)|
|`sap_softtimeout`|softtimeout in seconds: -1 = infinite wait, 0 = hard shutdown|No [(3)](#Remarks)|

#### Remarks:
1. Default provided
2. When the parameter is omitted, all instances are stopped.
3. When the parameter is omitted, a hard shutdown is executed.

## Defaults

Suggested default values are provided in defaults/main.yml:

| **Variable** | **Default** |
|:-------------|:------------|
|`sapctr_exe_dir` | "/usr/sap/hostctrl/exe" |

## Dependencies

None.

## Example Playbook
You plan to stop a SAP system with SAP SID (sap_sid) PRD having at least one instance on LPAR ibmaixserver01.mycorp.com

ibmaixserver01.mycorp.com has been defined in the inventory file.

You have created the following file <playbook_path>/customer_playbook>.yml

```YAML
    - hosts: ibmaixserver01.mycorp.com
      vars:
      - sap_sid: "PRD"
      roles:
      - role: <ansible_dir>/roles/stop_sap
```

Run the Stop of SAP System PRD by:
```YAML
ansible-playbook --verbose <playbook_path>/<customer_playbook>.yml
```
`

## License

This collection is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0).

## Author Information

SAP on IBM Power Development Team
