require 'spec_helper'

describe User do

  describe "validations name" do
    
    context "name reject nil" do 
      it { should_not accept_values_for(:name, nil)}
    end

    context "reject same name" do
      it "should reject duplicate name" do
        User.create!(name: "test name", email: "tak.email@163.com", password:"123456")
        user_with_same_name = User.new(name: "test name", email: "email@163.com", password:"123456")
        user_with_same_name.should_not be_valid
      end
    end
  end

  describe "validations email" do

    context "email accept john@example.com" do
      it { should accept_values_for(:email, "john@example.com", "lambda@gusiev.com") }
    end

    context "email reject invalid nil a@b john@.com" do
      it { should_not accept_values_for(:email, "invalid", nil, "a@b", "john@.com") }
    end

    context "reject same email" do
      it "should reject duplicate email" do
        User.create!(name: "test email", email: "email@163.com", password:"123456")
        user_with_same_name = User.new(name: "test email", email: "email@163.com", password:"123456")
        user_with_same_name.should_not be_valid
      end
    end
  end

  describe "validations password" do
    context "password reject nil, password size between 2..10" do
      it { should_not accept_values_for(:password, nil, "a", "a" * 17) }
    end
  end

  describe 'user could' do
    it 'new album' do
      user = FactoryGirl.create(:user)
      album = user.albums.build
      expect(album.user_id).to eq(user.id)
    end
  end

end
