defmodule NflRushingWeb.StatLive.Index do
  use NflRushingWeb, :live_view

  alias NflRushing.Rushings
  alias NflRushing.Rushings.Stat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :stats, list_stats())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stat")
    |> assign(:stat, Rushings.get_stat!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stat")
    |> assign(:stat, %Stat{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stats")
    |> assign(:stat, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stat = Rushings.get_stat!(id)
    {:ok, _} = Rushings.delete_stat(stat)

    {:noreply, assign(socket, :stats, list_stats())}
  end

  defp list_stats do
    Rushings.list_stats()
  end
end
