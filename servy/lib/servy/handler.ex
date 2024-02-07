defmodule Servy.Handler do
  # modules
  require Logger

  def handle(request) do
    # conv = parse(request)
    # conv  = route(conv)
    # format_response(conv)

    # in a more efficient way, transforming the data
    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> track
    |> format_response
  end

  # functions
  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end
  def rewrite_path(%{path: "/names?id=" <> id} = conv) do
    %{conv | path: "/names/" <> id}
  end
  def rewrite_path(conv), do: conv

  def track(%{status: 404, path: path} = conv) do
    IO.puts "Warning: #{path} is not found :c"
    conv
  end
  def track(conv), do: conv

  def log(conv), do: IO.inspect conv

  def parse(request) do
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
  def route(%{ method: "GET", path: "/wildthings" } = conv) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers, Birds" }
  end
  def route(%{ method: "GET", path: "/names" } = conv) do
    %{conv | status: 200, resp_body: "name 1, name 2, name 3"}
  end
  # def route(%{ method: "GET", path: "/about" } = conv) do
  #   # get absolute path
  #   file =
  #     Path.expand("../../pages", __DIR__)
  #     |> Path.join("about.html")

  #   # read file
  #   case File.read(file) do
  #     {:ok, content} ->
  #       %{conv | status: 200, resp_body: content }

  #     {:error, reason} ->
  #       %{conv | status: 500, resp_body: "Error: #{reason}" }
  #   end
  # end
  def route(%{ method: "GET", path: "/about" } = conv) do
      Path.expand("../../pages", __DIR__)
      |> Path.join("about.html")
      |> File.read()
      |> handle_file(conv)
  end
  def route(%{ method: "GET", path: "/bears/new" } = conv) do
      Path.expand("../../pages", __DIR__)
      |> Path.join("form.html")
      |> File.read
      |> handle_file(conv)
  end
  def route(%{ method: "GET", path: "/pages/" <> filename } = conv) do
    Path.expand("../../pages", __DIR__)
    |> Path.join(filename <> ".html")
    |> File.read
    |> handle_file(conv)
  end
  def route(%{ method: "GET", path: "/names" <> id } = conv) do
    %{conv | status: 200, resp_body: "Name #{String.replace(id, "/", "")}"}
  end
  def route(%{ method: "DELETE", path: "/names" <> id } = conv) do
    %{conv | status: 200, resp_body: "Name #{id} will be deleted."}
  end
  def route(%{ method: method, path: path } = conv) do
    %{conv | status: 404, resp_body: "#{method} #{path} endpoint unavailable."}
  end

  def handle_file({:ok, content}, conv) do
    %{conv | status: 200, resp_body: content }
  end
  def handle_file({:error, :enoent}, conv) do
    %{conv | status: 404, resp_body: "File not found." }
  end
  def handle_file({:error, reason}, conv) do
    %{conv | status: 500, resp_body: "Error: #{reason}" }
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
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end

# # GET /wildthings
# request = """
# GET /wildthings HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handle(request)
# IO.puts response

# # GET /names
# request = """
# GET /names HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handle(request)
# IO.puts response

# # POST /
# request = """
# POST /names HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handle(request)
# IO.puts response

# # endpoint with id => GET /names/1
# request = """
# GET /names/Paty HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """
# response = Servy.Handler.handle(request)
# IO.puts response

# # DELETE /names/{id}
# request = """
# DELETE /names/Paty HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """

# response = Servy.Handler.handle(request)
# IO.puts response

# # GET /wildlife
# request = """
# GET /wildlife HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """
# response = Servy.Handler.handle(request)
# IO.puts response

# rewrite if contains id
# request = """
# GET /names?id=2 HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """
# response = Servy.Handler.handle(request)
# IO.puts response

# read a file
# request = """
# GET /about HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """
# response = Servy.Handler.handle(request)
# IO.puts response

# read form file
# request = """
# GET /bears/new HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*
# """
# response = Servy.Handler.handle(request)
# IO.puts response

# read generic file
request = """
GET /pages/contact HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
"""
response = Servy.Handler.handle(request)
IO.puts response
