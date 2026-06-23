type LuraphFunction<R...> = (...any) -> R...

declare function LPH_ENCFUNC<T, R...>(toEncrypt: T & LuraphFunction<R...>, encKey: string, decKey: string): T
declare function LPH_ENCSTR(toEncrypt: string): string
declare function LPH_ENCNUM(toEncrypt: number): number
declare function LPH_CRASH(): never
declare function LPH_JIT<T, R...>(toEnchance: T & LuraphFunction<R...>): T
declare function LPH_JIT_MAX<T, R...>(toEnchance: T & LuraphFunction<R...>): T
declare function LPH_NO_VIRTUALIZE<T, R...>(toDevirtualize: T & LuraphFunction<R...>): T
declare function LPH_NO_UPVALUES<T, R...>(toFix: T & LuraphFunction<R...>): T
declare LPH_OBFUSCATED: boolean
declare LPH_LINE: number