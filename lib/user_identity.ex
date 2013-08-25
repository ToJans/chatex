defmodule UserIdentity do
  @moduledoc """
  This module identifies users.
  It provides a consistent textual and visual representation of a user.

  For now it does not do any authentication at all.
  """

  @doc """
  A `UserIdentity.User` is record  that represents a user. 

  It contains the following properties for a user identity:
  - handle: the original handle that was used to identify the user
  - display name: the name one can use for displaying the user
  - avatar url: the url of the image that represents the user
  """
  defrecord User, handle: nil, display_name: nil, avatar_url: nil


  @doc """
  Converts a email addres into an identified user using Gravatars.

  For now it does not do any authentication.

  ## Examples

  	iex> UserIdentity.from_email("Tom@corebvba.be")
  	UserIdentity.new(handle: "Tojans", display_name: "Tom Janssens", avatar_url: "http://1.gravatar.com/avatar/df6affd04f619165417f87f07028f068")

  """
  def from_handle(email) do
  	nil
  end


end