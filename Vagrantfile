# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'
  config.vm.synced_folder './workspace', '/home/vagrant/workspace'
  config.vm.network 'forwarded_port', guest: 9393, host: 9393
  config.vm.network 'forwarded_port', guest: 8888, host: 8888
  config.vm.network 'forwarded_port', guest: 4000, host: 4000
  config.ssh.forward_agent = true
  config.berkshelf.enabled = true
  config.vm.provision :shell, :inline => 'sudo apt-get update && sudo apt-get install -y python-software-properties && sudo add-apt-repository ppa:chris-lea/node.js && sudo apt-get update'
  config.vm.provision 'chef_solo' do |chef|
    chef.run_list = [
      'recipe[sandbox::rvm]',
      'recipe[sandbox::heroku]',
      'recipe[sandbox::packages]',
      'recipe[sandbox::wkhtmltopdf]',
      'recipe[rvm::user]',
      'recipe[rvm::vagrant]'
    ]
  end
  config.vm.provision 'file', source: '~/.gitconfig', destination: '.gitconfig'
  config.vm.provision 'file', source: 'files/sshconfig', destination: '.ssh/config'

  if Vagrant.has_plugin?('vagrant-proxyconf') && ENV.has_key?('http_proxy')
    config.proxy.http = ENV['http_proxy']
  end
end
