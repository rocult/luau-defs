# Cryptography

Functions made for encrypting and decrypting data.

---

## crypt.base64encode

Encodes a string with Base64 encoding.

```luau
function crypt.base64encode(data: string): string
```

### Parameters

- `data` - The data to encode.

### Example

```luau
print(crypt.base64encode("DummyString\0\2")) -- Output: RHVtbXlTdHJpbmcAAg==
```

---

## crypt.base64decode

Decodes a Base64 string into its original form.

```luau
function crypt.base64decode(data: string): string
```

### Parameters

- `data` - The data to decode.

```luau
local bytecode = game:HttpGet("https://rubis-api.numelon.com/v2/scrap/zuxQZuM9Tnl5MRbo/raw")
writefile("sound.mp3", crypt.base64decode(bytecode)) -- This file should be a valid and working mp3 file.
```
