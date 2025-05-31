# Debug

Functions that allow us to get **more control** over Luau functions.

---

## debug.getconstants

Returns the constants of the specified Lua function. Should error on C closures, since they have no constants.

```luau
function debug.getconstants(func: (...any) -> (...any) | number): { number | string | boolean | nil }
```

### Parameter

- `func` - The Lua function/level the constants would be obtained from.

### Example

```luau
local function DummyFunction()
    local DummyString = "foo bar"
    string.split(DummyString, " ")
end

local Constants = debug.getconstants(DummyFunction)
for ConstantIndex, Constant in Constants do
    print(`[{ConstantIndex}]: {Constant}`)
end

-- Output:
-- [1]: "string"
-- [2]: "split"
-- [4]: "foo bar"
-- [5]: " "
-- Optimization Level: 1, Debug Level: 1
```

```luau
print(debug.getconstants(print)) -- Should error due to being a C closure
```

---

## debug.getconstant

Returns the constant at the specified index. If there is no constant at the specified index, `nil` will be returned instead.

```luau
function debug.getconstant(func: (...any) -> (...any) | number, index: number): number | string | boolean | nil
```

### Parameters

- `func` - The Lua function/level the constant would be obtained from.
- `index` - Position of the wanted constant.

### Examples

```luau
local function DummyFunction()
    local DummyString = "foo bar"
    string.split(DummyString, " ")
end

local Result = debug.getconstant(DummyFunction, 2)
print(Result) -- Output: string

-- Optimization Level: 1, Debug Level: 1
```

```luau
local function DummyFunction()
    local DummyString = "foo bar"
    string.split(DummyString, " ")
end

local Result = debug.getconstant(DummyFunction, 3)
print(Result) -- Output: nil

-- Optimization Level: 1, Debug Level: 1
```

> [!WARNING]
> If `game` is a mutable global, the indexes will be different

```luau
print(debug.getconstant(print)) -- Should error due to being a C closure
```

---

## debug.setconstant

Sets the wanted constant at the specified index. An error will be returned if the index is invalid.

```luau
function debug.setconstant(func: (...any) -> (...any) | number, index: number, value: number | string | boolean | nil): ()
```

### Parameters

- `func` - The Lua function/level whose constant would be set.
- `index` - The position of the constant.
- `value` - New constant replacing the old one.

### Example

```luau
local function DummyFunction()
    print(game.Name)
end

debug.setconstant(DummyFunction, 4, "Players")

DummyFunction() -- Output: Players
-- Optimization Level: 1, Debug Level: 1
```

> [!WARNING]
> If `game` is a mutable global, the index will be different

---

## debug.getupvalues

Returns the upvalues of the specified function. `nil` will be returned if there is none.

```luau
function debug.getupvalues(func: (...any) -> (...any) | number): { any }
```

### Parameter

- `func` - The Lua function/level the upvalues would be obtained from.

### Examples

```luau
local Var1 = false
local Var2 = "Hi"
local function DummyFunction()
    Var1 = true
    Var2..=", hello"
end

for UpvalIndex, UpvalValue in pairs(debug.getupvalues(DummyFunction)) do
    print(UpvalIndex, UpvalValue)
end

-- Output:
-- 1 false
-- 2 Hi
```

```luau
local Var1 = false
local function DummyFunction()
    print(Var1)
end

print(next(debug.getupvalues(DummyFunction))) -- Output: nil
```

```luau
print(debug.getupvalues(print)) -- Should error due to `print` being a C closure
```

---

## debug.getupvalue

Returns the upvalue at the specified index. An error should occur if the index is invalid.

```luau
function debug.getupvalue(func: (...any) -> (...any) | number, index: number): any
```

### Parameters

- `func` - The Lua function/level the upvalue would be obtained from.
- `index` - The position of the wanted upvalue.

### Examples

```luau
local UpFunction = function() print("Hello from up") end

local function DummyFunction()
    UpFunction()
end

local Upvalue = debug.getupvalue(DummyFunction, 1)
Upvalue() -- Output: Hello from up
```

```luau
local function DummyFunction() end

debug.getupvalue(DummyFunction, 0) -- Should error due to invalid index passage
```

```luau
debug.getupvalue(print, 1) -- Should error due to invalid index and C closure passage
```

---

## debug.setupvalue

Replaces the upvalue at the specified index. An error should occur if the index is invalid.

```luau
function debug.setupvalue(func: (...any) -> (...any) | number, index: number, value: any): ()
```

### Parameters

- `func` - The Lua function/level whose upvalue would be set.
- `index` - The position of the wanted upvalue.
- `value` - New upvalue replacing the old one.

### Example

```luau
local Upvalue = 90

local function DummyFunction()
    Upvalue += 1
    print(Upvalue)
end

DummyFunction() -- Output: 91
debug.setupvalue(DummyFunction, 1, 99)
DummyFunction() -- Output: 100
```

---

## debug.getstack

Returns all used values in the provided stack level.

```luau
function debug.getstack(level: number, index: number?): any | { any }
```

### Parameters

- `level` - The call stack.
- `index?` - The position of the values inside the stack frame.

### Examples

```luau
-- level 1
local Count = 0
local function RecursiveFunction() -- Entering a level deeper, meaning we can call using level 2 in this function
    Count += 1
    if Count > 6 then return end -- We'll stop at 6 to not retrieve useless information for our example
    local a = 29
    local b = true
    local c = "Example"
    a += 1
    b = false
    c..="s"
    print(debug.getstack(1, Count))
    RecursiveFunction()
end

RecursiveFunction()
-- Output:
-- 30
-- false
-- Examples
-- function: 0x...  <-- print function
-- function: 0x...  <-- getstack function
-- 1  <-- argument provided to getstack function
```

```luau
local function DummyFunction() return "Hello" end
local Var = 5
Var += 1

(function()
    print(debug.getstack(2)[1]()) -- Output: Hello
    print(debug.getstack(2)[2]) -- Output: 6
end)()
```

---

## debug.setstack

Sets a value in the stack at the specified index.

```luau
function debug.setstack(level: number, index: number, value: any): ()
```

### Parameters

- `level` - The call stack.
- `index` - The position of the values inside the stack frame.
- `value` - The new value to set at the specified position.

### Examples

```luau
error(debug.setstack(1, 1, function() -- Replace error with our function
    return function()
        print("Replaced")
    end
end))() -- Output: Replaced
```

```luau
local OuterValue = 10

local function InnerFunction()
    OuterValue += 9
    debug.setstack(2, 1, 100)
end 
InnerFunction()

print(OuterValue) -- Output: 100
```

---

## debug.getprotos

Returns all the functions defined in the provided function.

```luau
function debug.getprotos(func: (...any) -> (...any) | number): { (...any) -> (...any) }
```

### Parameter

- `func` - The function to obtain the protos from.

### Example

```luau
local function DummyFunction0()
    local function DummyFunction1() end
    local function DummyFunction2() end
end

for IndexProto, ValueProto in pairs(debug.getprotos(DummyFunction0)) do
    print(IndexProto, debug.info(ValueProto, "n"))
end

-- Output:
-- DummyFunction1
-- DummyFunction2
```

---

## debug.getproto

Returns the proto at the specified position. If third argument is true, instead returns a table which contains the active functions of the proto.

```luau
function debug.getproto(func: (...any) -> (...any) | number, index: number, activated: boolean?): (...any) -> (...any) | { (...any) -> (...any) } 
```

### Parameters

- `func` - The function to obtain the proto from.
- `index` - The position of the proto.
- `activated` - Whether to search the GC for the active function of the proto.

### Examples

```luau
local function DummyFunction()
    local function DummyProto1()
        print("Hello")
    end
    local function DummyProto2() 
        print("Hello2")
    end
end

debug.getproto(DummyFunction, 1)() -- Output: Hello
debug.getproto(DummyFunction, 2)() -- Output: Hello2
```

```luau
local function DummyFunction()
    local function DummyProto()
       return "hi"
    end
    return DummyProto
end

local RealProto = DummyFunction()
local RetrievedProto = debug.getproto(DummyFunction, 1, true)[1]

print(RealProto == RetrievedProto) -- Output: true
print(RetrievedProto()) -- Output: hi
```
