defmodule Servy.Parser do
	def parse(request) do
      [method, path, _] = request
        |> String.split("\n")
        |> List.first
        |> String.split(" ")
      %Servy.Conv{
		method: method,
        path: path,
        resp_body: "",
        status: nil}
    end
end
