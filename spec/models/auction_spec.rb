require 'spec_helper'

describe Auction do
  it { should validate_presence_of(:name).with_message('is mandatory') }
end
