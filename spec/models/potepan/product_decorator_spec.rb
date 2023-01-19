require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  describe "#related_products" do
    let(:taxons) { create_list(:taxon, 3) }
    let(:product) { create(:product, taxons: [taxons[0], taxons[1]]) }
    let(:related_product_1) { create(:product, taxons: [taxons[0], taxons[1]]) }
    let(:related_product_2) { create(:product, taxons: [taxons[1]]) }
    let!(:unrelated_product) { create(:product, taxons: [taxons[2]]) }

    context "選択されている商品がproductの場合" do
      it "選択されている商品・重複を除いた、関連商品が取得できていること" do
        expect(product.related_products).to match_array([related_product_1, related_product_2])
      end
    end
  end
end
