class ApiClient
  def initialize
    @client = AFMotion::Client.build('https://my-api.com') do
      header "Accept", "application/json"

      response_serializer :json
    end
  end

  def token(username, password, &block)
    @client.post("oauth/token", grant_type: 'password', username: username, password: password) do |result|
      block.call(result.object)
    end
  end

  def another_endpoint_call(token, params, &block)
    refresh_token_header(token)

    @client.get('another-endpoint', params) do |result|
      clear_token_header

      block.call(result)
    end
  end

  private

  def clear_token_header
   @client.headers.delete 'Authorization'
  end

  def refresh_token_header(token)
    @client.headers['Authorization'] = "Bearer #{token}"
  end
end