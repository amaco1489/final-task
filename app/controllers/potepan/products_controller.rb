class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = @product.related_products.preload(master:
      [:default_price, images: { attachment_attachment: :blob }]).limit(4)
  end
end
