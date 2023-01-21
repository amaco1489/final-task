require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "商品詳細ページ" do
    let(:product) { create(:product, taxons: [taxon]) }
    let(:image) { create(:image) }
    let(:taxon) { create(:taxon) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end
    let(:related_products) do
      [15, 16, 17, 18, 19].map do |price|
        create(:product, taxons: [taxon], price: price)
      end
    end

    before do
      product.images << image
      related_products.each do |related_product|
        related_product.images << create(:image)
      end
      get potepan_product_path(product.id)
    end

    it "HTTPのステータスコードが200であること" do
      expect(response).to have_http_status 200
    end

    it "商品情報が取得できていること" do
      expect(response.body).to include product.name
      expect(response.body).to include product.display_price.to_s
      expect(response.body).to include product.description
      expect(response.body).to include product_image_filename
    end

    it "4個の関連商品情報が取得できていること" do
      related_products[0..3].all? do |related_product|
        expect(response.body).to include related_product.name
        expect(response.body).to include related_product.display_price.to_s
      end
    end

    it "5個目の関連商品情報が含まれていないこと" do
      expect(response.body).not_to include related_products[4].name
      expect(response.body).not_to include related_products[4].display_price.to_s
    end
  end
end
