require 'rails_helper'

RSpec.describe "Potepan::Products", type: :model do
  describe "#related_products" do
    let(:taxons) { create_list(:taxon, 3) }
    let(:products) { create_list(:product, 2, taxons: [taxons[0], taxons[1]]) }
    let(:product_1) { create(:product, taxons: [taxons[1]]) }
    let!(:product_2) { create(:product, taxons: [taxons[2]]) }

    context "選択されている商品がproducts[0]の場合" do
      it "選択されている商品・重複を除いた、関連商品が取得できていること" do
        expect(products[0].related_products).to match_array([products[1], product_1])
      end
    end
  end
end
