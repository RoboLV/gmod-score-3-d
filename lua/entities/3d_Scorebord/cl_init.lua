include("shared.lua")



local Rules={
	"1. Respect the other players, not hinder them.",
	"2. Do not flood propyl and other objects.",
	"3. Do not flood in chat, a microphone, do not cuss.",
	"4. Do not spawn log and annoying construction.",
	"5. Disable or change the annoying sound of thrusters"
}


surface.CreateFont( "ScoreBoardServer", {
	font = "Arial",
	size = 40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = true,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = true,
	outline = false
} )

surface.CreateFont( "ScoreBoard1", {
	font = "Arial",
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
} )


function ENT:Draw()
	cam.Start3D2D(self:GetPos() - self:GetAngles():Forward() * 190 + self:GetAngles():Right() * 190, self:GetAngles() + Angle(90, 90, 90), 0.3)
		
		ScoreBG = Color( 0, 0, 255, 100 )
		draw.RoundedBox(0,0,0, 1100, 90, ScoreBG)
		draw.RoundedBox(0,520,90, 580, 20+(table.Count(Rules)*40), ScoreBG)
		
		-- Hostname
		draw.SimpleText( GetHostName(), "ScoreBoardServer", 30 , 10 , Color(255, 255, 255, Motd_T), 0,0)
		
		textColor = Color(200, 200, 200, 255) -- The colum name color
		
		--Colums         Name     Font      pos X   Y    Color    
		draw.SimpleText("Nick" , "Trebuchet24", 50, 65 , textColor, 0,0)-- Colum Nick
		--draw.SimpleText("Team" , "Trebuchet24", 300, 65 , textColor, 0,0) -- Colum Team
		draw.SimpleText("Ping" , "Trebuchet24", 410, 65 , textColor, 0,0)-- Colum Ping
		draw.SimpleText("Frags" , "Trebuchet24", 460, 65 , textColor, 0,0)-- Colum Frags
		local i=0
		
		-- Spawn Rules
		
		for k,v in pairs(Rules) do
			draw.SimpleText(v , "ScoreBoard1", 550, 60+(k*30) , Color(255, 255, 255, Motd_T), 0,0)
		end
		
		-- End spawn rules
		
		-- The lop> Creating player line
		
		for k,v in pairs(player.GetAll()) do

			Tem = team.GetName(v:Team())
			RColor = team.GetColor(v:Team())
			
			if v:SteamID() == "STEAM_0:0:28757317" then
				RColor = Color( 255, 100, 0, 200 )
			end
			
			
			draw.RoundedBox(0,0,60+(k*30), 520, 25  , RColor /*Color(R, G, B, 150)*/)
			draw.SimpleText(k.."  "..v:Nick() , "ScoreBoard1", 20, 60+(k*30) , Color(0,0,0,255), 0,0)
			--draw.SimpleText(Tem, "ScoreBoard1", 300, 60+(k*30) , Color(0,0,0,255), 0,0)
			draw.SimpleText(v:Ping(), "ScoreBoard1", 410, 60+(k*30) , Color(0,0,0,255), 0,0)
			draw.SimpleText(v:Frags(), "ScoreBoard1", 475, 60+(k*30) , Color(0,0,0,255), 0,0)
			Players_m=k
		end
		
		-- Lop End
		
		
		draw.RoundedBox(0,520,0, 580, -80, ScoreBG)
		
		-- Mini fix :3
		maxpl = 1
		if not game.SinglePlayer() then
			maxpl = game.MaxPlayers( )
		end
		
		-- Server info
		draw.SimpleText("Map : "..game.GetMap(), "Trebuchet24", 540, -20 , Color(255, 255, 255, Motd_T), 0,0)
		draw.SimpleText("Gamemode : "..gmod.GetGamemode().Name, "Trebuchet24", 540, -40 , Color(255, 255, 255, Motd_T), 0,0)
		draw.SimpleText("Players "..table.Count( player.GetAll() ).."/"..maxpl, "Trebuchet24", 540, -60 , Color(255, 255, 255, Motd_T), 0,0)



	cam.End3D2D()
end
	




