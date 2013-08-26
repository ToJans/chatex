defmodule Gravatar do
  @moduledoc """
  Interfaces with the Gravatar web service
  """

  @doc """
  Gets the gravatar url for a certain email address

  ## Example

  	iex> Gravatar.email_to_url("tom@corebvba.be")
  	"http://www.gravatar.com/df6affd04f619165417f87f07028f068.xml"
  """
  def email_to_url(email) do
  	hashcode = gravatar_hash(email)
  	"http://www.gravatar.com/#{hashcode}.xml"
  end

  defp gravatar_hash(email) do
  	email
  		|> normalize_email
  		|> :crypto.md5
  		|> binary_to_hex
  end

  defp normalize_email(email) do
  	email |> String.strip |> String.downcase 
  end

  defp binary_to_hex(b) do
  	b	|> :binary.bin_to_list
  		|> Enum.map_join(&byte_to_hex/1)
  		|> String.downcase
  end

  defp byte_to_hex(b) do
  	integer_to_list(b,16)
  end

end