defmodule Waveform.Application do
  use Application

  def start(_type, _args) do

    children = [
      { Waveform.Lang, nil },
      { Waveform.OSC, nil },
      { Waveform.Synth, nil }
    ]

    opts = [strategy: :one_for_one, name: Waveform.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
