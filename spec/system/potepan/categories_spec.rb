require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "GET #show" do
    let(:taxonomy_1) { create(:taxonomy, name: "Ruby") }
    let(:taxonomy_2) { create(:taxonomy, name: "Rails") }
    let(:taxon_1) { create(:taxon, name: "ruby", taxonomy: taxonomy_1, products: [product_1]) }
    let!(:taxon_2) { create(:taxon, name: "rails", taxonomy: taxonomy_2, products: [product_2]) }
    let(:product_1) { create(:product) }
    let(:product_2) { create(:product) }
    let(:image) { create(:image) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let!(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end

    before do
      product_1.images << image
      visit potepan_category_path(taxon_1.id)
    end

    it "タイトルにカテゴリー名とストア名が表示されていること" do
      expect(title).to eq "#{taxon_1.name} - BIGBAG Store"
    end
  end
end
