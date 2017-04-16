defmodule Imgur.Comment do
  alias Imgur.API

  @doc """
  Get a single comment.
  """
  @spec get(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  def get(client, id) do
    API.get(client, "/3/comment/#{id}", schema: Imgur.Model.Comment.schema())
  end
end
