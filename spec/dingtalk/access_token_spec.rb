require "json"
require "dingtalk"
require "dingtalk/access_token"

RSpec.describe Dingtalk::AccessToken do
  before :each do
    @app_key = "mocked_app_key"
    @app_secret = "mocked_app_secret"
    @mocked_access_token = "mocked_access_token"

    @dingtalk_request = Dingtalk::Request.new(app_key: @app_key, app_secret: @app_secret)

    response_body = {}.tap do |h|
      h[:errcode] = 0
      h[:errmsg] = 0
      h[:access_token] = @mocked_access_token
    end

    stub_request(:get, /oapi.dingtalk.com/)
      .with(query: { appkey: @app_key, appsecret: @app_secret })
      .to_return(status: 200, body: response_body.to_json )
  end

  it "should return correct access_token from request" do
    response = @dingtalk_request.get_access_token

    expect(response[:access_token]).to eq(@mocked_access_token)
  end
end