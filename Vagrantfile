Vagrant.configure(2) do |config|
  config.vm.box = "denis/archlinux64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.hostname = "Jeroen"
  config.vm.provision "shell", inline: "yes | pacman -Suy"
  config.vm.provision "shell", path: "provision_php.sh"
end
