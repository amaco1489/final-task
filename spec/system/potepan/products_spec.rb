require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let!(:product) { create(:product) }

    before do
      visit potepan_product_path(product.id)
    end

    it "商品情報が表示されているか" do
      expect(page).to have_title product.name
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end

    it "ヘッダーのHomeボタンからtopページへ遷移できるか" do
      click_on "header-home-btn"
      expect(current_path).to eq potepan_index_path
    end

    it "ヘッダーのロゴからtopページへ遷移できるか" do
      click_on "ロゴ"
      expect(current_path).to eq potepan_index_path
    end

    it "lightSectionのHomeボタンからtopページへ遷移できるか" do
      click_on "light-section-home-btn"
      expect(current_path).to eq potepan_index_path
    end
  end
end
