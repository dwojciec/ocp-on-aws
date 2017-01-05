# -*- mode: ruby -*-
# vi: set ft=ruby :
PUBLIC_ADDRESS="10.1.2.2"
# Number of virtualized CPUs
VM_CPU = ENV['VM_CPU'] || 1

# Amount of available RAM
VM_MEMORY = ENV['VM_MEMORY'] || 1024

DOMAIN = (ENV['DOMAIN'] || 'sysdeseng.com')

# Validate required plugins
REQUIRED_PLUGINS = %w(vagrant-registration vagrant-timezone)
errors = []

def message(name)
  "#{name} plugin is not installed, run `vagrant plugin install #{name}` to install it."
end

# Validate and collect error message if plugin is not installed
REQUIRED_PLUGINS.each { |plugin| errors << message(plugin) unless Vagrant.has_plugin?(plugin) }
unless errors.empty?
  msg = errors.size > 1 ? "Errors: \n* #{errors.join("\n* ")}" : "Error: #{errors.first}"
  fail Vagrant::Errors::VagrantError.new, msg
end


Vagrant.configure("2") do |config|
 if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "Europe/Paris"
 end
 config.vm.box = "gwhorley/rhel72-x86_64"
 config.vm.hostname='consoleaws.local'

 config.vm.box_check_update = false
  
 config.vm.provider "virtualbox" do |vb|
    vb.memory = VM_MEMORY
    vb.cpus   = VM_CPU
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.name = "aws_client"
 end
 config.vm.network "private_network", ip: "#{PUBLIC_ADDRESS}"

# vagrant-registration
 if ENV.has_key?('SUB_USERNAME') && ENV.has_key?('SUB_PASSWORD')
    config.registration.username = ENV['SUB_USERNAME']
    config.registration.password = ENV['SUB_PASSWORD']
    config.registration.pools = ENV['SUB_POOLID']
  end

# Proxy Information from environment
 config.registration.proxy = PROXY = (ENV['PROXY'] || '')
 config.registration.proxyUser = PROXY_USER = (ENV['PROXY_USER'] || '')
 config.registration.proxyPassword = PROXY_PASSWORD = (ENV['PROXY_PASSWORD'] || '')



 config.vm.provision "shell" do |s|
   s.path = "provision/setup.sh" 
   s.args = "#{DOMAIN}"
 end
end
