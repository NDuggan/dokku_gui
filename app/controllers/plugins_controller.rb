class PluginsController < ApplicationController
  def index
    @output = []
    ssh_connect do |ssh|
     result = ssh.exec!('dokku plugin:list')
     result.split("\n").each_with_index do |app, i|
       if i == 0
        @plugin_version = app
        next
      end
       @output << app.split(" ", 4).flatten
     end
    end
  end
end
