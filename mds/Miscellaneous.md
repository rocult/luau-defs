# Miscellaneous

The **miscellaneous** functions are a collection of functions that have no designated category.

---

## identifyexecutor

Returns the name and version of the current executor, first string contains the executor's identifier and the second contains the version of the executor.

```luau
function identifyexecutor(): (string, string)
```

### Example

```luau
local ExecName, ExecVersion = identifyexecutor()
print(ExecName, ExecVersion) -- Output: "YourName 0.0.1"
```
---

## request

Sends an HTTP request with the given options, yielding until the request is finished, and returns the response.

```luau
function request(options: Request): Response
```

### Request

| Field | Type | Description |
| ----- | ---- | ----------- |
| `Url` | string | The URL for the request. |
| `Method` | string | The HTTP method to use. Can be `GET`, `POST`, `PATCH`, or `PUT`. |
| `Body` | string? | The body of the request. |
| `Headers` | table? | A table of headers. |
| `Cookies` | table? | A table of cookies. |

### Response

| Field | Type | Description |
| ----- | ---- | ----------- |
| `Body` | string | The body of the response. |
| `StatusCode` | number | The number status code of the response. |
| `StatusMessage` | string | The status message of the response. |
| `Success` | boolean | Whether or not the request was successful. |
| `Headers` | table | A dictionary of headers. |

### Headers

The executor provides the following headers for identification on a web server:

| Header | Description |
| ------ | ----------- |
| `PREFIX-User-Identifier` | A string unique to each user, and does not change if the script executor is used across computers. |
| `PREFIX-Fingerprint` | The hardware identifier of the user. |
| `User-Agent` | The name and version of the executor. |

### Parameters

- `options` - The options to use.

### Examples
```luau
local Response = request({
	Url = "http://httpbin.org/get",
	Method = "GET",
})

local RetrievedFingerprint

local Decoded = game:GetService("HttpService"):JSONDecode(Response.Body)
for i, v in pairs(Decoded["headers"]) do
    if i:match("Fingerprint") then RetrievedFingerprint = i break end
end

print(Response.StatusCode) -- Output: 200
print(Response.Success) -- Output: true
print(RetrievedFingerprint) -- Output: Prefix-Fingerprint ("Prefix" being the exec's name)
```

```luau
local Response = request({
	Url = "http://httpbin.org/post",
	Method = "POST",
	Body = "Example"
})

print(Response.StatusMessage) -- Output: 200
print(Response.StatusCode) -- Output: true
print(game:GetService("HttpService"):JSONDecode(Response.Body).data) -- Output: Example
```
