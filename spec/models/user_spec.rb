require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
    end
    it "should be valid when all fields are filled out correctly" do
      u = User.create(first_name: "s", last_name: "s", email: "abc@example.com", password: 'abc', password_confirmation: 'abc')
      expect(u).to be_valid
    end
    it "should be invalid when password is not filled out" do
      u = User.create(first_name: "s", last_name: "s", email: "abc@example.com", password: nil, password_confirmation: 'abc')
      expect(u.errors.full_messages).to include("Password can't be blank")
    end
    it "should be invalid when password confirmation is not filled out" do
      u = User.create(first_name: "s", last_name: "s", email: "abc@example.com", password: 'abc', password_confirmation: nil)
      expect(u.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it "should be invalid when password and confirmation differ" do
      u = User.create(first_name: "s", last_name: "s", email: "abc@example.com", password: 'abc', password_confirmation: 'acc')
      expect(u.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should be invalid when password is shorter than 3 characters" do
      u = User.create(first_name: "s", last_name: "s", email: "abc@example.com", password: 'ab', password_confirmation: 'ab')
      expect(u.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
    it "should be invalid when first name is not filled out" do
      u = User.create(first_name: nil, last_name: "s", email: "abc@example.com", password: 'abc', password_confirmation: 'abc')
      expect(u.errors.full_messages).to include("First name can't be blank")
    end
    it "should be invalid when last name is not filled out" do
      u = User.create(first_name: "a", last_name: nil, email: "abc@example.com", password: 'abc', password_confirmation: 'abc')
      expect(u.errors.full_messages).to include("Last name can't be blank")
    end
    it "should be invalid when email is not filled out" do
      u = User.create(first_name: "a", last_name: "s", email: nil, password: 'abc', password_confirmation: 'abc')
      expect(u.errors.full_messages).to include("Email can't be blank")
    end
    it "should be invalid when email is not unique" do
      u = User.create(first_name: "a", last_name: "s", email: "abc@example.com", password: 'abc', password_confirmation: 'abc')
      u1 = User.create(first_name: "a", last_name: "s", email: "Abc@example.com", password: 'abc', password_confirmation: 'abc')
      expect(u1.errors.full_messages).to include("Email has already been taken")
    end
  end
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(first_name: "s", last_name: "s", email: "abc@example.com", password: 'abc', password_confirmation: 'abc')
    end
    it "should be nil when you don't have a correct login credentials" do
      a = User.authenticate_with_credentials("abc@example.com", "sdffs")
      expect(a).to be_nil
    end
    it "should be nil when you don't have a correct login credentials" do
      a = User.authenticate_with_credentials("ac@example.com", "sdffs")
      expect(a).to be_nil
    end
    it "should return the user when you have correct login credentials" do
      a = User.authenticate_with_credentials("abc@example.com", "abc")
      expect(a).to eq(@user)
    end
    it "should return the user when you have correct login credentials, but extra spaces" do
      a = User.authenticate_with_credentials(" abc@example.com", "abc")
      expect(a).to eq(@user)
    end
    it "should return the user when you have correct login credentials, but incorrect cases" do
      u = User.create(first_name: "s", last_name: "s", email: "abCd@example.com", password: 'abc', password_confirmation: 'abc')
      a = User.authenticate_with_credentials("ABCd@example.com", "abc")
      expect(a).to eq(u)
    end
  end
end

