require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let!(:product) { create(:product) }

    before do
      visit potepan_product_path(product.id)
    end

    it "商品情報が表示されているか" do
      within "body" do
        expect(page).to have_content product.name
        expect(page).to have_content product.price
        expect(page).to have_content product.description
      end
    end
    it "ヘッダーのHomeボタンからindexへ遷移できるか" do
      click_on "header-home-btn"
      expect(current_path).to eq potepan_index_path
    end
    it "ヘッダーのロゴボタンからindexへ遷移できるか" do
      click_on "ロゴ"
      expect(current_path).to eq potepan_index_path
    end
    it "lightSectionのHomeボタンからindexへ遷移できるか" do
      click_on "light-section-home-btn"
      expect(current_path).to eq potepan_index_path
    end
  end
end
