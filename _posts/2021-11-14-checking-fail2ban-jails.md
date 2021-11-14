---
layout: post
title: Checking fail2ban jails
tags:
    - programming
    - sysadmin
    - bash
excerpt: This simple bash script will print the current status of any fail2ban jails on the system.
summary: A simple bash script to check the status of any fail2ban jails
image: /assets/img/dan.png
---

[Fail2ban](https://www.fail2ban.org/wiki/index.php/Main_Page) is an excellent tool to help ban unwelcome IPs from hitting your services.

>Fail2ban scans log files (e.g. /var/log/apache/error_log) and bans IPs that show the malicious signs -- too many password failures, seeking for exploits, etc. Generally Fail2Ban is then used to update firewall rules to reject the IP addresses for a specified amount of time, although any arbitrary other action (e.g. sending an email) could also be configured. Out of the box Fail2Ban comes with filters for various services (apache, courier, ssh, etc).

This simple bash script will print the current status of any fail2ban jails on the system.

```bash
#!/bin/bash
# Check the status of the Fail2Ban jails
JAILS=$(fail2ban-client status | grep "Jail list" | sed -E 's/^[^:]+:[ \t]+//' | sed 's/,//g')
for JAIL in $JAILS
do
    fail2ban-client status "$JAIL"
done
```

Output:

```text
root@pihole:~ λ ./fail2banstatus.sh

Status for the jail: sshd
|- Filter
|  |- Currently failed: 2
|  |- Total failed:     18
|  `- File list:        /var/log/auth.log
`- Actions
   |- Currently banned: 2
   |- Total banned:     4
   `- Banned IP list:   <redacted IPs...>
```

This particular output is from a Pihole. For more information on configuring jails see [This forum post](https://discourse.pi-hole.net/t/securing-pihole/1155/7).

I tend to run this script across all my local machines that have external services exposed via Ansible. I'm hoping to detail that in an upcoming blog post.
