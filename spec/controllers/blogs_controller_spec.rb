require 'spec_helper.rb'

describe BlogsController do

  context 'set current_user, session and ' do
    before do 
      @current_user = FactoryGirl.create(:user)
      session[:uid] = @current_user.id
    end

    context 'build blog before' do
      let(:blog) {FactoryGirl.build(:blog, user_id: @current_user.id)}
      describe 'Get new' do
        it 'assigns blog' do
          get :new
          expect(blog).to be_new_record
          expect(blog).to be_instance_of(Blog)
        end
        it 'render template' do
          get :new
          expect(response).to render_template(:new)
        end
      end
      
      describe 'Post create' do
        it 'assigns blog' do
          expect{post :create, blog: blog.attributes}.to change{Blog.count}.by(1)
        end
        it 'redirect_to blogs_path' do
          post :create, blog: blog.attributes
          expect(response).to redirect_to(blogs_path)
        end

      end
    end

    context 'create blog before' do
      before { @blog = FactoryGirl.create(:blog, user_id: @current_user.id)}

      describe 'Get edit' do
        it 'assigns blog' do
          get :edit, id: @blog.id
          expect(assigns[:blog]).to eq(@blog)
        end
        it 'render template new' do
          get :edit, id: @blog.id
          expect(response).to render_template(:edit)
        end
      end

      describe 'Put update' do
        it 'assigns blog' do
          put :update, id: @blog.id, blog: FactoryGirl.attributes_for(:blog, user_id: @current_user.id, content: 'sometext')
          expect(Blog.find(@blog.id).content).to eq('sometext')
        end
        it 'redirect_to blogs_path' do
          put :update, id: @blog.id, blog: FactoryGirl.attributes_for(:blog, user_id: @current_user.id, content: 'sometext')
          expect(response).to redirect_to(blogs_path)
        end
      end

      describe 'Delete destroy' do
        it 'assigns blog' do
          delete :destroy, id: @blog.id
          expect(assigns[:blog]).to eq(@blog)
        end
        it 'delete a record' do
          expect{delete :destroy, id: @blog.id}.to change{ Blog.count}.by(-1)
        end
        it 'redirect_to blogs_path' do
          delete :destroy, id: @blog.id
          expect(response).to redirect_to(blogs_path)
        end
      end
    end   
  end
  
  describe 'Get index' do
    it "doesn't matter" do
      blog1 = FactoryGirl.create(:blog)
      blog2 = FactoryGirl.create(:blog)
      get :index
      expect(assigns[:blogs]).to match_array([blog1,blog2])
    end
    it 'render template index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'Get show' do
    it "assigns blog" do
      @blog = FactoryGirl.create(:blog)
      get :show, id: @blog.id
      expect(assigns[:blog]).to eq(@blog)
    end
    it 'render template index' do
      @blog = FactoryGirl.create(:blog)
      get :show, id: @blog.id
      expect(response).to render_template(:show)
    end
  end

end