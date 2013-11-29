require 'spec_helper'

describe Blog do
  # context "when first created" do
  #   subject do
  #     blog = Blog.new
  #     blog.name = "blog_name"
  #     blog
  #   end
  #   its(:name) { should eq('blog_name') }
  # end
  before{ @current_user = FactoryGirl.create(:user)}

  it "is valid" do
    expect(FactoryGirl.build(:blog, user_id: @current_user.id)).to be_valid
  end

  it '#add_intro' do
    blog = FactoryGirl.create(:blog, user_id: @current_user.id)
    expect(blog.intro).to eq('n'*207 + '...')
  end
end