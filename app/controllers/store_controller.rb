class StoreController < ApplicationController

  def index
    @products = Product.all
    @visits = self.store_visits += 1
    @cart = current_cart
  end

end
