--[[ Cracked by team sauce - now v5!
Optimized & merged to reduce lag
]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- GUI Parent
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SuperRingPartsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = gethui and gethui() or game:GetService("CoreGui")

-- Play sound helper
local function playSound(id)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://" .. id
    s.Parent = SoundService
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end
playSound("2865227271") -- initial sound

-- GUI Setup
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 190)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -95)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 102, 51)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Super Ring Parts v5"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(0, 153, 76)
Title.Font = Enum.Font.Fondamento
Title.TextSize = 22
Title.Parent = MainFrame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 20)

-- Buttons
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0, 35)
ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleButton.Text = "Ring Parts Off"
ToggleButton.BackgroundColor3 = Color3.fromRGB(160, 82, 45)
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Font = Enum.Font.Fondamento
ToggleButton.TextSize = 15
ToggleButton.Parent = MainFrame
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

local DecreaseRadius = Instance.new("TextButton")
DecreaseRadius.Size = UDim2.new(0.2, 0, 0, 35)
DecreaseRadius.Position = UDim2.new(0.1, 0, 0.6, 0)
DecreaseRadius.Text = "<"
DecreaseRadius.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
DecreaseRadius.TextColor3 = Color3.new(0,0,0)
DecreaseRadius.Font = Enum.Font.Fondamento
DecreaseRadius.TextSize = 18
DecreaseRadius.Parent = MainFrame
Instance.new("UICorner", DecreaseRadius).CornerRadius = UDim.new(0, 10)

local IncreaseRadius = DecreaseRadius:Clone()
IncreaseRadius.Text = ">"
IncreaseRadius.Position = UDim2.new(0.7, 0, 0.6, 0)
IncreaseRadius.Parent = MainFrame

local RadiusDisplay = Instance.new("TextLabel")
RadiusDisplay.Size = UDim2.new(0.4, 0, 0, 35)
RadiusDisplay.Position = UDim2.new(0.3, 0, 0.6, 0)
RadiusDisplay.Text = "Radius: 50"
RadiusDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
RadiusDisplay.TextColor3 = Color3.new(0,0,0)
RadiusDisplay.Font = Enum.Font.Fondamento
RadiusDisplay.TextSize = 15
RadiusDisplay.Parent = MainFrame
Instance.new("UICorner", RadiusDisplay).CornerRadius = UDim.new(0, 10)

local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 1, -20)
Watermark.Text = "Super Ring [V5] by lukas!"
Watermark.TextColor3 = Color3.new(1,1,1)
Watermark.BackgroundTransparency = 1
Watermark.Font = Enum.Font.Fondamento
Watermark.TextSize = 14
Watermark.Parent = MainFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
MinimizeButton.TextColor3 = Color3.new(1,1,1)
MinimizeButton.Font = Enum.Font.Fondamento
MinimizeButton.TextSize = 15
MinimizeButton.Parent = MainFrame
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 15)

-- Minimize
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 40), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "+"
        ToggleButton.Visible = false
        DecreaseRadius.Visible = false
        IncreaseRadius.Visible = false
        RadiusDisplay.Visible = false
        Watermark.Visible = false
    else
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 190), "Out", "Quad", 0.3, true)
        MinimizeButton.Text = "-"
        ToggleButton.Visible = true
        DecreaseRadius.Visible = true
        IncreaseRadius.Visible = true
        RadiusDisplay.Visible = true
        Watermark.Visible = true
    end
    playSound("12221967")
end)

-- Draggable GUI
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- Network System (only one instance now)
if not getgenv().Network then
    getgenv().Network = { BaseParts = {}, Velocity = Vector3.new(14.4626, 14.4626, 14.4626) }
    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
            Part.CanCollide = false
        end
    end
    RunService.Heartbeat:Connect(function()
        sethiddenproperty(LocalPlayer, "SimulationRadius", 1e10)
        for _, Part in ipairs(Network.BaseParts) do
            if Part and Part:IsDescendantOf(Workspace) then
                Part.Velocity = Network.Velocity
            end
        end
    end)
end

-- Ring Parts System
local radius, height, rotationSpeed, attractionStrength = 50, 100, 0.5, 1000
local ringPartsEnabled = false
local parts = {}

local function isValidPart(p)
    return p:IsA("BasePart") and not p.Anchored and not p:IsDescendantOf(LocalPlayer.Character)
end

local function addPart(p)
    if isValidPart(p) and not table.find(parts, p) then
        table.insert(parts, p)
    end
end

local function removePart(p)
    local i = table.find(parts, p)
    if i then table.remove(parts, i) end
end

for _, p in ipairs(Workspace:GetDescendants()) do addPart(p) end
Workspace.DescendantAdded:Connect(addPart)
Workspace.DescendantRemoving:Connect(removePart)

RunService.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local center = hrp.Position
    for _, part in ipairs(parts) do
        if part and part.Parent and (part.Position - center).Magnitude <= radius * 1.5 then
            local pos = part.Position
            local dist = (Vector3.new(pos.X, center.Y, pos.Z) - center).Magnitude
            local angle = math.atan2(pos.Z - center.Z, pos.X - center.X) + math.rad(rotationSpeed)
            local targetPos = Vector3.new(
                center.X + math.cos(angle) * math.min(radius, dist),
                center.Y + height * math.abs(math.sin((pos.Y - center.Y) / height)),
                center.Z + math.sin(angle) * math.min(radius, dist)
            )
            local dir = (targetPos - part.Position).Unit
            part.Velocity = dir * attractionStrength
        end
    end
end)

-- Button Actions
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
local uid = Players:GetUserIdFromNameAsync("Robloxlukasgames")
local content = Players:GetUserThumbnailAsync(uid, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
local function notify(title, text)
    StarterGui:SetCore("SendNotification", { Title = title, Text = text, Icon = content, Duration = 5 })
end
notify("Super ring parts V5", "enjoy")
notify("Credits", "Original By Yumm Scriptblox")
notify("Credits", "Edited By lukas")
StarterGui:SetCore("SendNotification", {
    Title = "More Credits",
    Text = "Also edited by team sauce",
    Icon = content,
    Duration = 5
})
