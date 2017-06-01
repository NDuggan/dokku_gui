class ConfigController < ApplicationController
  def show
    @app_name = params[:app_name]

    @output = []
    ssh_connect do |ssh|
     result = ssh.exec!("dokku config #{@app_name}")
     result.split("\n").each_with_index do |config, i|
       next if i == 0
       @output << config.split(" ", 2)
     end
    end
  end
end