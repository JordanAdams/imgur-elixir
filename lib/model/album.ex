defmodule Imgur.Model.Album do
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
    :favorite,
    :nsfw,
    :section,
    :order,
    :deletehash,
    :images_count,
    :images,
    :in_gallery
  ]

  @type t :: %Imgur.Model.Album{
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
    favorite: boolean,
    nsfw: boolean,
    section: String.t,
    order: integer,
    deletehash: String.t,
    images_count: integer,
    images: [Imgur.Model.Image.t],
    in_gallery: boolean
  }

  @spec schema() :: %Imgur.Model.Album{images: [%Imgur.Model.Image{}]}
  def schema do
    %Imgur.Model.Album{
      images: [%Imgur.Model.Image{}]
    }
  end
end
