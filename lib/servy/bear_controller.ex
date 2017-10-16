defmodule Servy.BearController do
	alias Servy.Wildthings

	def index(conv) do
		items =
			Wildthings.list_bears()
			|> Enum.map(fn(b) -> "<li>#{b.name} - #{b.type}</li>" end)
			|> Enum.join
		%{conv | status: 200, resp_body: "<ul>#{items}</ul>"}
	end

	def show(conv, %{"id" => id}) do
		%{conv | status: 200, resp_body: "Bear #{id}"}
	end

	def post(conv, %{"name" => name, "type" => type} = params) do
		%{ conv | status: 201,
			resp_body: "Created a #{type} bear named #{name}" }
	end
end
