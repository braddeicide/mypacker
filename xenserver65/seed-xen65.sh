#!/bin/bash

# Set date with touch as requred wget option isn't avail across OSs

mkdir -p ../packer_cache/65/xen
cd ../packer_cache/65/xen
wget -c http://downloadns.citrix.com.edgesuite.net/10340/XS65ESP1.zip
touch XS65ESP1.zip
wget -c http://downloadns.citrix.com.edgesuite.net/10566/XS65ESP1002.zip
touch XS65ESP1002.zip
wget -c http://downloadns.citrix.com.edgesuite.net/10597/XS65ESP1003.zip
touch XS65ESP1003.zip
wget -c http://downloadns.citrix.com.edgesuite.net/10663/XS65ESP1004.zip
touch XS65ESP1004.zip
wget -c http://downloadns.citrix.com.edgesuite.net/10662/XS65E010.zip
touch XS65E010.zip
wget -c http://support.citrix.com/filedownload/CTX201514/XS65ESP1005.zip
touch XS65ESP1005.zip
