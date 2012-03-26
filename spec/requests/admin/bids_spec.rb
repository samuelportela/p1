require 'spec_helper'

describe 'Bids' do
  
  def login_as(user)
    click_link 'Sign in'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Sign in'
  end
  
  before do
    @administrator = User.new(:email => 'user_email', :password => 'user_password', :role => :administrator, :remaining_bids => 5)
    @administrator.confirm!
    @mouse = Product.create(:name => 'magic mouse')
    @keyboard = Product.create(:name => 'hot keyboard')
    @mouse_auction = Auction.create(:name => 'apple mouse', :product => @mouse)
    @keyboard_auction = Auction.create(:name => 'apple keyboard', :product => @keyboard)
    @mouse_bid = Bid.create(:auction => @mouse_auction, :user => @administrator)
    @keyboard_bid = Bid.create(:auction => @keyboard_auction, :user => @administrator)
    visit admin_root_path(:locale => :en)
    login_as(@administrator)
    click_link 'List Bids'
  end
  
  describe 'GET' do
    it 'should list some bids' do
      page.should have_content 'Bid: 1 | Auction: apple mouse | User: user_email'
      page.should have_content 'Bid: 2 | Auction: apple keyboard | User: user_email'
    end
    
    it 'should show a specific bid' do
      click_link 'apple mouse'
      
      page.should have_content 'Details'
      page.should have_content 'apple mouse'
      page.should have_content 'user_email'
    end
  end
  
  describe 'POST' do
    it 'should create a bid' do
      page.should have_content 'Bid: 1 | Auction: apple mouse | User: user_email'
      page.should have_content 'Bid: 2 | Auction: apple keyboard | User: user_email'
      page.should_not have_content 'Bid: 3 | Auction: apple keyboard | User: user_email'
      
      click_link 'Create'
      select('apple keyboard', :from => 'Auction')
      select('user_email', :from => 'User')
      click_button 'Create Bid'
      
      page.should have_content 'Bid successfully created.'
      page.should have_content 'Auction: apple keyboard'
      page.should have_content 'User: user_email'
      
      click_link 'List'
      
      page.should have_content 'Bid: 1 | Auction: apple mouse | User: user_email'
      page.should have_content 'Bid: 2 | Auction: apple keyboard | User: user_email'
      page.should have_content 'Bid: 3 | Auction: apple keyboard | User: user_email'
    end
    
    it 'should display error messages when validation errors exist' do
      click_link 'Create'
      click_button 'Create Bid'
      
      page.should have_content 'Auction is required'
      page.should have_content 'User is required'
    end
  end
  
  describe 'PUT' do
    it 'should update a bid' do
      find("#bid_#{@mouse_bid.id}").click_link 'Edit'
      
      find_field('Auction').value.should == "#{@mouse_auction.id}"
      find_field('User').value.should == "#{@administrator.id}"
      
      select('apple keyboard', :from => 'Auction')
      select('user_email', :from => 'User')
      click_button 'Update Bid'
      
      page.should have_content 'Bid successfully updated.'
      page.should have_content 'Auction: apple keyboard'
      page.should have_content 'User: user_email'
    end
  end
  
  describe 'DELETE', :js => true do
    it 'should delete a bid' do
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
