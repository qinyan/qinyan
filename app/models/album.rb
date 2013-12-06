class Album < ActiveRecord::Base
  
  validates :name, presence: {message: '输入不能为空'}, length: {maximum: 20, message: '请设置1-20位英文字母'}
  validates :user_id, presence: {message: '输入不能为空'}
  belongs_to :user
  
end
