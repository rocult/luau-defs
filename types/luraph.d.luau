type GenericFunction<T, U...> = (U...) -> T

declare function LPH_ENCFUNC<T, U...>(toEncrypt: GenericFunction<T, U...>, encKey: string, decKey: string): GenericFunction<T, U...> 
declare function LPH_ENCSTR(toEncrypt: string): string
declare function LPH_ENCNUM(toEncrypt: number): number
declare function LPH_CRASH(): never
declare function LPH_JIT<T, U...>(toEnchance: GenericFunction<T, U...>): GenericFunction<T, U...>
declare function LPH_JIT_MAX<T, U...>(toEnchance: GenericFunction<T, U...>): GenericFunction<T, U...>
declare function LPH_NO_VIRTUALIZE<T, U...>(toDevirtualize: GenericFunction<T, U...>): GenericFunction<T, U...> 
declare function LPH_NO_UPVALUES<T, U...>(toFix: GenericFunction<T, U...>): GenericFunction<T, U...>
declare LPH_OBFUSCATED: boolean
declare LPH_LINE: number