defmodule Servy.Handler do
    def handle(request) do
      request 
      |> parse 
      |> route 
      |> format_response
    end

    def parse(request) do
      conv = %{method: "GET", path: "/wildthings", resp_body: ""}
    end

    def route(conv) do
      conv = %{method: "GET", path: "/wildthings", resp_body: "Bears, lions, tigers"}
    end

    def format_response(conv) do
        """
        HTTP/1.1 200 OK
        Content-Type: text/html
        Content-Length: 20

        Bears, lions, tigers
        """
    end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response