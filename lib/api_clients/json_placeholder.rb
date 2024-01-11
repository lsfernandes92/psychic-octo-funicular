require 'net/http'

class JsonPlaceHolder
  def self.posts(id = '')
    url = URI("https://jsonplaceholder.typicode.com/posts/#{id}")
    Net::HTTP.get(url)
  end
end