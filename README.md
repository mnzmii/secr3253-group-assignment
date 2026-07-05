# SECR3253 Network Programming & Automation Project

This repository contains the infrastructure and configuration files to automate a Cisco CSR1000v router using Ansible, containerized entirely within Docker. Additionally, it features a custom bash script for real-time Linux system health monitoring.

---

## 👥 Team Members

| Name | Matrix ID | Project Role | Specific Tasks Executed |
| :--- | :--- | :--- | :--- |
| **Muhammad Nazmi bin Mohd Saifulizam** | `[A23CS0135]` | Infrastructure Lead | • Engineered the Python 3.10 Docker container environment.<br>• Built the `Dockerfile` to install Ansible, Netmiko, and required Linux system tools.<br>• Configured the global `ansible.cfg` and `hosts` inventory to automate connection mappings. |
| **Nur Arisha binti Amyrul Naim** | `[A23CS0154]` | Network Automation | • Authored `playbook_basic_config.yml` for initial device provisioning.<br>• Configured Loopback0 IPv4 addressing and enabled the interface.<br>• Created privilege 15 admin credentials and deployed the MOTD security banner. |
| **Muhammad Khairul Hakimi bin Mohd Khalid** | `[A23CS0133]` | Network Automation | • Authored `playbook_routing_info.yml` for network routing.<br>• Configured GigabitEthernet descriptions and deployed static IPv4 routes.<br>• Utilized Ansible modules to dynamically extract and display router hardware/OS facts. |
| **Balqis Nabilah binti Muhammad Azwan** | `[A23CS0054]` | Linux Administration | • Initiated the `sysinfo.sh` bash script architecture.<br>• Implemented commands to retrieve the container hostname and formatted system date/time.<br>• Utilized `lscpu` to extract and display detailed CPU architecture metrics and core counts. |
| **Wan Muhammad Afif Zikry bin Wan Ruslan** | `[A23CS0282]` | Linux Administration | • Expanded the `sysinfo.sh` script for deeper resource monitoring.<br>• Engineered parsing for active memory usage and disk partition limits.<br>• Implemented process monitoring to sort and display the top 5 CPU-consuming tasks. |

---

## 🏗️ System Architecture

This project is built on a containerized architecture to eliminate cross-platform dependency issues. The Docker container serves as the execution environment, securely pushing configurations to the target network node.

[ Host Machine (Windows/macOS/Linux) ]
       │
       ▼ (Docker Engine)
┌──────────────────────────────────────────┐
│ 🐳 Docker Container (python:3.10-slim)   │
│                                          │
│  ⚙️ Ansible Environment                  │
│     ├─ ansible.cfg                       │
│     └─ hosts (Credentials)               │
│                                          │
│  🖥️ Local Execution                      │
│     └─ sysinfo.sh (Gets local metrics)   │
└──────────────────┬───────────────────────┘
                   │
                   ▼ (SSH Connection)
┌──────────────────────────────────────────┐
│ 🌐 Cisco CSR1000v Router                 │
│    IP: 192.168.56.101                    │
│    OS: Cisco IOS XE                      │
└──────────────────────────────────────────┘

---

## 📂 Project Structure

    secr3253-group-assignment/
    ├── Dockerfile                  # Base Python image and system dependencies
    ├── README.md                   # Project documentation
    ├── ansible.cfg                 # Global Ansible configurations
    ├── hosts                       # Inventory file defining the CSR1000v target
    ├── playbook_basic_config.yml   # Arisha's automation script
    ├── playbook_routing_info.yml   # Khairul's automation script
    └── sysinfo.sh                  # Balqis & Zikri's Linux monitoring script

---

## 🚀 How to Run the Project

### 1. Prerequisites
Ensure you have the following installed on your host machine:
* **Git** (for version control)
* **Docker** (for containerization)
* A **Cisco CSR1000v Virtual Machine** running and accessible at `192.168.56.101`.

### 2. Clone the Repository
Open your terminal and pull down the latest code:
    
    git clone https://github.com/mnzmii/secr3253-group-assignment.git
    cd secr3253-group-assignment

### 3. Build the Docker Image
We use Docker to ensure all dependencies (Python 3.10, Ansible, and system libraries) are perfectly configured. Build the image using this command:
    
    docker build -t secr3253-network-auto .

### 4. Run the Docker Container
Once built, run the container interactively. This drops you into a bash shell *inside* the container where all your tools are ready:
    
    docker run -it --name my-network-auto secr3253-network-auto

### 5. Execute the Automation Scripts
You are now inside the Docker container! Run the following commands to execute the team's scripts:

**Run Arisha's Basic Configuration Playbook:**
    
    ansible-playbook playbook_basic_config.yml

**Run Khairul's Routing & Device Info Playbook:**
    
    ansible-playbook playbook_routing_info.yml

**Run Balqis & Zikri's Linux System Information Script:**
    
    chmod +x sysinfo.sh
    ./sysinfo.sh

---

## ✅ Sample Output

When the playbooks and scripts are executed successfully inside the Docker container, you will see the following validated outputs for each team member's module:

**1. Arisha's Basic Configuration (`playbook_basic_config.yml`)**
    
    TASK [Configure IP address on interface Loopback0] ******************************************
    changed: [192.168.56.101]

    TASK [Configure administrative user account] ************************************************
    changed: [192.168.56.101]

    TASK [Configure MOTD banner message] ********************************************************
    changed: [192.168.56.101]

    TASK [Save running configuration to startup config] *****************************************
    changed: [192.168.56.101]

    PLAY RECAP **********************************************************************************
    192.168.56.101             : ok=4    changed=4    unreachable=0    failed=0   

**2. Khairul's Routing & Device Info (`playbook_routing_info.yml`)**
    
    TASK [Configure interface description] ******************************************************
    changed: [192.168.56.101]

    TASK [Configure static route] ***************************************************************
    changed: [192.168.56.101]

    TASK [Retrieve device information] **********************************************************
    ok: [192.168.56.101]

    TASK [Display retrieved device information] *************************************************
    ok: [192.168.56.101] => {
        "msg": "Hostname: CSR1kv, Model: CSR1000V, OS Version: 16.09.05"
    }

    PLAY RECAP **********************************************************************************
    192.168.56.101             : ok=4    changed=2    unreachable=0    failed=0   

**3. Balqis & Zikri's Linux System Info (`sysinfo.sh`)**
    
    ========================================
           LINUX SYSTEM INFORMATION         
    ========================================
    
    --- CPU Information ---
    CPU(s):                          4
    Model name:                      11th Gen Intel(R) Core(TM) i5-11400H @ 2.70GHz
    
    --- Memory Usage ---
                   total        used        free      shared  buff/cache   available
    Mem:           3.8Gi       1.4Gi       659Mi        49Mi       2.1Gi       2.4Gi
    
    --- Disk Usage ---
    Filesystem      Size  Used Avail Use% Mounted on
    overlay          31G   25G  4.6G  85% /

---

## 📝 Infrastructure Notes

To ensure this automation runs flawlessly on modern machines communicating with older Cisco virtual routers, the following infrastructure adjustments were built into this project:
* **Legacy SSH KEX Support:** The Docker container automatically generates an SSH configuration file to accept `diffie-hellman-group14-sha1` algorithms to prevent Cisco CSR1000v connection drops.
* **Modern Ansible Connection:** Implemented `ansible-pylibssh` for stable network CLI connections.
* **Streamlined Execution:** A local `ansible.cfg` file automatically disables RSA fingerprint host key checking, allowing automation to run without interactive SSH prompts.
