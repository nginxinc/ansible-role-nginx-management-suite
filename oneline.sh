#!/usr/bin/bash
#
# make this executable so the ansible task can run it with chmod +x 
#
sed ':a; N; $!ba; s/\n//g' nms_license.base64.txt > oneline.txt
