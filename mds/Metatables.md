# Metatables

The **Metatable** library allows interaction with metatables.

---

## getrawmetatable

Returns the metatable of **object**, bypassing the `__metatable` field.

```luau
function getrawmetatable(object: any): { [any]: any }
```

### Parameters

- `object` - The object to get the metatable of.

### Example

```luau
print(getrawmetatable(game).__index(game, "workspace")) -- Output: Workspace
```

---

## setrawmetatable

Sets the metatable of **object** to the metatable provided, bypassing the `__metatable` field.

```luau
function setrawmetatable<T>(object: T, metatable: { any }): T
```

### Parameters

- `object` - The object's metatable to be set.
- `metatable` - The wanted metatable to set.

### Example

```luau
local DummyString = "Example"
local StringMetatable = setrawmetatable(DummyString, { __index = getgenv() })
print(StringMetatable) -- Output: Example
print(Metatable.getgenv) -- Output: function: 0x...
```

---

## setreadonly

Sets the read-only value to true or false, allowing to write inside read-only tables.

```luau
function setreadonly(table: { any }, state: boolean): ()
```

### Parameters

- `table` - The wanted table to set read-only to.
- `state` - Wanted state to set.

### Example

```luau
local Metatable = getrawmetatable(game)
Metatable.Example = "Hello" -- Throws an error
setreadonly(Metatable, false)
Metatable.Example = "Hello"
print(Metatable.Example) -- Output: Hello
setreadonly(Metatable, true)
```

---

## isreadonly

Will return true/false, depending if the table provided is read-only or not.

```luau
function isreadonly(table: { any }): boolean
```

### Parameters

- `table` - The table to check read-only state on.

### Example

```luau
print(isreadonly({})) -- Output: false
print(isreadonly(getrawmetatable(game))) -- Output: true
```
