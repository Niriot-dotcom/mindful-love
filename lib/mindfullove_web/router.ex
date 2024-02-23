defmodule MindfulloveWeb.Router do
  use MindfulloveWeb, :router

  import MindfulloveWeb.UserAuth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {MindfulloveWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MindfulloveWeb do
    pipe_through(:browser)

    live("/thermostat", ThermostatLive)
    # live "/dashboard", DashboardLive

    resources("/psychologists", PsychologistController)
    get("/", PageController, :home)
    get("/dashboard", DashboardController, :index)

    # users
    # live("/users", UserLive.Index, :index)
    # live("/users/new", UserLive.Index, :new)
    # live("/users/:id/edit", UserLive.Index, :edit)
    # live("/users/:id", UserLive.Show, :show)
    # live("/users/:id/show/edit", UserLive.Show, :edit)

    # psychologists
    live("/psychologists", PsychologistLive.Index, :index)
    live("/psychologists/new", PsychologistLive.Index, :new)
    live("/psychologists/:id/edit", PsychologistLive.Index, :edit)
    live("/psychologists/:id", PsychologistLive.Show, :show)
    live("/psychologists/:id/show/edit", PsychologistLive.Show, :edit)

    # appointments
    live("/appointments", AppointmentLive.Index, :index)
    live("/appointments/new", AppointmentLive.Index, :new)
    live("/appointments/:id/edit", AppointmentLive.Index, :edit)
    live("/appointments/:id", AppointmentLive.Show, :show)
    live("/appointments/:id/show/edit", AppointmentLive.Show, :edit)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MindfulloveWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:mindfullove, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: MindfulloveWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", MindfulloveWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{MindfulloveWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live("/users/register", UserRegistrationLive, :new)
      live("/users/log_in", UserLoginLive, :new)
      live("/users/reset_password", UserForgotPasswordLive, :new)
      live("/users/reset_password/:token", UserResetPasswordLive, :edit)
    end

    post("/users/log_in", UserSessionController, :create)
  end

  scope "/", MindfulloveWeb do
    pipe_through([:browser, :require_authenticated_user])

    live_session :require_authenticated_user,
      on_mount: [{MindfulloveWeb.UserAuth, :ensure_authenticated}] do
      live("/users/settings", UserSettingsLive, :edit)
      live("/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email)
    end
  end

  scope "/", MindfulloveWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)

    live_session :current_user,
      on_mount: [{MindfulloveWeb.UserAuth, :mount_current_user}] do
      live("/users/confirm/:token", UserConfirmationLive, :edit)
      live("/users/confirm", UserConfirmationInstructionsLive, :new)
    end
  end
end
