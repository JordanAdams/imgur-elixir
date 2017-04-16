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
  @spec create_album(Imgur.Client.t, Imgur.API.params) :: {:ok, map} | {:error, any}
  defdelegate create_album(client, params), to: Imgur.Album, as: :create

  @doc """
  See Imgur.Album.update/3
  """
  @spec update_album(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, boolean} | {:error, any}
  defdelegate update_album(client, id_or_deletehash, params), to: Imgur.Album, as: :update

  @doc """
  See Imgur.Album.delete/2
  """
  @spec delete_album(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate delete_album(client, id_or_deletehash), to: Imgur.Album, as: :delete

  @doc """
  See Imgur.Album.add_images/3
  """
  @spec add_images_to_album(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, boolean} | {:error, any}
  defdelegate add_images_to_album(client, id_or_deletehash, params), to: Imgur.Album, as: :add_images

  @doc """
  See Imgur.Album.remove_images/3
  """
  @spec remove_images_from_album(Imgur.Client.t, String.t, [String.t]) :: {:ok, boolean} | {:error, any}
  defdelegate remove_images_from_album(client, id_or_deletehash, ids), to: Imgur.Album, as: :remove_images

  @doc """
  See Imgur.Comment.get/2
  """
  @spec get_comment(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  defdelegate get_comment(client, id), to: Imgur.Comment, as: :get

  @doc """
  See Imgur.Comment.create/3
  """
  @spec create_comment(Imgur.Client.t, String.t, String.t) :: {:ok, map} | {:error, any}
  defdelegate create_comment(client, image_id, comment), to: Imgur.Comment, as: :create

  @doc """
  See Imgur.Comment.delete/2
  """
  @spec delete_comment(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate delete_comment(client, id), to: Imgur.Comment, as: :delete

  @doc """
  See Imgur.Comment.get_with_replies/2 
  """
  @spec get_comment_with_replies(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  defdelegate get_comment_with_replies(client, id), to: Imgur.Comment, as: :get_with_replies
end
