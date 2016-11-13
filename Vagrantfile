# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/yakkety64'
  config.vm.network 'private_network', ip: "192.168.50.4"
  config.vm.synced_folder './workspace', '/home/ubuntu/workspace'
  config.vm.synced_folder File.expand_path('~/.aws'), '/home/ubuntu/.aws'
  config.ssh.forward_agent = true
  config.vm.provision 'file', source: '~/.gitconfig', destination: '.gitconfig'
  config.vm.provision 'file', source: 'files/sshconfig', destination: '.ssh/config'

  config.vm.provision 'shell', inline: 'curl -sL https://deb.nodesource.com/setup_7.x | bash -'
  config.vm.provision 'shell', inline: 'apt-get --yes update'
  config.vm.provision 'shell', inline: 'apt-get --yes upgrade'

  [
    'docker.io',
    'golang-1.7',
    'ruby',
    'nodejs',
    'python',
    'vim'
  ].each do |pkg|
    config.vm.provision 'shell', inline: "apt-get --yes install #{pkg}"
  end

  config.vm.provision 'shell', inline: 'usermod -a -G docker ubuntu'

  if Vagrant.has_plugin?('vagrant-proxyconf') && ENV.has_key?('http_proxy')
    config.proxy.http = ENV['http_proxy']
    config.proxy.no_proxy = 'localhost,127.0.0.1,.example.com,.oracle.com';
    config.apt_proxy.http = ENV['http_proxy']
    config.apt_proxy.https = 'DIRECT'
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '4096']
  end
end
