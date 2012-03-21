require 'spec_helper'

describe User do
  it { should validate_presence_of(:role).with_message('is required') }
  
  it { should validate_presence_of(:display_name).with_message('is required') }
  
  it { should validate_presence_of(:remaining_bids).with_message('is required') }
end
