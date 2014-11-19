# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'
  config.vm.synced_folder './workspace', '/home/vagrant/workspace'
  config.vm.network 'forwarded_port', guest: 9393, host: 9393
  config.ssh.forward_agent = true
  config.berkshelf.enabled = true
  config.vm.provision :shell, :inline => 'sudo apt-get update && sudo apt-get install -y python-software-properties && sudo add-apt-repository ppa:chris-lea/node.js && sudo apt-get update'
  config.vm.provision 'chef_solo' do |chef|
    chef.run_list = [
      'recipe[sandbox::rvm]',
      'recipe[sandbox::heroku]',
      'recipe[sandbox::packages]',
      'recipe[rvm::user]',
      'recipe[rvm::vagrant]'
    ]
  end
  config.vm.provision :shell, :inline => "echo -e '#{File.read("#{Dir.home}/.gitconfig")}' > '/home/vagrant/.gitconfig'" if File.exist?("#{Dir.home}/.gitconfig")
end
