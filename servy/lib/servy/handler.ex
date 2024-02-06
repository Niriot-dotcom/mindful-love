defmodule Servy.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv  = route(conv)
    # format_response(conv)

    # in a more efficient way, transforming the data
    request
    |> parse
    |> log
    |> route
    |> format_response
  end

  # functions
  def log(conv), do: IO.inspect conv
  # def log(conv) do
  #   IO.inspect conv
  # end

  def parse(request) do
    # TODO: Parse the request string into a map:
    # first_line = request |> String.split("\n") |> List.first

    # # parts = String.split(first_line, ' ')
    # [method, path, _] = String.split(first_line, " ")
    # %{ method: method, path: path, resp_body: "" }

    # efficient way using pipelines
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first
      |> String.split(" ")
    %{
      method: method,
      path: path,
      resp_body: "",
      status: nil
    }
  end

  # def route(conv) do
  #   # TODO: Create a new map that also has the response body:
  #   # conv = %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers" }

  #   %{ conv | resp_body: "Bears, Lions, Tigers, Birds" }
  # end
  def route(conv) do
    route(conv, conv.method, conv.path)
  end
  def route(conv, "GET", "/wildthings") do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers, Birds" }
  end
  def route(conv, "GET", "/names") do
    %{conv | status: 200, resp_body: "name 1, name 2, name 3"}
  end
  def route(conv, "GET", "/names/" <> id) do
    %{conv | status: 200, resp_body: "Name #{id}"}
  end
  def route(conv, "DELETE", "/names/" <> id) do
    %{conv | status: 200, resp_body: "Name #{id} will be deleted."}
  end
  def route(conv, method, path) do
    %{conv | status: 404, resp_body: "#{method} #{path} endpoint unavailable."}
  end

  def format_response(conv) do
    # IO.puts conv.resp_body

    # TODO: Use values in the map to create an HTTP response string:
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
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end

# GET /wildthings
request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
"""

response = Servy.Handler.handle(request)
IO.puts response

# GET /names
request = """
GET /names HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
"""

response = Servy.Handler.handle(request)
IO.puts response

# POST /
request = """
POST /names HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
"""

response = Servy.Handler.handle(request)
IO.puts response

# endpoint with id => GET /names/1
request = """
GET /names/Paty HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
"""

response = Servy.Handler.handle(request)
IO.puts response

# DELETE /names/{id}
request = """
DELETE /names/Paty HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
"""

response = Servy.Handler.handle(request)
IO.puts response
