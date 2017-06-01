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
    toggle_plugin_status(params[:plugin_name], "disable")
  end

  def enable
    toggle_plugin_status(params[:plugin_name], "enable")
  end

  private

  def toggle_plugin_status(plugin_name, state)
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
