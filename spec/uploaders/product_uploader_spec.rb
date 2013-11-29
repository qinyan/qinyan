require 'spec_helper'
# require 'support/fog_helper'
require 'carrierwave/test/matchers'

describe ProductUploader do
  include CarrierWave::Test::Matchers

  before do
    ProductUploader.enable_processing = true
    @product = FactoryGirl.build(:product)
    @uploader = ProductUploader.new(@product)
    # @uploader.store!(File.open(path_to_file))
    @uploader.store!(File.open("#{Rails.root}/spec/support/test_images/3lian_com_005.jpg"))
  end

  after do
    @uploader.remove!
    ProductUploader.enable_processing = false
  end

  context 'the small version' do
    it "should scale down a landscape image to be exactly 200 by 200 pixels" do
      @uploader.small.should have_dimensions(200, 200)
    end
  end

  context 'the lager version' do
    it "should scale down a landscape image to fit within 200 by 200 pixels" do
      @uploader.lager.should be_no_larger_than(230, 160)
    end
  end

  it "should make the image readable only to the owner and not executable" do
    @uploader.should have_permissions(0644)
  end
end