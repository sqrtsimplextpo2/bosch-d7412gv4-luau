--SDI Bus
local sdiAddresses = {}

-- Active zones
local activeZones = {}


-- who are sdi keypads
for i,v in pairs(script.Parent.SDI:GetChildren()) do
	table.insert(sdiAddresses,v.Name)
end

function sdiKeypad(dp,snd)
	for i,v in pairs(script.Parent.SDI:GetChildren()) do
		local disp = v:FindFirstChild("Display")
		local pzo = v:FindFirstChild("Piezo")
		if v then
			task.wait()
			disp.Line1.Value = dp
			if snd == 0 then
				for j,snd in pairs(pzo:GetChildren()) do
					if snd and snd:IsA("Sound") then
						snd.Playing = false
					end
				end
			elseif snd == 1 then -- Burglary Alarm
				pzo.Alarm:Play()
			elseif snd == 2 then -- Arming Chime
				pzo.Arm:Play()
			elseif snd == 3 then -- Watch
				pzo.Chime:Play()
			elseif snd == 4 then -- Fire Alarm
				pzo.FireAlarm:Play()
			elseif snd == 5 then -- Trouble / Exit Now when arming
				pzo.Trouble:Play()
			end
		end
	end
end

-- hi keypads
for i,v in pairs(script.Parent.SDI:GetChildren()) do
	--[[local disp = v:FindFirstChild("Display")
	local pzo = v:FindFirstChild("Piezo")
	if v then
		task.wait()
		disp.Line1.Value = "THIS IS KP"..i
		pzo.Chime:Play()
	end]]
	
end

sdiKeypad("A1 AREA 1 IS OFF",0)

while true do
	for i,pt in pairs(script.Parent.Points:GetChildren()) do
		for j,dev in pairs(pt.Devices:GetChildren()) do
			if dev.Alarm.Value == true then
				local tempTable = {}
				table.insert(tempTable,pt) table.insert(tempTable,pt.PointName.Value) table.insert(tempTable,pt.PointType.Value)
				table.insert(activeZones,tempTable)
				if pt.PointType.Value == 3 or pt.PointType.Value == 4 or pt.PointType.Value == 5 then
					sdiKeypad("P"..pt.Name.." FIRE ALARM",4)
				elseif pt.PointType.Value == 1 or pt.PointType.Value == 7 or pt.PointType.Value == 8 or pt.PointType.Value == 10 or pt.PointType.Value == 11 or pt.PointType.Value == 13 then
					sdiKeypad("A1  "..#activeZones.." ALARMS",1)
					task.wait(2)
					sdiKeypad(string.upper(pt.PointName.Value))
					task.wait(2)
				end
			else
				--sdiKeypad("A1 AREA 1 IS OFF",0)
			end
			--print(dev.Alarm.Value == true and dev.Name.."\n" or dev.Name)
		end
	end
	task.wait(1)
end
