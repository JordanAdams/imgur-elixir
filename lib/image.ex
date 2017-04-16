defmodule Imgur.Image do
  alias Imgur.API

  @doc """
  Get an image.
  """
  @spec get(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Image.t} | {:error, any}
  def get(client, id) do
    API.get(client, "/3/image/#{id}", schema: Imgur.Model.Image.schema())
  end
end
