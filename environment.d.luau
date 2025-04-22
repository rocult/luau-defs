type GenericFunction<T..., U...> = (U...) -> T...
type GenericScript = LocalScript | ModuleScript
type AnyFunction = GenericFunction<...any, ...any>
type AnyTable = { [any]: any }
type BuiltIn = nil | string | number | boolean
type BooleanNumber = number 
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
declare function hookmetamethod(object: AnyTable | Instance, metamethod_name: string, hook: AnyFunction): AnyFunction

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

--[=[
    Functions made for encrypting and decrypting data.
]=]
type crypt = {
    --[=[
        Encodes a string with Base64 encoding.
    
        @param data - The data to encode
        @return The encoded string
    ]=]
    base64encode: (data: string) -> string,

    --[=[
        Decodes a Base64 string into its original form.
    
        @param data - The data to decode
        @return The decoded string
    ]=]
    base64decode: (data: string) -> string,
}
declare crypt: crypt

--[=[
    Functions that allow us to get **more control** over Luau functions.
]=]
type debug = {
    --[=[
        Returns the constants of the specified Lua function.
        
        @param func_or_level - The Lua function/level from which the constants are obtained
        @error "Unknown" -- errors on C closures, since they have no constants
        @return An array of constants (BuiltIn)
    ]=]
    getconstants: (func_or_level: AnyFunction | number) -> { BuiltIn },

    --[=[
        Returns the constant at the specified index. If there is no constant at that index, `nil` is returned.
        
        @param func_or_level - The Lua function/level from which the constant is obtained
        @param index - The position of the desired constant
        @return The constant at the specified index, or `nil` if it doesn't exist
    ]=]
    getconstant: (func_or_level: AnyFunction | number, index: number) -> BuiltIn,

    --[=[
        Sets the constant at the specified index in the given Lua function.
        
        @param func - The Lua function/level whose constant is to be set
        @param index - The position of the constant
        @param value - The new constant replacing the old one
        @error "Unknown" -- errors if the index is invalid
        @return ()
    ]=]
    setconstant: (func_or_level: AnyFunction | number, index: number, value: BuiltIn) -> (),

    --[=[
        Returns the upvalues of the specified Lua function.
        
        @param func_or_level - The Lua function/level from which the upvalues are obtained
        @return An array of upvalues, if there are any
    ]=]
    getupvalues: (func_or_level: AnyFunction | number) -> { any }?,

    --[=[
        Returns the upvalue at the specified index.
        
        @param func_or_level - The Lua function/level from which the upvalue is obtained
        @param index - The position of the desired upvalue
        @error "Unknown" -- errors if the index is invalid
        @return The upvalue at the specified index
    ]=]
    getupvalue: (func_or_level: AnyFunction | number, index: number) -> any,

    --[=[
        Replaces the upvalue at the specified index in the given Lua function.
        
        @param func_or_level - The Lua function/level whose upvalue is to be set
        @param index - The position of the desired upvalue
        @param value - The new upvalue replacing the old one
        @error "Unknown" -- errors if the index is invalid
        @return ()
    ]=]
    setupvalue: (func_or_level: AnyFunction | number, index: number, value: any) -> (),

    --[=[
        Returns all values used in the call stack of the provided level. If `index` is given, returns the value
        at that position inside the stack frame.
        
        @param level - The call stack level
        @param index - The position within the stack frame
        @return Either a single value or an array of values from the stack
    ]=]
    getstack: (level: number, index: number?) -> any | { any },

    --[=[
        Sets a new value in the call stack at the specified level and index.
        
        @param level - The call stack level
        @param index - The position within the stack frame
        @param value - The new value to set
        @return ()
    ]=]
    setstack: (level: number, index: number, value: any) -> (),

    --[=[
        Returns all the functions (protos) defined within the given Lua function.
        
        @param func_or_level - The function from which the protos are obtained
        @return An array of functions representing the protos
    ]=]
    getprotos: (func_or_level: AnyFunction | number) -> { AnyFunction },

    --[=[
        Returns the proto at the specified index. If the third argument is `true`, returns a table containing the
        active functions of the proto.
        
        @param func_or_level - The function from which to obtain the proto
        @param index - The position of the proto
        @param activated - Whether to search the GC for the active function of the proto
        @return Either a function or an array of functions representing the active proto
    ]=]
    getproto: (func_or_level: AnyFunction | number, index: number, activated: boolean?) -> AnyFunction | { AnyFunction },
}
declare debug: debug

type DrawingBase = {
    Visible: boolean,
    ZIndex: number,
    Transparency: number,
    Color: Color3,
    __OBJECT_EXISTS: boolean,
    Remove: (self: DrawingBase) -> (),
    Destroy: (self: DrawingBase) -> (),
}
type DrawingLine = DrawingBase & {
    Thickness: number,
    From: Vector2,
    To: Vector2,
}
type DrawingText = DrawingBase & {
    Text: string,
    Size: number,
    Center: boolean,
    Outline: boolean,
    OutlineColor: Color3,
    Position: Vector2,
    TextBounds: Vector2, --readonly
}
type DrawingImage = DrawingBase & {
    Data: string, --writeonly
    Size: Vector2,
    Position: Vector2,
    Rounding: number,   
}
type DrawingCircle = DrawingBase & {
    Thickness: number,
    NumSides: number,
    Radius: number,
    Filled: boolean,
    Position: Vector2,
}
type DrawingSquare = DrawingBase & {
    Thickness: number,
    Size: Vector2,
    Position: Vector2,
    Filled: boolean,
}
type DrawingQuad = DrawingBase & {
    Thickness: number,
    PointA: Vector2,
    PointB: Vector2,
    PointC: Vector2,
    PointD: Vector2,
    Filled: boolean,
}
type DrawingTriangle = DrawingBase & {
    Thickness: number,
    PointA: Vector2,
    PointB: Vector2,
    PointC: Vector2,
    Filled: boolean,
}
type DrawingFonts = {
    UI: number,
    System: number,
    Plex: number,
    Monospace: number,
}
type DrawingFontsData = {
    UI: number?,
    System: number?,
    Plex: number?,
    Monospace: number?,
}
export type DrawingNewTypes = "Line" | "Text" | "Image" | "Circle" | "Square" | "Quad" | "Triangle"
export type DrawingNewFunction =
    (("Line") -> DrawingLine)
    & (("Text") -> DrawingText)
    & (("Image") -> DrawingImage)
    & (("Circle") -> DrawingCircle)
    & (("Square") -> DrawingSquare)
    & (("Quad") -> DrawingQuad)
    & (("Triangle") -> DrawingTriangle)
export type Drawing = {
    Fonts: DrawingFonts,
    new: DrawingNewFunction
}
declare Drawing: Drawing

--[=[
    Returns a table containing all executor functions, serving as the shared environment for all scripts executed by the executor.
    
    @return A table containing executor functions
]=]
declare function getgenv(): { any }

--[=[
    Returns a table containing the Roblox environment.
    
    [!NOTE]
    Any changes to this environment shouldn't affect the executor; however it should affect game scripts.
    
    @return A table containing the Roblox environment
]=]
declare function getrenv(): { any }

--[=[
    Returns a table with all collectible values that aren't dead (referenced by active scripts).
    By default, it excludes tables; use `include_tables` to also include tables.
    
    @param include_tables - Whether to include tables in the result
    @return A table containing collectible values
]=]
declare function getgc(include_tables: boolean?): { { any } | any }

--[=[
    Similar to [getgc], returns Lua values that are referenced and match the specified criteria.
    
    @param filter_type - The type of Lua value to search for (`function` or `table`)
    @param filter_options - Criteria used to filter the search results based on the specified type
    @param return_one - If `true`, returns only the first match; otherwise, returns all matches
    @return Filtered Lua value(s) matching the criteria
]=]
declare function filtergc(
    filter_type: "function" | "table",
    filter_options: FunctionFilterOptions | TableFilterOptions,
    return_one: boolean?
): AnyFunction | AnyTable | { AnyFunction | AnyTable }

--[=[
    Options for filtering functions in [filtergc].
    
    .Name - Include functions with this name
    .IgnoreExecutor - If `true`, exclude executor functions. Defaults to `true`
    .Hash - Include functions with the specified hash of their bytecode
    .Constants - Include functions with constants matching all values in this array
    .Upvalues - Include functions with upvalues matching all values in this array
]=]
type FunctionFilterOptions = {
    Name: string?,
    IgnoreExecutor: boolean?,
    Hash: string?,
    Constants: { any }?,
    Upvalues: { any }?,
}

--[=[
    Options for filtering tables in [filtergc].
    
    .Keys - Include tables with keys corresponding to all values in this array
    .Values - Include tables with values corresponding to all values in this array
    .KeyValuePairs - Include tables with key/value pairs matching all values in this table
    .Metatable - Include tables with the specified metatable
]=]
type TableFilterOptions = {
    Keys: { any }?,
    Values: { any }?,
    KeyValuePairs: AnyTable?,
    Metatable: any?,
}

--[=[
    Writes data to a specified file path.
    
    @param path - The path to the file that will be wrote to
    @param data - The data to be written into the file
    @return ()
]=]
declare function writefile(path: string, data: string): ()

--[=[
    Retrieves the content of the file at the specified path.
    
    @param path - The path to the file that will be read
    @return The file content as a string
]=]
declare function readfile(path: string): string

--[=[
    Provides a list of files and folders within a specified directory.
    
    @param path - The path to the directory
    @return An array of file and folder names
]=]
declare function listfiles(path: string): { string }

--[=[
    Determines if the specified path is a file.
    
    @param path - The path to the file
    @return True if the path is a file; false otherwise
]=]
declare function isfile(path: string): boolean

--[=[
    Appends data to the end of the file at the specified path, creating the file if it doesn't already exist.
    
    @param path - The path to the file
    @param contents - The content to append
    @return ()
]=]
declare function appendfile(path: string, contents: string): ()

--[=[
    Deletes the file at the specified path.
    
    @param path - The path to the file
    @return ()
]=]
declare function delfile(path: string): ()

--[=[
    Generates a chunk from the file at the given path, using the global environment.
    Returns the chunk or nil with an error message.
    
    @param path - The path to the file
    @return A function representing the chunk, or nil and an error message
]=]
declare function loadfile(path: string): AnyFunction

--[=[
    Creates a folder at the specified path if it doesn't already exist.
    
    @param path - The location where you want to create the folder
    @return ()
]=]
declare function makefolder(path: string): ()

--[=[
    Determines if the specified path is a folder.
    
    @param path - The path to check
    @return True if the path is a folder; false otherwise
]=]
declare function isfolder(path: string): boolean

--[=[
    Deletes the folder at the specified path.
    
    @param path - The path to the folder
    @return ()
]=]
declare function delfolder(path: string): ()

--[=[
    Returns a content URL (e.g., `rbxasset://`) that can be used with UI elements, sounds, meshes, and more.
    Internally, files are copied to the game's content directory.
    
    @param path - The path to the file
    @return A content URL as a string
]=]
declare function getcustomasset(path: string): string

--[=[
    Returns a list of all instances referenced by the client.
    
    Should be able to return instances outside of `game`/[DataModel].
    
    @return An array of [Instance] objects
]=]
declare function getinstances(): { Instance }

--[=[
    Returns a list of instances that have their [Instance.Parent] property set to `nil`.
    
    @return An array of [Instance`] objects with [`Instance.Parent] equal to `nil`
]=]
declare function getnilinstances(): { Instance }

--[=[
    Returns a copy of the given [Instance].
    The copy should not be equal to the original [Instance].
    
    @param object - The [Instance] to clone
    @return A new [Instance] copy of the given object
]=]
declare function cloneref<T>(object: T & Instance): T

--[=[
    Checks if two instances are equal.
    This is primarily used for comparing instances returned by [cloneref] since the normal equality check may fail.
    
    @param object1 - The first [Instance] to compare
    @param object2 - The second [Instance] to compare
    @return `true` if the instances are considered equal; `false` otherwise
]=]
declare function compareinstances(object1: Instance, object2: Instance): boolean

--[=[
    Returns a hidden UI container that minimizes detection.
    This container should not be directly discoverable via standard search methods.
    
    @return An [Instance] representing the hidden UI container
]=]
declare function gethui(): Instance

--[=[
    Returns the callback function assigned to an object's callback property.
    This function retrieves the underlying function that is otherwise inaccessible through normal indexing.
    
    @param object - The [Instance] from which to get the callback
    @param property - The name of the callback property
    @return The callback function
]=]
declare function getcallbackvalue(object: Instance, property: string): AnyFunction

--[=[
    Triggers a specified event on a [ClickDetector].
    
    @param object - The [ClickDetector] to trigger
    @param distance - The distance from which to trigger the [ClickDetector`], defaults to [`math.huge]
    @param event -  The event to trigger; defaults to [`ClickDetector.MouseClick]`
    @return ()
]=]
declare function fireclickdetector(object: ClickDetector, distance: number?, event: ("MouseClick" | "MouseHoverEnter" | "MouseHoverLeave" | "RightMouseClick")?): ()

--[=[
    Triggers a [ProximityPrompt] instantly, regardless of distance or duration.
    
    @param object - The [ProximityPrompt] to fire
    @return ()
]=]
declare function fireproximityprompt(object: ProximityPrompt): ()

--[=[
    Triggers a [BasePart.Touched`] event on a [`BasePart].
    This function supports both numbers and booleans as the toggle parameter:
      - `false` or `0` starts the [BasePart.Touched] event.
      - `true` or `1` ends the [BasePart.Touched] event.
    
    When firing touch interests, the function should yield between calls to prevent overlaps.
    
    @param part - The [BasePart] initiating the touch
    @param part2 - The [BasePart] to be touched
    @param toggle - Determines whether to start (`false`/`0`) or end (`true`/`1`) the touch event
    @return ()
]=]
declare function firetouchinterest(part: BasePart, part2: BasePart, toggle: boolean | BooleanNumber): ()

--[=[
    Returns the metatable of `object`, bypassing the `__metatable` field.
    
    @param object - The object to get the metatable of
    @return The metatable of the object
]=]
declare function getrawmetatable(object: any): AnyTable

--[=[
    Sets the metatable of `object` to the provided metatable, bypassing the `__metatable` field.

    @param object - The object whose metatable is to be set
    @param metatable - The metatable to set
    @return The object with the new metatable
]=]
declare function setrawmetatable<T>(object: T, metatable: { any }): T

--[=[
    Sets the read-only state of the table to the provided boolean value, allowing or disallowing modifications.
    
    @param table - The table to change the read-only state on
    @param state - The desired read-only state
    @return ()
]=]
declare function setreadonly(table: { any }, state: boolean): ()

--[=[
    Checks whether the provided table is read-only.
    
    @param table - The table to check
    @return `true` if the table is read-only; `false` otherwise
]=]
declare function isreadonly(table: { any }): boolean

--[=[
    Returns the name and version of the current executor.
    The first string is the executor's identifier and the second is the executor's version.
    
    @return A tuple containing the executor's name and version
]=]
declare function identifyexecutor(): (string, string)

--[=[
    Sends an HTTP request with the given options, yielding until the request is finished, and returns the response.
    
    @param options - The options to use for the request
    @return The response from the request
]=]
declare function request(options: Request): Response

--[=[
    @interface Request
    The Request type used for making HTTP requests.
    
    .Url - The URL for the request.
    .Method - The HTTP method to use. Can be GET, POST, PATCH, or PUT.
    .Body - The body of the request.
    .Headers - A table of headers.
    .Cookies - A table of cookies.
]=]
type Request = {
    Url: string,
    Method: string,
    Body: string?,
    Headers: { [string]: any }?,
    Cookies: { [string]: any }?,
}

--[=[
    @interface Response
    The Response type returned after making an HTTP request.
    
    .Body - The body of the response.
    .StatusCode - The HTTP status code of the response.
    .StatusMessage - The status message of the response.
    .Success - Whether the request was successful.
    .Headers - A dictionary of response headers.
]=]
type Response = {
    Body: string,
    StatusCode: number,
    StatusMessage: string,
    Success: boolean,
    Headers: { [string]: any },
}

--[=[
    Returns the hidden, non-scriptable property's value regardless of its type,
    along with a boolean indicating if the property is hidden.
    
    @param instance - The instance that contains the property
    @param property_name - The name of the property to be read
    @return A tuple where the first value is the property value and the second is a boolean indicating if the property is hidden
]=]
declare function gethiddenproperty(instance: Instance, property_name: string): (any, boolean)

--[=[
    Sets the hidden, non-scriptable property's value regardless of its type,
    such as `BinaryString`, `SharedString`, or `SystemAddress`.
    This function avoids detection vectors and errors associated with using [setscriptable] directly.
    
    @param instance - The instance that contains the property
    @param property_name - The name of the property to assign
    @param property_value - The value to set for the property
    @return A boolean indicating success or failure
]=]
declare function sethiddenproperty(instance: Instance, property_name: string, property_value: any): boolean

--[=[
    Sets a hidden property to be scriptable so that it can be indexed as if it weren't hidden.

    [!WARNING] This function exposes detection vectors as game scripts can verify property indexability.
    [!NOTE] This function is limited and may not work on all hidden properties; for those, use [gethiddenproperty].
    
    @param object - The instance whose property is to be modified
    @param property - The property to set as scriptable
    @param state - Whether to make the property scriptable (true) or non-scriptable (false)
    @return A boolean indicating success, or nil if the operation fails
]=]
declare function setscriptable(object: Instance, property: string, state: boolean): boolean | nil

--[=[
    Determines whether the function was called from the executor's thread.
    
    @return True if called from the executor's thread; false otherwise
]=]
declare function checkcaller(): boolean

--[=[
    Sets the current thread's identity to the specified value.
    
    @param id - The identity value to change to
    @return ()
]=]
declare function setthreadidentity(id: number): ()

--[=[
    Retrieves the identity of the current thread.
    
    @return The current thread's identity as a number
]=]
declare function getthreadidentity(): number

--[=[
    Returns the bytecode of the given script. If the script has no bytecode, returns `nil`.
    
    @param script - The script to retrieve bytecode from
    @return The bytecode as a `string`, or `nil`
]=]
declare function getscriptbytecode(script: GenericScript): string?

--[=[
    Returns a SHA384 hash (in hex) of the given script's compressed and encrypted bytecode.
    If the script has no bytecode, returns nil.
    
    @param script - The script to get the hash from
    @return The SHA384 hash in hexadecimal format as a string, or nil
]=]
declare function getscripthash(script: GenericScript): string?

--[=[
    Creates a new closure (function) from the provided script's bytecode.
    This closure is typically used to retrieve constants.
    
    @param script - The script to obtain the closure from
    @return A function representing the script's closure, or nil
]=]
declare function getscriptclosure(script: GenericScript): AnyFunction?

--[=[
    Returns the environment (globals table) of the given script thread.
    
    @param script - The script whose environment is to be retrieved
    @return A table representing the script's environment
]=]
declare function getsenv(script: GenericScript): { [any]: any }

--[=[
    Returns all the scripts in the game. `CoreScripts` are filtered by default.
    
    @return An array of script objects
]=]
declare function getscripts(): { GenericScript }

--[=[
    Returns all the running scripts in the caller's global state. `CoreScripts` are filtered by default.
    
    @return An array of script objects
]=]
declare function getrunningscripts(): { GenericScript }

--[=[
    Returns all [ModuleScript]s that are currently loaded in the caller's global state.
    
    @return An array of [ModuleScript] objects
]=]
declare function getloadedmodules(): { ModuleScript }

--[=[
    Returns the script that is currently executing.
    For executor threads, this function returns nil. If a game thread's global `script` is set to `nil`,
    it must still return the correct script.
    
    @return The calling script, if there is one
]=]
declare function getcallingscript(): GenericScript?

--[=[
    Compiles the given Lua source into a function.
    The returned function is runnable and its environment becomes 'unsafe'.
    
    @param src - The source code to compile
    @param chunkname - The name to assign to the chunk
    @return A tuple: the compiled function (or `nil` if an error occurred) and an error message (or `nil` on success)
]=]
declare function loadstring<A...>(src: string, chunkname: string?): (((A...) -> any)?, string?)

--[=[
    Returns the connections of the specified [RBXScriptSignal].
    
    @param signal - The signal whose connections you want to retrieve.
    @return An array of [CustomConnection] objects.
    
    Each Connection object contains the following fields:
      - Enabled: boolean - Whether the connection can receive events.
      - ForeignState: boolean - True if the connection was created by a foreign Lua state.
      - LuaConnection: boolean - True if the connection was created in Luau code.
      - Function: function? - The function bound to this connection (nil if inaccessible).
      - Thread: thread? - The thread that created the connection (nil if inaccessible).
    
    And the following methods:
      - Fire(...: ...any): () - Fires this connection with the provided arguments.
      - Defer(...: ...any): () - Defers the event to the connection.
      - Disconnect(): () - Disconnects the connection.
      - Disable(): () - Prevents the connection from firing.
      - Enable(): () - Enables the connection.
]=]
declare function getconnections(signal: RBXScriptSignal): { CustomConnection }

--[=[
    @interface CustomConnection

    .Enabled - Whether the connection can receive events.
    .ForeignState - `true` if the connection was created by a foreign Lua state.
    .LuaConnection - `true` if the connection was created in Luau code.
    .Function - The function bound to this connection (`nil`, if inaccessible).
    .Thread - The thread that created the connection (`nil`, if inaccessible).

    .Fire(...: ...any) - Fires this connection with the provided arguments.
    .Defer(...: ...any) - Defers the event to the connection.
    .Disconnect() - Disconnects the connection.
    .Disable() - Prevents the connection from firing.
    .Enable()- Enables the connection.
]=]
type CustomConnection = { 
    Enabled: boolean,
    ForeignState: boolean,
    LuaConnection: boolean,
    Function: AnyFunction?,
    Thread: thread?,
    Fire: ((...any) -> ()),
    Defer: ((...any) -> ()),
    Disconnect: () -> (),
    Disable: () -> (),
    Enable: () -> ()
}

--[=[
    Fires a signal's Lua connections.
    
    @param signal - The [RBXScriptSignal] to fire.
    @param ... - The arguments to pass into the fired connections.
]=]
declare function firesignal(signal: RBXScriptSignal, ...: any): ()

--[=[
    If possible, replicates the specified signal to the server with the provided arguments.
    The arguments must match the signal's expected parameters.
    
    @param signal - The [RBXScriptSignal] to replicate.
    @param ... - The arguments to pass into the signal.
]=]
declare function replicatesignal(signal: RBXScriptSignal, ...: any): ()