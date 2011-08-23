class UpdateLineItemPriceFromProduct < ActiveRecord::Migration
  def self.up
    Cart.all.each do |cart|
      cart.line_items.each do |item|
        item.price = item.product.price
        item.save
      end
    end
  end

  def self.down
    Cart.all.each do |cart|
      cart.line_items.each do |item|
        item.price = nil
        item.save
      end
    end
  end
end
