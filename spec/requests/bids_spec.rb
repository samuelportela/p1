require 'spec_helper'

describe 'Bids' do
  
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
    @mouse_auction = Auction.create(:name => 'apple mouse', :product => @mouse)
    @keyboard_auction = Auction.create(:name => 'apple keyboard', :product => @keyboard)
    visit bids_path
    login_as(:administrator)
  end
  
  describe 'GET index' do
    it 'should list some bids' do
      page.should have_content 'apple mouse'
      page.should have_content 'apple keyboard'
    end
    
    it 'should list a specific bid' do
      click_link 'apple mouse'
      
      page.should have_content 'Details'
      page.should have_content 'apple mouse'
      page.should have_content 'magic mouse'
    end
  end
  
  describe 'POST create' do
    it 'should create an bid' do
      click_link 'Create'
      fill_in 'Name', :with => 'new wireless keyboard'
      select('hot keyboard', :from => 'Product')
      click_button 'Create Bid'
      
      page.should have_content 'Bid successfully created.'
      page.should have_content 'new wireless keyboard'
      page.should have_content 'hot keyboard'
      
      click_link 'List'
      
      page.should have_content 'apple mouse'
      page.should have_content 'apple keyboard'
      page.should have_content 'new wireless keyboard'
    end
    
    it 'should display error messages when validation errors exist' do
      click_link 'Create'
      click_button 'Create Bid'
      
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'PUT update' do
    it 'should update an bid' do
      find("#bid_#{@mouse_bid.id}").click_link 'Edit'
      
      find_field('Name').value.should == 'apple mouse'
      
      fill_in 'Name', :with => 'new wireless keyboard'
      select('hot keyboard', :from => 'Product')
      click_button 'Update Bid'
      
      page.should have_content 'Bid successfully updated.'
      page.should have_content 'new wireless keyboard'
      page.should have_content 'hot keyboard'
    end
    
    it 'should display error messages when validation errors exist' do
      find("#bid_#{@keyboard_bid.id}").click_link 'Edit'
      
      find_field('Name').value.should == 'apple keyboard'
      
      fill_in 'Name', :with => ''
      click_button 'Update Bid'
      
      page.should have_content 'Name is mandatory'
    end
  end
  
  describe 'DELETE destroy', :js => true do
    it 'should delete an bid' do
      find("#bid_#{@keyboard_bid.id}").click_link 'Remove'
      
      page.should have_content 'Confirmation'
      page.should have_content 'Are you sure you want to remove this bid?'
      
      find(".ui-dialog-buttonset").click_button 'Yes'
      
      page.should have_content 'Bid successfully removed'
      page.should have_content 'apple mouse'
      page.should_not have_content 'apple keyboard'
    end
  end
end
