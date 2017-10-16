defmodule Servy.Plugins do
	alias Servy.Conv

	def track(%{status: 404, path: path} = conv) do
      IO.puts "Warning: #{path} not found"
      conv
    end

    def track(%Conv{} = conv), do: conv

    def log(%Conv{} = conv) do
		if Mix.env == :dev do
			IO.inspect conv
		end
		conv
	end

    def rewrite_path(%Conv{path: "/wildlife"} = conv) do
      %{ conv | path: "/wildthings" }
    end

    def rewrite_path(%Conv{} = conv), do: conv

    def handle_file({:ok, content}, conv) do
      %{conv | status: 200, resp_body: content}
    end

    def handle_file({:error, :emoent}, conv) do
      %{conv | status: 404, resp_body: "File not found"}
    end

    def handle_file({:error, reason}, conv) do
      %{conv | status: 500, resp_body: "File error: #{reason}"}
    end

    def format_response(conv) do
        """
        HTTP/1.1 #{Conv.full_status(conv)}\r
        Content-Type: text/html\r
        Content-Length: #{String.length(conv.resp_body)}\r
		\r
        #{conv.resp_body}
        """
    end
end
