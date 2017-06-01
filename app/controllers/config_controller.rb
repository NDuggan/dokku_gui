class ConfigController < ApplicationController
  before_action :set_app_name

  def show
    @output = []
    ssh_connect do |ssh|
     result = ssh.exec!("dokku config #{@app_name}")
     result.split("\n").each_with_index do |config, i|
       next if i == 0
       key, value = config.split(":", 2).map(&:strip)
       @output << [key, value] unless key.blank?
     end
    end
  end

  def destroy
    config_key = params[:config_key]

    @output = []
    ssh_connect do |ssh|
     @output = ssh.exec!("dokku config:unset --no-restart #{@app_name} #{config_key}")
    end

    if @output[/-----> Unsetting #{config_key}/]
      render json: :ok
    else
      render json: :error, status: :unprocessable_entity
    end
  end

  private

  def set_app_name
    @app_name = params[:app_name]
  end
end