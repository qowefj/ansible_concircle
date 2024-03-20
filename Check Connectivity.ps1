---
- name: Check Connectivity with Hosts
  hosts: all  # Specifies that the playbook should run on all hosts in your inventory
  gather_facts: no  # This skips gathering system facts, making the task quicker

  tasks:
    - name: Ping Hosts
      ansible.builtin.ping:  # Uses the ping module to check connectivity
