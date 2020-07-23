require 'rails_helper'

RSpec.describe "Homes", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response.body).to include("The message is 1")
    end
  end

end
