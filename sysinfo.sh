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
