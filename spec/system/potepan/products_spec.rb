require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let(:product) { create(:product) }

    before do
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
