defmodule Imgur.Comment do
  alias Imgur.API

  @doc """
  Get a single comment.
  """
  @spec get(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  def get(client, id) do
    API.get(client, "/3/comment/#{id}", schema: Imgur.Model.Comment.schema())
  end

  @doc """
  Create a comment.
  """
  @spec create(Imgur.Client.t, String.t, String.t) :: {:ok, map} | {:error, any}
  def create(client, image_id, comment) do
    API.post(client, "/3/comment", %{
      "image_id" => image_id,
      "comment" => comment
    })
  end

  @doc """
  Delete a comment.
  """
  @spec delete(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def delete(client, id) do
    API.delete(client, "/3/comment/#{id}")
  end
end
