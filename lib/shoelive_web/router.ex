defmodule ShoeliveWeb.Router do
  use ShoeliveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ShoeliveWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ShoeliveWeb do
    pipe_through :browser

    live "/", DemoLive
    live "/testing", TestingLive
  end
end
