defmodule ShoppingCartTest do
  use ExUnit.Case

  def cart_with_items do
    pid = ShoppingCart.start_cart
    ShoppingCart.add pid, {:item1}
    ShoppingCart.add pid, {:item2}
    pid
  end

  test "initial empty state" do
    pid = ShoppingCart.start_cart
    assert (length (ShoppingCart.event_history pid))
      == 0
  end

  test "initial state with items" do
    pid = cart_with_items
    assert (ShoppingCart.event_history pid) ==
      [{:add_item,{:item1}},{:add_item,{:item2}}]
  end

  test "test add to all events" do
    pid = cart_with_items
    ShoppingCart.add pid, {:item3}
    assert (ShoppingCart.event_history pid) ==
      [{:add_item,{:item1}},{:add_item,{:item2}},{:add_item,{:item3}}]
  end

  test "test remove to all event" do
    pid = cart_with_items
    ShoppingCart.remove pid, {:item1}
    assert (ShoppingCart.event_history pid) ==
      [{:add_item,{:item1}},{:add_item,{:item2}},{:remove_item,{:item1}}]
  end

  test "is cart working" do
    pid = ShoppingCart.start_cart
    assert ShoppingCart.cart_list(pid) == []
  end

  test "test add to cart" do
    pid = ShoppingCart.start_cart
    ShoppingCart.add pid, {:item3}
    assert (ShoppingCart.cart_list pid) ==
      [{:item3}]
  end

  test "a cart with more than one
    item is displayed in the list" do
    pid = cart_with_items
    assert (ShoppingCart.cart_list pid) ==
      [{:item1}, {:item2}]
  end
  #
  # test "test remove from cart" do
  #   pid = cart_with_items
  #   ShoppingCart.remove pid, {:item1}
  #   assert (ShoppingCart.cart_list pid) ==
  #     [{:add_item,{:item2}}]
  # end

end

# {:ok, pid} = GenEvent.start_link()
#
# GenEvent.add_handler(pid, LoggerHandler, [])
# #=> :ok
#
# GenEvent.notify(pid, {:log, 1})
# #=> :ok
#
# GenEvent.notify(pid, {:log, 2})
# #=> :ok
#
# GenEvent.call(pid, LoggerHandler, :messages)
# #=> [1, 2]
#
# GenEvent.call(pid, LoggerHandler, :messages)
# #=> []
