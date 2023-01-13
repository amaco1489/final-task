require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let(:taxon) { create(:taxon) }

    it "レスポンスとして200ステータスが返されること" do
      get potepan_category_path(taxon.id)
      expect(response).to have_http_status 200
    end
  end
end
