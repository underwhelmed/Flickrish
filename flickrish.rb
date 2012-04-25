class Flickrish
  
  def self.getFileUrl(id, secret)
    info = flickr.photos.getInfo :photo_id => id, :secret => secret
    sizes = flickr.photos.getSizes :photo_id => id
    original = sizes.find {|s| s.label == 'Original' }
    original.source
  end
  
  def self.download(url, filename)
    open(filename, 'wb') do |file|
      file << open(url).read
    end
  end

end