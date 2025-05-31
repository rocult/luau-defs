# Instances

The **Instance** library allows interaction with game objects.

---

## getinstances

> [!NOTE]
> **getinstances** should be able to return instances outside of `game`.

Returns a list of all instances referenced by the client.

```luau
function getinstances(): { Instance }
```

### Example

```luau
local DummyPart = Instance.new("Part")

for IndexInstance, ValueInstance in pairs(getnilinstances()) do
    if ValueInstance == DummyPart then
        print(`Found the wanted nil instance: {DummyPart}`)
    end
end
```

---

## getnilinstances

Returns a list of instances that have their parent property set to `nil`.

```luau
function getnilinstances(): { Instance }
```

### Example

```luau
local DummyPart = Instance.new("Part")
DummyPart.Parent = nil

for IndexNil, ValueNil in pairs(getnilinstances()) do
    if ValueNil == DummyPart then
        print(`Found the wanted nil instance: {DummyPart}`)
    end
end
```

---

## cloneref

Returns a copy of the Instance where the copy should not be equal to the original Instance it was cloned from.

```luau
function cloneref<T>(object: T & Instance): T
```

### Parameter

- `object` - The Instance to clone.

### Example

```luau
local ClonedPlayer = cloneref(game:GetService("Players").LocalPlayer)
local Player = game:GetService("Players").LocalPlayer
print(Player == ClonedPlayer) -- Output: false
```

---

## compareinstances

Checks if two instances are equal, used for clonerefed instances as normal equality check fails on them.

```luau
function compareinstances(object1: Instance, object2: Instance): boolean
```

### Parameter

- `object1` - The instance to check.
- `object2` - The instance to check the first instance with.

### Example

```luau
print(compareinstances(game, game)) -- Output: true
print(compareinstances(game, workspace)) -- Output: false
print(compareinstances(game, cloneref(game))) -- Output: true
print(game == cloneref(game)) -- Output: false
```

---

## gethui

> [!NOTE]
> This is an implementation detail; as a regular scripter, you may ignore this!
> The container in which the elements sit in, should not be findable directly. For example, a descendant for loop through CoreGui shouldn't find the container. Although if found directly, the container's parent should be clonereffed.
>
> If you're going for a different approach from the one above, make sure the container is able to be found in the registry.

Returns a hidden UI container that minimalizes most detection methods.

```luau
function gethui(): Instance
```

### Example

```luau
local UI = Instance.new("ScreenGui")
UI.Parent = gethui()
print(gethui().ScreenGui) -- Output: "ScreenGui"
```

---

## getcallbackvalue

Returns the function assigned to an object's callback property, which is otherwise inaccessible through standard indexing.

```luau
function getcallbackvalue(object: Instance, property: string): (...any) -> (...any)
```

### Parameters

- `object` - The object to get the callback property from.
- `property` - The name of the callback property.

### Example

```luau
local DummyBindableFunction = Instance.new("BindableFunction")
local DummyRemoteFunction = Instance.new("RemoteFunction")

DummyBindableFunction.OnInvoke = function()
    print("Callback")
end

getcallbackvalue(DummyBindableFunction, "OnInvoke")() -- Output: Callback
getcallbackvalue(DummyRemoteFunction, "OnClientInvoke") -- Throws an error
```

---

## fireclickdetector

> [!NOTE]
> It's not recommended to implement this function in luau. Doing so will expose you to easy detections.

Triggers a specified event on a `ClickDetector`. The event parameter defaults to **MouseClick** if not defined. Not providing the distance will default to infinite.

```luau
function fireclickdetector(object: ClickDetector, distance: number?, event: string?): ()
```

Selectable Events: 'MouseClick', 'RightMouseClick', 'MouseHoverEnter', 'MouseHoverLeave'.

### Parameters

- `object` - The ClickDetector to trigger.
- `distance` - Distance to trigger the ClickDetector from.
- `event` - The chosen event to trigger the detector with.

### Example

```luau
local ClickDetector = Instance.new("ClickDetector")

ClickDetector.MouseClick:Connect(function()
    print("Fired")
end)

fireclickdetector(ClickDetector, 32) -- This will not output
```

```luau
local ClickDetector = Instance.new("ClickDetector")

ClickDetector.MouseClick:Connect(function(player)
    print(`{player.Name} Fired M1`)
end)

ClickDetector.RightMouseClick:Connect(function(player)
    print(`{player.Name} Fired M2`)
end)

ClickDetector.MouseHoverEnter:Connect(function(player)
    print(`{player.Name} Fired HoverEnter`)
end)

ClickDetector.MouseHoverLeave:Connect(function(player)
    print(`{player} Fired HoverLeave`)
end)

fireclickdetector(ClickDetector, 0, "MouseClick") -- Output: Player Fired M1
fireclickdetector(ClickDetector, 0, "RightMouseClick") -- Output: Player Fired M2
fireclickdetector(ClickDetector, 0, "MouseHoverEnter") -- Output: Player Fired HoverEnter
fireclickdetector(ClickDetector, 0, "MouseHoverLeave") -- Output: Player Fired HoverLeave
```

---

## fireproximityprompt

> [!NOTE]
> It's not recommended to implement this function in luau. Doing so will expose you to easy detections.


Triggers a `ProximityPrompt` instantly, regardless of distance or duration.

```luau
function fireproximityprompt(object: ProximityPrompt): ()
```

### Parameter

- `object` - The ProximityPrompt to fire.

### Example

```luau
local DummyPart = Instance.new("Part", workspace)
local DummyProximityPrompt = Instance.new("ProximityPrompt")
DummyProximityPrompt.Parent = DummyPart

DummyProximityPrompt.Triggered:Connect(function()
    print("Triggered")
end)

fireproximityprompt(DummyProximityPrompt) -- Output: Triggered
```

---

## firetouchinterest

> [!NOTE]
> This is an implementation detail; as a regular scripter, you may ignore this!
> 
> It's not recommended to implement this function in luau. Doing so will expose you to easy detections. Additionally, when firing the touch interests, the function should yield, in order to allow the next one to fire with no problems.
> 
> Both numbers and booleans should be supported for the toggle (1 being true, 0 being false)

Triggers a `Touched` event on a `BasePart` with the other wanted part.

```luau
function firetouchinterest(part: BasePart, part2: BasePart, toggle: boolean | number): ()
```

### Parameters

- `part` - The part initiating the touch.
- `part2` - The part to be touched.
- `toggle` - Determines the touching event trigger.
    - `false` - Starts the **Touched** event. (Touch, internally).
    - `true` - Ends the **Touched** event. (Untouch, internally).

### Example

```luau
local DummyPart = Instance.new("Part")
DummyPart.CFrame = CFrame.new(0, -200, 0)
DummyPart.Anchored = true
DummyPart.Parent = workspace

DummyPart.Touched:Connect(function(arg1)
    print(arg1:IsDescendantOf(game.Players.LocalPlayer.Character))
end)

firetouchinterest(game.Players.LocalPlayer.Character.Head, DummyPart, false)
task.wait(0.5)
firetouchinterest(game.Players.LocalPlayer.Character.Head, DummyPart, true)
```
