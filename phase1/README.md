# 📚 Phase 1: Setup and Initial Configuration

---

## 🛠️ Environment Setup

### 1. Import Victim VM (Metasploitable3)

We downloaded the `.ova` file from the official [SourceForge Metasploitable3 Repository](https://sourceforge.net/projects/metasploitable3-ub1404upgraded/files/).

- Opened VirtualBox → File → Import Appliance
- Selected `.ova` file and customized VM settings (RAM = 2048MB, CPU = 2)
- Verified that import completed successfully

**Screenshots:**
- ![VirtualBox Attacker Machine](./screenshots/1-virtualbox_attacker_machine.png)
- ![Import Appliance Option](./screenshots/2-import_appliance_option.png)
- ![Select Metasploitable3 OVA](./screenshots/3-select_metasploitable3_ova.png)
- ![Import Appliance Settings](./screenshots/4-import_appliance_settings.png)
- ![Import Progress](./screenshots/5-import_progress.png)

---

### 2. Boot the Victim VM

- VM launched using default credentials:
  - `username: vagrant`
  - `password: vagrant`

**Screenshot:**
- ![Metasploitable3 Login Success](./screenshots/6-metasploitable3_login_success.png)

---

### 3. Find Victim Machine IP

- Victim IP was retrieved using `ifconfig` on Metasploitable3: `10.0.2.15`
- Attacker IP retrieved on Kali Linux: `10.0.2.6`
- Successfully pinged victim machine from attacker machine.

**Screenshots:**
- ![Victim IP - ifconfig](./screenshots/7-ifconfig_command.png)
- ![Victim IP Found](./screenshots/8-victim_ip_found.png)
- ![Ping Success](./screenshots/9-kali_ping_success.png)

---

### ✅ GitHub Commit Comment

```text
[Phase1-Setup] Imported Metasploitable3, configured NAT network, verified attacker-victim connection (10.0.2.6 ↔ 10.0.2.15).















➡️ Custom exploitation scripts used for Task 1.2 are located in [custom/](./custom/).
