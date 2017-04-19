defmodule Imgur do
  @doc """
  See Album.get/2
  """
  @spec get_album(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Album.t} | {:error, any}
  defdelegate get_album(client, id), to: Imgur.Album, as: :get

  @doc """
  See Album.images/2
  """
  @spec get_album_images(Imgur.Client.t, String.t) :: {:ok, [Imgur.Model.Image.t]} | {:error, any}
  defdelegate get_album_images(client, id), to: Imgur.Album, as: :images

  @doc """
  See Album.image/3
  """
  @spec get_album_image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.Image.t} | {:error, any}
  defdelegate get_album_image(client, album_id, image_id), to: Imgur.Album, as: :image

  @doc """
  See Album.create/2
  """
  @spec create_album(Imgur.Client.t, Imgur.API.params) :: {:ok, map} | {:error, any}
  defdelegate create_album(client, params), to: Imgur.Album, as: :create

  @doc """
  See Album.update/3
  """
  @spec update_album(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, boolean} | {:error, any}
  defdelegate update_album(client, id_or_deletehash, params), to: Imgur.Album, as: :update

  @doc """
  See Album.delete/2
  """
  @spec delete_album(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate delete_album(client, id_or_deletehash), to: Imgur.Album, as: :delete

  @doc """
  See Album.add_images/3
  """
  @spec add_images_to_album(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, boolean} | {:error, any}
  defdelegate add_images_to_album(client, id_or_deletehash, params), to: Imgur.Album, as: :add_images

  @doc """
  See Album.remove_images/3
  """
  @spec remove_images_from_album(Imgur.Client.t, String.t, [String.t]) :: {:ok, boolean} | {:error, any}
  defdelegate remove_images_from_album(client, id_or_deletehash, ids), to: Imgur.Album, as: :remove_images

  @doc """
  See Comment.get/2
  """
  @spec get_comment(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  defdelegate get_comment(client, id), to: Imgur.Comment, as: :get

  @doc """
  See Comment.create/3
  """
  @spec create_comment(Imgur.Client.t, String.t, String.t) :: {:ok, map} | {:error, any}
  defdelegate create_comment(client, image_id, comment), to: Imgur.Comment, as: :create

  @doc """
  See Comment.delete/2
  """
  @spec delete_comment(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate delete_comment(client, id), to: Imgur.Comment, as: :delete

  @doc """
  See Comment.get_with_replies/2
  """
  @spec get_comment_with_replies(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  defdelegate get_comment_with_replies(client, id), to: Imgur.Comment, as: :get_with_replies

  @doc """
  See Comment.create_reply/4
  """
  @spec create_comment_reply(Imgur.Client.t, String.t, String.t, String.t) :: {:ok, map} | {:error, any}
  defdelegate create_comment_reply(client, image_id, comment_id, comment), to: Imgur.Comment, as: :create_reply

  @doc """
  See Comment.upvote/2
  """
  @spec upvote_comment(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate upvote_comment(client, id), to: Imgur.Comment, as: :upvote

  @doc """
  See Comment.downvote/2
  """
  @spec downvote_comment(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate downvote_comment(client, id), to: Imgur.Comment, as: :downvote

  @doc """
  See Comment.report/3
  """
  @spec report_comment(Imgur.Client.t, String.t, integer) :: {:ok, nil} | {:error, any}
  defdelegate report_comment(client, id, reason), to: Imgur.Comment, as: :report

  @doc """
  See Image.get/2
  """
  @spec get_image(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Image.t} | {:error, any}
  defdelegate get_image(client, id), to: Imgur.Image, as: :get

  @doc """
  See Image.upload_file/3
  """
  @spec upload_image_file(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  defdelegate upload_image_file(client, path, params \\ %{}), to: Imgur.Image, as: :upload_file

  @doc """
  See Image.upload_base_64/3
  """
  @spec upload_image_base_64(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  defdelegate upload_image_base_64(client, data, params \\ %{}), to: Imgur.Image, as: :upload_base_64

  @doc """
  See Image.upload_url/3
  """
  @spec upload_image_url(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  defdelegate upload_image_url(client, data, params \\ %{}), to: Imgur.Image, as: :upload_url

  @doc """
  See Image.delete/2
  """
  @spec delete_image(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate delete_image(client, id_or_deletehash), to: Imgur.Image, as: :delete

  @doc """
  See Image.update_info/3
  """
  @spec update_image_info(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, boolean} | {:error, any}
  defdelegate update_image_info(client, id_or_deletehash, params), to: Imgur.Image, as: :update_info

  @doc """
  See Image.favorite/2
  """
  @spec favorite_image(Imgur.Client.t, String.t) :: {:ok, String.t} | {:error, any}
  defdelegate favorite_image(client, id), to: Imgur.Image, as: :favorite

  @doc """
  See Gallery.get/2
  """
  @spec get_gallery(Imgur.Client.t, Imgut.API.params) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  defdelegate get_gallery(client, params \\ %{}), to: Imgur.Gallery, as: :get

  @doc """
  See Gallery.get_memes/2
  """
  @spec get_memes_gallery(Imgur.Client.t, Imgur.API.params) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  defdelegate get_memes_gallery(client, params \\ %{}), to: Imgur.Gallery, as: :get_memes

  @doc """
  See Gallery.get_meme/2
  """
  @spec get_memes_gallery_image(Imgur.Client.t, String.t) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  defdelegate get_memes_gallery_image(client, image_id), to: Imgur.Gallery, as: :get_meme

  @doc """
  See Gallery.subreddit/3
  """
  @spec get_subreddit_gallery(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, [Imgur.Model.GalleryImage.t]} | {:error, any}
  defdelegate get_subreddit_gallery(client, subreddit, params \\ %{}), to: Imgur.Gallery, as: :subreddit
end
