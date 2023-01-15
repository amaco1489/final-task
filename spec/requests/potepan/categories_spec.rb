require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "商品カテゴリーページ" do
    let(:taxonomy_1) { create(:taxonomy) }
    let(:taxon_1) { create(:taxon, taxonomy: taxonomy_1, products: [product_1]) }
    let(:product_1) { create(:product) }
    let(:image) { create(:image) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end
    let(:taxonomy_2) { create(:taxonomy) }
    let!(:taxon_2) { create(:taxon, taxonomy: taxonomy_2, products: [product_2]) }
    let(:product_2) { create(:product) }

    before do
      product_1.images << image
      get potepan_category_path(taxon_1.id)
    end

    it "レスポンスが200ステータスであること" do
      expect(response).to have_http_status 200
    end

    it "全ての大カテゴリー名が取得できていること" do
      expect(response.body).to include taxonomy_1.name
      expect(response.body).to include taxonomy_2.name
    end

    it "全ての小カテゴリー名が取得できていること" do
      expect(response.body).to include taxon_1.name
      expect(response.body).to include taxon_2.name
    end

    it "カテゴリー毎の商品数が取得できていること" do
      expect(response.body).to include taxon_1.products.count.to_s
      expect(response.body).to include taxon_2.products.count.to_s
    end

    it "選択されたカテゴリーの商品情報が取得できていること" do
      expect(response.body).to include product_1.name
      expect(response.body).to include product_1.display_price.to_s
      expect(response.body).to include product_image_filename
    end

    it "選択されていないカテゴリーの商品情報(名前)が表示されていないこと" do
      expect(response.body).not_to include product_2.name
    end
  end
end
