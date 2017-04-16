defmodule Imgur.API do
  alias HTTPoison.Response

  @type params :: %{optional(String.t) => any}

  @doc """
  Make a GET request to the Imgur API.
  """
  @spec get(Imgur.Client.t, String.t) :: {:ok, any} | {:error, any}
  def get(client, endpoint), do: get(client, endpoint, %{})

  @doc """
  Make a GET request to the Imgur API.

  ## Options
  - schema: A valid schema to pass to Poison.decode's `as:` option.
  """
  @spec get(Imgur.Client.t, String.t, keyword) :: {:ok, any} | {:error, any}
  def get(client, endpoint, options) when is_list(options),
    do: get(client, endpoint, %{}, options)

  @doc """
  Make a GET request to the Imgur API.

  ## Options
  - schema: A valid schema to pass to Poison.decode's `as:` option.
  """
  @spec get(Imgur.Client.t, String.t, Imgur.API.params, keyword) :: {:ok, any} | {:error, any}
  def get(client, endpoint, params, options \\ []) do
    url = "https://api.imgur.com" <> endpoint
    headers = [{"Authorization", authorization_header(client)}]

    case HTTPoison.get(url, headers, params: params) do
      {:ok, %Response{status_code: 200, body: json}} -> parse_response(json, options)
      {_, error} -> {:error, error}
    end
  end

  @doc """
  Make a POST request to the Imgur API.

  ## Options
  - schema: A valid schema to pass to Poison.decode's `as:` option.
  """
  @spec post(Imgur.Client.t, String.t, Imgur.API.params, keyword) :: {:ok, any} | {:error, any}
  def post(client, endpoint, params, options \\ []) do
    url = "https://api.imgur.com" <> endpoint
    body = {:form, Map.to_list(params)}
    headers = [{"Authorization", authorization_header(client)}]

    case HTTPoison.post(url, body, headers) do
      {:ok, %Response{status_code: 200, body: json}} -> parse_response(json, options)
      {_, error} -> {:error, error}
    end
  end

  @doc """
  Make a PUT request to the Imgur API.

  ## Options
  - schema: A valid schema to pass to Poison.decode's `as:` option.
  """
  @spec post(Imgur.Client.t, String.t, Imgur.API.params, keyword) :: {:ok, any} | {:error, any}
  def put(client, endpoint, params, options \\ []) do
    url = "https://api.imgur.com" <> endpoint
    body = {:form, Map.to_list(params)}
    headers = [{"Authorization", authorization_header(client)}]

    case HTTPoison.put(url, body, headers) do
      {:ok, %Response{status_code: 200, body: json}} -> parse_response(json, options)
      {_, error} -> {:error, error}
    end
  end

  @doc """
  Make a DELETE request to the Imgur API.

  ## Options
  - schema: A valid schema to pass to Poison.decode's `as:` option.
  """
  @spec post(Imgur.Client.t, String.t, Imgur.API.params, keyword) :: {:ok, any} | {:error, any}
  def delete(client, endpoint, params \\ %{}, options \\ []) do
    url = "https://api.imgur.com" <> endpoint
    headers = [{"Authorization", authorization_header(client)}]
    params = Map.to_list(params)

    case HTTPoison.delete(url, headers, params: params) do
      {:ok, %Response{status_code: 200, body: json}} -> parse_response(json, options)
      {_, error} -> {:error, error}
    end
  end

  # Parses an Imgur response.
  #
  # Options:
  # - schema: A valid schema to pass to Poison.decode's `as:` option.
  @spec parse_response(String.t) :: {:ok, any} | {:error, any}
  defp parse_response(json, options \\ []) do
    schema = Keyword.get(options, :schema, nil)

    case Poison.decode(json, as: %{"data" => schema}) do
      {:ok, %{"data" => data}} -> {:ok, data}
      {:error, error} -> {:error, error}
    end
  end

  # Generates an Authorization header value for the given client.
  @spec authorization_header(Imgur.Client.t) :: String.t
  defp authorization_header(%Imgur.Client{auth: auth}) do
    case auth do
      %{access_token: access_token} -> "Bearer #{access_token}"
      %{client_id: client_id} -> "Client-ID #{client_id}"
    end
  end
end
