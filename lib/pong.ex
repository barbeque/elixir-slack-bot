defmodule Pong do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # load slack token from config.exs
    slack_token = Application.get_env(:pong, Pong.Slack)[:token]

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Pong.Worker, [arg1, arg2, arg3]),
        worker(Pong.Slack, [slack_token, :whatever])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pong.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
