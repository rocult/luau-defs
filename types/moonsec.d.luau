--#region MoonSec Macros
declare function MS_ENCRYPT(toEncrypt: string): string
declare function MS_WATERMARK(watermark: string): ()
declare function MOONSEC_EXIT(): never
declare function MOONSEC_GET_SCRIPT_ID(): number
