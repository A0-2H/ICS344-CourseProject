# Custom Exploitation Scripts – Task 1.2

This folder contains two custom scripts used for exploiting Metasploitable3 manually.

## `custom.sh`
- Exploits the SUID bit on `/usr/bin/lppasswd` via a PATH hijacking attack.
- Drops a fake `logger` binary that spawns a root shell.

## `lightpeas.sh`
- Performs system enumeration to identify escalation paths.
- Lists SUID binaries, writable root files, environment paths, running processes, and more.
