defmodule Imgur do
  @doc """
  Get a single album.
  """
  @spec get_album(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Album.t} | {:error, any}
  defdelegate get_album(client, id), to: Imgur.Album, as: :get

  @doc """
  Get images for an album.
  """
  @spec get_album(Imgur.Client.t, String.t) :: {:ok, [Imgur.Model.Image.t]} | {:error, any}
  defdelegate get_album_images(client, id), to: Imgur.Album, as: :images

  @doc """
  Get an image from an album.
  """
  @spec get_album_image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.Image.t} | {:error, any}
  defdelegate get_album_image(client, album_id, image_id), to: Imgur.Album, as: :image
end
