# NetScan


NetScan 
NetScan is an advanced tool for discovering live hosts on a network and performing comprehensive network scans. It combines host discovery and detailed scanning into a user-friendly script, with the ability to save and manage results for each IP address individually. This tool is ideal for network administrators, security researchers, and anyone looking to analyze their network efficiently.

Features
Live Host Discovery: Automatically detects active hosts on a specified IP range using ICMP ping.
Customizable Scanning: Scans each live host with Nmap, providing detailed information about open ports, operating systems, and more.
Result Management:
Automatically saves scan results in separate files for each IP address.
If a scan result file already exists, the tool will prompt you to view, delete, or skip scanning that host.
Parallel Processing: Speeds up host discovery and scanning by running processes in parallel.
Summary Logs: A detailed summary log of scanned hosts and their result files.
Error Handling: Handles invalid inputs gracefully and ensures the script runs smoothly.
Installation
Prerequisites
Before running the script, ensure that you have the following installed:

Bash (Typically pre-installed on most Linux/macOS systems)

Nmap: Install Nmap using the following commands:

On Debian/Ubuntu:

bash
Copy
Edit
sudo apt-get install nmap
On Red Hat/CentOS:

bash
Copy
Edit
sudo yum install nmap
On macOS (using Homebrew):

bash
Copy
Edit
brew install nmap
Clone or Download the Script
To get started, clone the repository or download the script:

bash
Copy
Edit
git clone https://github.com/yourusername/netscan-pro.git
Alternatively, you can directly download the script from the repository.

Usage
Make the script executable:

bash
Copy
Edit
chmod +x advanced_discover_and_scan.sh
Run the script:

bash
Copy
Edit
./advanced_discover_and_scan.sh
Input:

When prompted, enter the base IP address (e.g., 192.168.1).
Follow the prompts to view, delete, or skip scanning results for previously scanned hosts.
Example Usage
bash
Copy
Edit
$ ./advanced_discover_and_scan.sh
Enter the base IP address (e.g., 192.168.0): 192.168.1
Discovering live hosts in 192.168.1.0/24...
192.168.1.1 is up
192.168.1.10 is up
192.168.1.100 is up

Scanning live hosts...
Scan result for 192.168.1.1 already exists in 192.168.1.1.txt.
Options: [v]iew, [d]elete and rescan, [s]kip
v
Displaying existing results for 192.168.1.1:
Results for 192.168.1.1:
...
Skipping 192.168.1.10.
Scanning 192.168.1.100...
Results saved in 192.168.1.100.txt.

Discovery and scanning complete. Summary saved in scan_summary.log.
Detailed scan results are stored in individual files named [IP].txt.
Files Generated
live_hosts.log: Contains a list of all discovered live hosts.
scan_summary.log: Contains a summary of the scanned IPs, including a reference to their result files.
[IP].txt: A file for each scanned host containing the Nmap scan results for that host.
Contributing
If you'd like to contribute to NetScan Pro, feel free to fork the repository, make improvements, and submit a pull request. We welcome any contributions that make this tool better and more useful.
