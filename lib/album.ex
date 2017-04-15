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
  - ids: List of image IDs to be included in the album.
  - deletehashes: List of delete hashes for the images.
  - title: The title of the album.
  - description: The description of the album.
  - privacy: The privacy level of the album. Options: public, hidden, secret.
  - layout: The layout to display the album in. Options: blog, grid, horizontal, vertical.
  - cover: The ID of the image to use as the album's cover.
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

  @doc """
  Update an album.

  ## Optional Params
  - ids: List of image IDs to be included in the album.
  - deletehashes: List of delete hashes for the images.
  - title: The title of the album.
  - description: The description of the album.
  - privacy: The privacy level of the album. Options: public, hidden, secret.
  - layout: The layout to display the album in. Options: blog, grid, horizontal, vertical.
  - cover: The ID of the image to use as the album's cover.
  """
  @spec update(Imgur.Client.t, String.t, map) :: {:ok, map} | {:error, any}
  def update(client, id_or_deletehash, params) do
    params = params
    |> Map.update("ids", "", &Enum.join(&1, ","))
    |> Map.update("deletehashes", "", &Enum.join(&1, ","))
    |> Enum.reject(fn {_, value} -> value === "" end)
    |> Enum.into(%{})

    API.put(client, "/3/album/#{id_or_deletehash}", params)
  end

  @spec delete(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def delete(client, id_or_deletehash) do
    API.delete(client, "/3/album/#{id_or_deletehash}")
  end

  @doc """
  Add images to an album.
  """
  @spec add_images(Imgur.Client.t, String.t, map) :: {:ok, boolean} | {:error, any}
  def add_images(client, id_or_deletehash, params) do
    params = params
    |> Map.update("ids", "", &Enum.join(&1, ","))
    |> Map.update("deletehashes", "", &Enum.join(&1, ","))
    |> Enum.reject(fn {_, value} -> value === "" end)
    |> Enum.into(%{})

    API.put(client, "/3/album/#{id_or_deletehash}/add", params)
  end

  @doc """
  Remove images from an album.
  """
  @spec remove_images(Imgur.Client.t, String.t, [String.t]) :: {:ok, boolean} | {:error, any}
  def remove_images(client, id_or_deletehash, ids) do
    params = %{"ids" => Enum.join(ids, ",")}

    API.delete(client, "/3/album/#{id_or_deletehash}/remove_images", params)
  end
end
