# WebSocket

The **WebSocket** class provides a simple interface for sending and receiving data over a WebSocket connection.

## WebSocket.connect

```lua
function WebSocket.connect(url: string): WebSocket
```

---

### `WebSocket` Methods

| Method | Description |
| ------ | ----------- |
| `Send(message: string): ()` | Sends a message over the WebSocket connection. |
| `Close(): ()` | Closes the WebSocket connection. |

### `WebSocket` Events

| Event | Description |
| ----- | ----------- |
| `OnMessage(message: string): ()` | Triggered when a message is received over the WebSocket connection. |
| `OnClose(): ()` | Triggered when the WebSocket connection closes. |

---

### Example - `WebSocket.connect`

```luau
local ws = WebSocket.connect("ws://echo.websocket.events")
print(ws) -- Output: WebSocket
```

### Example - `OnMessage, Send`

```luau
local ws = WebSocket.connect("ws://echo.websocket.events")
ws.OnMessage:Connect(function(message)
    print(message)
end)
ws:Send("Hello") -- Output: Hello
```

### Example - `OnClose, Close`

```luau
local ws = WebSocket.connect("ws://echo.websocket.events")
ws.OnClose:Connect(function()
    print("Closed")
end)
ws:Close() -- Output: Closed
```
