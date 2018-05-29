defmodule Waveform.Synth.Manager do
  use GenServer

  @me __MODULE__

  @synth_names %{
    beep: 'sonic-pi-beep',
    bnoise: 'sonic-pi-bnoise',
    chipbass: 'sonic-pi-chipbass',
    chiplead: 'sonic-pi-chiplead',
    chipnoise: 'sonic-pi-chipnoise',
    cnoise: 'sonic-pi-cnoise',
    dark_ambience: 'sonic-pi-dark_ambience',
    dpulse: 'sonic-pi-dpulse',
    dsaw: 'sonic-pi-dsaw',
    dtri: 'sonic-pi-dtri',
    dull_bell: 'sonic-pi-dull_bell',
    fm: 'sonic-pi-fm',
    gnoise: 'sonic-pi-gnoise',
    growl: 'sonic-pi-growl',
    hollow: 'sonic-pi-hollow',
    hoover: 'sonic-pi-hoover',
    mod_dsaw: 'sonic-pi-mod_dsaw',
    mod_fm: 'sonic-pi-mod_fm',
    mod_pulse: 'sonic-pi-mod_pulse',
    mod_saw: 'sonic-pi-mod_saw',
    mod_sine: 'sonic-pi-mod_sine',
    mod_tri: 'sonic-pi-mod_tri',
    noise: 'sonic-pi-noise',
    piano: 'sonic-pi-piano',
    pluck: 'sonic-pi-pluck',
    pnoise: 'sonic-pi-pnoise',
    pretty_bell: 'sonic-pi-pretty_bell',
    prophet: 'sonic-pi-prophet',
    pulse: 'sonic-pi-pulse',
    recorder: 'sonic-pi-recorder',
    saw: 'sonic-pi-saw',
    scope: 'sonic-pi-scope',
    square: 'sonic-pi-square',
    subpulse: 'sonic-pi-subpulse',
    supersaw: 'sonic-pi-supersaw',
    synth_violin: 'sonic-pi-synth_violin',
    tb303: 'sonic-pi-tb303',
    tech_saws: 'sonic-pi-tech_saws',
    tri: 'sonic-pi-tri',
    zawa: 'sonic-pi-zawa'
  }
  @default_synth @synth_names[:prophet]

  defmodule State do
    defstruct(current: nil)
  end

  def set_current_synth(next) do
    GenServer.call(@me, {:set_current, next})
  end

  def current_synth_atom() do
    current_name = GenServer.call(@me, {:current})

    {name, _} =
      Enum.find(@synth_names, fn {key, value} ->
        value == current_name
      end)

    name
  end

  def current_synth() do
    GenServer.call(@me, {:current})
  end

  def start_link(_state) do
    GenServer.start_link(@me, %State{current: @default_synth}, name: @me)
  end

  def init(state) do
    {:ok, state}
  end

  def terminate(_reason, _state), do: nil

  def handle_call({:set_current, new}, _from, state) do
    name = @synth_names[new]
    {:reply, if(name, do: new), %State{state | current: name || state.current}}
  end

  def handle_call({:current}, _from, state) do
    {:reply, state.current, state}
  end
end