defmodule UserIdentityTest do
  use ExUnit.Case

  test "get an existing gravatar" do
  	assert UserIdentity.from_handle("tom@corebvba.be")
  	 == UserIdentity.User.new(
  	 	handle: "Tojans", 
  	 	display_name: "Tom Janssens", 
  	 	avatar_url: "http://1.gravatar.com/avatar/df6affd04f619165417f87f07028f068")
  end

end
