defmodule BanditSse.Router do
  use Plug.Router

  @msg_interval_ms 1000

  plug(Corsica, origins: "*")
  plug(Plug.Logger)
  plug(Plug.Static, at: "/", from: :bandit_sse)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_file(conn, 200, Application.app_dir(:bandit_sse, "priv/static/index.html"))
  end

  get "/event-stream" do
    # Process.flag(:trap_exit, true)

    {:ok, conn} =
      conn
      |> put_resp_header("content-type", "text/event-stream")
      |> put_resp_header("cache-control", "no-cache")
      |> send_chunked(200)
      |> chunk("data: somerandomdata\n\n")

    stream_msgs(conn)
    |> send_resp()
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

  defp stream_msgs(conn) do
    Process.send_after(self(), :send_msg, @msg_interval_ms)

    receive do
      :send_msg ->
        dbg(:sending_msg)
        {:ok, conn} = chunk(conn, "data: somerandomdata\n\n")
        stream_msgs(conn)
    end
  end
end
