defmodule Imgur.Client do
  defstruct [:auth]
  @type t :: %Imgur.Client{auth: map}

  @doc """
  Create a new API client.
  """
  @spec new([client_id: String.t]) :: t
  def new(client_id: client_id) do
    %Imgur.Client{auth: %{client_id: client_id}}
  end
end
