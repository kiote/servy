defmodule Servy.Handler do
	import Servy.Plugins
	import Servy.Parser

    @pages_path Path.expand("../../pages", __DIR__)

	def route(%{method: "GET", path: "/wildthings"} = conv) do
	  %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
	end

	def route(%{method: "GET", path: "/bears"} = conv) do
      %{conv | status: 200, resp_body: "teddy, smokey, paddington"}
    end

    def route(%{method: "GET", path: "/bears/" <> id} = conv) do
      %{conv | status: 200, resp_body: "Bear #{id}"}
    end

	def route(%{method: "GET", path: "/about"} = conv) do
      @pages_path
      |> Path.join('about.html')
      |> File.read
      |> handle_file(conv)
    end

	def route(%{path: path} = conv) do
	  %{conv | status: 404, resp_body: "no #{path} here!"}
	end

    def handle(request) do
      request
      |> parse
      |> rewrite_path
      |> log
      |> route
      |> track
      |> format_response
    end
end

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response



request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response


request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response


request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response





request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response
