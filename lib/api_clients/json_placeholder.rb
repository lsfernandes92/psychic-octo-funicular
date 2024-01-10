require 'net/http'

class JsonPlaceHolder
  def self.posts
    url = URI('https://jsonplaceholder.typicode.com/posts')
    Net::HTTP.get(url)
  end
end