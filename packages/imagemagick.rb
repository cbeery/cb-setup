package :imagemagick do
  description 'ImageMagick image conversion library'
  apt 'libmagick++-dev imagemagick' 

  # apt 'imagemagick' 
  # apt 'graphicsmagick-libmagick-dev-compat imagemagick' # maybe need libmagickwand-dev
  # apt 'libxml2-dev libmagick9-dev imagemagick'

  verify do
    has_file '/usr/bin/convert'
  end
end