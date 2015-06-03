. /root/.profile

# "Fuzzy package addition" is broken for ruby, this means we don't have to hardcode versions.
false | pkg_add ruby 2>&1 | perl -n -e 'print `pkg_add $&` if $_ =~ /ruby-1.9[\w\.]+/'

ln -sf /usr/local/bin/ruby19 /usr/local/bin/ruby
ln -sf /usr/local/bin/erb19 /usr/local/bin/erb
ln -sf /usr/local/bin/irb19 /usr/local/bin/irb
ln -sf /usr/local/bin/rdoc19 /usr/local/bin/rdoc
ln -sf /usr/local/bin/ri19 /usr/local/bin/ri
ln -sf /usr/local/bin/rake19 /usr/local/bin/rake
ln -sf /usr/local/bin/gem19 /usr/local/bin/gem
ln -sf /usr/local/bin/testrb19 /usr/local/bin/testrb

pkg_add ruby-gems
pkg_add ruby-iconv
