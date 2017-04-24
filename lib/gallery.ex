defmodule Imgur.Gallery do
  alias Imgur.API

  @type gallery_item :: Imgur.Model.GalleryImage.t | Imgur.Model.GalleryAlbum.t

  @doc """
  Get the current gallery.
  """
  @spec get(Imgur.Client.t, Imgur.API.params) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  def get(client, params \\ %{}) do
    section = Map.get(params, "section", "hot")
    sort = Map.get(params, "sort", "viral")
    page = Map.get(params, "page", 0)
    window = Map.get(params, "window", "day")

    endpoint = "/3/gallery/#{section}/#{sort}/#{window}/#{page}"

    case API.get(client, endpoint, params) do
      {:ok, values} -> {:ok, Enum.map(values, &parse_gallery_item/1)}
      response -> response
    end
  end

  @doc """
  Get the memes subgallery.
  """
  @spec get_memes(Imgur.Client.t, Imgur.API.params) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  def get_memes(client, params \\ %{}) do
    sort = Map.get(params, "sort", "viral")
    page = Map.get(params, "page", 0)
    window = Map.get(params, "window", "week")

    case API.get(client, "/3/g/memes/#{sort}/#{window}/#{page}") do
      {:ok, values} -> {:ok, Enum.map(values, &parse_gallery_item/1)}
      response -> response
    end
  end

  @doc """
  Get a single item from the memes subgallery.
  """
  @spec get_meme(Imgur.Client.t, String.t) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  def get_meme(client, image_id) do
    case API.get(client, "/3/g/memes/#{image_id}") do
      {:ok, item} -> {:ok, parse_gallery_item(item)}
      response -> response
    end
  end

  @doc """
  Get a subreddit gallery.
  """
  @spec subreddit(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, [Imgur.Model.GalleryImage.t]} | {:error, any}
  def subreddit(client, subreddit, params \\ %{}) do
    sort = Map.get(params, "sort", "time")
    page = Map.get(params, "page", 0)
    window = Map.get(params, "window", "week")

    endpoint = "/3/gallery/r/#{subreddit}/#{sort}/#{window}/#{page}"

    API.get(client, endpoint, params, schema: [Imgur.Model.GalleryImage.schema()])
  end

  @doc """
  Get an image from a subreddit gallery.
  """
  @spec subreddit_image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.GalleryImage.t} | {:error, any}
  def subreddit_image(client, subreddit, image_id) do
    API.get(client, "/3/gallery/r/#{subreddit}/#{image_id}", schema: Imgur.Model.GalleryImage.schema())
  end

  @doc """
  Get gallery items for tag.
  """
  @spec tag(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, Imgur.Model.Tag.t} | {:error, any}
  def tag(client, name, params \\ %{}) do
    sort = Map.get(params, "sort", "viral")
    page = Map.get(params, "page", 0)
    window = Map.get(params, "window", "week")

    endpoint = "/3/gallery/t/#{name}/#{sort}/#{window}/#{page}"
    schema = Imgur.Model.Tag.schema()

    case API.get(client, endpoint, params, schema: schema) do
      {:ok, tag = %{items: items}} when is_list(items) ->
        items = Enum.map(tag.items, &parse_gallery_item/1)
        {:ok, Map.put(tag, :items, items)}
      result -> result
    end
  end

  @doc """
  Get an image in a tag's gallery.
  """
  @spec tag_image(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.GalleryImage.t} | {:error, any}
  def tag_image(client, tag, image_id) do
    API.get(client, "/3/gallery/t/#{tag}/#{image_id}", schema: Imgur.Model.GalleryImage.schema())
  end

  @doc """
  Get the tags for a single gallery item.
  """
  @spec tags_for_item(Imgur.Client.t, String.t) :: {:ok, [Imgur.Model.TagVote.t]} | {:error, any}
  def tags_for_item(client, id) do
    schema = %{"tags" => [Imgur.Model.TagVote.schema()]}

    case API.get(client, "/3/gallery/#{id}/tags", schema: schema) do
      {:ok, %{"tags" => tags}} -> {:ok, tags}
      result -> result
    end
  end

  @doc """
  Upvote a tag gallery item.
  """
  @spec upvote_tag_item(Imgur.Client.t, String.t, String.t) :: {:ok, boolean} | {:error, any}
  def upvote_tag_item(client, item_id, tag) do
    API.post(client, "/3/gallery/#{item_id}/vote/tag/#{tag}/up")
  end

  @doc """
  Downvote a tag gallery item.
  """
  @spec downvote_tag_item(Imgur.Client.t, String.t, String.t) :: {:ok, boolean} | {:error, any}
  def downvote_tag_item(client, item_id, tag) do
    API.post(client, "/3/gallery/#{item_id}/vote/tag/#{tag}/down")
  end

  @doc """
  Update the tags for a gallery item.
  """
  @spec update_tags_for_item(Imgur.Client.t, String.t, [String.t]) :: {:ok, boolean} | {:error, any}
  def update_tags_for_item(client, item_id, tags) do
    API.post(client, "/3/gallery/tags/#{item_id}", %{
      "tags" => Enum.join(tags, ",")
    })
  end

  @doc """
  Search the gallery.
  """
  @spec search(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  def search(client, query, params),
    do: search(client, Map.put(params, "q", query))

  @spec search(Imgur.Client.t, String.t) :: {:ok, any} | {:error, any}
  def search(client, query) when is_binary(query),
    do: search(client, %{"q" => query})

  @spec search(Imgur.Client.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  def search(client, params) do
    sort = Map.get(params, "sort", "time")
    page = Map.get(params, "page", 0)
    window = Map.get(params, "window", "all")

    case API.get(client, "/3/gallery/search/#{sort}/#{window}/#{page}", params) do
      {:ok, items} -> {:ok, Enum.map(items, &parse_gallery_item/1)}
      result -> result
    end
  end

  @doc """
  Get a random set of gallery items.
  """
  @spec random(Imgur.Client.t, integer) :: {:ok, [Imgur.Gallery.gallery_item]} | {:error, any}
  def random(client, page \\ 0) do
    case API.get(client, "/3/gallery/random/random/#{page}") do
      {:ok, items} -> {:ok, Enum.map(items, &parse_gallery_item/1)}
      result -> result
    end
  end

  @doc """
  Publish an image or album to the public gallery.
  """
  @spec publish(Imgur.Client.t, String.t, String.t, Imgur.API.params) :: {:ok, boolean} | {:error, any}
  def publish(client, id, title, params \\ %{}) do
    params = params
    |> Map.put("title", title)
    |> Map.update("tags", "", &Enum.join(&1, ","))

    API.post(client, "/3/gallery/#{id}", params)
  end

  @doc """
  Remove an item from the gallery.
  """
  @spec remove(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def remove(client, id),
    do: API.delete(client, "/3/gallery/#{id}")

  @doc """
  Get an album from the gallery.
  """
  @spec album(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.GalleryAlbum.t} | {:error, any}
  def album(client, id),
    do: API.get(client, "/3/gallery/album/#{id}", schema: Imgur.Model.GalleryAlbum.schema())

  @doc """
  Get an image from the gallery.
  """
  @spec image(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.GalleryImage.t} | {:error, any}
  def image(client, id),
    do: API.get(client, "/3/gallery/image/#{id}", schema: Imgur.Model.GalleryImage.schema())

  @doc """
  Report an item in the gallery.

  ## Reasons
  1 Doesn't belong on Imgur
  2 Spam
  3 Abusive
  4 Mature content not marked as mature
  5 Pornography
  """
  @spec report_item(Imgur.Client.t, String.t, integer) :: {:ok, boolean} | {:error, any}
  def report_item(client, id, reason) do
    API.post(client, "/3/gallery/#{id}/report", %{"reason" => reason})
  end

  @spec report_item(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def report_item(client, id) do
    API.post(client, "/3/gallery/#{id}/report")
  end

  @doc """
  Get vote information for a gallery item.
  """
  @spec votes_for_item(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Vote.t} | {:error, any}
  def votes_for_item(client, id) do
    API.get(client, "/3/gallery/#{id}/votes", schema: Imgur.Model.Vote.schema())
  end

  @doc """
  Upvote a gallery item.
  """
  @spec upvote_item(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def upvote_item(client, id) do
    API.post(client, "/3/gallery/#{id}/vote/up")
  end

  @doc """
  Downvote a gallery item.
  """
  @spec downvote_item(Imgur.Client.t, String.t) :: {:ok, boolean} | {:error, any}
  def downvote_item(client, id) do
    API.post(client, "/3/gallery/#{id}/vote/down")
  end

  @doc """
  Get all comments for a gallery item.
  """
  @spec comments_for_item(Imgur.Client.t, String.t, String.t) :: {:ok, [Imgur.Model.Comment.t]} | {:error, any}
  def comments_for_item(client, id, sort \\ "best") do
    API.get(client, "/3/gallery/#{id}/comments/#{sort}", schema: [Imgur.Model.Comment.schema()])
  end

  @doc """
  Get a single comment for a gallery item.
  """
  @spec comment_for_item(Imgur.Client.t, String.t, String.t) :: {:ok, Imgur.Model.Comment.t} | {:error, any}
  def comment_for_item(client, item_id, comment_id) do
    API.get(client, "/3/gallery/#{item_id}/comment/#{comment_id}", schema: Imgur.Model.Comment.schema())
  end

  @spec parse_gallery_item(%{optional(String.t) => any}) :: Imgur.Gallery.gallery_item
  defp parse_gallery_item(item = %{"is_album" => is_album}) do
    case is_album do
      true  -> map_to_struct(item, %Imgur.Model.GalleryAlbum{})
      false -> map_to_struct(item, %Imgur.Model.GalleryImage{})
    end
  end

  @spec map_to_struct(%{optional(String.t) => any}, struct) :: struct
  defp map_to_struct(map, struct) do
    Enum.reduce(map, struct, fn {key, value}, acc ->
      key = String.to_atom(key)
      case Map.has_key?(struct, key) do
        true  -> Map.put(acc, key, value)
        false -> acc
      end
    end)
  end
end
