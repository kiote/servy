defmodule Servy.Handler do
	import Servy.Plugins
	import Servy.Parser

	alias Servy.Conv
	alias Servy.BearController

	@pages_path Path.expand("../../pages", __DIR__)

	def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
	  %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
	end

	def route(%Conv{method: "GET", path: "/api/bears"} = conv) do
		Servy.Api.BearController.index(conv)
	end

	def route(%Conv{method: "GET", path: "/bears"} = conv) do
		BearController.index(conv)
	end

	def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
		params = Map.put(conv.params, "id", id)
		BearController.show(conv, params)
	end

	def route(%Conv{method: "POST", path: "/bears"} = conv) do
		BearController.post(conv, conv.params)
	end

	def route(%Conv{method: "GET", path: "/about"} = conv) do
      @pages_path
      |> Path.join('about.html')
      |> File.read
      |> handle_file(conv)
    end

	def route(%Conv{path: path} = conv) do
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
