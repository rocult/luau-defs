type GenericFunction<T..., U...> = (U...) -> T...
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
    
    @field Name - Include functions with this name
    @field IgnoreExecutor - If `true`, exclude executor functions. Defaults to `true`
    @field Hash - Include functions with the specified hash of their bytecode
    @field Constants - Include functions with constants matching all values in this array
    @field Upvalues - Include functions with upvalues matching all values in this array
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
    
    @field Keys - Include tables with keys corresponding to all values in this array
    @field Values - Include tables with values corresponding to all values in this array
    @field KeyValuePairs - Include tables with key/value pairs matching all values in this table
    @field Metatable - Include tables with the specified metatable
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
    
    @param object - The object to get the metatable of.
    @return The metatable of the object.
]=]
declare function getrawmetatable(object: any): AnyTable

--[=[
    Sets the metatable of `object` to the provided metatable, bypassing the `__metatable` field.

    @param object - The object whose metatable is to be set.
    @param metatable - The metatable to set.
    @return The object with the new metatable.
]=]
declare function setrawmetatable<T>(object: T, metatable: { any }): T

--[=[
    Sets the read-only state of the table to the provided boolean value, allowing or disallowing modifications.
    
    @param table - The table to change the read-only state on.
    @param state - The desired read-only state.
    @return ()
]=]
declare function setreadonly(table: { any }, state: boolean): ()

--[=[
    Checks whether the provided table is read-only.
    
    @param table - The table to check.
    @return `true` if the table is read-only; `false` otherwise.
]=]
declare function isreadonly(table: { any }): boolean