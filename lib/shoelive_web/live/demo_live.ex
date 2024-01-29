defmodule ShoeliveWeb.DemoLive do
  use ShoeliveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :counter, 0)}
  end

  @impl true
  def handle_event("inc", _params, %{assigns: assigns} = socket) do
    {:noreply, assign(socket, :counter, assigns.counter + 1)}
  end

  @impl true
  def handle_event(signal, params, %{assigns: _assigns} = socket) do
    dbg({signal, params})
    {:noreply, socket}
  end
end
