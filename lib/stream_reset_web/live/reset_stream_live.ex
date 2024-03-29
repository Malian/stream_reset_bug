defmodule StreamResetWeb.ResetStreamLive do
  use StreamResetWeb, :live_view

  @users [
    %{id: 1, name: "John", age: 27},
    %{id: 2, name: "Mary", age: 25},
    %{id: 3, name: "Peter", age: 30}
  ]

  def handle_params(_params, _uri, socket) do
    new_stream =
      @users
      |> Enum.shuffle()
      |> IO.inspect(label: "New stream (patch)")

    socket =
      socket
      |> stream(:users, new_stream, reset: true)

    {:noreply, socket}
  end

  def handle_event("shuffle", _, socket) do
    new_stream =
      @users
      |> Enum.shuffle()
      |> IO.inspect(label: "New stream (event)")

    socket =
      socket
      |> stream(:users, new_stream, reset: true)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.button phx-click={JS.patch(~p"/reset_stream")}>
      Shuffle (patch)
    </.button>

    <.button phx-click="shuffle">
      Shuffle (event)
    </.button>

    <.table id="users" rows={@streams.users}>
      <:col :let={{_id, user}} label="id"><%= user.id %></:col>
      <:col :let={{_id, user}} label="name"><%= user.name %></:col>
      <:col :let={{_id, user}} label="age"><%= user.age %></:col>
    </.table>
    """
  end
end
