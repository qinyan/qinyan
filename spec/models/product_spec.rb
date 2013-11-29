require 'spec_helper'

describe Product do
  it "is valid with name" do
    product = FactoryGirl.build(:product)
    expect(product).to be_valid
  end

  it "is invalid without name" do
    expect(Product.new(name: nil)).to have(1).errors_on(:name)
  end

end
