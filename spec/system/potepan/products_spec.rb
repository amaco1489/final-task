require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "商品詳細ページ" do
    let(:product) { create(:product, taxons: [taxon_1, taxon_2]) }
    let(:image) { create(:image) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end
    let(:taxon_1) { create(:taxon) }
    let(:taxon_2) { create(:taxon) }

    before do
      product.images << image
      visit potepan_product_path(product.id)
    end

    it "タイトルに商品名とストア名が表示されていること" do
      expect(title).to eq "#{product.name} - BIGBAG Store"
    end

    it "商品情報が表示されていること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end

    it "商品画像(大)のファイル名を取得できていること" do
      within first(".carousel-inner") do
        expect(page).to have_selector "img[src$='#{product_image_filename}']"
      end
    end

    it "商品画像(小)のファイル名を取得できていること" do
      within "#thumbcarousel" do
        expect(page).to have_selector "img[src$='#{product_image_filename}']"
      end
    end

    it "ヘッダーのHomeボタンからtopページへ遷移できること" do
      within ".nav" do
        click_on "Home"
        expect(current_path).to eq potepan_index_path
      end
    end

    it "商品名横のHomeボタンからtopページへ遷移できること" do
      within ".breadcrumb" do
        click_on "Home"
        expect(current_path).to eq potepan_index_path
      end
    end

    it "ヘッダーのロゴからtopページへ遷移できること" do
      click_on "ロゴ"
      expect(current_path).to eq potepan_index_path
    end

    it "一覧ページへ戻るリンクからカテゴリーページへ遷移できること" do
      click_on "一覧ページへ戻る"
      expect(current_path).to eq potepan_category_path(product.taxons.first.id)
    end
  end
end
