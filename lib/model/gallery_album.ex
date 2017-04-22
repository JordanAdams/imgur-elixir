defmodule Imgur.Model.GalleryAlbum do
  defstruct [
    :id,
    :title,
    :description,
    :datetime,
    :cover,
    :cover_width,
    :cover_height,
    :account_url,
    :account_id,
    :privacy,
    :layout,
    :views,
    :link,
    :ups,
    :downs,
    :points,
    :score,
    :is_album,
    :vote,
    :favorite,
    :nsfw,
    :comment_count,
    :topic,
    :topic_id,
    :images_count,
    :images,
    :in_most_viral
  ]

  @type t :: %Imgur.Model.GalleryAlbum{
    id: String.t,
    title: String.t,
    description: String.t,
    datetime: integer,
    cover: String.t,
    cover_width: integer,
    cover_height: integer,
    account_url: String.t,
    account_id: integer,
    privacy: String.t,
    layout: String.t,
    views: integer,
    link: String.t,
    ups: integer,
    downs: integer,
    points: integer,
    score: integer,
    is_album: boolean,
    vote: String.t,
    favorite: boolean,
    nsfw: boolean,
    comment_count: integer,
    topic: String.t,
    topic_id: integer,
    images_count: integer,
    images: [%Imgur.Model.Image{}],
    in_most_viral: boolean
  }

  @spec schema() :: %Imgur.Model.GalleryAlbum{images: [%Imgur.Model.GalleryImage{}]}
  def schema() do
    %Imgur.Model.GalleryAlbum{
      images: [%Imgur.Model.Image{}]
    }
  end
end
