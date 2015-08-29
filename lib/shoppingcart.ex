defmodule ShoppingCart do
  use GenEvent

  # Cart Actor
  def start_cart do
    {:ok, pid} = GenEvent.start_link
    GenEvent.add_handler pid, ShoppingCart, []
    pid
  end

  def cart_list(pid) do
    GenEvent.call pid, ShoppingCart, :cart_list
  end

  def event_history(pid) do
    GenEvent.call pid, ShoppingCart, :event_history
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
      :event_history -> {:ok, Enum.reverse(events), events}
      :cart_list -> {:ok, filter_events(Enum.reverse(events)), events}
    end
  end
  # End GenEvent

  # Cart Logic
  def filter_events(events) do
    expanded_item_quantities = Enum.map(events, &event_kinds_to_quantity/1)
    item_quantities = Enum.reduce(expanded_item_quantities, %{}, &count_items/2)
    items_in_cart = Enum.filter(item_quantities, fn {_, quantity} -> quantity > 0 end)
    Enum.map(items_in_cart, fn {item, _} -> item end)
  end

  def event_kinds_to_quantity({:add_item, item}), do: {item, 1}
  def event_kinds_to_quantity({:remove_item, item}), do: {item, -1}

  def count_items({item, quantity}, quantities) do
    case Dict.has_key?(quantities, item) do
      true -> Dict.put(quantities, item, quantities[item] + quantity)
      false -> Dict.put(quantities, item, quantity)
    end
  end

  # End Cart Logic
end
