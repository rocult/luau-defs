type GenericFunction<A..., R...> = (A...) -> R...

declare function LPH_ENCFUNC<T, A..., R...>(toEncrypt: T & GenericFunction<A..., R...>, encKey: string, decKey: string): T
declare function LPH_ENCSTR(toEncrypt: string): string
declare function LPH_ENCNUM(toEncrypt: number): number
declare function LPH_CRASH(): never
declare function LPH_JIT<T, A..., R...>(toEnchance: T & GenericFunction<A..., R...>): T
declare function LPH_JIT_MAX<T, A..., R...>(toEnchance: T & GenericFunction<A..., R...>): T
declare function LPH_NO_VIRTUALIZE<T, A..., R...>(toDevirtualize: T & GenericFunction<A..., R...>): T
declare function LPH_NO_UPVALUES<T, A..., R...>(toFix: T & GenericFunction<A..., R...>): T
declare LPH_OBFUSCATED: boolean
declare LPH_LINE: number