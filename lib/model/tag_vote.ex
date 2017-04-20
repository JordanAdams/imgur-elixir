defmodule Imgur.Model.TagVote do
  defstruct [
    :ups,
    :downs,
    :name,
    :author
  ]

  @type t :: %Imgur.Model.TagVote{
    ups: integer,
    downs: integer,
    name: String.t,
    author: String.t
  }

  @spec schema() :: %Imgur.Model.TagVote{}
  def schema(), do: %Imgur.Model.TagVote{}
end
