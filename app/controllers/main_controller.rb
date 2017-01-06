class MainController < ApplicationController
  def dashboard

  end

  def apps
    @output = []
    ssh_connect do |ssh|
     result = ssh.exec!('dokku apps')
     result.split("\n").each_with_index do |app, i|
       next if i == 0
       @output << app
     end
    end
  end

  def list
    @output = []
    ssh_connect do |ssh|
     result = ssh.exec!('dokku ls')
     result.split("\n").each_with_index do |app, i|
       next if i == 0
       @output << app.split(" ").flatten
     end
    end
  end
end
