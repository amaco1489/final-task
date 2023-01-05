require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let(:product) { create(:product) }
    let(:image_first) { create(:image) }
    let(:image_second) { create(:image) }
    let(:image_third) { create(:image) }

    before do
      product.images.push(image_first, image_second, image_third)
      visit potepan_product_path(product.id)
    end

    it "動的なタイトルになること" do
      expect(title).to eq "#{product.name} - BIGBAG Store"
    end

    it "商品情報を表示すること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end

    it "商品画像(大)のファイル名が含まれていること" do
      within first(".carousel-inner") do
        expect(page).to have_selector "img[src$='#{product.images.first.filename}']"
      end
    end

    it "商品画像(小)のファイル名が含まれていること" do
      within "#thumbcarousel" do
        expect(page).to have_selector "img[src$='#{product.images.last.filename}']"
      end
    end

    it "ヘッダーのHomeボタンからtopページへ遷移すること" do
      within ".nav" do
        click_on "Home"
        expect(current_path).to eq potepan_index_path
      end
    end

    it "商品名横のHomeボタンからtopページへ遷移すること" do
      within ".breadcrumb" do
        click_on "Home"
        expect(current_path).to eq potepan_index_path
      end
    end

    it "ヘッダーのロゴからtopページへ遷移すること" do
      click_on "ロゴ"
      expect(current_path).to eq potepan_index_path
    end
  end
end
