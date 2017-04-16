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

  @doc """
  Get a comment with its replies.
  """
  @spec get_with_replies(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  def get_with_replies(client, id) do
    API.get(client, "/3/comment/#{id}/replies", schema: Imgur.Model.Comment.schema())
  end

  @doc """
  Create a reply to a comment.
  """
  @spec create_reply(Imgur.Client.t, String.t, String.t, String.t) :: {:ok, map} | {:error, any}
  def create_reply(client, image_id, comment_id, comment) do
    API.post(client, "/3/comment/#{comment_id}", %{
      "image_id" => image_id,
      "comment" => comment
    })
  end

  @doc """
  Upvote a comment.
  """
  @spec upvote(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def upvote(client, id) do
    API.post(client, "/3/comment/#{id}/vote/up")
  end

  @doc """
  Downvote a comment.
  """
  @spec downvote(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def downvote(client, id) do
    API.post(client, "/3/comment/#{id}/vote/down")
  end
end
