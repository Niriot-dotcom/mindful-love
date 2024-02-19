defmodule BmvpWeb.Router do
  use BmvpWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BmvpWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BmvpWeb do
    pipe_through :browser

    get "/", PageController, :home

    # users
    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit
    live "/users/:id", UserLive.Show, :show
    live "/users/:id/show/edit", UserLive.Show, :edit

    # psychologists
    live "/psychologists", PsychologistLive.Index, :index
    live "/psychologists/new", PsychologistLive.Index, :new
    live "/psychologists/:id/edit", PsychologistLive.Index, :edit
    live "/psychologists/:id", PsychologistLive.Show, :show
    live "/psychologists/:id/show/edit", PsychologistLive.Show, :edit

    # appointments
    live "/appointments", AppointmentLive.Index, :index
    live "/appointments/new", AppointmentLive.Index, :new
    live "/appointments/:id/edit", AppointmentLive.Index, :edit
    live "/appointments/:id", AppointmentLive.Show, :show
    live "/appointments/:id/show/edit", AppointmentLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", BmvpWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:bmvp, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BmvpWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
