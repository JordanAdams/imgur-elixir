defmodule Imgur.Model.Vote do
  defstruct [:ups, :downs]

  @type t :: %Imgur.Model.Vote{ups: integer, downs: integer}

  @spec schema() :: %Imgur.Model.Vote{}
  def schema(), do: %Imgur.Model.Vote{}
end
