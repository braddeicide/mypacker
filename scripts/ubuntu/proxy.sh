export http_proxy='http://192.168.122.8:3128'
export https_proxy='http://192.168.122.8:3128'
echo 'Acquire::http::Proxy "http://192.168.122.8:3128";\nAcquire::https::Proxy "http://192.168.122.8:3128";' > /etc/apt/apt.conf.d/01proxy
sed -i 's/us.archive.ubuntu.com\/ubuntu/mirror.internode.on.net\/pub\/ubuntu\/ubuntu/' /etc/apt/sources.list
apt-get update
apt-get -y install wget
echo 'https_proxy = http://192.168.122.8:3128/\nhttp_proxy = http://192.168.122.8:3128/\n' >> /etc/wgetrc
