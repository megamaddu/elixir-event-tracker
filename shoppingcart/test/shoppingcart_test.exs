defmodule ShoppingCartTest do
  use ExUnit.Case

  test "initial state" do
    assert (length ShoppingCart.list) == 0
  end
end
