remote_file '/tmp/wkhtmltopdf.deb' do
  source 'http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.2.1/wkhtmltox-0.12.2.1_linux-precise-amd64.deb'
  mode 0644
  checksum '320efbfc109b823d0eae41e1818c52d6b4f62d40'
end

dpkg_package 'wkhtmltopdf' do
  ignore_failure true
  source '/tmp/wkhtmltopdf.deb'
  action :install
end

execute 'install-wkhtmltopdf-deps' do
  command 'apt-get -yf install'
end
