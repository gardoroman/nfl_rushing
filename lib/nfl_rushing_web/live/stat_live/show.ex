defmodule NflRushingWeb.StatLive.Show do
  use NflRushingWeb, :live_view

  alias NflRushing.Rushings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stat, Rushings.get_stat!(id))}
  end

  defp page_title(:show), do: "Show Stat"
  defp page_title(:edit), do: "Edit Stat"
end
