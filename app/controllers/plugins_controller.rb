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
       attributes = app.split(" ", 4).flatten
       @output << OpenStruct.new(name: attributes[0], version: attributes[1], status: attributes[2], description: attributes[3])
     end
    end
  end

  def toggle_status
    plugin_name = params[:plugin_name]
    state = params[:state]

    @output = []
    ssh_connect do |ssh|
      @output = ssh.exec!("sudo dokku plugin:#{state} #{plugin_name}") 
    end

    if @output[/-----> Plugin #{plugin_name} #{state}d/]
      render json: :ok
    else
      render json: :error, status: :unprocessable_entity
    end
  end
end
