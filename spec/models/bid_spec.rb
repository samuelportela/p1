require 'spec_helper'

describe Bid do
  it { should validate_presence_of(:auction).with_message('is mandatory') }
  it { should validate_presence_of(:user).with_message('is mandatory') }
end
