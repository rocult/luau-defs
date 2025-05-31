# Drawing

The **Drawing** library provides an interface for rendering shapes and text onto the game window.

---

## Drawing.new

Creates a new drawing object of the specified type. The possible types are: Line, Text, Image, Circle, Square, Quad, and Triangle.

```luau
function Drawing.new(type: string): Drawing
```

## Parameters

- `type` - The type of drawing object to create.

## Example

```luau
local Camera = game.Workspace.CurrentCamera
local Viewport = Camera.ViewportSize
local Position = Vector2.new(Viewport.X / 2, Viewport.Y / 2)

local circle = Drawing.new("Circle")
circle.Radius = 50
circle.Color = Color3.fromRGB(255, 0, 0)
circle.Filled = true
circle.NumSides = 32
circle.Position = Position
circle.Transparency = 0.7
circle.Visible = true

task.wait(0.6)
circle:Destroy()
```

---

## Drawing

The class which all drawing objects will inherit.

| Property        | Type                                                                                       | Description                                                         |
| ----------------| -------------------------------------------------------------------------------------------| --------------------------------------------------------------------|
| Visible         | boolean                                                                                    | Whether the drawing is visible. Defaults to `false`.                |
| ZIndex          | number                                                                                     | Determines the order in which a Drawing renders relative to others. |
| Transparency    | number                                                                                     | The opacity of the drawing (1 - opaque, 0 - transparent).           |
| Color           | Color3                                                                                     | The color of the drawing.                                           |
| __OBJECT_EXISTS | boolean                                                                                    | Whether the object exists.                                          |
| Destroy(): ()   | function                                                                                   | Destroys the drawing.                                               |

### Line

Renders a line starting at `From` and ending at `To`.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `From` | Vector2 | The starting point of the line. |
| `To` | Vector2 | The ending point of the line. |
| `Thickness` | number | The thickness of the line. |

### Text

Renders text at `Position`.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `Text` | string | The text to render. |
| `TextBounds` | 🔒 Vector2 | The size of the text. Cannot be set. |
| `Font` | Drawing.Font | The font to use. |
| `Size` | number | The size of the text. |
| `Position` | Vector2 | The position of the text. |
| `Center` | boolean | Whether the text should be centered horizontally. |
| `Outline` | boolean | Whether the text should be outlined. |
| `OutlineColor` | Color3 | The color of the outline. |

### Image

Draws the image data to the screen. `Data` *must* be the raw image data.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `Data` | string | The raw image data of the file. You can use `readfile` or another method to read the raw bytecode of the image. |
| `Size` | Vector2 | The size of the image. |
| `Position` | Vector2 | The position of the image. |
| `Rounding` | number | The rounding of the image. |

### Circle

Draws a circle that is centered at `Position`.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `NumSides` | number | The sides number of the circle. |
| `Radius` | number | The radius of the circle. |
| `Position` | Vector2 | The center position of the circle. |
| `Thickness` | number | If `Filled` is false, specifies the thickness of the outline. |
| `Filled` | boolean | Whether the circle should be filled. |

### Square

Draws a rectangle starting at `Position` and ending at `Position` + `Size`.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `Size` | Vector2 | The size of the square. |
| `Position` | Vector2 | The top-left corner position of the square. |
| `Thickness` | number | If `Filled` is false, specifies the thickness of the outline. |
| `Filled` | boolean | Whether the square should be filled. |

### Quad

Draws a four-sided figure connecting to each of the four points.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `PointA` | Vector2 | The first point. |
| `PointB` | Vector2 | The second point. |
| `PointC` | Vector2 | The third point. |
| `PointD` | Vector2 | The fourth point. |
| `Thickness` | number | If `Filled` is false, specifies the thickness of the outline. |
| `Filled` | boolean | Whether the quad should be filled. |

### Triangle

Draws a triangle connecting to each of the three points.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `PointA` | Vector2 | The first point. |
| `PointB` | Vector2 | The second point. |
| `PointC` | Vector2 | The third point. |
| `Thickness` | number | If `Filled` is false, specifies the thickness of the outline. |
| `Filled` | boolean | Whether the triangle should be filled. |

---

### Example - `Image`

Upong replacing `your_image.png` and executing the example below, you should be able to see your image in the middle of the screen.

```luau
local Camera = game.Workspace.CurrentCamera
local Viewport = Camera.ViewportSize
local Position = Vector2.new(Viewport.X / 2, Viewport.Y / 2)
local image = Drawing.new("Image")
image.Data = readfile("your_image.png")
image.Size = Vector2.new(455, 155)
image.Visible = true
image.Position = Position

task.wait(2)
image:Destroy()
```

---

### Example - `__OBJECT_EXISTS`

```luau
local Camera = game.Workspace.CurrentCamera
local Viewport = Camera.ViewportSize
local Position = Vector2.new(Viewport.X / 2, Viewport.Y / 2)

local circle = Drawing.new("Circle")
circle.Radius = 50
circle.Color = Color3.fromRGB(255, 0, 0)
circle.Filled = true
circle.NumSides = 150
circle.Position = Position
circle.Transparency = 1
circle.Visible = true

print(circle.__OBJECT_EXISTS) -- Output: true
circle:Destroy()
print(circle.__OBJECT_EXISTS) -- Output: false
```

---

## cleardrawcache

Destroys every drawing object in the cache, invalidating references to the drawing objects.

```lua
function cleardrawcache(): ()
```

### Example

```luau
local Camera = game.Workspace.CurrentCamera
local Viewport = Camera.ViewportSize
local Position = Vector2.new(Viewport.X / 2, Viewport.Y / 2)

local circle = Drawing.new("Circle")
circle.Radius = 50
circle.Color = Color3.fromRGB(255, 0, 0)
circle.Filled = true
circle.NumSides = 1111
circle.Position = Position
circle.Transparency = 1
circle.Visible = true

task.defer(cleardrawcache)
print(circle.__OBJECT_EXISTS) -- Outpuut: true
task.wait()
print(circle.__OBJECT_EXISTS) -- Output: false
```

---

## getrenderproperty

Gets the value of a drawing property, functionally similar to `drawing[property]`.

```lua
function getrenderproperty(drawing: Drawing, property: string): any
```

### Parameters

- `drawing` - The drawing's property to get.
- `property` - The property.

### Example

```luau
local circle = Drawing.new("Circle")
circle.Radius = 50
print(getrenderproperty(circle, "Radius")) -- Output: 50
print(getrenderproperty(circle, "Visible")) -- Output: false
```

---

## setrenderproperty

Sets the value of a drawing property, functionally similar to `drawing[property] = value`.

```luau
function setrenderproperty(drawing: Drawing, property: string, value: any): ()
```

### Parameters

- `drawing` - The drawing's property to set.
- `property` - The property.
- `value` - The value to set the property to.

### Example

```luau
local circle = Drawing.new("Circle")
setrenderproperty(circle, "Radius", 50)
setrenderproperty(circle, "Visible", true)
print(circle.Radius) -- Output: 50
print(circle.Visible) -- Output: true
```

---

## isrenderobj

Returns whether `object` is a valid Drawing object.

```luau
function isrenderobj(object: any): boolean
```

### Parameters

- `object` - The object to determine.

### Example

```luau
print(isrenderobj(Drawing.new("Square"))) -- Output: true
print(isrenderobj(game)) -- Output: false
```
