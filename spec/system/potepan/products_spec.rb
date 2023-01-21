require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "商品詳細ページ" do
    let(:taxons) { create_list(:taxon, 2) }
    let(:product) { create(:product, taxons: taxons) }
    let(:image) { create(:image) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end
    let(:related_products) do
      [15, 16, 17, 18, 19].map do |price|
        create(:product, taxons: [taxons[0]], price: price)
      end
    end

    before do
      product.images << image
      related_products.each do |related_product|
        related_product.images << create(:image)
      end
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
      expect(current_path).to eq potepan_category_path(product.taxons[0].id)
    end

    it "関連商品情報（4個のみ）が表示されていること" do
      within ".productsContent" do
        related_products[0..3].all? do |related_product|
          expect(page).to have_content related_product.name
          expect(page).to have_content related_product.display_price
        end
        expect(page).not_to have_content related_products[4].name
        expect(page).not_to have_content related_products[4].display_price
      end
    end

    it "関連商品名リンクからそれぞれの商品詳細ページへ遷移できること" do
      within ".productsContent" do
        related_products[0..3].all? do |related_product|
          click_on related_product.name
          expect(current_path).to eq potepan_product_path(related_product.id)
        end
      end
    end
  end
end
