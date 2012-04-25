# Flickrish

Flickrish is a small Ruby program that will iterate through all of a user's public photos and attempt to download the original sized photo.

In order to get this working, you have to register an application on http://www.flickr.com/services/apps/create/noncommercial/? 

Then, add the api_key and secret to a file called config.yml. (An example file is provided)

Find the user_id of the Flickr account you're trying to access.  This can be done by going to the user's photostream and right clicking the avatar of the user and looking at the name of the file.  The name is the user_id that you can put into the config.yml file.

Finally, you provide a path to store all photos.

This program requires at least Ruby 1.9 and uses the flickraw gem.

```git clone git@github.com:underwhelmed/Flickrish.git
cd flickrish
gem install bundler
bundle
ruby app.rb```

## NOTE:

*This program is provided as-is. I wrote it quickly to download all my original sized files because my pro account was expiring. If you have any issues with it, please submit a pull request.*