defmodule Imgur.Album do
  alias Imgur.API

  @doc """
  Get a single album.
  """
  @spec get(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Album.t} | {:error, any}
  def get(client, id) do
    API.get(client, "/3/album/#{id}", schema: Imgur.Model.Album.schema())
  end

  @doc """
  Get images for an album.
  """
  @spec images(Imgur.Client.t, String.t) :: {:ok, [Imgur.Model.Image.t]} | {:error, any}
  def images(client, id) do
    API.get(client, "/3/album/#{id}/images", schema: [Imgur.Model.Image.schema()])
  end

  @doc """
  Get an image from an album.
  """
  @spec image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.Image.t} | {:error, any}
  def image(client, album_id, image_id) do
    API.get(client, "/3/album/#{album_id}/image/#{image_id}", schema: Imgur.Model.Image.schema())
  end
end
