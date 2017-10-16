defmodule HandlerTest do
	use ExUnit.Case

	import Servy.Handler, only: [handle: 1]

	test "GET /wildthigs" do
		request = """
		GET /wildthings HTTP/1.1\r
		Host: example.com\r
		User-Agent: ExampleBrowser/1.0\r
		Accept: */*\r
		\r
		"""

		response = handle(request)

		assert response == """
		HTTP/1.1 200 OK\r
		Content-Type: text/html\r
		Content-Length: 20\r
		\r
		Bears, Lions, Tigers
		"""
	end

	test "GET /bears" do
		request = """
		GET /bears HTTP/1.1\r
		Host: example.com\r
		User-Agent: ExampleBrowser/1.0\r
		Accept: */*\r
		\r
		"""

		response = handle(request)

		assert response == """
		HTTP/1.1 200 OK\r
		Content-Type: text/html\r
		Content-Length: 81\r\n\r
		<ul><li>Teddy - Brown</li><li>Smokey - Black</li><li>Paddington - Brown</li></ul>
		"""
	end

	test "GET /api/bears" do
		request = """
		GET /api/bears HTTP/1.1\r
		Host: example.com\r
		User-Agent: ExampleBrowser/1.0\r
		Accept: */*\r
		\r
		"""

		response = handle(request)

		assert response == """
		HTTP/1.1 200 OK\r
		Content-Type: application/json\r
		Content-Length: 183\r\n\r
		[{\"type\":\"Brown\",\"name\":\"Teddy\",\"id\":1,\"hibernating\":true},{\"type\":\"Black\",\"name\":\"Smokey\",\"id\":2,\"hibernating\":false},{\"type\":\"Brown\",\"name\":\"Paddington\",\"id\":3,\"hibernating\":false}]
		"""
	end
end

# request = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
#
# """
#
# response = Servy.Handler.handle(request)
# IO.puts response
# #
# #
# #
# # request = """
# # GET /bears HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*
# #
# # """
# #
# # response = Servy.Handler.handle(request)
# # IO.puts response
# #
# #
# # request = """
# # GET /bigfoot HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*
# #
# # """
# #
# # response = Servy.Handler.handle(request)
# # IO.puts response
# #
# #
# # request = """
# # GET /bears/1 HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*
# #
# # """
# #
# # response = Servy.Handler.handle(request)
# # IO.puts response
# #
# #
# #
# #
# #
# # request = """
# # GET /about HTTP/1.1
# # Host: example.com
# # User-Agent: ExampleBrowser/1.0
# # Accept: */*
# #
# # """
# #
# # response = Servy.Handler.handle(request)
# # IO.puts response
#
#
# request = """
# POST /bears HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# Content-Type: application/x-www-form-unicoded
# Content-Length: 21
#
# name=Baloo&type=Browny
# """
#
# response = Servy.Handler.handle(request)
# IO.puts response
