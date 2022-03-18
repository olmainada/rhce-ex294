# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo ---- Starting the VMs ------"


  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.

  # To install thre vmware_fusion plugin, run the following command:  "vagrant plugin install vagrant-vmware-desktop"

  config.vm.provider "vmware_fusion" 
  
  config.vm.box = "generic/rhel8"
  config.vm.provision "shell", inline: <<-SHELL
  #set root password
    echo <your_password> | passwd --stdin root

  #edit sshd_config file to be able to connect to the node 
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    systemctl restart sshd

  # Enable your RedHat8 subscription
    subscription-manager register --username <your_redhat_username> --password <your_redhat_password> --auto-attach
  SHELL

#Create the controler node
  config.vm.define "controler" do |app|
    app.vm.hostname = "controler"
    app.vm.network :private_network, ip: "192.168.144.140"
    config.vm.provision "shell", inline: <<-SHELL
    subscription-manager repos --enable ansible-2.8-for-rhel-8-x86_64-rpms
    yum install -y ansible
  SHELL
  end

# Create 5 managed node node-1 to node-5 and set their IP addresses.

  (1..5).each do |i|
    config.vm.define "node-#{i}" do |app|
      app.vm.hostname = "node-#{i}"
      app.vm.network :private_network, ip: "192.168.144.14#{i}"

    end
  end

  # config.vm.define "node-1" do |app|
  #   app.vm.hostname = "node-1"
  #   config.vm.disk :disk, name: "sda", size: "1GB"
  #   app.vm.network :private_network, ip: "192.168.144.144"
  # end


  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
