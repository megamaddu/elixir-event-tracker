defmodule ShoppingCartTest do
  use ExUnit.Case

  test "initial state" do
    assert (length ShoppingCart.list) == 0
  end

  test "test one item" do
    assert (length ShoppingCart.addItem) == 1
  end

  test "test add array" do
    assert [] ++ [1] == [1]
  end
end
