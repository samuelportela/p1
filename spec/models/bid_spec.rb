require 'spec_helper'

describe Bid do
  it { should validate_presence_of(:auction) }
  
  it { should validate_presence_of(:user) }
end
