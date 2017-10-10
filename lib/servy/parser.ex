defmodule Servy.Parser do
	alias Servy.Conv

	def parse(request) do
		[top, param_string] = String.split(request, "\n\n")

		[request_line | header_lines] = String.split(top, "\n")

		[method, path, _] = String.split(request_line, " ")

		%Conv{
			method: method,
			path: path,
			resp_body: "",
			status: nil,
			params: parse_params(param_string)
		}
	end

	def parse_params(params_string) do
		params_string |> String.trim |> URI.decode_query
	end
end
