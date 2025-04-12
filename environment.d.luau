type GenericFunction<T..., U...> = (U...) -> T...
type AnyFunction = GenericFunction<...any, ...any>
type AnyTable = { [any]: any }
type Metamethods =
    "__index" |
    "__newindex" |
    "__call" |
    "__concat" |
    "__unm" |
    "__add" |
    "__sub" |
    "__mul" |
    "__div" |
    "__idiv" |
    "__mod" |
    "__pow" |
    "__tostring" |
    "__metatable" |
    "__eq" |
    "__lt" |
    "__le" |
    "__mode" |
    "__len" |
    "__iter" |
    "__namecall"


--[=[
    Hooks a function with another wanted function, returning the original unhooked function.
    
    [!NOTE]
    The hook shouldn't have more upvalues than the function you want to hook.
    
    @tag closures
    @param function_to_hook - The function that will be hooked
    @param hook - The function that will be used as a hook
    @return The original unhooked function
]=]
declare function hookfunction<A1..., R1...>(function_to_hook: (A1...) -> R1..., hook: (A1...) -> R1...): (A1...) -> R1...


--[=[
    Takes any Lua value that can have a metatable and attempts to hook the specified metamethod
    using the hookfunction.
    
    @tag closures
    @param object - The object which has the metatable
    @param metamethod_name - The name of the metamethod to hook
    @param hook - The function that will be used as a hook
    @return The original unhooked metamethod
]=]
declare function hookmetamethod(object: AnyTable | Instance | userdata, metamethod_name: string, hook: AnyFunction): AnyFunction


--[=[
    Wraps a Lua function into a C closure.
    When the returned function is called, the original Lua closure is invoked,
    and its returned values are passed to the caller.
    
    @tag closures
    @param function_to_wrap - A function to be wrapped
    @return The original function wrapped in a new C closure
]=]
declare function newcclosure<A..., R...>(function_to_wrap: (A...) -> R...): (A...) -> R...


--[=[
    Checks if a given function is a C closure.
    
    @param func - The function to check
    @return `true` if the function is a C closure, `false` otherwise
]=]
declare function iscclosure(func: AnyFunction): boolean


--[=[
    Checks if a given function is a Lua closure.
    
    @param func - The function to check
    @return `true` if the function is a Lua closure, `false` otherwise
]=]
declare function islclosure(func: AnyFunction): boolean


--[=[
    Checks if a given function is the executor's closure.
    
    @param func - The function to check
    @return `true` if the function is the executor's closure, `false` otherwise
]=]
declare function isexecutorclosure(func: AnyFunction): boolean


--[=[
    Creates and returns a new function that has the same behavior as the given function.
    
    @tag closures
    @param function_to_clone - The function to clone
    @return A new function replicating the behavior of the original
]=]
declare function clonefunction<A..., R...>(function_to_clone: (A...) -> R...): (A...) -> R...


--[=[
    Returns the hex-represented SHA-384 hash of a function's instructions and constants.
    
    @param function_to_hash - The function whose hash is to be computed
    @return The SHA-384 hash in hexadecimal format
]=]
declare function getfunctionhash(function_to_hash: AnyFunction): string