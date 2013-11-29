# encoding: utf-8

class UserLogoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include Piet::CarrierWaveExtension

  process :optimize

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/a/#{model.gender}_00.png"
  end

  version :originals do
  end

  version :normal do
    process :manualcrop
    process resize_to_fill: [200, 300] 
  end

  version :medium do
    process :manualcrop
    process resize_to_fill: [90, 100]
  end

  version :feed do
    process :manualcrop
    process :resize_to_fill => [45, 50]
  end

  def manualcrop
    return unless model.cropping?
    manipulate! do |img|
      x = model.crop_x.to_i
      y = model.crop_y.to_i
      w = model.crop_w.to_i
      h = model.crop_h.to_i
      img.crop("#{w}x#{h}+#{x}+#{y}")
      img
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def filename
    @name ||= "#{md5}.#{file.extension}" if original_filename.present?
  end

  protected

  def md5
    var = :"@#{mounted_as}_md5"
    model.instance_variable_get(var) or model.instance_variable_set(var, ::Digest::MD5.file(current_path).hexdigest)
  end

end
