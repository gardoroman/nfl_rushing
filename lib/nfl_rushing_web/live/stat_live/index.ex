defmodule NflRushingWeb.StatLive.Index do
  use NflRushingWeb, :live_view

  alias NflRushing.Rushings
  alias NflRushing.Rushings.Stat

  @impl true
  def mount(_params, _session, socket) do
    stats = list_stats()
    players = Enum.map(stats, &(&1.player))
    updated_socket =
      socket
      |> assign(:stats, stats)
      |> assign(players: players)
    
    {:ok, updated_socket}
    # {:ok, assign(socket, :stats, list_stats())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("order-by", %{"field" => sort_field}, socket) do
    updated_socket = sort_stats(socket, sort_field)
    {:noreply, updated_socket}
  end

  def handle_event("filter-by-player", %{"player" => player}, socket) do
    stats = 
      list_stats()
      |> filter_stats_by_player(player)
    {
      :noreply, 
      assign(socket, :stats, stats)
    }
  end

  # defp apply_action(socket, :edit, %{"id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit Stat")
  #   |> assign(:stat, Rushings.get_stat!(id))
  # end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New Stat")
  #   |> assign(:stat, %Stat{})
  # end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "NFL Rushing Stats")
    |> assign(:stat, nil)
  end

  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   stat = Rushings.get_stat!(id)
  #   {:ok, _} = Rushings.delete_stat(stat)

  #   {:noreply, assign(socket, :stats, list_stats())}
  # end

  defp list_stats do
    Rushings.list_stats()
  end



  #------------------------------------------------------------------------------------
  # sort_stats/2 
  # Will sort the table by the field passed via the "order-by" event.
  # Currently only handles "Yds", "TD", and "Lng" per requirements.
  # The function also tracks which fields have been selected. In case of a column
  # being clicked more than once will toggle between ascending and descending.
  # The function returns a socket wit the updated stats, sort_field, and sort_order.
  #------------------------------------------------------------------------------------
  defp sort_stats(socket, field) do
    current_field = Map.get(socket.assigns, :sort_field)
    current_order = Map.get(socket.assigns, :sort_order)
    sort_order = get_sort_order(current_field, field, current_order)

    fun = get_sort_by_field(field)

    stats = 
      socket.assigns.stats
      |> Enum.sort_by(fun, sort_order)
    
    socket
    |> assign(:stats, stats)
    |> assign(:sort_field, field)
    |> assign(:sort_order, sort_order)
  end

  defp get_sort_by_field("yds"), do: &(&1.yds)
  defp get_sort_by_field("lng"), do: &(&1.lng)
  defp get_sort_by_field("td"), do: &(&1.td)

  defp get_sort_order(current, current, :asc), do: :desc
  defp get_sort_order(current, current, :desc), do: :asc
  defp get_sort_order(_, _, _), do: :asc

  defp filter_stats_by_player(stats, "reset"), do: stats
  defp filter_stats_by_player(stats, player) do
    stats
    |> Enum.filter(&(&1.player == player))
  end
end
