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

  @doc """
  Gets the gravatar displayname,profile pic and normalized email address
  for a given email address

  ## Example

  	iex> Gravatar.email_to_profile("tom@corebvba.be")
  	[display_name: "Tom Janssens",
    avatar_url: "http://1.gravatar.com/avatar/df6affd04f619165417f87f07028f068",
    email: "tom@corebvba.be"]
  """
  def email_to_profile(email) do
  	keyword_list = [email: normalize_email(email)]
  	email
  		|> email_to_url
  		|> http_download
  		|> merge_profile_info_in_keyword_list(keyword_list)
  end

  defp http_download(url) do
  	response = url |> String.to_char_list!() |> :httpc.request()
  	{:ok,{_status,_headers,body}} = response
  	body
  end

  defp merge_profile_info_in_keyword_list(xml,result) do
  	{:ok, data, _whitespace} = :erlsom.simple_form(xml)
  	merge_response(data,result)
  end

  defp merge_response({'response',[],[{'entry',[],elements}]},result) do 
  	merge_entry_elements(elements,result)
  end

  defp merge_response({'response',[],[{'error',[],['User not found']}]},result) do 
  	email = result[:email]
  	hash = gravatar_hash(email)
  	Keyword.merge(result,[display_name: email,avatar_url: "http://1.gravatar.com/avatar/#{hash}"])
  end

  defp merge_entry_elements([],result) do
  	result
  end

  defp merge_entry_elements([element|remainder],result) do
  	result = merge_element(element,result)
  	merge_entry_elements(remainder,result)
  end

  defp merge_element({'thumbnailUrl',[],[url]},result) do
  	Keyword.merge(result,[avatar_url: String.from_char_list!(url)])
  end

  defp merge_element({'displayName',[],[displayname]},result) do
  	Keyword.merge(result,[display_name: String.from_char_list!(displayname)])
  end

  defp merge_element(_,result) do
  	result
  end
end