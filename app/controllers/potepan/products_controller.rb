class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_LIMIT = 4

  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = @product.related_products.preload(master:
      [:default_price, images: { attachment_attachment: :blob }]).limit(RELATED_PRODUCTS_LIMIT)
  end
end
