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
  def filter_events(events), do: Enum.map(events, &item_from_event/1)
  def item_from_event({:add_item, item}), do: item
  # End Cart Logic
end
