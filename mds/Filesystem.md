# Filesystem

Functions that provide read and write access to a files in an executor's workspace.

> [!WARNING]
> **Filesystem** functions should restrict access to read and write potentially harmful file types like `.exe` or `.bat`.

---

## writefile

Writes data to a specified file path.

```luau
function writefile(path: string, data: string): ()
```

### Parameters
- `path` - path to the file that will be wrote to.
- `data` - the data to be written into the file.

### Example

```luau
writefile("file.txt", "Hello world")
print(readfile("file.txt")) -- Output: Hello world
```

---

## readfile

Retrieves the content of the file at the specified path.

```luau
function readfile(path: string): string
```

### Parameter
- `path` - path to the file that will be read.

### Example

```luau
writefile("file0.txt", "Hello")
print(readfile("file0.txt")) -- Output: Hello
```

---

## listfiles

Provides a list of files and folders within a specified directory.

```luau
function listfiles(path: string): { string }
```

### Parameter
- `path` - path to the directory.

### Example

```luau
writefile("file1.txt", "")
writefile("file2.lua", "")
task.wait()
for _, File in listfiles("") do
    if File == "file1.txt" then
        print(`Found: {File}`) -- Output: Found: file1.txt
    end
    if File == "file2.lua" then
        print(`Found: {File}`) -- Output: Found: file2.lua
    end
end
```

---

## isfile

Determines if the specified path is a file.

```luau
function isfile(path: string): boolean
```

### Parameter
- `path` - The path to the file.

### Example

```luau
print(isfile("nonexistent.txt")) -- Output: false
writefile("file3.txt", "")
print(isfile("file3.txt")) -- Output: true
```

---

## appendfile

Appends data to the end of the file at the specified path, creating the file if it doesn't already exist.

```luau
function appendfile(path: string, contents: string): ()
```

### Parameters
- `path` - Path to the file.
- `contents` - The content to append.

### Example

```luau
writefile("file4.txt", "print(")
appendfile("file4.txt", "'Hello')")
print(readfile("file4.txt")) -- Output: print('Hello')
```

---

## delfile

Deletes the file at the specified path.

```luau
function delfile(path: string): ()
```

### Parameter

- `path` - Path to the file.

### Example

```luau
writefile("file5.txt", "Hello")
print(isfile("file5.txt")) -- Output: true
delfile("file5.txt")
print(isfile("file5.txt")) -- Output: false
```

---

## loadfile

Generates a chunk from the file at the given path, using the global environment. Returns the chunk or nil with an error message.

```luau
function loadfile(path: string): ()
```

### Parameter

- `path` - Path to the file.

### Examples

```luau
writefile("file6.lua", "return 10 + ...")
local Func, Err = loadfile("file5.lua")
print(Func(1), Err) -- Output: 11, nil
```

```luau
writefile("file6.lua", "retrn 10  ...")
local Func, Err = loadfile("file5.lua")

if Func == nil and string.find(Err, "expected assignment or a function call") then
    print("Caught the error") -- Output: Caught the error
end
```

---

## makefolder

Creates a folder at the specified path if it doesn't already exist.

```luau
function makefolder(path: string): ()
```

### Parameter

- `path` - The location where you want to create the folder.

### Example

```luau
makefolder("folder")
print(isfolder("folder")) -- Output: true
```

--- 

## isfolder

Determines if the specified path is a folder.

```luau
function isfolder(path: string): boolean
```

### Parameter

- `path` - The path to check.

### Example

```luau
writefile("file7.txt", "")
makefolder("folder2")
print(isfolder("file7.txt")) -- Output: false
print(isfolder("folder2")) -- Output: true
```

---

## delfolder

Deletes the folder at the specified path.

```luau
function delfolder(path: string): ()
```

### Parameter

- `path` - Path to the folder you will delete.

### Example

```luau
makefolder("folder3")
print(isfolder("folder3")) -- Output: true
delfolder("folder3")
print(isfolder("folder3")) -- Output: false
```

---

## getcustomasset

Returns a content URL `(e.g., rbxasset://)` that can be used with UI elements, sounds, meshes, and more. Internally, files are copied to the game's content directory.

```luau
function getcustomasset(path: string): string
```

### Parameter

- `path` - The path to the file.

### Example

```luau
-- Will load and play an mp3 sound in-game.
local Encoded = game:HttpGet("https://gitlab.com/sens3/nebunu/-/raw/main/encodedBytecode.txt?ref_type=heads")
writefile("ExampleSound.mp3", crypt.base64decode(Encoded)) -- Write bytes to file
local Retrieved = getcustomasset("ExampleSound.mp3")
local Sound = Instance.new("Sound")
Sound.Parent = workspace
Sound.SoundId = Retrieved
Sound.Volume = 0.35
Sound:Play()
```
