class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def store_visits
    session[:visit_counter] || 0
  end

  def store_visits=(value)
    session[:visit_counter] = value
  end

  private
  def current_cart
    Cart.find session[:cart_id]
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
