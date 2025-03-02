defmodule Namakemonosocial.Repo do
  use Ecto.Repo,
    otp_app: :namakemonosocial,
    adapter: Ecto.Adapters.Postgres
end
