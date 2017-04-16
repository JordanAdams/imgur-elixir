defmodule Imgur.Image do
  alias Imgur.API

  @doc """
  Get an image.
  """
  @spec get(Imgur.Client.t, String.t) :: {:ok, Imgur.Model.Image.t} | {:error, any}
  def get(client, id) do
    API.get(client, "/3/image/#{id}", schema: Imgur.Model.Image.schema())
  end

  @doc """
  Uploads an image from a file path.
  """
  @spec upload_file(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  def upload_file(client, path, params \\ %{}) do
    with {:ok, file_data} <- File.read(path),
         encoded <- Base.encode64(file_data),
         do: upload_base_64(client, encoded, params)
  end

  @doc """
  Uploads an image from its base64 encoded data.
  """
  @spec upload_base_64(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  def upload_base_64(client, data, params \\ %{}),
    do: upload(client, data, "base64", params)

  @doc """
  Uploads an image from a URL.
  """
  @spec upload_url(Imgur.Client.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  def upload_url(client, url, params \\ %{}),
    do: upload(client, url, "url", params)

  # Uploads an image.
  #
  # Acceptable values for data_type are "url" and "base64"
  @spec upload(Imgur.Client.t, String.t, String.t, Imgur.API.params) :: {:ok, any} | {:error, any}
  defp upload(client, data, data_type, params) do
    params = Map.merge(params, %{"image" => data, "type" => data_type})

    API.post(client, "/3/image", params)
  end
end
