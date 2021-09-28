# Using AIX RBAC with Ansible

This Document describes how to use a non-root User for executing Ansible Task remote on a (target) host.
RBAC principles are:

- Authorizations are assigned to commands
- Roles are assigned to users.
- Privileges are associated with specific processes.
- Explicit privileges are assigned to commands required for execution and their execution is governed by authorization.

Goals:
- no need to change Ansible playbooks or tasks
- add only a few user configurations to your Ansible inventory to run tasks as non-root User.

You need to do the following steps:
1. Adding a local user id on your AIX target host --> in this example we use "ansusr1" as the user name. You can choose another one by your own.
2. Adding a proper RBAC configuration to this local user
3. Adding a module for user privilege escalation with Ansible "Become"
4. Configure your inventory

## Step 1 : adding a local user
1. Log-on into your AIX Target Host as Root/UID-0.
2. Create a new user with:
```shell
$> mkuser ansusr1
```

## Step 2 : create RBAC configuration
1. Configure as User Root/UID-0 a RBAC Role with the following commands:
```shell
$> mkauth dfltmsg='for ansible' ans_auth
$> setsecattr -c innateprivs=PV_SU_UID accessauths=ans_auth ruid=0 euid=0 /bin/sh
$> mkrole authorizations=ans_auth dfltmsg="Ansible role" ansible
$> chrole auth_mode=NONE ansible
$> chuser roles=ansible ansusr1
$> setkst
```
Last Step "setkst" will reload the Kernel Tables used for the Role Based Access Control.

2. Make a test and logon as the test-user:
```shell
$> su - ansusr1
$> id --> should show you a UID bigger then 0 ! --> uid from ansusr1
$> swrole ansible -c /bin/sh
$> id --> should show you running shell with UID 0
```

3. Configure ssh to remote login for "ansusr1"

## Step 3 : adding a module for user privilege escalation with Ansible "Become"
Use the python Module from: **https://github.com/power-devops/ansible-swrole**

just copy swrole.py into the proper directory on your Ansible Host e.g. **/opt/freeware/lib/python??/site-packages/ansible/plugins/become** or where your Ansible is installed. You can search for the "plugins/become" directory on you Ansible Host. On an Ansible Linux server this could be located in: **/usr/lib/python3.6/site-packages/ansible/plugins/become/swrole.py**

## Step 4 : Configure your inventory
Here on example you could use in your YAML Inventory file named **sapinventory.yaml**
The machine "host1234" is an AIX target host.
```YAML
host1234:
        ansible_local_tmp: /tmp
        ansible_user: ansusr1
        ansible_become: yes
        ansible_become_method: swrole
        ansible_become_role: ansible
        ansible_python_interpreter: /usr/bin/python
        ansible_host: host1234.my.domain.com
```

If you need further information how on "Understanding privilege escalation: become" you may have a look here:
**https://docs.ansible.com/ansible/latest/user_guide/become.html**

## Example and Debugging
An example call could look like this:
```shell
$> ansible-playbook -i sapinventory.yaml start.yaml
```

If you run into errors open a "typescript" file, add the Ansible debug variable in front of the playbook call like this:
```shell
ANSIBLE_DEBUG=1 ansible-playbook ...
```
and close the log file after this run. You may review the log now to detect the root cause of the error. There are also other options to save output like using Ansible-Tower or configure log-options in your configuration/settings file.

## List configuration and hints
### RBAC: list authorization
```shell
$> lsauth ALL|grep -i ans
ans_auth id=10019 dfltmsg=for ansible
```

If you know the name of the authorization then replace "ALL" with this.
You can also have a look to the authorization configuration file:
```shell
$> cat /etc/security/authorizations
```

or in a similar format output with:
```shell
$> lsauth -f ALL
```

### Listing a role configuration:
```shell
$> lsrole ansible
```

or
```shell
$> lsrole ALL|grep -i ans
```

### List the privileged command database:
```shell
$> cat /etc/security/privcmds
```

For further details see: https://www.ibm.com/docs/en/aix/7.2?topic=database-adding-command-privileged-command

