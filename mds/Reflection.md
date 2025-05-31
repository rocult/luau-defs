# Reflection

Functions that allow to **modify/access** hidden/non-scriptable properties of Instances.

---

## gethiddenproperty

> [!WARNING]
> Many executors may implement this function by using `setscriptable`, which is discouraged due to detection vectors and/or limitations coming with `setscriptable` itself.

Returns the hidden, non-scriptable properties value no matter its type, such as `BinaryString`, `SharedString` and `SystemAddress`. A boolean will also be returned, indicating if the property is hidden or not.


```luau
function gethiddenproperty(instance: Instance, property_name: string): (any, boolean)
```

### Parameters

- `instance` - The instance that contains the property.
- `property_name` - The name of the property to be read.

### Example

```luau
local part = Instance.new("Part")
print(gethiddenproperty(part, "Name")) -- Output: "Part", false
print(gethiddenproperty(part, "DataCost")) -- Output: 20, true
```

---

## sethiddenproperty

> [!WARNING]
> Many executors may implement this function by using `setscriptable`, which is discouraged due to detection vectors and/or limitations coming with `setscriptable` itself.


Sets the hidden, non-scriptable property's value no matter its type, such as `BinaryString`, `SharedString` and `SystemAddress`. A boolean will also be returned, indicating if the property is hidden or not.

Avoids detections and errors that can happen by just using `setscriptable` to set the property

```luau
function sethiddenproperty(instance: Instance, property_name: string, property_value: any): boolean
```

### Parameters

- `instance` - The instance that contains the property.
- `property_name` - The name of the property to be assigned.
- `property_value` - The value to which the property should be set.

### Example

```luau
local part = Instance.new("Part")
print(gethiddenproperty(part, "DataCost")) -- Output: 20, true
sethiddenproperty(part, "DataCost", 100)
print(gethiddenproperty(part, "DataCost")) -- Output: 100, true
```

---

## setscriptable

Sets a hidden property scriptable, which means you will be able to index the hidden properties as if they weren't hidden.

> [!WARNING]
> This function exposes detection vectors, as game scripts can check whether they can also index those properties.

> [!NOTE]
> This function is limited, meaning you won't be able to use it on all the hidden properties; use `gethiddenproperty` for those instead.

```luau
function setscriptable(object: Instance, property: string, state: boolean): boolean | nil
```

### Parameters

- `object` - The instance's property to set scriptable.
- `property` - The wanted property to set scriptable.
- `state` - Whether to turn it scriptable (true) or non-scriptable (false). 

### Example

```luau
local a = Instance.new("Part")
setscriptable(a, "BottomParamA", true)
print(a.BottomParamA) -- Output: -0.5
setscriptable(a, "BottomParamA", false)
print(a.BottomParamA) -- Throws an error
```

---

## checkcaller

Determines whether the function was called from the executor's thread or not.

```luau
function checkcaller(): boolean
```

### Example

```luau
local FromCaller
local _; _ = hookmetamethod(game, "__namecall", function(...)
    if FromCaller ~= true then
        FromCaller = checkcaller()
    end
    return _(...)
end)

task.wait(0.09) -- Step a bit
hookmetamethod(game, "__namecall", _)

print(FromCaller) -- Output: false
print(checkcaller()) -- Output: true
```

---

## setthreadidentity

Sets the current thread's identity to the wanted value

```luau
function setthreadidentity(id: number): ()
```

### Parameters

- `id` - The wanted identity to change to

### Example

```luau
setthreadidentity(2)
print(game.CoreGui) -- Throws an error
setthreadidentity(8)
print(pcall(Instance.new, "Player")) -- Output: true Player
```

---

## getthreadidentity

Gets the current thread's identity

```luau
function getthreadidentity(): number
```

### Example

```luau
task.defer(function() setthreadidentity(2); print(getthreadidentity()) end)
setthreadidentity(3)
print(getthreadidentity())

-- Output: 
-- 3
-- 2
```
