require 'spec_helper'

describe 'Products' do
  
  def login_as(role)
    @administrator = User.new(:email => 'email', :password => 'password', :role => role)
    @administrator.confirm!
    
    click_link 'Sign in'
    fill_in 'Email', :with => 'email'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
  end
  
  before do
    @mouse = Product.create(:name => 'magic mouse')
    @keyboard = Product.create(:name => 'hot keyboard')
    visit products_path
    login_as(:administrator)
  end
  
  describe 'GET index' do
    it 'should list some products' do
      page.should have_content 'magic mouse'
      page.should have_content 'hot keyboard'
    end
    
    it 'should list a specific product' do
      click_link 'magic mouse'
      
      page.should have_content 'Details'
      page.should have_content 'magic mouse'
    end
  end
  
  describe 'POST create' do
    it 'should create a product' do
      click_link 'Create'
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Create Product'
      
      page.should have_content 'Product successfully created.'
      page.should have_content 'trust mouse'
      
      click_link 'List'
      
      page.should have_content 'magic mouse'
      page.should have_content 'hot keyboard'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      click_link 'Create'
      click_button 'Create Product'
      
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'PUT update' do
    it 'should update a product' do
      find("#product_#{@mouse.id}").click_link 'Edit'
      
      find_field('Name').value.should == 'magic mouse'
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Update Product'
      
      page.should have_content 'Product successfully updated.'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      find("#product_#{@keyboard.id}").click_link 'Edit'
      
      find_field('Name').value.should == 'hot keyboard'
      
      fill_in 'Name', :with => ''
      click_button 'Update Product'
      
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'DELETE destroy', :js => true do
    it 'should delete a product' do
      find("#product_#{@keyboard.id}").click_link 'Remove'
      
      page.should have_content 'Confirmation'
      page.should have_content 'Are you sure you want to remove this product?'
      
      find(".ui-dialog-buttonset").click_button 'Yes'
      
      page.should have_content 'Product successfully removed'
      page.should have_content 'magic mouse'
      page.should_not have_content 'hot keyboard'
    end
  end
end
