# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.synced_folder './workspace', '/home/vagrant/workspace'
  config.vm.synced_folder File.expand_path('~/.aws'), '/home/vagrant/.aws'
  config.vm.network 'forwarded_port', guest: 9292, host: 9292
  config.vm.network 'forwarded_port', guest: 9393, host: 9393
  config.vm.network 'forwarded_port', guest: 8888, host: 8888
  config.vm.network 'forwarded_port', guest: 4000, host: 4000
  config.ssh.forward_agent = true
  config.omnibus.chef_version = '12.3.0'
  config.berkshelf.enabled = true
  config.vm.provision :shell, inline: 'sudo apt-get update && sudo apt-get install -y python-software-properties && sudo add-apt-repository ppa:chris-lea/node.js && sudo apt-get update'
  config.vm.provision 'chef_solo' do |chef|
    chef.run_list = [
      'recipe[sandbox::rvm]',
      'recipe[sandbox::heroku]',
      'recipe[sandbox::packages]',
      'recipe[sandbox::wkhtmltopdf]',
      'recipe[rvm::user]'
    ]
  end
  config.vm.provision 'file', source: '~/.gitconfig', destination: '.gitconfig'
  config.vm.provision 'file', source: 'files/sshconfig', destination: '.ssh/config'

  config.vm.provision :shell, inline: [
    'apt-get -y -q update',
    'apt-get -y -q upgrade',
    'apt-get -y -q install software-properties-common htop',
    'add-apt-repository ppa:webupd8team/java',
    'apt-get -y -q update',
    'echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections',
    'apt-get -y -q install oracle-java8-installer',
    'apt-get -y -q install maven'
  ].join(' && ')

  if Vagrant.has_plugin?('vagrant-proxyconf') && ENV.has_key?('http_proxy')
    config.proxy.http = ENV['http_proxy']
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
  end
end
