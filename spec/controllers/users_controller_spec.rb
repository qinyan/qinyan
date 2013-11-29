require 'spec_helper'

describe UsersController do


  describe 'Get new' do
    before do
      @user = FactoryGirl.build(:user)
      get :new
    end
    it 'assigns @user' do  
      expect(assigns[:user]).to be_new_record
      expect(assigns[:user]).to be_instance_of(User)
    end
    it 'render template' do
      expect(response).to render_template :new
    end
  end

  describe 'Post create' do
    context "when user doesn't have" do
      %w(name email password).each do |type|
        context "#{type}" do
          it 'assigns @user' do
            expect{post :create, user: FactoryGirl.attributes_for(:user, type.to_sym => '')}.to change{User.count}.by(0)
          end
          it 'render template new' do
            post :create, user: FactoryGirl.attributes_for(:user, type.to_sym => '')
            expect(response).to render_template :new
          end
        end
      end
    end
    context "when user have name email password" do
      it 'assigns @user' do
        expect{ post :create, user: FactoryGirl.attributes_for(:user)}.to change{User.count}.by(1)
      end
      it 'redirect_to root_path' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to(root_path)
      end
      it 'get session[:uid]' do
        session[:uid] = nil
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(session[:uid]).to_not eql(nil)
      end
    end
  end

  context 'create user before' do

    before{ @user = FactoryGirl.create(:user)}

    describe 'Get index' do      
      before do
        @user2 = FactoryGirl.create(:user)
        get :index
      end
      it 'assign @users and render template' do
        expect(assigns(:users)).to match_array([@user, @user2])
      end
      it 'render template index' do
        expect(response).to render_template(:index)
      end
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end
    end

    %w(show edit).each do |type|
      describe "Get #{type}" do
        before {get type.to_sym, id: @user.id}
        it 'assigns @user' do
          expect(assigns[:user]).to eq(@user)
        end
        it 'render template show' do
          expect(response).to render_template(type.to_sym)
        end
      end
    end

    describe 'Put update' do
      context "when user doesn't have" do
        %w(name email password).each do |type|
          context "#{type}" do
            before {put :update , id: @user.id, user: FactoryGirl.attributes_for(:user, gender: 'M', type.to_sym => '')}
            it 'assigns @user' do
              expect(User.find(@user.id).gender).to_not eq('M')
            end
            it 'render template edit' do
              expect(response).to render_template(:edit)
            end
          end
        end
      end
      context "when user have name email and password" do
        before{put :update , id: @user.id, user: FactoryGirl.attributes_for(:user, gender: 'M')}
        it 'assigns @user' do
          expect(User.find(@user.id).gender).to eq('M')
        end
        it 'redirect_to users_path' do
          expect(response).to (redirect_to users_path)
        end
      end
    end

    describe 'Delete destroy' do
      it 'assigns @user' do
        delete :destroy, id: @user.id
        expect(assigns[:user]).to eq(@user)
      end
      it 'delele a record' do
        expect{delete :destroy, id: @user.id}.to change{User.count}.by(-1)
      end
      it 'redirect_to users_path' do
        delete :destroy, id: @user.id
        expect(response).to (redirect_to users_path)
      end
    end

  end
  
end
