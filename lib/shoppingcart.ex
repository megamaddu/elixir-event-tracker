defmodule ShoppingCart do
  use GenEvent

  # Cart Actor
  def init do
    {:ok, pid} = GenEvent.start_link
    GenEvent.add_handler pid, ShoppingCart, []
    pid
  end

  def list(pid) do
    GenEvent.call pid, ShoppingCart, :list_items
  end

  def add(pid, item) do
    GenEvent.notify pid, {:add_item, item}
  end

  def remove(pid, item) do
    GenEvent.notify pid, {:remove_item, item}
  end
  # End Cart Actor

  # GenEvent
  def handle_event(event, events) do
    {:ok, [event|events]}
  end

  def handle_call(action, events) do
    case action do
      :list_items -> {:ok, Enum.reverse(events), events}
    end
  end
  # End GenEvent

  # Cart Logic
  def _list do
    []
  end

  def _addItem(cart, item) do
    cart ++ [item]
  end
  # End Cart Logic
end
