defmodule Imgur do
  @doc """
  See Imgur.Album.get/2
  """
  @spec get_album(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Album.t} | {:error, any}
  defdelegate get_album(client, id), to: Imgur.Album, as: :get

  @doc """
  See Imgur.Album.images/2
  """
  @spec get_album(Imgur.Client.t, String.t) :: {:ok, [Imgur.Model.Image.t]} | {:error, any}
  defdelegate get_album_images(client, id), to: Imgur.Album, as: :images

  @doc """
  See Imgur.Album.image/3
  """
  @spec get_album_image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.Image.t} | {:error, any}
  defdelegate get_album_image(client, album_id, image_id), to: Imgur.Album, as: :image

  @doc """
  See Imgur.Album.create/2
  """
  @spec create_album(Imgur.Client.t, map) :: {:ok, map} | {:error, any}
  defdelegate create_album(client, params), to: Imgur.Album, as: :create

  @doc """
  See Imgur.Album.update/3
  """
  @spec update_album(Imgur.Client.t, String.t, map) :: {:ok, map} | {:error, any}
  defdelegate update_album(client, id_or_deletehash, params), to: Imgur.Album, as: :update

  @doc """
  See Imgur.Album.delete/2
  """
  @spec delete_album(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate delete_album(client, id_or_deletehash), to: Imgur.Album, as: :delete

  @doc """
  See Imgur.Album.add_images/3
  """
  @spec add_images_to_album(Imgur.Client.t, String.t, map) :: {:ok, boolean} | {:error, any}
  defdelegate add_images_to_album(client, id_or_deletehash, params), to: Imgur.Album, as: :add_images

  @doc """
  See Imgut.Album.remove_images/3
  """
  @spec remove_images_from_album(Imgur.Client.t, String.t, [String.t]) :: {:ok, boolean} | {:error, any}
  defdelegate remove_images_from_album(client, id_or_deletehash, ids), to: Imgur.Album, as: :remove_images
end
