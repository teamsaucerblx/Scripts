--[[ Cracked by team sauce
now v5!
]]--

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Character
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Invisible part for alignment
local Folder = Instance.new("Folder", workspace)
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

-- Network setup (only once)
if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(14.4626, 14.4626, 14.4626)
	}

	Network.RetainPart = function(part)
		if typeof(part) == "Instance" and part:IsA("BasePart") and part:IsDescendantOf(workspace) then
			table.insert(Network.BaseParts, part)
			part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			part.CanCollide = false
		end
	end

	RunService.Heartbeat:Connect(function()
		sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
		for _, p in pairs(Network.BaseParts) do
			if p:IsDescendantOf(workspace) then
				p.Velocity = Network.Velocity
			end
		end
	end)
end

-- Function to modify parts
local function ForcePart(v)
	if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
		for _, x in ipairs(v:GetChildren()) do
			if x:IsA("BodyMover") or x:IsA("RocketPropulsion") then
				x:Destroy()
			end
		end
		v:ClearAllChildren()

		v.CanCollide = false
		local Torque = Instance.new("Torque", v)
		Torque.Torque = Vector3.new(100000, 100000, 100000)
		local AlignPosition = Instance.new("AlignPosition", v)
		local Attachment2 = Instance.new("Attachment", v)
		Torque.Attachment0 = Attachment2
		AlignPosition.MaxForce = 999999999
		AlignPosition.MaxVelocity = math.huge
		AlignPosition.Responsiveness = 200
		AlignPosition.Attachment0 = Attachment2
		AlignPosition.Attachment1 = Attachment1
	end
end

-- Sound helper
local function playSound(soundId)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. soundId
	sound.Parent = SoundService
	sound:Play()
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

-- Initial sound
playSound("2865227271")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperRingPartsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 190)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -95)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 102, 51)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Super Ring Parts v5"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 153, 76)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = Title

-- Toggle button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0, 35)
ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleButton.Text = "Ring Parts Off"
ToggleButton.BackgroundColor3 = Color3.fromRGB(160, 82, 45)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 15
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

-- Radius control
local radius = 50
local height = 100
local rotationSpeed = 0.5
local attractionStrength = 1000
local ringPartsEnabled = false

local DecreaseRadius = Instance.new("TextButton")
DecreaseRadius.Size = UDim2.new(0.2, 0, 0, 35)
DecreaseRadius.Position = UDim2.new(0.1, 0, 0.6, 0)
DecreaseRadius.Text = "<"
DecreaseRadius.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
DecreaseRadius.TextColor3 = Color3.fromRGB(0, 0, 0)
DecreaseRadius.Font = Enum.Font.GothamBold
DecreaseRadius.TextSize = 18
DecreaseRadius.Parent = MainFrame

local IncreaseRadius = Instance.new("TextButton")
IncreaseRadius.Size = UDim2.new(0.2, 0, 0, 35)
IncreaseRadius.Position = UDim2.new(0.7, 0, 0.6, 0)
IncreaseRadius.Text = ">"
IncreaseRadius.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
IncreaseRadius.TextColor3 = Color3.fromRGB(0, 0, 0)
IncreaseRadius.Font = Enum.Font.GothamBold
IncreaseRadius.TextSize = 18
IncreaseRadius.Parent = MainFrame

local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Size = UDim2.new(0.4, 0, 0, 35)
RadiusDisplay.Position = UDim2.new(0.3, 0, 0.6, 0)
RadiusDisplay.Text = "Radius: 50"
RadiusDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
RadiusDisplay.TextColor3 = Color3.fromRGB(0, 0, 0)
RadiusDisplay.Font = Enum.Font.GothamBold
RadiusDisplay.TextSize = 15
RadiusDisplay.Parent = MainFrame

-- Part collection
local parts = {}
local function RetainPart(p)
	if p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(LocalPlayer.Character) then
		p.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		p.CanCollide = false
		if not table.find(parts, p) then
			table.insert(parts, p)
		end
	end
end

local function RemovePart(p)
	local i = table.find(parts, p)
	if i then
		table.remove(parts, i)
	end
end

for _, p in pairs(workspace:GetDescendants()) do
	RetainPart(p)
end

workspace.DescendantAdded:Connect(RetainPart)
workspace.DescendantRemoving:Connect(RemovePart)

-- Movement loop
RunService.Heartbeat:Connect(function()
	if not ringPartsEnabled then return end
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local tornadoCenter = hrp.Position
		for _, part in pairs(parts) do
			if part.Parent and not part.Anchored then
				local pos = part.Position
				local offset = Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter
				local dist = offset.Magnitude
				if dist > 0 then
					local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
					local newAngle = angle + math.rad(rotationSpeed)
					local targetPos = Vector3.new(
						tornadoCenter.X + math.cos(newAngle) * math.min(radius, dist),
						tornadoCenter.Y + (height * math.abs(math.sin((pos.Y - tornadoCenter.Y) / height))),
						tornadoCenter.Z + math.sin(newAngle) * math.min(radius, dist)
					)
					local dir = targetPos - part.Position
					if dir.Magnitude > 0 then
						part.Velocity = dir.Unit * attractionStrength
					end
				end
			end
		end
	end
end)

-- Button actions
ToggleButton.MouseButton1Click:Connect(function()
	ringPartsEnabled = not ringPartsEnabled
	ToggleButton.Text = ringPartsEnabled and "Ring Parts On" or "Ring Parts Off"
	ToggleButton.BackgroundColor3 = ringPartsEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(160, 82, 45)
	playSound("12221967")
end)

DecreaseRadius.MouseButton1Click:Connect(function()
	radius = math.max(0, radius - 5)
	RadiusDisplay.Text = "Radius: " .. radius
	playSound("12221967")
end)

IncreaseRadius.MouseButton1Click:Connect(function()
	radius = math.min(10000, radius + 5)
	RadiusDisplay.Text = "Radius: " .. radius
	playSound("12221967")
end)

-- Notifications
local userId = Players:GetUserIdFromNameAsync("Sito_Vega")
local content = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

local function notify(title, text)
	StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Icon = content,
		Duration = 5
	})
end

notify("Super ring parts V4", "enjoy")
notify("Credits", "Original By Yumm Scriptblox")
notify("Credits", "Edited By lukas")

CoreGui:SetCore("SendNotification", {
	Title = "More Credits",
	Text = "Also edited by team sauce",
	Icon = content,
	Duration = 5
})
