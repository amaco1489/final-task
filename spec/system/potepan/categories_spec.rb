require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  describe "商品カテゴリーページ" do
    let(:taxonomy_1) { create(:taxonomy, name: "Categories", root: taxon_0) }
    let(:taxon_0) { create(:taxon, name: "Categories", products: [product_1]) }
    let(:taxon_1) do
      create(:taxon, name: "Shirts", taxonomy: taxonomy_1, parent: taxon_0, products: [product_1])
    end
    let(:product_1) { create(:product) }
    let(:image) { create(:image) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end
    let(:taxonomy_2) { create(:taxonomy, name: "Brand") }
    let!(:taxon_2) { create(:taxon, name: "Solidus", taxonomy: taxonomy_2, products: [product_2]) }
    let(:product_2) { create(:product) }

    before do
      product_1.images << image
      visit potepan_category_path(taxon_1.id)
    end

    it "タイトルにカテゴリー名とストア名が表示されていること" do
      expect(title).to eq "#{taxon_1.name} - BIGBAG Store"
    end

    it "ページヘッダーにカテゴリー名とShopが表示されていること" do
      within ".pageHeader"
      expect(page).to have_content taxon_1.name
      expect(page).to have_content "Shop"
    end

    it "サイドバーに全ての大カテゴリー名が表示されていること" do
      within ".side-nav" do
        expect(page).to have_content taxonomy_1.name
        expect(page).to have_content taxonomy_2.name
      end
    end

    it "サイドバーに小カテゴリー名及び商品数（末端のみ）が表示されていること" do
      within ".side-nav" do
        expect(page).to have_content "#{taxon_1.name}(#{taxon_1.products.count})"
        expect(page).not_to have_content "#{taxon_0.name}(#{taxon_0.products.count})"
        expect(page).to have_content "#{taxon_2.name}(#{taxon_2.products.count})"
      end
    end

    it "選択されたカテゴリーの商品情報が表示されていること" do
      within ".productBox" do
        expect(page).to have_content product_1.name
        expect(page).to have_content product_1.display_price
        expect(page).to have_selector "img[src$='#{product_image_filename}']"
      end
    end

    it "選択されていないカテゴリーの商品情報(名前)が表示されていないこと" do
      expect(page).not_to have_content product_2.name
    end

    it "サイドバーのカテゴリーリンクから選択されたカテゴリー一覧ページへ遷移できるか" do
      click_on "#{taxon_1.name}(#{taxon_1.products.count})"
      expect(current_path).to eq potepan_category_path(taxon_1.id)
    end

    it "商品名リンクから商品詳細ページへ遷移できるか" do
      click_on "#{product_1.name}"
      expect(current_path).to eq potepan_product_path(product_1.id)
    end
  end
end
