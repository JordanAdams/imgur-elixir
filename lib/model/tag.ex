defmodule Imgur.Model.Tag do
  defstruct [
    :name,
    :followers,
    :total_items,
    :following,
    :items
  ]

  @type t :: %Imgur.Model.Tag{
    name: String.t,
    followers: integer,
    total_items: integer,
    following: boolean,
    items: [Imgur.Model.GalleryImage.t | Imgur.Model.GalleryAlbum.t]
  }

  @spec schema() :: Imgur.Model.Tag.t
  def schema(), do: %Imgur.Model.Tag{}
end
