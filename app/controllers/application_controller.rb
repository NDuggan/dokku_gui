class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def ssh_connect
    Net::SSH.start(ENV["SSH_HOST"], ENV["SSH_USER"], password: ENV["SSH_PASS"]) do |ssh|
      yield ssh
    end
  end
end
