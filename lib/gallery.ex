defmodule Imgur.Gallery do
  alias Imgur.API

  @doc """
  Get the current gallery.
  """
  @spec get(Imgur.Client.t, Imgur.API.params) :: {:ok, [%Imgur.Model.GalleryAlbum{} | %Imgur.Model.GalleryImage{}]} | {:error, any}
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
  @spec get_memes(Imgur.Client.t, Imgur.API.params) :: {:ok, [%Imgur.Model.GalleryAlbum{} | %Imgur.Model.GalleryImage{}]} | {:error, any}
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
  @spec get_meme(Imgur.Client.t, String.t) :: {:ok, [%Imgur.Model.GalleryAlbum{} | %Imgur.Model.GalleryImage{}]} | {:error, any}
  def get_meme(client, image_id) do
    case API.get(client, "/3/g/memes/#{image_id}") do
      {:ok, item} -> {:ok, parse_gallery_item(item)}
      response -> response
    end
  end

  @doc """
  Get a subreddit gallery.
  """
  @spec subreddit(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, [%Imgur.Model.GalleryImage{}]} | {:error, any}
  def subreddit(client, subreddit, params \\ %{}) do
    sort = Map.get(params, "sort", "time")
    page = Map.get(params, "page", 0)
    window = Map.get(params, "window", "week")

    endpoint = "/3/gallery/r/#{subreddit}/#{sort}/#{window}/#{page}"

    API.get(client, endpoint, params, schema: [Imgur.Model.GalleryImage.schema()])
  end

  @spec parse_gallery_item(%{optional(String.t) => any}) :: %Imgur.Model.GalleryAlbum{} | %Imgur.Model.GalleryImage{}
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
