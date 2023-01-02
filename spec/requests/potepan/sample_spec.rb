require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "Potepan::Sample", type: :request do
  let!(:product) { create(:product) }

  describe "GET #index" do
    it "returns http success" do
      get potepan_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
