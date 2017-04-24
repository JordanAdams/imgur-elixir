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

  @doc """
  See Gallery.subreddit_image/3
  """
  @spec get_subreddit_gallery_image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.GalleryImage.t} | {:error, any}
  defdelegate get_subreddit_gallery_image(client, subreddit, image_id), to: Imgur.Gallery, as: :subreddit_image

  @doc """
  See Gallery.tag/3
  """
  @spec get_tag_gallery(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, Imgur.Model.Tag.t} | {:error, any}
  defdelegate get_tag_gallery(client, tag, params \\ %{}), to: Imgur.Gallery, as: :tag

  @doc """
  See Gallery.tag_image/3
  """
  @spec get_tag_gallery_image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.GalleryImage.t} | {:error, any}
  defdelegate get_tag_gallery_image(client, tag, image_id), to: Imgur.Gallery, as: :tag_image

  @doc """
  See Gallery.tags_for_item/2
  """
  @spec get_tags_for_gallery_item(Imgur.Client.t, String.t) :: {:ok, [Imgur.Model.TagVote.t]} | {:error, any}
  defdelegate get_tags_for_gallery_item(client, id), to: Imgur.Gallery, as: :tags_for_item

  @doc """
  See Gallery.upvote_tag_item/3
  """
  @spec upvote_tag_gallery_item(Imgut.Client.t, String.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate upvote_tag_gallery_item(client, item_id, tag), to: Imgur.Gallery, as: :upvote_tag_item

  @doc """
  See Gallery.downvote_tag_item/3
  """
  @spec downvote_tag_gallery_item(Imgut.Client.t, String.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate downvote_tag_gallery_item(client, item_id, tag), to: Imgur.Gallery, as: :downvote_tag_item

  @doc """
  See Gallery.update_tags_for_gallery_item/3
  """
  @spec update_tags_for_gallery_item(Imgur.Client.t, String.t, [String.t]) :: {:ok, boolean} | {:error, any}
  defdelegate update_tags_for_gallery_item(client, item_id, tags), to: Imgur.Gallery, as: :update_tags_for_item

  @doc """
  See Gallery.search/3
  """
  @spec search_gallery(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  defdelegate search_gallery(client, query, params), to: Imgur.Gallery, as: :search

  @doc """
  See Gallery.search/2
  """
  @spec search_gallery(Imgur.Client.t, String.t | Imgur.API.params) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  defdelegate search_gallery(client, query_or_params), to: Imgur.Gallery, as: :search

  @doc """
  See Gallery.random/2
  """
  @spec random_gallery(Imgur.Client.t, integer) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  defdelegate random_gallery(client, page \\ 0), to: Imgur.Gallery, as: :random

  @doc """
  See Gallery.publish/4
  """
  @spec publish_to_gallery(Imgur.Client.t, String.t, String.t, Imgur.API.params) :: {:ok, boolean} | {:error, any}
  defdelegate publish_to_gallery(client, id, title, params \\ %{}), to: Imgur.Gallery, as: :publish

  @doc """
  See Gallery.remove/2
  """
  @spec remove_from_gallery(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate remove_from_gallery(client, id), to: Imgur.Gallery, as: :remove

  @doc """
  See Gallery.album/2
  """
  @spec get_gallery_album(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.GalleryAlbum.t} | {:error, any}
  defdelegate get_gallery_album(client, id), to: Imgur.Gallery, as: :album

  @doc """
  See Gallery.image/2
  """
  @spec get_gallery_image(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.GalleryImage.t} | {:error, any}
  defdelegate get_gallery_image(client, id), to: Imgur.Gallery, as: :image

  @doc """
  See Gallery.report/3
  """
  @spec report_gallery_item(Imgur.Client.t, String.t, integer) :: {:ok, boolean} | {:error, any}
  defdelegate report_gallery_item(client, id, reason), to: Imgur.Gallery, as: :report_item

  @doc """
  See Gallery.report/2
  """
  @spec report_gallery_item(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate report_gallery_item(client, id), to: Imgur.Gallery, as: :report_item

  @doc """
  See Gallery.votes_for_item/2
  """
  @spec votes_for_gallery_item(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Vote.t} | {:error, any}
  defdelegate votes_for_gallery_item(client, id), to: Imgur.Gallery, as: :votes_for_item

  @doc """
  See Gallery.upvote_item/2
  """
  @spec upvote_gallery_item(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate upvote_gallery_item(client, id), to: Imgur.Gallery, as: :upvote_item

  @doc """
  See Gallery.downvote_item/2
  """
  @spec downvote_gallery_item(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  defdelegate downvote_gallery_item(client, id), to: Imgur.Gallery, as: :downvote_item

  @doc """
  See Gallery.comments_for_gallery_item/3
  """
  @spec comments_for_gallery_item(Imgur.Client.t, String.t, String.t) :: {:ok, [Imgur.Model.Comment.t]} | {:error, any}
  defdelegate comments_for_gallery_item(client, id, sort \\ "best"), to: Imgur.Gallery, as: :comments_for_item

  @doc """
  See Gallery.comment_for_item/3
  """
  @spec comment_for_gallery_item(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  defdelegate comment_for_gallery_item(client, item_id, comment_id), to: Imgur.Gallery, as: :comment_for_item
end
