require 'spec_helper'

describe AlbumsController do


  context 'set current_user, session and ' do
    before do 
      @current_user = FactoryGirl.create(:user)
      session[:uid] = @current_user.id
    end

    context 'build album before' do
      let(:album){FactoryGirl.build(:album, user_id: @current_user.id)}
      describe 'Get new' do
        it 'assigns new' do
          get :new
          expect(album).to be_new_record
          expect(album).to be_instance_of(Album)
        end
      end
    end

    describe 'Post create' do
      it 'assigns album' do
        expect{post :create, album: FactoryGirl.attributes_for(:album, user_id: @current_user.id)}.to change{Album.count}.by(1)
      end
    end

    describe 'Get index' do
      it "doesn't matter" do
        album1 = FactoryGirl.create(:album)
        album2 = FactoryGirl.create(:album)
        get :index
        expect(assigns[:albums]).to match_array([album1,album2])
      end
    end
  
    %w(show edit).each do |type|
      describe "Get #{type}" do
        it 'assigns album' do
          album = FactoryGirl.create(:album, user_id: @current_user.id)
          get type.to_sym, id: album.id
          expect(assigns[:album]).to eq(album)
        end
      end
    end


    describe 'Put update' do
      context "dosen't update a record" do
        it 'when album has no name' do
          @album = FactoryGirl.create(:album, user_id: @current_user.id)
          put :update, id: @album.id, album: FactoryGirl.attributes_for(:album, user_id: @current_user.id, name: '')
          expect(Album.find(@album.id).name).to_not eq('')
        end
        it 'when album has to long name' do
          @album = FactoryGirl.create(:album, user_id: @current_user.id)
          put :update, id: @album.id, album: FactoryGirl.attributes_for(:album, user_id: @current_user.id, name: 'a'*21)
          expect(Album.find(@album.id).name).to_not eq('a'*21)
        end
      end
      context 'update a record' do
        it 'when album has recept name' do
          @album = FactoryGirl.create(:album, user_id: @current_user.id)
          put :update, id: @album.id, album: FactoryGirl.attributes_for(:album, user_id: @current_user.id, name: 'a'*20)
          expect(Album.find(@album.id).name).to eq('a'*20)
        end
      end  
    end
    
    describe 'Delete destroy' do
      it 'destroy a assign' do
        @album = FactoryGirl.create(:album, user_id: @current_user.id)
        expect{delete :destroy, id: @album.id}.to change{Album.count}.by(-1)
      end
    end
  end
end
