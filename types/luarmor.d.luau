declare script_key: string?
declare LRM_IsUserPremium: boolean
declare LRM_LinkedDiscordID: string?
declare LRM_ScriptName: string
declare LRM_TotalExecutions: number
declare LRM_SecondsLeft: number
declare LRM_UserNote: string
declare LRM_ScriptVersion: string

declare function LRM_INIT_SCRIPT(f: () -> ()): ()
declare function LRM_SEND_WEBHOOK(url: string, data: { [string]: any }): ()
declare function LRM_SANITIZE(value: any, regex: string): ()