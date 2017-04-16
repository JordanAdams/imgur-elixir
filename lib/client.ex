defmodule Imgur.Client do
  defstruct [:auth]
  @type t :: %Imgur.Client{auth: map}

  @doc """
  Create a new API client from a client ID.
  """
  @spec new([client_id: String.t]) :: Imgur.Client.t
  def new(client_id: client_id) do
    %Imgur.Client{auth: %{client_id: client_id}}
  end

  @doc """
  Create a new API client from an access token.
  """
  @spec new([access_token: String.t]) :: Imgur.Client.t
  def new(access_token: access_token) do
    %Imgur.Client{auth: %{access_token: access_token}}
  end
end
