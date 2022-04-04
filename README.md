# Linux Hardening Practice
This was made for anyone to practice basic linux hardening skills on Ubuntu (tested). Clone this repo in your home directory and run `totallySafe.sh` with `sudo`. This script will make your linux installation vulnerable in many ways. This is only for teaching linux misconfigurations and how to fix them. Please do not use on any production machines.

## Ways To Run

### Example Run (No Output):
```
chmod +x totallySafe.sh
sudo ./totallySafe.sh 1>/dev/null 2>/dev/null
```

### Example Run (Output):
```
chmod +x totallySafe.sh
sudo ./totallySafe.sh
```
## Vulnerabilities Covered
**Ignore this section if you want to solve without any tips.**
- SSHD misconfigurations
- SETUID permissions
- Established shells with various permissions
- Unsecure permssions with a few files/executables
- Firewall not enabled