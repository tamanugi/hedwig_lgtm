defmodule HedwigLgtm.Responders.Lgtm do
  use Hedwig.Responder

  @lgtm_url "https://lgtm.in/g/"

  @usage """
  <text> (lgtm) - Replies with a random Borat image.
  """
  respond ~r/lgtm(?: *)(.*)$/i, msg do

    to_username = case msg do
             %{matches: %{1 => matches}} when matches != "" -> matches
             %{user: user} -> user
           end

    lgtm_image_url = fetch() |> find_image_url

    reply %{msg | user: to_username}, lgtm_image_url

  end

  defp fetch do
    headers = ["Accept": "application/json"]
    opts = [ hackney: [:insecure], follow_redirect: true ]

    HTTPoison.get(@lgtm_url, headers, opts)
    |> handle_response
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  defp handle_response({_, %{status_code: _status, body: _body}}) do
    {:error}
  end

  defp find_image_url({:ok, json}) do
    json
    |> Map.get("actualImageUrl")
  end

  defp find_image_url({:error}) do
    "Error Occured."
  end
end
