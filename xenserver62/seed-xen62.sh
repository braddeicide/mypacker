#!/bin/bash

# Set date with touch as requred wget option isn't avail across OSs

mkdir -p ../packer_cache/62/xen
cd ../packer_cache/62/xen
wget -c http://downloadns.citrix.com.edgesuite.net/8707/XS62ESP1.zip
touch XS62ESP1.zip
wget -c http://downloadns.citrix.com.edgesuite.net/9708/XS62ESP1014.zip
touch XS62ESP1014.zip
wget -c http://downloadns.citrix.com.edgesuite.net/10193/XS62ESP1017.zip
touch XS62ESP1017.zip
wget -c http://downloadns.citrix.com.edgesuite.net/10567/XS62ESP1024.zip
touch XS62ESP1024.zip
wget -c http://downloadns.citrix.com.edgesuite.net/10654/XS62ESP1028.zip
touch XS62ESP1028.zip
wget -c http://support.citrix.com/filedownload/CTX201739/XS62ESP1032.zip
touch XS62ESP1032.zip
wget -c http://support.citrix.com/filedownload/CTX202617/XS62ESP1034.zip
touch XS62ESP1034.zip
