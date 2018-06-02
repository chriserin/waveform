defmodule Waveform.OSC do
  use GenServer

  alias Waveform.OSC.Node, as: Node
  alias Waveform.OSC.Group, as: Group

  @me __MODULE__
  @synth_folder __ENV__.file
                |> Path.dirname()
                |> Path.join("../../synthdefs/compiled")
                |> to_charlist

  @s_new '/s_new'
  @g_new '/g_new'
  @g_deepFree '/g_deepFree'
  @notify '/notify'
  @d_loadDir '/d_loadDir'
  @n_go '/n_go'
  @n_end '/n_end'

  @yes 1

  @add_actions %{
    # add the new group to the the head of the group specified by the add target ID.
    head: 0,
    # add the new group to the the tail of the group specified by the add target ID.
    tail: 1,
    # add the new group just before the node specified by the add target ID.
    before: 2,
    # add the new group just after the node specified by the add target ID.
    after: 3,
    # the new node replaces the node specified by the add target ID. The target node is freed.
    replace: 4
  }

  defmodule State do
    defstruct(
      socket: nil,
      pid: nil,
      host: '127.0.0.1',
      host_port: 57110,
      udp_port: 57111
    )
  end

  def setup do
    load_synthdefs()
    request_notifications()
  end

  def new_synth(name, id, action, group_id, args) do
    send_command([@s_new, name, id, @add_actions[action], group_id | args])
  end

  def delete_group(id) when is_number(id), do: delete_group([id])

  def delete_group(ids) do
    send_command([@g_deepFree | ids])
  end

  def new_group(id, action, parent) do
    send_command([@g_new, id, @add_actions[action], parent])
  end

  def request_notifications do
    send_command([@notify, @yes])
  end

  def load_synthdefs do
    {:ok, cwd} = File.cwd()
    send_command([@d_loadDir, @synth_folder])
  end

  def send_command(command) do
    GenServer.cast(@me, {:command, command})
  end

  def start_link(_opts) do
    GenServer.start_link(@me, %State{}, name: @me)
  end

  def init(state) do
    {:ok, socket} = :gen_udp.open(state.udp_port, [:binary, {:active, false}])

    Waveform.Lang.start_server()

    pid = spawn(fn -> udp_receive(socket) end)

    state = %State{
      socket: socket,
      pid: pid
    }

    {:ok, state}
  end

  def terminate(_reason, state) do
    :gen_udp.close(state.socket)
    Process.exit(state.pid, :kill)
  end

  def handle_cast({:command, command}, state) do
    osc(state, command)
    {:noreply, state}
  end

  defp udp_receive(socket) do
    case :gen_udp.recv(socket, 0, 1000) do
      {:ok, {_ip, _port, the_message}} ->

        message = :osc.decode(the_message)

        # IO.inspect({"osc message:", message})

        case message do
          {:cmd, [@n_go, 1 | _]} ->
            Group.setup()

          {:cmd, [@n_go, node_id | _]} ->
            Node.activate_node(node_id)

          {:cmd, [@n_end, node_id | _]} ->
            Node.deactivate_node(node_id)

          _ ->
            nil
        end

        udp_receive(socket)

      {:error, :timeout} ->
        udp_receive(socket)
    end
  end

  defp osc(state, command) do
    # IO.inspect({"osc send:", command})
    :ok = :gen_udp.send(state.socket, state.host, state.host_port, :osc.encode(command))
  end
end
