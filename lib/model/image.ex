defmodule Imgur.Model.Image do
  defstruct [
    :id,
    :title,
    :description,
    :datetime,
    :type,
    :animated,
    :width,
    :height,
    :size,
    :views,
    :bandwidth,
    :deletehash,
    :name,
    :section,
    :link,
    :gifv,
    :mp4,
    :mp4_size,
    :looping,
    :favorite,
    :nsfw,
    :vote,
    :in_gallery
  ]

  @type t :: %Imgur.Model.Image{
    id: String.t,
    title: String.t,
    description: String.t,
    datetime: integer,
    type: String.t,
    animated: boolean,
    width: integer,
    height: integer,
    size: integer,
    views: integer,
    bandwidth: integer,
    deletehash: String.t,
    name: String.t,
    section: String.t,
    link: String.t,
    gifv: String.t,
    mp4: String.t,
    mp4_size: integer,
    looping: boolean,
    favorite: boolean,
    nsfw: boolean,
    vote: String.t,
    in_gallery: boolean
  }

  def schema do
    %Imgur.Model.Image{}
  end
end
