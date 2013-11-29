require 'spec_helper'

describe ProductsController do

  describe "Get new" do
    before do
      product = FactoryGirl.build(:product)
      get :new
    end
    it "assigns @product" do
      expect(assigns[:product]).to be_new_record
      expect(assigns[:product]).to be_instance_of(Product)
    end
    it "render template" do
      response.should render_template :new
    end
  end

  describe "Post create" do
    context "when product doesn't have name" do
      it "doesn't create a record" do
        expect{post :create, product: FactoryGirl.attributes_for(:product, name: '')}.to change{Product.count}.by(0)
      end
      it "render template new" do
        post :create, product: FactoryGirl.attributes_for(:product, name: '')
        expect(response).to render_template(:new)
      end
    end
    context "when product have name" do
      it "create new product record " do
        expect{ post :create, product: FactoryGirl.attributes_for(:product)}.to change{Product.count}.by(1)
      end
      it "redirect_to prodcuts_path" do
        post :create, product:  FactoryGirl.attributes_for(:product)
        expect(response).to redirect_to(products_path)
      end
    end
  end

  context 'create product before' do

    before {@product = FactoryGirl.create(:product)}

    describe "Get index" do
      before do
        @product2 = FactoryGirl.create(:product)
        get :index
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "doesn't matter" do   
        expect(assigns[:products]).to match_array([@product,@product2])
      end
      it "render template index" do
        expect(response).to render_template(:index)
      end
    end

    %w(show edit).each do |type|
      describe "Get #{type}" do
        before {get type.to_sym, id: @product.id}
        it "assigns @product" do
          expect(assigns[:product]).to eq(@product)
        end
        it "render template" do
          expect(response).to render_template(type.to_sym)
        end
      end
    end

    describe "Put update" do
      context "when product params doesn't have name" do
        before {put :update , id: @product.id , product: FactoryGirl.attributes_for(:product, name: '', description: 'sometext')}
        it "doesn't update a record" do
          expect(Product.find(@product.id).description).to_not eq('sometext')   
        end
        it "render edit template" do
          expect{response}.to render_template(:edit)
        end
      end
      context "when product params have name" do
        before {put :update , id: @product.id , product: FactoryGirl.attributes_for(:product, description: 'sometext')}
        it "update a record" do
          expect(Product.find(@product.id).description).to eq('sometext') 
        end
        it "redirect_to products_path" do
          expect{response}.to redirect_to(products_path)
        end
      end
    end

    describe "Delete destroy" do
      it "assigns @product" do
        delete :destroy, id: @product.id
        expect(assigns[:product]).to eq(@product)
      end
      it "delete a record" do
        expect{delete :destroy, id: @product.id}.to change{ Product.count}.by(-1)
      end
      it "redirect_to products_path" do
        delete :destroy, id: @product.id
        expect{response}.to redirect_to(products_path)
      end
    end

  end

end
