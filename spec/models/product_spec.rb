require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
      @category = Category.create(name: "a")
    end
    it "should be valid when all fields are filled out" do
      p = @category.products.create(name: "s", price: 3, quantity: 2)
      expect(p).to be_valid
    end
    it "should have a name" do
      p = @category.products.create(name: nil, price: 3, quantity: 2)
      expect(p.errors.full_messages).to include("Name can't be blank")
    end
    it "should have a name" do
      p = @category.products.create(name: "sdfds", price: nil, quantity: 2)
      expect(p.errors.full_messages).to include("Price can't be blank")
    end
    it "should have a name" do
      p = @category.products.create(name: "sdfds", price: 3, quantity: nil)
      expect(p.errors.full_messages).to include("Quantity can't be blank")
    end
    it "should have a name" do
      p = Product.create(name: 'sd', price: 3, quantity: 2)
      expect(p.errors.full_messages).to include("Category can't be blank")
    end
  end
end