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

  @doc """
  Create a new album.

  ## Optional Params
  - `list` ids: The image IDs to be included in the album.
  - `list` deletehashes: The delete hashes for the images.
  - `string` title: The title of the album.
  - `string` description: The description of the album.
  - `string` privacy: The privacy level of the album (public | hidden | secret).
  - `string` layout: The layout to display the album in (blog | grid | horizontal | vertical).
  - `string` cover: The ID of the image to use as the album's cover.
  """
  @spec create(Imgur.Client.t, map) :: {:ok, map} | {:error, any}
  def create(client, params) do
    params = params
    |> Map.update("ids", "", &Enum.join(&1, ","))
    |> Map.update("deletehashes", "", &Enum.join(&1, ","))
    |> Enum.reject(fn {_, value} -> value === "" end)
    |> Enum.into(%{})

    API.post(client, "/3/album", params)
  end
end
