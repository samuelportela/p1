require 'spec_helper'

describe 'Products' do
  before do
    @mouse = Product.create(:name => 'magic mouse')
    @keyboard = Product.create(:name => 'hot keyboard')
  end
  
  describe 'GET index' do
    it 'should list some products' do
      visit products_path
      
      page.should have_content 'magic mouse'
      page.should have_content 'hot keyboard'
    end
  end
  
  describe 'POST create' do
    it 'should create a product' do
      visit products_path
      click_link 'Create'
      
      current_path.should == new_product_path(:locale => 'en')
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Create Product'
      
      page.should have_content 'Product successfully created.'
      page.should have_content 'trust mouse'
      
      click_link 'List'
      
      current_path.should == products_path(:locale => 'en')
      page.should have_content 'magic mouse'
      page.should have_content 'hot keyboard'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      visit products_path
      click_link 'Create'
      
      current_path.should == new_product_path(:locale => 'en')
      
      click_button 'Create Product'
      
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'PUT update' do
    it 'should update a product' do
      visit products_path
      find("#product_#{@mouse.id}").click_link 'Edit'
      
      current_path.should == edit_product_path(@mouse, :locale => 'en')
      find_field('Name').value.should == 'magic mouse'
      
      fill_in 'Name', :with => 'trust mouse'
      click_button 'Update Product'
      
      current_path.should == product_path(@mouse, :locale => 'en')
      page.should have_content 'Product successfully updated.'
      page.should have_content 'trust mouse'
    end
    
    it 'should display error messages when validation errors exist' do
      visit products_path
      find("#product_#{@keyboard.id}").click_link 'Edit'
      
      current_path.should == edit_product_path(@keyboard, :locale => 'en')
      find_field('Name').value.should == 'hot keyboard'
      
      fill_in 'Name', :with => ''
      click_button 'Update Product'
      
      current_path.should == product_path(@keyboard, :locale => 'en')
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'DELETE destroy', :js => true do
    it 'should delete a product' do
      visit products_path
      find("#product_#{@keyboard.id}").click_link 'Remove'
      
      page.should have_content 'Confirmation'
      page.should have_content 'Are you sure you want to remove this product?'
      
      page.execute_script "$('.ui-dialog button:contains(\"Yes\")').click()"
      
      current_path.should == products_path(:locale => 'en')
      page.should have_content 'Product successfully removed'
      page.should have_content 'magic mouse'
      page.should_not have_content 'hot keyboard'
    end
  end
end
