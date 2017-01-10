class AppsController < ApplicationController
  def index
    @output = []
    ssh_connect do |ssh|
     result = ssh.exec!('dokku apps')
     result.split("\n").each_with_index do |app, i|
       next if i == 0
       @output << app
     end
    end
  end

  def create
    app_name = params[:app_name]

    ssh_connect do |ssh|
      @output = ssh.exec!("dokku apps:create #{app_name}")
    end

    if @output&.match(/Creating #{app_name}... done/)
      render json: :ok
    else
      render json: :error, status: :unprocessable_entity
    end
  end

  def destroy
    app_name = params[:app_name]

    ssh_connect do |ssh|
      @output = ssh.exec!("dokku --force apps:destroy #{app_name}")
    end

    if @output&.match(/Destroying #{app_name}/)
      redirect_to apps_path, success: "App #{app_name} successfully deleted"
    else
      redirect_to apps_path, error: "App #{app_name} could not be deleted"
    end
  end
end
