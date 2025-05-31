# Signals

Functions that allow interaction with RBXScriptSignals and RBXScriptConnections.

---

## getconnections

> [!NOTE]
> Passing a C-Signal or a foreign signal into **getconnections** should return `Function` and `Thread` as nil into their connections, due to them not being accessible.

Returns the connections of the specified signal.

```luau
function getconnections(signal: RBXScriptSignal): {Connection}
```

### Connection

| Field | Type | Description |
| ----- | ---- | ----------- |
| `Enabled` | boolean | Whether the connection can receive events. |
| `ForeignState` | boolean | Whether the function was connected by a foreign Lua state (i.e. CoreScripts, Actors). |
| `LuaConnection` | boolean | Whether the connection was created in Luau code. |
| `Function` | function? | The function bound to this connection. Nil when `ForeignState` is true, or `LuaConnection` is false. |
| `Thread` | thread? | The thread that created the connection. Nil when `ForeignState` is true, or `LuaConnection` is false. |

| Method | Description |
| ----- | ----------- |
| `Fire(...: any): ()` | Fires this connection with the provided arguments. |
| `Defer(...: any): ()` | [Defers](https://devforum.roblox.com/t/beta-deferred-lua-event-handling/1240569) an event to connection with the provided arguments. |
| `Disconnect(): ()` | Disconnects the connection from the function. |
| `Disable(): ()` | Prevents the connection from firing. |
| `Enable(): ()` | Enables the connection, allowing it to fire. |

### Parameters

- `signal` - The signal whose connections you want to retrieve.

### Examples

```luau
local DummyFolder = Instance.new("Folder")
DummyFolder.ChildAdded:Connect(function() return "Triggered" end)
local connection = getconnections(DummyFolder.ChildAdded)[1] -- First connection in the returned table

print(`{connection.Function()}, {type(connection.Thread)}`) -- Output: Triggered, thread
```

```luau
local CConnection = getconnections(game.Players.LocalPlayer.Idled)[1]
print(`{CConnection.Function}, {CConnection.Thread}`) -- Output: nil, nil
```
---

## firesignal

Fires a signal's Lua connections.

```luau
function firesignal(signal: RBXScriptSignal, ...: any?)
```

### Parameters

- `signal` - The signal to fire.
- `...?` - The wanted arguments to pass into the fired connections.

### Example

```luau
local part = Instance.new("Part")
part.ChildAdded:Connect(function(arg1)
    print(typeof(arg1))
end)

firesignal(part.ChildAdded) -- Output: nil
firesignal(part.ChildAdded, workspace) -- Output: Instance
```

---

## replicatesignal

> [!NOTE]
> For an accurate result from the example, test the function in [our game](https://www.roblox.com/games/122008870888915/boibiobioboiio).
> 
> Also note that some signals might have different namings. For all the current replicable signals, visit [this](https://rubis.numelon.com/view/?scrap=AIOzG1Di7NSLADKE)

If possible, replicates the signal to the server with the provided arguments. The arguments must also match accordingly to the signal itself. To know a signal's arguments, visit [this](https://robloxapi.github.io/ref/).


```luau
function replicatesignal(signal: RBXScriptSignal, ...: any?)
```

### Parameters

- `signal` - The signal to be fired/replicated.
- `...?` - The wanted arguments to pass into `signal`.

### Examples

```luau
local Path = workspace.replicatesigmal
replicatesignal(Path.ClickDetector.MouseActionReplicated, game.Players.LocalPlayer, 0)
task.wait(0.1)
print(game.Players.LocalPlayer:GetAttribute("MouseClickReplicated")) -- Output: true
```

```luau
local Path = game.Players.LocalPlayer.PlayerGui.ScreenGui.Frame
replicatesignal(Path.MouseWheelForward) -- Throws an arg error
replicatesignal(Path.MouseWheelForward, 121) -- Throws an arg error
replicatesignal(Path.MouseWheelForward, 121, 214)
task.wait(0.1)
print(game.Players.LocalPlayer:GetAttribute("MouseWheelForwardReplicated")) -- Output: true
```
