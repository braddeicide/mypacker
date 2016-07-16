#!/bin/bash

# Set date with touch as requred wget option isn't avail across OSs

mkdir -p ../packer_cache/70/xen
cd ../packer_cache/70/xen
wget -O XS70E004.zip -c http://support.citrix.com/supportkc/filedownload?uri=/filedownload/CTX214305/XS70E004.zip 
touch XS70E004.zip 
