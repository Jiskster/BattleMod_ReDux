local B = CBW_Battle
local F = B.CTF
local R = B.Ruby

local str2global = function(str)
	local flagstate = pcall(do return _G[str] end)

	if flagstate then
		return _G[str]
	end
end

--[[ 
/* 	=== NOTE: ALL CUSTOM CTF FLAG HOOKS ARE CURRENTLY UNUSED! ===

	Real flags indicate flags that will be used in-game, and fake flags are
	the flags that will be replaced with the real flags.

	For this instance, REALFLAG_R (MT_REDFLAG) will replace FAKEFLAG_R (MT_CREDFLAG).

*/]]--
local REALFLAG_R = MT_REDFLAG
local REALFLAG_B = MT_BLUEFLAG
local FAKEFLAG_R = MT_CREDFLAG
local FAKEFLAG_B = MT_CBLUEFLAG

addHook("MobjThinker",F.TrackRed, REALFLAG_R)
addHook("MobjThinker",F.TrackBlue, REALFLAG_B)
addHook("MobjThinker",F.FlagIntangible,REALFLAG_R)
addHook("MobjThinker",F.FlagIntangible, REALFLAG_B)
addHook("MobjThinker",F.FlagMobjThinker,REALFLAG_R)
addHook("MobjThinker",F.FlagMobjThinker, REALFLAG_B)
addHook("TouchSpecial", F.TouchFlag, REALFLAG_R)
addHook("TouchSpecial", F.TouchFlag, REALFLAG_B)
addHook("ThinkFrame",F.TrackPlayers)
addHook("MobjSpawn", function(flag)
	local flagstate = str2global(mapheaderinfo[gamemap].blueflag_state)

	if (flagstate) then
		flag.state = flagstate
	end

	flag.tics = -1 // remove when done with branch
end, REALFLAG_R)

addHook("MobjSpawn", function(flag)
	local flagstate = str2global(mapheaderinfo[gamemap].blueflag_state)

	if (flagstate) then
		flag.state = flagstate
	end

	flag.tics = -1 // remove when done with branch
end, REALFLAG_B)

addHook("MobjThinker",B.Arena.RingLoss, MT_FLINGRING)

-- Draw GOT FLAG! indicator on player.
addHook("PostThinkFrame", F.DrawIndicator)

-- Check if flag was tossed or capped, etc.
addHook("PreThinkFrame", F.FlagPreThinker) 

-- Toss ruby
--addHook("PreThinkFrame", R.PreThinker) 
