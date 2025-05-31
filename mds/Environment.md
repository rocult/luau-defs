# Environment

These functions allow to **modify/access** our executor environment and Roblox environment.

---

## getgenv

Returns a table containing all executor functions, serving as the shared environment for all scripts executed by the executor.

```luau
function getgenv(): { any }
```

### Example

```luau
getgenv().test = "hello world"
print(test) -- Output: hello world
```

---

## getrenv

Returns a table containing the Roblox environment.

> [!NOTE]
> Any changes to this environment shouldn't affect the executor; however it should affect game scripts.

```luau
function getrenv(): { any }
```

### Example

```luau
getrenv().game = nil -- game scripts won't be able to access game
getrenv().warn = "Hello"
print(type(warn)) -- Output: string
```

---

## getgc

Returns a table with all collectible values that aren't dead (meaning they are referenced by active scripts).

By default, it excludes tables; you can use `includeTables` to also get tables.

```luau
function getgc(include_tables: boolean?): { { any } | (...any) -> (...any) | userdata }
```

### Parameter

- `include_tables?` - Whether the output table should also include tables

### Examples

```luau
local DummyTable = {}
local function DummyFunction() end
task.wait(0.05) -- Step a bit

for GarbageIndex, GarbageValue in pairs(getgc()) do
    if GarbageValue == DummyFunction then
        print(`Found function: {DummyFunction}`)
    elseif GarbageValue == DummyTable then
        print(`Found table?: {DummyTable}`) -- This shouldn't print
    end
end
```

```luau
local DummyTable = {}
local function DummyFunction() end
task.wait(0.05) -- Step a bit

for GarbageIndex, GarbageValue in pairs(getgc(true)) do
    if GarbageValue == DummyFunction then
        print(`Found function: {DummyFunction}`) -- Both should print
    elseif GarbageValue == DummyTable then
        print(`Found table: {DummyTable}`) -- Both should print
    end
end
```

---

## filtergc

Similar to `getgc`, will return Lua values that are being referenced and match the specified criteria.

```luau
function filtergc(filter_type: "function" | "table", filter_options: FunctionFilterOptions | TableFilterOptions, return_one: boolean?): (...any) -> (...any) | { [any]: any } | { (...any) -> (...any) | { [any]: any } }
```

### Table filter options:

| Key            | Description                                                                                       | Default |
| -------------- | ------------------------------------------------------------------------------------------------- | ------- |
| `Keys`         | If not empty, also include tables with keys corresponding to all values in this table.             |  `nil`  |
| `Values`       | If not empty, also include tables with values corresponding to all values in this table.           |  `nil`  |
| `KeyValuePairs`| If not empty, also include tables with keys/value pairs corresponding to all values in this table. |  `nil`  |
| `Metatable`    | If not empty, also include tables with the metatable passed.                                       |  `nil`  |

### Function filter options:

| Key             | Description                                                                             | Default |
| --------------- | --------------------------------------------------------------------------------------- | ------- |
| `Name`          | If not empty, also include functions with this name.                                     |  `nil`  |
| `IgnoreExecutor`| If true, also exclude functions made in the executor.                                    |  `true` |
| `Hash`          | If not empty, also include functions with the specified hash of their bytecode.                  |  `nil`  |
| `Constants`     | If not empty, also include functions with constants that match all values in this table. |  `nil`  |
| `Upvalues`      | If not empty, also include functions with upvalues that match all values in this table.  |  `nil`  |

### Parameters

- `filter_type` - Specifies the type of Lua value to search for.
- `filter_options` - Criteria used to filter the search results based on the specified type.
- `return_one?` - A boolean that returns only the first match when true; otherwise, all matches are returned.

> [!NOTE]
> Executing these examples multiple times in a short period of time may result in false negatives.

### Examples - Function


Usage of `Name` and `return_one?` set to `false` (default option):
```luau
local function DummyFunction() 
end

local Retrieved = filtergc("function", {
    Name = "DummyFunction", 
    IgnoreExecutor = false
})

print(typeof(Retrieved)) -- Output: table
print(Retrieved[1] == DummyFunction) -- Output: true
```

Usage of `Name` and `return_one?` set to `true`:
```luau
local function DummyFunction() 
end

local Retrieved = filtergc("function", {
    Name = "DummyFunction", 
    IgnoreExecutor = false
}, true)

print(typeof(Retrieved)) -- Output: function
print(Retrieved == DummyFunction) -- Output: true
```

### Usage of `options` parameter

Usage of `Hash`:
```luau
local function DummyFunction() 
    return "Hello" 
end

local DummyFunctionHash = getfunctionhash(DummyFunction)

local Retrieved = filtergc("function", {
    Hash = DummyFunctionHash, -- A C Closure will automatically fail this filter because it's impossible to rebuild the bytecode of a C Closure
    IgnoreExecutor = false
}, true)

print(getfunctionhash(Retrieved) == DummyFunctionHash) -- Output: true
print(Retrieved == DummyFunction) -- Output: true
```

Usage of `Constants` and `Upvalues`:
```luau
local Upvalue = 5

local function DummyFunction() 
    Upvalue += 1
    print(game.Players.LocalPlayer)
end

local Retrieved = filtergc("function", { 
    Constants = { "print", "game", "Players", "LocalPlayer", 1 }, -- A C Closure will automatically fail this filter because a C Closure does not have Constants
    Upvalues = { 5 },
    IgnoreExecutor = false
}, true)

print(Retrieved == DummyFunction) -- Output: true
```

---

### Examples - Table

Usage of `Keys` and `Values`:
```lua
local DummyTable = { ["DummyKey"] = "" }

local Retrieved = filtergc("table", {
    Keys = { "DummyKey" },
}, true)

print(Retrieved == DummyTable) -- Output: true
```

Usage of `KeyValuePairs`:
```luau
local DummyTable = { ["DummyKey"] = "DummyValue" }

local Retrieved = filtergc("table", {
    KeyValuePairs = { ["DummyKey"] = "DummyValue" },
}, true)

print(Retrieved == DummyTable) -- Output: true
```

Usage of `Metatable`:
```luau
local DummyTable = setmetatable( {}, { __index = getgenv() } )

local Retrieved = filtergc("table", { 
    Metatable = getmetatable(DummyTable) 
}, true)

print(Retrieved == DummyTable) -- Output: true
```
