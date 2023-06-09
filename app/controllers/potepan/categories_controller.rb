class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.all
    @products =
      @taxon.all_products.preload(master:
      [:default_price, images: { attachment_attachment: :blob }])
  end
end
