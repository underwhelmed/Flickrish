require 'flickraw'
require 'open-uri'
require 'FileUtils'
require 'yaml'
require_relative 'flickrish'

keys = YAML.load_file('config.yml')
FlickRaw.api_key = keys['api_key']
FlickRaw.shared_secret = keys['secret']

user_id = keys['user_id']
backup_dir = keys['directory']

MAX_ATTEMPTS = 5

if Dir.exists?(backup_dir)
  FileUtils.rm_rf(backup_dir)
end
Dir.mkdir(backup_dir)

user = flickr.people.getInfo :user_id => user_id
total_photos = user.photos.count
photos_processed = 0
pages_processed = 1

while photos_processed < total_photos  
  list = flickr.people.getPublicPhotos :user_id => user_id, :per_page => 500, :page => pages_processed
  500.times do |i|
    if list != nil
      url = Flickrish.getFileUrl(list[i].id, list[i].secret)
      attempts = 0
      begin
        Flickrish.download(url, backup_dir + '/' + File.basename(url))      
      rescue Exception => ex
        log.error "Error: #{ex}, cannot download #{url}"
        attempts = attempts + 1
        sleep(5) # wait 5 seconds before trying again
        retry if(attempts < MAX_ATTEMPTS)
      end      
      photos_processed += 1
    else
      break
    end
  end
  pages_processed += 1 
end


