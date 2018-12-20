defmodule Waveform.BeatTest do
  use ExUnit.Case
  alias Waveform.Beat, as: Subject

  setup do
    Subject.reset()

    on_exit(fn ->
      Subject.reset()
    end)

    :ok
  end

  test "creates a beat handler" do
    Subject.on_beat(:bass, 1, fn -> IO.inspect("foo") end)
    Subject.on_beat(:bass, 2, fn -> IO.inspect("bar") end)

    %Subject.State{
      callbacks: callbacks
    } = state = Subject.state()

    # IO.inspect(state)

    assert Enum.count(callbacks) == 1
  end
end
