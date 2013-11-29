class Blog < ActiveRecord::Base
  belongs_to :user
  before_save :add_intro
  delegate :email, :to => :user

  def add_intro
    self.intro = self.content.gsub(/&nbsp;/, '').gsub(/<.*?>/, '').truncate(210, :omission=>'...') if self.content.present?
  end

end