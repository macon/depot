class CombineDupeItemsInCart < ActiveRecord::Migration
  def self.up
    Cart.all.each do |cart|
      product_quantities = cart.line_items.group(:product_id).sum(:quantity)

      product_quantities.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(:product_id => product_id).delete_all
          cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
        end
      end
    end
  end

  def self.down
    LineItem.where("quantity > 1").each do |item|
      item.quantity.times do
        LineItem.create \
          :cart_id=>item.cart_id,
          :product_id=>item.product_id,
          :quantity=>1
      end
      item.destroy
    end
  end
end
