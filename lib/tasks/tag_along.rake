require 'uri'
require 'net/http'

namespace :tag_along do

  desc "Get an updated Auth0 token for API use"
  task auth0token: :environment do
    
#    header = "content-type: application/json"
#    data = "{\"grant_type\":\"client_credentials\",\"client_id\": \"nKrzBwtzsY07J9eqYhmeuXgHhXOckq2t\",\"client_secret\": \"BuvBUJhh87u_KWUNsrdi9fh7Fq9MJoaXWPr9_0oDFxAG99iiK3NSZrj4hCF1qaSB\",\"audience\": \"https://tag-along.auth0.com/api/v2/\"}"
#    
    url = URI("https://tag-along.auth0.com/oauth/token")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"grant_type\":\"client_credentials\",\"client_id\": \"nKrzBwtzsY07J9eqYhmeuXgHhXOckq2t\",\"client_secret\": \"BuvBUJhh87u_KWUNsrdi9fh7Fq9MJoaXWPr9_0oDFxAG99iiK3NSZrj4hCF1qaSB\",\"audience\": \"https://tag-along.auth0.com/api/v2/\"}"

    response = http.request(request)
    puts response.read_body
  end
  
end