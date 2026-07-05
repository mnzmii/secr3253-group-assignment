
echo ""
echo "--- Disk Usage ---"
df -h

echo ""
echo "--- Logged-in Users ---"
who

echo ""
echo "--- Top 5 Running Processes by CPU Usage ---"
ps aux --sort=-%cpu | head -n 6
