class User < ActiveRecord::Base
  #default_scope  where(name: 'qinyan')
  # attr_accessible :name, :email, :password, :password_confirmation
  # acts_as_global_primary_key
 # validates :name, :presence => { :message => '请输入中文姓名'}
 # validates :email, :presence => { :message => "请填写联系邮箱" }
 # validates :password, :confirmation => true, :presence => { :message => '请填写密码'}
  # validates :name, presence: {message: '输入不能为空'}, uniqueness: {message: '名字已被占用'} 
  # validates :email, presence: {message: '输入不能为空'}, uniqueness: {message: '邮箱已被占用'}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: '邮箱格式不正确' }
  # validates :password, presence: {message: '输入不能为空'}, length: { minimum: 2, maximum: 16, message: '请设置2-16位英文字母、数字、符号密码' }, confirmation: {message: '密码输入不一致'} 
  
  # validates_presence_of :name, :email
  # validates_presence_of :password, :on => :create
  # validates_format_of :name, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  # validates_length_of :password, :minimum => 4, :allow_blank => true
  # validates_confirmation_of :password
  # validates_uniqueness_of :name, :email, :on => :create, :message => 'must be unique'
  # validates :email, :email_format => true
  # validates_email :email  :user_info
  has_many :blogs
  has_many :albums
  has_many :groups, -> { where accept: true }, class_name: 'Group',  foreign_key:  :from_id
  has_many :group_users, through: :groups, source: :follow_user 
  has_paper_trail
  mount_uploader :logo, UserLogoUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
end
