require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  describe "GET #show" do
    let(:product) { create(:product) }
    let(:image) { create(:image) }
    # 画像URLの取得が上手くいかない問題への対応
    # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
    let(:product_image_filename) do
      filename = image.attachment_blob.filename
      "#{filename.base}#{filename.extension_with_delimiter}"
    end

    before do
      product.images << image
      visit potepan_product_path(product.id)
      ActiveStorage::Current.host = page.current_host
    end

    it "タイトルに商品名とストア名を表示すること" do
      expect(title).to eq "#{product.name} - BIGBAG Store"
    end

    it "商品情報を表示すること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end

    it "商品画像(大)のファイル名が含まれていること" do
      within first(".carousel-inner") do
        expect(page).to have_selector "img[src$='#{product_image_filename}']"
      end
    end

    it "商品画像(小)のファイル名が含まれていること" do
      within "#thumbcarousel" do
        expect(page).to have_selector "img[src$='#{product_image_filename}']"
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
