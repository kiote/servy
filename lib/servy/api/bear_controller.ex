defmodule Servy.Api.BearController do

	def index(conv) do
		json =
			Servy.Wildthings.list_bears()
			|> Poison.encode!

		%{ conv | status: 200, content_type: "application/json", resp_body: json}
	end

end
