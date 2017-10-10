defmodule Servy.Plugins do
	def track(%{status: 404, path: path} = conv) do
      IO.puts "Warning: #{path} not found"
      conv
    end

    def track(conv), do: conv

    def log(conv), do: IO.inspect conv

    def rewrite_path(%{path: "/wildlife"} = conv) do
      %{ conv | path: "/wildthings" }
    end

    def rewrite_path(conv), do: conv

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
        HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
        Content-Type: text/html
        Content-Length: #{String.length(conv.resp_body)}

        #{conv.resp_body}
        """
    end

    defp status_reason(code) do
      %{
          200 => "OK",
          201 => "Created",
          401 => "Unauthorized",
          403 => "Forbidden",
          404 => "Not found",
          500 => "Internal server error"
      }[code]
    end
end
