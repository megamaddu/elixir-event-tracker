defmodule ShoppingCartTest do
  use ExUnit.Case

  test "initial state" do
    pid = ShoppingCart.init
    assert (length (ShoppingCart.list pid)) == 0
  end

  test "test one item" do
    pid = ShoppingCart.init
    ShoppingCart.add pid, {:item1}
    assert (length (ShoppingCart.list pid)) == 1
    ShoppingCart.add pid, {:item2}
    assert (length (ShoppingCart.list pid)) == 2
  end

  test "test add array" do
    assert [] ++ [1] == [1]
  end
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
