require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  let(:product) { create(:product) }

  describe "GET #show" do
    it "正常なレスポンスが返されること" do
      get potepan_product_path(product.id)
      expect(response).to have_http_status(:success)
    end
  end
end
