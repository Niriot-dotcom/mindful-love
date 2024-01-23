defmodule Mindfullove.Repo do
  use Ecto.Repo,
    otp_app: :mindfullove,
    adapter: Ecto.Adapters.Postgres
end
