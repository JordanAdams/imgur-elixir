# Imgur
> An Elixir wrapper around the Imgur API

## Installation
Add `imgur` to your deps in `mix.exs`

```elixir
def deps do
  [{:imgur, "~> 0.1.0"}]
end
```

## Usage
```elixir
client = Imgur.Client.new(client_id: "myclientid")
{:ok, image} = Imgur.Image.get(client, "someimageid")
```

## Maintainer
[Jordan Adams](http://github.com/jordanadams)

## Contribute
PRs are welcome.

If you have any problems or questions, please [create an issue](https://github.com/JordanAdams/imgur-elixir/issues/new).

## License
[MIT © Jordan Adams](https://github.com/JordanAdams/imgur-elixir/blob/master/LICENSE)
