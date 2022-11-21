class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def add_item(item_id:, amount:)

    item = items.find_by(item_id: item_id) || items.build(item_id: item_id)
    item.amount += amount.to_i
    item.save
  end

  def update_item(item_id:, amount:)
    items.find_by(item_id: item_id).update(amount: amount.to_i)
  end

  def delete_item(item_id:)
    items.find_by(item_id: item_id).destroy
  end

  def total_price
    items.sum("amount*price")
  end

  def subtotal
    item.with_tax_price * amount
  end

end
