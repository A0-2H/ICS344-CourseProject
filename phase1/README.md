## 🛠️ Phase 1: Environment Setup

### ✅ 1. Import Victim VM (Metasploitable3)
We downloaded the `.ova` file from the official [SourceForge Metasploitable3 Repository](https://sourceforge.net/projects/metasploitable3-ub1404upgraded/files/).

- Opened VirtualBox → File → Import Appliance
- Selected `.ova` file and customized VM settings (RAM = 2048MB, CPU = 2)
- Verified that import completed successfully

📸 Screenshots:
- `1-virtualbox_attacker_machine.png`
- `2-import_appliance_option.png`
- `3-select_metasploitable3_ova.png`
- `4-import_appliance_settings.png`
- `5-import_progress.png`

---

### ✅ 2. Boot the Victim VM

- VM launched using default credentials:
  - `username: vagrant`
  - `password: vagrant`

📸 Screenshot:
- `6-metasploitable3_login_success.png`

---

### ✅ 3. Verify NAT Network Communication

- Victim IP: `10.0.2.15` (obtained using `ifconfig`)
- Attacker IP: `10.0.2.6` (shown via `ip a`)
- Attacker pinged victim successfully

📸 Screenshots:
- `7-ifconfig_command.png`
- `8-victim_ip_found.png`
- `9-kali_ping_success.png`

---

### ✅ GitHub Commit Comments (suggested)
```text
[Phase1-Setup] Imported Metasploitable3, configured NAT network, verified attacker-victim connection (10.0.2.6 ↔ 10.0.2.15).














➡️ Custom exploitation scripts used for Task 1.2 are located in [custom/](./custom/).
