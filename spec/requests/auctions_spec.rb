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
end
