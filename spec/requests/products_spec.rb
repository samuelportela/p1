require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "should display some products" do
      visit products_path
    end
  end
end
