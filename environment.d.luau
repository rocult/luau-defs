-- @environment-functions
declare class Connection
    Function: RBXScriptConnection
    State: Enum.ConnectionState
    Enable: () -> ()
    Disable: () -> ()
    Fire: (...any) -> ()
end

declare function getgenv(): { [any]: any }

declare function getrenv(): { [any]: any }

declare function getreg(): { [any]: any }

declare function cleardrawcache(): { [any]: any }

declare function setrenderproperty(Drawing: Instance, String: string, Value: boolean): { [any]: Instance }

declare function getgc(include_tables: boolean?): { [any]: any }

declare function getinstances(): { [any]: Instance }

declare function getrenderproperty(instance: Instance, String: string): any

declare function isrenderobj(instance: any): boolean

declare function getnilinstances(): { [any]: Instance }

declare function getscripts(): { [any]: LocalScript | ModuleScript }

declare function getloadedmodules(): { [any]: ModuleScript }

declare function getconnections(connection: RBXScriptSignal?): { [any]: Connection }

declare function firesignal(signal: RBXScriptSignal, ...: any): ()

declare function getcustomasset(asset: string): any

declare function isscriptable(instance: Instance, String: string): boolean

declare function setscriptable(instance: Instance, String: string, Value: boolean): ()

declare function getcallbackvalue(instance: Instance, type: string)

declare function fireclickdetector(detector: ClickDetector, distance: number, type: string): ()

declare function fireproximityprompt(prompt: ProximityPrompt, distance: number): ()

declare function firetouchinterest(totouch : BasePart, Part : BasePart, toggle : number): ()

declare function isnetworkowner(part: BasePart): boolean

declare function getproperties(object: Instance): { [any]: any }

declare function gethui(): any

declare function getrunningscripts(): any

declare function gethiddenproperty(object: Instance, property: string): any

declare function sethiddenproperty(object: Instance, property: string, value: any): ()

declare function setsimulationradius(radius: number, max_radius: number): ()

declare function create_secure_folder(path: string): ()

declare function replicatesignal(signal: RBXScriptSignal) : ()

declare function cansignalreplicate(signal: RBXScriptSignal): boolean

declare function getsignalarguments(signal : RBXScriptSignal): ()

declare function is_secured_instance(instance: Instance) : boolean

declare function set_normal_instance(instance : Instance) : boolean

declare function set_secure_instance(instance : Instance) : boolean



-- @script-functions
type Function = (...any) -> any 

declare function getsenv(script: LocalScript | ModuleScript): { [any]: any }

declare function getcallingscript(): LocalScript | ModuleScript | nil

declare function cloneref(Part: Instance): { [any]: any }

declare function getscriptclosure(script: LocalScript | ModuleScript): Function

declare function getscripthash(script: LocalScript | ModuleScript): string


-- @table-functions
declare function getrawmetatable(table: { [any]: any }): { [any]: any }

declare function setrawmetatable(table: { [any]: any }, metatable: { [any]: any }): boolean

declare function setreadonly(table: { [any]: any }, readonly: boolean): ()

declare function isreadonly(table: { [any]: any }): boolean


-- @input-functions
declare function iswindowactive(): boolean

declare function keypress(key: number): ()

declare function keyrelease(key: number): ()

declare function mouse1click(): ()

declare function mouse1press(): ()

declare function mouse1release(): ()

declare function mouse2click(): ()

declare function mouse2press(): ()

declare function mouse2release(): ()

declare function mousescroll(pixel: number): ()

declare function mousemoverel(x: number, y: number): ()

declare function setfpscap(fps: number): ()

declare function getthreadidentity(): any

declare function setthreadidentity(value: any): ()

declare function identifyexecutor(): any

declare function lz4compress(String: string): any

declare function lz4decompress(String: string, raw: any): string

declare function mousemoveabs(x: number, y: number): ()


-- @hook-functions
declare function hookfunction(old: Function, hook: Function): Function

declare function hookmetamethod(object: { [any]: any } | any, method: string, hook: Function): Function

declare function newcclosure(func: Function): Function


-- @reflection-functions
declare function checkcaller(): boolean

declare function iscclosure(Instance: Function): boolean

declare function isexecutorclosure(Instance: Function): boolean

declare function islclosure(func: Function): boolean

declare function dumpstring(script: string): string

declare function decompile(target: LocalScript | ModuleScript | Function | string): string


-- @console-functions
declare function rconsoleprint(message: string): ()

declare function rconsoleinfo(message: string): ()

declare function rconsolewarn(message: string): ()

declare function rconsoleerr(message: string): ()

declare function rconsolename(name: string): ()

declare function rconsoleclear(): ()

declare function rconsoleinput(): string

declare function printconsole(message: string, red: number, green: number, blue: number): ()


-- @filesystem-functions
declare function readfile(path: string): string

declare function writefile(path: string, content: string): ()

declare function appendfile(path: string, content: string): ()

declare function loadfile(path: string): (Function | nil, string?)

declare function listfiles(path: string): { [any]: string }

declare function isfile(path: string): boolean

declare function isfolder(path: string): boolean

declare function makefolder(path: string): ()

declare function delfolder(path: string): ()

declare function delfile(path: string): ()


-- @misc-functions
declare function setclipboard(content: string): ()

declare function setfflag(fflag: string, value: string): ()

declare function getnamecallmethod(): string

declare function setnamecallmethod(method: string): ()

declare function getsynasset(asset: string): string

declare function clonefunction(a: Function): { [any]: any }

declare function getscriptbytecode(instance: Instance): { [any]: any }

declare function getspecialinfo(obj: Instance): { [any]: any }

declare function compareinstances(a: Instance, b: Instance): { [any]: any }

declare function saveinstance(opt: { mode: "optimized" | "full" | "scripts", noscript: boolean, scriptcache: boolean, timeout: number }?)

declare function messagebox(text: string, caption: string, flags: number): number

declare function gethwid() : string

-- @cache-library
declare class cacheF
    replace: (a: number, b: number) -> number
    iscached: (a: number) -> number
    invalidate: (a: number) -> number
end

declare cache: cacheF

-- @bit-library
declare class bit
    bdiv: (dividend: number, divisor: number) -> number
    badd: (a: number, b: number) -> number
    bsub: (a: number, b: number) -> number
    bmul: (val: number, by: number) -> number
    band: (val: number, by: number) -> number
    bor: (val: number, by: number) -> number
    bxor: (val: number, by: number) -> number
    bnot: (val: number) -> number
    bswap: (val: number) -> number
    ror: (value: number, rotate_count: number) -> number
    rol: (value: number, rotate_count: number) -> number
    tohex: (val: number) -> string
    tobit: (val: number) -> number
    lshift: (val: number, by: number) -> number
    rshift: (val: number, by: number) -> number
    arshift: (val: number, shift_count: number) -> number
end

declare bit: bit


-- @crypt-library
type Algorithm = "aes-cbc" | "aes-cfb" | "aes-ctr" | "aes-ofb" | "aes-gcm" | "aes-eax" | "bf-cbc" | "bf-cfb" | "bf-ofb"

declare class base64
    encode: (data: string) -> string
    decode: (data: string) -> string
end

declare class custom
    encrypt: (cipher: string, data: string, key: string, iv: string) -> string
    encrypt: (cipher: string, data: string, key: string, nonce: string) -> string

    decrypt: (cipher: string, data: string, key: string, iv: string) -> string
    decrypt: (cipher: string, data: string, key: string, nonce: string) -> string

    hash: (algorithm: Algorithm, data: string) -> string
end

declare class crypt
    base64encode: (data: string) -> string
    encrypt: (data: string, key: string, iv: any, String: string) -> string
    decrypt: (data: string, key: string, iv: any, String: string) -> string
    hash: (data: string) -> string
    derive: (data: string, length: number) -> string
    random: (size: number) -> string
    generatekey: () -> string
    base64decode: (data: string) -> string
    base64: base64
    custom: custom
    hash: (String: string, table: any) -> string
    generatebytes: (size: number) -> string
end

declare crypt: crypt

-- @debug-library
declare class debug
    getconstants: (target: Function | number) -> { [any]: any }
    getconstant: (target: Function | number, index: number) -> any
    setconstant: (target: Function | number, index: number | string, value: number | string | boolean | nil) -> ()
    getupvalues: (target: Function | number) -> { [any]: any }
    getupvalue: (target: Function | number, index: number) -> any
    setupvalue: (target: Function | number, index: number, value: { [any]: any } | any) -> ()
    getprotos: (target: Function) -> { [any]: any }
    getproto: (target: Function, index: number, activated: boolean?) -> any
    setproto: (target: Function, index: number, value: Function) -> ()
    getstack: (level: number, index: number | nil) -> any
    setstack: (level: number, index: number, value: { [any]: any } | string) -> ()
    setmetatable: (target: { [any]: any }, metatable: { [any]: any }) -> ()
    getregistry: () -> { [any]: any }
    getinfo: (target: Function | number, what: string | nil) -> string
end

declare debug: debug


-- @drawing-library
declare class DrawingObject
    Visible: boolean
    ZIndex: number
    Transparency: number
    Color: Color3

    remove: (self: DrawingObject) -> ()
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
    Font: number
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
    Filled: boolean
    Size: Vector2
    Position: Vector2
end

declare class DrawingQuad extends DrawingObject
    Thickness: number
    Filled: boolean
    PointA: Vector2
    PointB: Vector2
    PointC: Vector2
    PointD: Vector2
end

declare class DrawingTriangle extends DrawingObject
    Thickness: number
    Filled: boolean
    PointA: Vector2
    PointB: Vector2
    PointC: Vector2
end

declare class Drawing
    new: (type: "Line") -> DrawingLine  
    new: (type: "Text") -> DrawingText
    new: (type: "Image") -> DrawingImage
    new: (type: "Circle") -> DrawingCircle
    new: (type: "Square") -> DrawingSquare
    new: (type: "Quad") -> DrawingQuad
    new: (type: "Triangle") -> DrawingTriangle

    Fonts: any
end

declare Drawing: Drawing


-- @websocket-library
declare class Socket
    Send: (self: Socket, message: string) -> ()
    Close: (self: Socket) -> ()
    OnMessage: RBXScriptSignal
    OnClose: RBXScriptSignal
end

declare class WebSocket
    connect: (url: string) -> Socket
    Connect: (url: string) -> Socket
end

declare websocket: WebSocket
declare WebSocket: WebSocket

-- @request-definitions
type Request = {
    Url: string,
    Method: "GET" | "POST" | "PUT" | "DELETE"?,
    Headers: { [any]: any }?,
    Body: string?,
    Cookies: { [any]: any }?,
}

type Response = {
    Success: boolean,
    StatusCode: number,
    StatusMessage: string,
    Headers: { [any]: any },
    Cookies: { [any]: any },
    Body: string,
}

declare function request(request: Request): Response

declare function http_request(request: Request): Response

    declare function http(request: Request): Response

-- @actor-library 
declare function get_actors() : string

declare function get_current_actor() : string

declare function get_deleted_actors() : string

declare function is_parallel() : string

declare function run_on_actor(ActorState: Instance, Script : string) : string

declare function create_comm_channel() : ()

-- @luraph

declare LPH_OBFUSCATED : boolean

declare LPH_LINE : number

declare function LPH_JIT(func : any) : ()

declare function LPH_JIT_MAX(func : any) : ()

declare function LPH_NO_VIRTUALIZE(func : any) : ()

declare function LPH_NO_UPVALUES(func : any) : ()

declare function LPH_CRASH() : ()

-- @luarmor

declare script_key : string

declare LRM_LinkedDiscordID: number

declare LRM_UserNote : string

declare LRM_ScriptName : string

declare LRM_TotalExecutions : number

declare LRM_IsUserPremium : boolean

declare LRM_SecondsLeft : number

declare LRM_ScriptVersion : string

declare function LRM_INIT(code : any) : ()

-- @other-definitions
declare function set_thread_identity(identity: number): ()

declare function isrbxactive(): any

declare function get_thread_identity(): number

declare function write_clipboard(content: string): ()

declare function queue_on_teleport(callback: string): ()

declare function protect_gui(gui: GuiObject): ()

declare function protectgui(gui: GuiObject): ()

declare function unprotect_gui(gui: GuiObject): ()

declare function loadstring(src: string, chunkname: any?): any