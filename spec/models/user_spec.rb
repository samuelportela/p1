require 'spec_helper'

describe User do
  it { should validate_presence_of(:role) }
  
  it { should validate_presence_of(:display_name) }
  
  it { should validate_presence_of(:remaining_bids) }
  
  it 'should be valid' do
    user = User.new(:email => 'valid@email.com',
      :password => 'user_password',
      :role => :administrator,
      :display_name => 'user_display_name',
      :remaining_bids => 'user_remaining_bids')
    user.should be_valid
  end
end
