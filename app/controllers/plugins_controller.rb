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

  def disable
    plugin_name = params[:plugin_name]

    @output = []
    ssh_connect do |ssh|
      @output = ssh.exec!("sudo dokku plugin:disable #{plugin_name}") 
    end

    if @output[/-----> Plugin #{plugin_name} disabled/]
      render json: :ok
    else
      render json: :error, status: :unprocessable_entity
    end
  end

  def enable
    plugin_name = params[:plugin_name]

    @output = []
    ssh_connect do |ssh|
      @output = ssh.exec!("sudo dokku plugin:enable #{plugin_name}") 
    end

    if @output[/-----> Plugin #{plugin_name} enabled/]
      render json: :ok
    else
      render json: :error, status: :unprocessable_entity
    end
  end
end
