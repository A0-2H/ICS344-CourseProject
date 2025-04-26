
# 📚 Phase 2: Visual Analysis with a SIEM Dashboard

---

## 🛠️ Part 1: Splunk SIEM Setup (Attacker Machine)

### 1.1 Download and Install Splunk

```bash
wget -O splunk-9.3.2.deb https://download.splunk.com/products/splunk/releases/9.3.2/linux/splunk-9.3.2-d8bb32809498-linux-2.6-amd64.deb
```

**Screenshots:**
- ![1-download-splunk-progress.png](./screenshots/1-download-splunk-progress.png)
- ![2-download-splunk-complete.png](./screenshots/2-download-splunk-complete.png)

---

### 1.2 Install Splunk Package

```bash
sudo dpkg -i splunk-9.3.2.deb
```

**Screenshot:**
- ![3-install-splunk-package.png](./screenshots/3-install-splunk-package.png)

---

### 1.3 Start Splunk and Accept License

```bash
sudo /opt/splunk/bin/splunk start --accept-license
```

**Screenshots:**
- ![4-start-splunk-first-time.png](./screenshots/4-start-splunk-first-time.png)
- ![5-splunk-web-ready.png](./screenshots/5-splunk-web-ready.png)

---

### 1.4 Enable Splunk Boot Start

```bash
sudo /opt/splunk/bin/splunk enable boot-start
```

**Screenshot:**
- ![6-enable-splunk-bootstart.png](./screenshots/6-enable-splunk-bootstart.png)

---

### 1.5 Access Splunk Web Interface

- URL: `http://localhost:8000`
- Login:
  - Username: admin
  - Password: splunk123

**Screenshots:**
- ![7-splunk-login-page.png](./screenshots/7-splunk-login-page.png)
- ![8-splunk-login-enter-credentials.png](./screenshots/8-splunk-login-enter-credentials.png)
- ![9-splunk-dashboard-home.png](./screenshots/9-splunk-dashboard-home.png)

---

## 🛠️ Part 2: Splunk Forwarder Setup (Victim Machine)

### 2.1 Download and Install Splunk Universal Forwarder

```bash
wget -O splunkforwarder.deb https://download.splunk.com/products/universalforwarder/releases/9.4.1/linux/splunkforwarder-9.4.1-e3bdab203ac8-linux-arm64.deb
sudo dpkg -i splunkforwarder.deb
sudo apt --fix-broken install
```

**Screenshots:**
- ![10-download-forwarder-package.png](./screenshots/10-download-forwarder-package.png)
- ![11-install-splunk-forwarder.png](./screenshots/11-install-splunk-forwarder.png)
- ![12-fix-broken-install-forwarder.png](./screenshots/12-fix-broken-install-forwarder.png)

---

### 2.2 Start Splunk Universal Forwarder

```bash
sudo /opt/splunkforwarder/bin/splunk start --accept-license
```

**Screenshot:**
- ![13-start-forwarder-first-time.png](./screenshots/13-start-forwarder-first-time.png)

---

### 2.3 Configure Forwarding Server

```bash
sudo /opt/splunkforwarder/bin/splunk add forward-server 10.0.2.6:9997
```

**Screenshot:**
- ![14-forwarder-ready-status.png](./screenshots/14-forwarder-ready-status.png)

---

### 2.4 Monitor Important Log File

```bash
sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/boot.log
```

**Screenshot:**
- ![15-add-forward-server.png](./screenshots/15-add-forward-server.png)

---

## 🔍 Part 3: Visualize and Analyze Logs

### 3.1 Access Search & Reporting

- Open Splunk → Search & Reporting App.

**Screenshot:**
- ![16-add-monitor-bootlog.png](./screenshots/16-add-monitor-bootlog.png)

---

### 3.2 Open Data Summary

- Navigate to Data Summary → Hosts.

**Screenshot:**
- ![17-splunk-search-homepage.png](./screenshots/17-splunk-search-homepage.png)

---

### 3.3 Host Detected

- Confirmed that `kali` host appears.

**Screenshot:**
- ![18-splunk-new-search-page.png](./screenshots/18-splunk-new-search-page.png)

---

### 3.4 Analyze Logs

- View forwarded logs from `/var/log/boot.log`.

**Screenshot:**
- ![19-data-summary-hosts.png](./screenshots/19-data-summary-hosts.png)

---

### 3.5 Search and View Boot Logs

```bash
host=kali
```

- Searched logs from the victim machine.

**Screenshot:**
- ![20-host-kali-log-list.png](./screenshots/20-host-kali-log-list.png)

---

### 3.6 View Log Event Details

- Inspected specific log events.

**Screenshot:**
- ![21-log-event-details.png](./screenshots/21-log-event-details.png)

---
