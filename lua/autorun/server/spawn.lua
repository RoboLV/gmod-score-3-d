

local map = game.GetMap()

local mapfile = "3D_Scoreboard.txt"

local rulesfile = "3D_scoreboard_rules.txt"

if not file.Exists( mapfile, "DATA" ) then
	file.Write( mapfile, "" )
end

if not file.Exists( rulesfile, "DATA" ) then
	file.Write( mapfile, [[1. Respect the other players, not hinder them.
2. Do not flood propyl and other objects.
3. Do not flood in chat, a microphone, do not cuss.
4. Do not spawn log and annoying construction.
5. Disable or change the annoying sound of thrusters.]] )
end

concommand.Add( "setscoreboard", function( ply )
	if not ply:IsAdmin() or not ply:IsSuperAdmin() then return end
	pos = ply:GetPos()
	ang = ply:GetAngles()
	
	format = string.format( "%s %s %s\n", map, pos, ang )
	maps = file.Read( mapfile, "DATA" )
	maplist = string.Explode( "\n", maps )
	table.remove( maplist, table.Count( maplist ) )
	
	for k,v in pairs( maplist ) do
		if string.find( v, map ) then
			table.remove( maplist, k )
		end
	end
	
	table.insert( maplist, format )
	out = table.concat( maplist, "\n" )
	
	file.Write( mapfile, out )
	
	Score_spawn()
end)

function Score_spawn()
	
	maps = file.Read( mapfile, "DATA" )
	if maps == "" then return end
	maplist = string.Explode( "\n", maps )
	
	rules = file.Read( rulesfile, "DATA" )
	
	for k,v in pairs( maplist ) do
		if string.find( v, map ) then
			
			p = string.Explode( " ", v )
			pos = Vector( p[2], p[3], p[4] + 300)
			ang = Angle( p[5] - 90, p[6], p[7] )
			
			if ScoreboardE then
				ScoreboardE:Remove()
			end
			
			print( pos )
			
			ScoreboardE = ents.Create( "3d_Scorebord" )
			ScoreboardE:SetPos( pos )
			ScoreboardE:SetAngles( ang )
			ScoreboardE:Spawn() 
			
		end
	end
	
end

hook.Add("InitPostEntity", "SpawnScoreboard", Score_spawn)
