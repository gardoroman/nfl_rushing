defmodule NflRushingWeb.StatLive.FormComponent do
  use NflRushingWeb, :live_component

  alias NflRushing.Rushings

  @impl true
  def update(%{stat: stat} = assigns, socket) do
    changeset = Rushings.change_stat(stat)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"stat" => stat_params}, socket) do
    changeset =
      socket.assigns.stat
      |> Rushings.change_stat(stat_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"stat" => stat_params}, socket) do
    save_stat(socket, socket.assigns.action, stat_params)
  end

  defp save_stat(socket, :edit, stat_params) do
    case Rushings.update_stat(socket.assigns.stat, stat_params) do
      {:ok, _stat} ->
        {:noreply,
         socket
         |> put_flash(:info, "Stat updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_stat(socket, :new, stat_params) do
    case Rushings.create_stat(stat_params) do
      {:ok, _stat} ->
        {:noreply,
         socket
         |> put_flash(:info, "Stat created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
