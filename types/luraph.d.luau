type GenericFunction<A..., R...> = (A...) -> R...

declare function LPH_ENCFUNC<A..., R...>(toEncrypt: GenericFunction<A..., R...>, encKey: string, decKey: string): GenericFunction<A..., R...> 
declare function LPH_ENCSTR(toEncrypt: string): string
declare function LPH_ENCNUM(toEncrypt: number): number
declare function LPH_CRASH(): never
declare function LPH_JIT<A..., R...>(toEnchance: GenericFunction<A..., R...>): GenericFunction<A..., R...>
declare function LPH_JIT_MAX<A..., R...>(toEnchance: GenericFunction<A..., R...>): GenericFunction<A..., R...>
declare function LPH_NO_VIRTUALIZE<A..., R...>(toDevirtualize: GenericFunction<A..., R...>): GenericFunction<A..., R...> 
declare function LPH_NO_UPVALUES<A..., R...>(toFix: GenericFunction<A..., R...>): GenericFunction<A..., R...>
declare LPH_OBFUSCATED: boolean
declare LPH_LINE: number