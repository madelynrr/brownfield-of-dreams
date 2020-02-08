class GithubController < ApplicationController

  def create
    client_id = ENV['RAILS_CLIENT_ID']
    client_secret = ENV['RAILS_CLIENT_SECRET']
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

    pairs = response.body.split("&")
    response_hash = {}
    pairs.each do |pair|
      key, value = pair.split("=")
      response_hash[key] = value
    end

    github_token = response_hash["access_token"]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{github_token}")

    auth = JSON.parse(oauth_response.body)

    current_user.update(token: github_token)

    redirect_to dashboard_path
  end
end
