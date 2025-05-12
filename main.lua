--SDI Bus
local sdiAddresses = {}

-- Active zones
local activeZones = {}

-- who are sdi keypads
for i,v in pairs(script.Parent.SDI:GetChildren()) do
	table.insert(sdiAddresses,v.Name)
end

-- hi keypads
for i,v in pairs(script.Parent.SDI:GetChildren()) do
	local disp = v:FindFirstChild("Display")
	local pzo = v:FindFirstChild("Piezo")
	if v then
		task.wait()
		disp.Line1.Value = "THIS IS KP"..i
		pzo.Chime:Play()
	end
end

while true do
	for i,pt in pairs(script.Parent.Points:GetChildren()) do
		for j,dev in pairs(pt.Devices:GetChildren()) do
			if dev.Alarm.Value == true then
				print("In Alarm:")
			end
			print(dev.Alarm.Value == true and dev.Name.."\n" or dev.Name)
		end
	end
	task.wait(1)
end
