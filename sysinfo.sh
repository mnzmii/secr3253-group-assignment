#!/bin/bash

echo "========================================"
echo "       LINUX SYSTEM INFORMATION         "
echo "========================================"

echo ""
echo "--- Hostname ---"
hostname

echo ""
echo "--- Current Date and Time ---"
date

echo ""
echo "--- CPU Information ---"
lscpu | grep -E "Model name|CPU\(s\):"

echo ""
echo "--- Memory Usage ---"
free -h

# --- End of Part A (Balqis) ---
# --- Part B (Zikri) continues below ---

echo ""
echo "--- Disk Usage ---"
df -h

echo ""
echo "--- Logged-in Users ---"
who

echo ""
echo "--- Top 5 Running Processes by CPU Usage ---"
ps aux --sort=-%cpu | head -n 6