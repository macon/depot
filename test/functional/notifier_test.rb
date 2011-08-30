require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    order = orders(:one)

    mail = Notifier.order_received(order)
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match order.name, mail.body.encoded
    assert_match order.name, mail.body.encoded
  end

  test "order_shipped" do
    order = orders(:one)

    mail = Notifier.order_shipped(order)
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal [order.email], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match "Just to let you know the following order has shipped", mail.body.encoded
  end

end
