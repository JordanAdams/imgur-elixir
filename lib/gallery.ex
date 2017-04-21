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
  @spec upvote_tag_item(Imgut.Client.t, String.t, String.t) :: {:ok, boolean} | {:error, any}
  def upvote_tag_item(client, item_id, tag) do
    API.post(client, "/3/gallery/#{item_id}/vote/tag/#{tag}/up")
  end

  @doc """
  Downvote a tag gallery item.
  """
  @spec downvote_tag_item(Imgut.Client.t, String.t, String.t) :: {:ok, boolean} | {:error, any}
  def downvote_tag_item(client, item_id, tag) do
    API.post(client, "/3/gallery/#{item_id}/vote/tag/#{tag}/down")
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
