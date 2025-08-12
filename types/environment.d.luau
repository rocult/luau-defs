--#region Helper types
type GenericFunction<T..., U...> = (U...) -> T...
type GenericScript = LocalScript | ModuleScript
type AnyFunction = GenericFunction<...any, ...any>
type AnyTable = { [any]: any }
type AnyArray = { any }
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

--#region Cache
type cache = {
    iscached: (object: Instance) -> boolean,
    invalidate: (object: Instance) -> (),
    replace: (object: Instance, newObject: Instance) -> (),
}
declare cache: cache

--#region Closures
declare function checkcaller(): boolean
declare function clonefunction<A..., R...>(function_to_clone: (A...) -> R...): (A...) -> R...
declare function getfunctionhash(function_to_hash: AnyFunction): string
declare function hookfunction<A1..., R1...>(function_to_hook: (A1...) -> R1..., hook: (A1...) -> R1...): (A1...) -> R1...
declare function hookmetamethod(object: AnyTable | Instance, metamethod_name: string, hook: AnyFunction): AnyFunction
declare function iscclosure(func: AnyFunction): boolean
declare function isexecutorclosure(func: AnyFunction): boolean
declare function islclosure(func: AnyFunction): boolean
declare function newcclosure<A..., R...>(function_to_wrap: (A...) -> R...): (A...) -> R...
declare function restorefunction(functionToRestore: (...any) -> (...any)): ()

declare function getnamecallmethod(): string

--#region Console
declare function rconsoleclear(): ()
declare function rconsolecreate(): ()
declare function rconsoledestroy(): ()
declare function rconsoleinput(): string
declare function rconsoleprint(text: string): ()
declare function rconsolesettitle(title: string): ()

--#region Cryptography
type CryptCipherMode = "CBC" | "ECB" | "CTR" | "CFB" | "OFB" | "GCM"
type CryptHashAlgorithm = "sha1" | "sha384" | "sha512" | "md5" | "sha256" | "sha3-224" | "sha3-256" | "sha3-512"
type crypt = {
    base64decode: (data: string) -> string,
    base64encode: (data: string) -> string,

    encrypt: (data: string, key: string, iv: string?, mode: CryptCipherMode?) -> (string, string),
    decrypt: (data: string, key: string, iv: string, mode: CryptCipherMode) -> string,
    generatebytes: (size: number) -> string,
    generatekey: () -> string,
    hash: (data: string, algorithm: CryptHashAlgorithm) -> string,
}
declare crypt: crypt

--#region Debug
type DebugInfo = {
    source: string,
    short_src: string,
    func: AnyFunction,
    what: "Lua" | "C",
    currentline: number,
    name: string,
    nups: number,
    numparams: number,
    is_vararg: BooleanNumber,
}
type debug = {
    getconstant: (func_or_level: AnyFunction | number, index: number) -> BuiltIn,
    getconstants: (func_or_level: AnyFunction | number) -> { BuiltIn },
    getproto: ((func_or_level: AnyFunction | number, index: number, activated: true) -> { AnyFunction }) &
              ((func_or_level: AnyFunction | number, index: number, activated: false?) -> AnyFunction),
    getprotos: (func_or_level: AnyFunction | number) -> { AnyFunction },
    getstack: (level: number, index: number?) -> any | AnyArray,
    getupvalue: (func_or_level: AnyFunction | number, index: number) -> any,
    getupvalues: (func_or_level: AnyFunction | number) -> AnyArray?,
    setconstant: (func_or_level: AnyFunction | number, index: number, value: BuiltIn) -> (),
    setstack: (level: number, index: number, value: any) -> (),
    setupvalue: (func_or_level: AnyFunction | number, index: number, value: any) -> (),

    getinfo: (func_or_level: AnyFunction | number) -> DebugInfo,
}
declare debug: typeof(debug) & debug

--#region Drawing
declare class DrawingObject
    Visible: boolean
    ZIndex: number
    Transparency: number
    Color: Color3
    __OBJECT_EXISTS: boolean
    function Remove(self)
    function Destroy(self)
end
declare class DrawingLine extends DrawingObject
    Thickness: number
    From: Vector2
    To: Vector2
end
declare class DrawingText extends DrawingObject
    Text: string
    Size: number
    Center: boolean
    Outline: boolean
    OutlineColor: Color3
    Position: Vector2
    TextBounds: Vector2 
end
declare class DrawingImage extends DrawingObject
    Data: string 
    Size: Vector2
    Position: Vector2
    Rounding: number
end
declare class DrawingCircle extends DrawingObject
    Thickness: number
    NumSides: number
    Radius: number
    Filled: boolean
    Position: Vector2
end
declare class DrawingSquare extends DrawingObject
    Thickness: number
    Size: Vector2
    Position: Vector2
    Filled: boolean
end
declare class DrawingQuad extends DrawingObject
    Thickness: number
    PointA: Vector2
    PointB: Vector2
    PointC: Vector2
    PointD: Vector2
    Filled: boolean
end
declare class DrawingTriangle extends DrawingObject
    Thickness: number
    PointA: Vector2
    PointB: Vector2
    PointC: Vector2
    Filled: boolean
end
type DrawingFonts = {
    UI: number,
    System: number,
    Plex: number,
    Monospace: number,
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
declare function cleardrawcache(): ()
declare function getrenderproperty(drawing: DrawingObject, property: string): any
declare function isrenderobj(object: any): boolean
declare function setrenderproperty(drawing: DrawingObject, property: string, value: any): ()

--#region Environment
type FunctionFilterOptions = {
    Name: string?,
    IgnoreExecutor: boolean?,
    Hash: string?,
    Constants: AnyArray?,
    Upvalues: AnyArray?,
}
type TableFilterOptions = {
    Keys: AnyArray?,
    Values: AnyArray?,
    KeyValuePairs: AnyTable?,
    Metatable: any?,
}
declare getgc:
    ((include_tables: false?) -> AnyArray)
    & ((include_tables: true) -> { any | AnyArray })
declare function getgenv(): AnyTable
declare function getreg(): AnyArray
declare function getrenv(): AnyTable
declare filtergc: (
    (filter_type: "table", filter_options: TableFilterOptions, return_one: true) -> AnyTable?
) & (
    (filter_type: "table", filter_options: TableFilterOptions, return_one: false?) -> { AnyTable }
) & (
    (filter_type: "function", filter_options: FunctionFilterOptions, return_one: true) -> AnyFunction?
) & (
    (filter_type: "function", filter_options: FunctionFilterOptions, return_one: false?) -> { AnyFunction }
)

--#region Filesystem
declare function appendfile(path: string, contents: string): ()
declare function delfile(path: string): ()
declare function delfolder(path: string): ()
declare function getcustomasset(path: string): string
declare function isfile(path: string): boolean
declare function isfolder(path: string): boolean
declare function listfiles(path: string): { string }
declare function loadfile(path: string): (AnyFunction?, string?)
declare function makefolder(path: string): ()
declare function readfile(path: string): string
declare function writefile(path: string, data: string): ()

declare function dofile(path: string): ()

--#region Input
declare function isrbxactive(): boolean
declare function mouse1click(): ()
declare function mouse1press(): ()
declare function mouse1release(): ()
declare function mouse2click(): ()
declare function mouse2press(): ()
declare function mouse2release(): ()
declare function mousemoveabs(x: number, y: number): ()
declare function mousemoverel(x: number, y: number): ()
declare function mousescroll(pixels: number): ()

--#region Instances
declare function cloneref<T>(object: T & Instance): T
declare function compareinstances(object1: Instance, object2: Instance): boolean
declare function fireclickdetector(object: ClickDetector, distance: number?, event: ("MouseClick" | "MouseHoverEnter" | "MouseHoverLeave" | "RightMouseClick")?): ()
declare function fireproximityprompt(object: ProximityPrompt): ()
declare function firetouchinterest(part: BasePart, part2: BasePart, toggle: boolean | BooleanNumber): ()
declare function getcallbackvalue(object: Instance, property: string): AnyFunction
declare function gethui(): Instance
declare function getinstances(): { Instance }
declare function getnilinstances(): { Instance }

--#region Metatable
declare function getrawmetatable(object: any): AnyTable
declare function isreadonly(table: AnyTable): boolean
declare function setrawmetatable<T>(object: T, metatable: AnyTable): T
declare function setreadonly(table: AnyTable, state: boolean): ()

--#region Miscellaneous
type Request = {
    Url: string,
    Method: string,
    Body: string?,
    Headers: { [string]: any }?,
    Cookies: { [string]: any }?,
}
type Response = {
    Body: string,
    StatusCode: number,
    StatusMessage: string,
    Success: boolean,
    Headers: { [string]: any },
}
type ExtraDataModel = {
    HttpGet: (url: string, synchronous: boolean?, httpRequestType: Enum.HttpRequestType, doNotAllowDiabolicalMode: boolean?) -> string,
    HttpGetAsync: (url: string, httpRequestType: Enum.HttpRequestType) -> string,
}
declare function identifyexecutor(): (string, string)
declare function request(options: Request): Response

declare function setclipboard(text: string): ()
declare function setfpscap(fps: number): ()
declare game: typeof(game) & ExtraDataModel

--#region Reflection
declare function gethiddenproperty(instance: Instance, property_name: string): (any, boolean)
declare function getthreadidentity(): number
declare function sethiddenproperty(instance: Instance, property_name: string, property_value: any): boolean
declare function setscriptable(object: Instance, property: string, state: boolean): boolean?
declare function setthreadidentity(id: number): ()

--#region Scripts
declare function getcallingscript(): GenericScript?
declare function getloadedmodules(): { ModuleScript }
declare function getrunningscripts(): { GenericScript }
declare function getscriptbytecode(script: GenericScript): string?
declare function getscriptclosure(script: GenericScript): AnyFunction?
declare function getscripthash(script: GenericScript): string?
declare function getscripts(): { GenericScript }
declare function getsenv(script: GenericScript): { [any]: any }
declare function loadstring<A...>(src: string, chunkname: string?): (((A...) -> any) | nil, string?)

--#region Signals
declare class Connection
    Enabled: boolean
    ForeignState: boolean
    LuaConnection: boolean
    Function: AnyFunction?
    Thread: thread?
    function Fire(self, ...: any): ()
    function Defer(self, ...: any): ()
    function Disconnect(self): ()
    function Disable(self): ()
    function Enable(self): ()
end
declare function firesignal<T...>(signal: RBXScriptSignal<T...>, ...: T...): ()
declare function getconnections<T...>(signal: RBXScriptSignal<T...>): { Connection }
declare function replicatesignal<T...>(signal: RBXScriptSignal<T...>, ...: T...): ()

--#region WebSocket
type WebSocketConnection = {
    OnMessage: RBXScriptSignal<string>,
    OnClose: RBXScriptSignal<()>,
    Send: (self: WebSocketConnection, message: string) -> (),
    Close: (self: WebSocketConnection) -> (),
}
type WebSocket = {
    connect: (url: string) -> WebSocketConnection
}
declare WebSocket: WebSocket
