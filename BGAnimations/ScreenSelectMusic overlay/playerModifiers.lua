-- This file is necessary to apply Speed Mods and Mini from profile(s).
-- These are normally applied in ScreenPlayerOptions, but there is the
-- possibility a player will not visit that screen, expecting mods to already
-- be set from a previous game.

return Def.ActorFrame{
	OnCommand=cmd(queuecommand,"ApplyModifiers"),
	PlayerJoinedMessageCommand=cmd(queuecommand,"ApplyModifiers"),
	ApplyModifiersCommand=function(self)
		-- there is the possibility a player just joined via latejoin
		-- so ensure that this is set correctly now
		if #GAMESTATE:GetHumanPlayers() > 1 then
			SL.Global.Gamestate.Style = "versus"
		end

		local Players = GAMESTATE:GetHumanPlayers()
		for player in ivalues(Players) do
			ApplySpeedMod(player)
			ApplyMini(player)
			
			local pn = ToEnumShortString(player)
			
			-- on first load of ScreenSelectMusic, PlayerOptions will be nil
			-- so set them here to whatever is default
			if not SL[pn].CurrentPlayerOptions.String then 
				SL[pn].CurrentPlayerOptions.String = GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Preferred")
			end
			
			GAMESTATE:GetPlayerState(player):SetPlayerOptions("ModsLevel_Preferred", SL[pn].CurrentPlayerOptions.String)
		end
	end
}