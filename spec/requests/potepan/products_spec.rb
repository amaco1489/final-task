require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET #show" do
    let(:product) { create(:product, taxon_ids: taxon.id) }
    let(:image) { create(:image) }
    let(:taxon) { create(:taxon) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end

    before do
      product.images << image
      get potepan_product_path(product.id)
    end

    it "レスポンスとして200ステータスが返されること" do
      expect(response).to have_http_status 200
    end

    it "商品情報が含まれること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
      expect(response.body).to include product_image_filename
    end
  end
end
