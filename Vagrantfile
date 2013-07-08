# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  config.vm.hostname = "canvas-lms.dev"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 443, host: 4443
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory",  "1024"]
    vb.customize ["modifyvm", :id, "--cpus",    "2"]
  end
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
  end
end