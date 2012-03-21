require 'spec_helper'

describe 'Auctions' do
  
  def login_as(user)
    click_link 'Sign in'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
  end
  
  before do
    @administrator = User.new(:email => 'user_email', :password => 'user_password', :role => :administrator)
    @administrator.confirm!
    @mouse = Product.create(:name => 'magic mouse')
    @keyboard = Product.create(:name => 'hot keyboard')
    @mouse_auction = Auction.create(:name => 'apple mouse', :product => @mouse)
    @keyboard_auction = Auction.create(:name => 'apple keyboard', :product => @keyboard)
    visit admin_root_path(:locale => :en)
    login_as(@administrator)
    click_link 'List Auctions'
  end
  
  describe 'GET' do
    it 'should list some auctions' do
      page.should have_content 'apple mouse'
      page.should have_content 'apple keyboard'
    end
    
    it 'should show a specific auction' do
      click_link 'apple mouse'
      
      page.should have_content 'Details'
      page.should have_content 'apple mouse'
    end
  end
  
  describe 'POST' do
    it 'should create an auction' do
      click_link 'Create'
      fill_in 'Name', :with => 'new wireless keyboard'
      select('hot keyboard', :from => 'Product')
      click_button 'Create Auction'
      
      page.should have_content 'Auction successfully created.'
      page.should have_content 'new wireless keyboard'
      
      click_link 'List'
      
      page.should have_content 'apple mouse'
      page.should have_content 'apple keyboard'
      page.should have_content 'new wireless keyboard'
    end
    
    it 'should display error messages when validation errors exist' do
      click_link 'Create'
      click_button 'Create Auction'
      
      page.should have_content 'Name is required'
      page.should have_content 'Product is required'
    end
  end
  
  describe 'PUT' do
    it 'should update an auction' do
      find("#auction_#{@mouse_auction.id}").click_link 'Edit'
      
      find_field('Name').value.should == 'apple mouse'
      
      fill_in 'Name', :with => 'new wireless keyboard'
      select('hot keyboard', :from => 'Product')
      click_button 'Update Auction'
      
      page.should have_content 'Auction successfully updated.'
      page.should have_content 'new wireless keyboard'
    end
    
    it 'should display error messages when validation errors exist' do
      find("#auction_#{@keyboard_auction.id}").click_link 'Edit'
      
      find_field('Name').value.should == 'apple keyboard'
      
      fill_in 'Name', :with => ''
      click_button 'Update Auction'
      
      page.should have_content 'Name is required'
    end
  end
  
  describe 'DELETE', :js => true do
    it 'should delete an auction' do
      find("#auction_#{@keyboard_auction.id}").click_link 'Remove'
      
      page.should have_content 'Confirmation'
      page.should have_content 'Are you sure you want to remove this auction?'
      
      find(".ui-dialog-buttonset").click_button 'Yes'
      
      page.should have_content 'Auction successfully removed'
      page.should have_content 'apple mouse'
      page.should_not have_content 'apple keyboard'
    end
  end
end
