class MainController < ApplicationController
  def dashboard
    ssh_connect do |ssh|
      @cpu = ssh.exec!('cat /proc/cpuinfo | grep processor').split("\n").last.match(/processor\t:(\S*) (.*)/)[2].to_i + 1
      @memory = ssh.exec!('cat /proc/meminfo | grep MemTotal:').match(/^MemTotal:(\S*) (.*)/)[2].to_i * 1024
      @docker_version = ssh.exec!('docker --version').match(/^Docker version(\S*) (.*)/)[2]
      @dokku_version = ssh.exec!('dokku version')
    end
  end
end
