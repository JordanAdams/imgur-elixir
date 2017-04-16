defmodule Imgur.Model.Comment do
  defstruct [
    :id,
    :image_id,
    :comment,
    :author,
    :author_id,
    :on_album,
    :album_cover,
    :ups,
    :downs,
    :points,
    :datetime,
    :parent_id,
    :deleted,
    :vote,
    :children
  ]

  @type t :: %Imgur.Model.Comment{
    id: integer,
    image_id: String.t,
    comment: String.t,
    author: String.t,
    author_id: integer,
    on_album: boolean,
    album_cover: String.t,
    ups: integer,
    downs: integer,
    points: float,
    datetime: integer,
    parent_id: integer,
    deleted: boolean,
    vote: String.t,
    children: [Imgur.Model.Comment.t]
  }

  @spec schema() :: Imgur.Model.Comment.t
  def schema() do
    %Imgur.Model.Comment{
      children: [%Imgur.Model.Comment{}]
    }
  end
end
