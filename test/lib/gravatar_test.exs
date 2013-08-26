defmodule GravatarTest do
  use ExUnit.Case
  doctest Gravatar

  setup_all do
  	:inets.start
  end

  test "return a gravatar url for a normalized email address" do
  	assert Gravatar.email_to_url("tom@corebvba.be") == 
  		"http://www.gravatar.com/df6affd04f619165417f87f07028f068.xml"
  end

  test "return a gravatar url for an unnormalized email address" do
  	assert Gravatar.email_to_url("  Tom@Corebvba.BE   ") == 
  		"http://www.gravatar.com/df6affd04f619165417f87f07028f068.xml"
  end

  test "return a user profile for an email address" do
  	assert Gravatar.email_to_profile("tom@corebvba.be") ==
  		[ display_name: "Tom Janssens",
 		  avatar_url: "http://1.gravatar.com/avatar/df6affd04f619165417f87f07028f068",
 		  email: "tom@corebvba.be"]
  end

  teardown_all do
  	:inets.stop
  end
end