require 'flickraw'
require 'open-uri'
require 'FileUtils'
require 'yaml'

class Flickrish
  
  def self.getFileUrl(id, secret)
    id     = list[0].id
    secret = list[0].secret
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

keys = YAML.load_file('config.yml')
FlickRaw.api_key = keys['api_key']
FlickRaw.shared_secret = keys['secret']

user_id = keys['user_id']
backup_dir = keys['directory']

if Dir.exists?(backup_dir)
  FileUtils.rm_rf(backup_dir)
end
Dir.mkdir(backup_dir)

user = flickr.people.getInfo :user_id => user_id
total_photos = user.photos.count
photos_processed = 0
pages_processed = 0

while photos_processed < total_photos
  
  list = flickr.people.getPublicPhotos :user_id => user_id, :per_page => 500, :page => pages_processed
  500.times do |i|
    url = Flickrish.getFileUrl(list[i].id, list[i].secret)
    Flickrish.download(url, backup_dir + '/' + File.basename(url) + '.jpg')
    photos_processed += 1    
  end
  pages_processed += 1
 
end


