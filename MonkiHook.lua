-- init
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if not syn or not protectgui then
	getgenv().protectgui = function() end
end

local resume = coroutine.resume
local create = coroutine.create

local CoreGui = game:GetService("StarterGui")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
--------
ESP.Boxes = false
ESP.Names = false
ESP.Tracers = false
ESP.TeamMates = false

local velspeed = false
local speed = 35
local LOCAL_PLAYER = game:GetService("Players").LocalPlayer
local INPUT_SERVICE = game:GetService("UserInputService")

local function SpeedHack()
    resume(create(function()
        while velspeed do
            local rootpart = LOCAL_PLAYER.Character:FindFirstChild("HumanoidRootPart")
            if rootpart ~= nil then
                local travel = Vector3.new()
                local looking = Workspace.CurrentCamera.CFrame.lookVector
                if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.W) then
                    travel += Vector3.new(looking.x, 0, looking.Z)
                end
                if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.S) then
                    travel -= Vector3.new(looking.x, 0, looking.Z)
                end
                if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.D) then
                    travel += Vector3.new(-looking.Z, 0, looking.x)
                end
                if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.A) then
                    travel += Vector3.new(looking.Z, 0, -looking.x)
                end

                travel = travel.Unit

                local newDir = Vector3.new(travel.x * speed, rootpart.Velocity.y, travel.Z * speed)

                if travel.Unit.x == travel.Unit.x then
                    rootpart.Velocity = newDir
                end
            end
            task.wait(0.01)
        end
    end))
end

speed2 = 35

local function FlyHack()
    local rootpart = LOCAL_PLAYER.Character:FindFirstChild("HumanoidRootPart")

    for lI, lV in pairs(LOCAL_PLAYER.Character:GetDescendants()) do
        if lV:IsA("BasePart") then
            lV.CanCollide = false
        end
    end

    resume(create(function()
        while velfly do
            local travel = Vector3.new()
            local looking = workspace.CurrentCamera.CFrame.lookVector --getting camera looking vector
    
            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.W) then
                travel += looking
            end
            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.S) then
                travel -= looking
            end
            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.D) then
                travel += Vector3.new(-looking.Z, 0, looking.x)
            end
            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.A) then
                travel += Vector3.new(looking.Z, 0, -looking.x)
            end

            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.Space) then
                travel += Vector3.new(0, 1, 0)
            end
            if INPUT_SERVICE:IsKeyDown(Enum.KeyCode.LeftShift) then
                travel -= Vector3.new(0, 1, 0)
            end

            if travel.Unit.x == travel.Unit.x then
                rootpart.Anchored = false
                rootpart.Velocity = travel.Unit * speed2 --multiplaye the unit by the speed to make
            else
                rootpart.Velocity = Vector3.new(0, 0, 0)
                rootpart.Anchored = false
            end
            task.wait(0.01)
        end
    end))
end

---------------------- Part Deleter and stuff
local function PartDeleter()
    local Head = game:GetService("Players").LocalPlayer.Character.Head
    local MyRayCast = Ray.new(Head.CFrame.p, Head.CFrame.LookVector * 100)
    local part = workspace:FindPartOnRay(MyRayCast)
    if part then
        part.Position = Vector3.new(50,0,0)
    end
end
----------------------

------------------------ Aimbot
local Area = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MyCharacter = LocalPlayer.Character
local MyRoot = MyCharacter:FindFirstChild("HumanoidRootPart")
local MyHumanoid = MyCharacter:FindFirstChild("Humanoid")
local Mouse = LocalPlayer:GetMouse()
local MyView = Area.CurrentCamera
local MyTeamColor = LocalPlayer.TeamColor
local HoldingM2 = false
local Active = false
local Lock = false
local Epitaph = 0.167 ---Note: The Bigger The Number, The More Prediction.
local HeadOffset = Vector3.new(0, .1, 0)

_G.TeamCheck = false
_G.AimPart = "Head"
_G.Sensitivity = 0
_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 100
_G.CircleRadius = 200
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 1
_G.AimbotON = false

local FOVCircle = Drawing.new("Circle")

FOVCircle.Position = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

local function CursorLock()
    UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
end
local function UnLockCursor()
    HoldingM2 = false Active = false Lock = false 
    UIS.MouseBehavior = Enum.MouseBehavior.Default
end
function FindNearestPlayer()
    local dist = math.huge
    local Target = nil
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") and v then
            local TheirCharacter = v.Character
            local CharacterRoot, Visible = MyView:WorldToViewportPoint(TheirCharacter[_G.AimPart].Position)
            if Visible then
                local RealMag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(CharacterRoot.X, CharacterRoot.Y)).Magnitude
                if RealMag < dist and RealMag < FOVCircle.Radius then
                    dist = RealMag
                    Target = TheirCharacter
                end
            end
        end
    end
    return Target
end

UIS.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        HoldingM2 = true
        Active = true
        Lock = true
        if Active then
            local The_Enemy = FindNearestPlayer()
            while HoldingM2 do task.wait(.000001)
                if Lock and The_Enemy ~= nil then
                    if _G.AimbotON == true then
                        local Future = The_Enemy[_G.AimPart].CFrame + (The_Enemy.HumanoidRootPart.Velocity * Epitaph + HeadOffset)
                        MyView.CFrame = CFrame.lookAt(MyView.CFrame.Position, Future.Position)
                        CursorLock()
                    end
                end
            end
        end
    end
end)
UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        UnLockCursor()
    end
end)
resume(create(function()
    while true do
        FOVCircle.Radius = _G.CircleRadius
        FOVCircle.Filled = _G.CircleFilled
        FOVCircle.Color = _G.CircleColor
        FOVCircle.Visible = _G.CircleVisible
        FOVCircle.Transparency = _G.CircleTransparency
        FOVCircle.NumSides = _G.CircleSides
        FOVCircle.Thickness = _G.CircleThickness
        wait(0.01)
    end
end))
------------------------

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'MonkiHook v0.23',
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals'),
    Movement = Window:AddTab('Movement'),
    Exploits = Window:AddTab('Exploits'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

--local LeftGroupBox = Tabs.Combat:AddLeftGroupbox('Silent Aim')

local RightGroupbox = Tabs.Combat:AddRightGroupbox('Aimbot')

RightGroupbox:AddToggle('aimyy', {
	Text = 'Aimbot',
	Default = false,
	Tooltip = 'Toggles Aimbot',
})

Toggles.aimyy:OnChanged(function()
	_G.AimbotON = Toggles.aimyy.Value
end)

local RightGroupbox2 = Tabs.Combat:AddRightGroupbox('Aimbot Settings')

RightGroupbox2:AddToggle('teammateeee', {
	Text = 'TeamCheck',
	Default = false,
	Tooltip = 'Toggles Aimbot Teamcheck',
})

Toggles.teammateeee:OnChanged(function()
	_G.TeamCheck = Toggles.teammateeee.Value
end)

RightGroupbox2:AddDropdown('targetpartyaaim', {
	Values = { 'Head', 'HumanoidRootPart' },
	Default = 1,
	Multi = false,

	Text = 'Aimbot Aim Target',
	Tooltip = 'Changes the Aimbot Target',
})

Options.targetpartyaaim:OnChanged(function()
	_G.AimPart = Options.targetpartyaaim.Value
end)

RightGroupbox2:AddSlider('senssssss', {
	Text = 'Prediction Amount',

	Default = 0.167,
	Min = 0,
	Max = 1,
	Rounding = 1,

	Compact = false,
})
Options.senssssss:OnChanged(function()
	Epitaph = Options.senssssss.Value
end)

RightGroupbox2:AddSlider('siedsfoccc', {
	Text = 'Fov Sides',

	Default = 64,
	Min = 3,
	Max = 128,
	Rounding = 0,

	Compact = false,
})

Options.siedsfoccc:OnChanged(function()
	_G.CircleSides = Options.siedsfoccc.Value
end)

RightGroupbox2:AddSlider('trannsssdasdasd', {
	Text = 'Fov Transperancy',

	Default = 70,
	Min = 0,
	Max = 100,
	Rounding = 1,

	Compact = false,
})
Options.trannsssdasdasd:OnChanged(function()
	_G.CircleTransparency = Options.trannsssdasdasd.Value
end)

RightGroupbox2:AddSlider('radsdasdasd', {
	Text = 'Aimbot Fov Radius',

	Default = 80,
	Min = 0,
	Max = 640,
	Rounding = 0,

	Compact = false,
})
Options.radsdasdasd:OnChanged(function()
	_G.CircleRadius = Options.radsdasdasd.Value
end)

RightGroupbox2:AddToggle('filledasdasda', {
	Text = 'Fov Filled',
	Default = false,
	Tooltip = 'Toggles Fov Filled',
})

Toggles.filledasdasda:OnChanged(function()
	_G.CircleFilled = Toggles.filledasdasda.Value
end)

RightGroupbox2:AddToggle('fovenabledvis', {
	Text = 'Fov Visible',
	Default = false,
	Tooltip = 'Toggles Fov Visible',
})

Toggles.fovenabledvis:OnChanged(function()
	_G.CircleVisible = Toggles.fovenabledvis.Value
end)

RightGroupbox2:AddSlider('thiccccc', {
	Text = 'Aimbot Fov thickness',

	Default = 0,
	Min = 0,
	Max = 3,
	Rounding = 1,

	Compact = false,
})
Options.thiccccc:OnChanged(function()
	_G.CircleThickness = Options.thiccccc.Value
end)

local GroupBox = Tabs.Visuals:AddLeftGroupbox('Esp')

GroupBox:AddToggle("espppppppp", {Text = "ESP", Default = false}):OnChanged(function()
	ESP:Toggle(Toggles.espppppppp.Value)
end)

GroupBox:AddToggle("boxes", {Text = "Boxes", Default = false}):OnChanged(function()
	ESP.Boxes = Toggles.boxes.Value
end)

GroupBox:AddToggle("names", {Text = "Names", Default = false}):OnChanged(function()
	ESP.Names = Toggles.names.Value
end)

GroupBox:AddToggle("tracers", {Text = "Tracers", Default = false}):OnChanged(function()
	ESP.Tracers = Toggles.tracers.Value
end)

GroupBox:AddToggle("teannate", {Text = "Teammates", Default = false}):OnChanged(function()
	ESP.TeamMates = Toggles.teannate.Value
end)

GroupBox:AddLabel('Esp Color'):AddColorPicker('Espcolor', {
	Default = Color3.fromRGB(255, 255, 255),
	Title = 'Esp Color'
})

Options.Espcolor:OnChanged(function()
    ESP.Color = --[[Color3.fromRGB]](Options.Espcolor.Value)
end)

--[[local GroupBox4 = Tabs.Visuals:AddRightGroupbox('Ores')

resume(create(function()
    GroupBox4:AddToggle("StoneOre", {Text = "Stone Ore ESP", Default = false}):OnChanged(function()
        if Toggles.StoneOre.Value then
            while Toggles.StoneOre.Value do
                for i,v1 in pairs(game:GetService("Workspace").Suroviny:GetChildren()) do
                    if v1.Name == "StoneOre" then
                        local a = Instance.new("BillboardGui",v)
                        a.Size = UDim2.new(1,0, 1,0)
                        a.Name = "A"
                        a.AlwaysOnTop = true
                        local b = Instance.new("Frame",a)
                        b.Size = UDim2.new(1,0, 1,0)
                        b.BackgroundTransparency = 1
                        b.BorderSizePixel = 0
                        local c = Instance.new("TextLabel",b)
                        c.Text = "Stone Ore"
                        c.Size = UDim2.new(1,0, 1,0)
                        c.BackgroundTransparency = 1
                        c.BorderSizePixel = 0
                        c.TextColor3 = Color3.fromRGB(255,255,255)
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Suroviny:GetChildren()) do
                if v1.Name == "StoneOre" then
                    for __,v in pairs(v1:GetChildren()) do
                        for i,v2 in pairs(v1:GetChildren()) do
                            if v2:IsA("Model") or v2:IsA("Part") or v2:IsA("MeshPart") then
                                for i,v3 in pairs(v2:GetChildren()) do
                                    v3:Destroy()
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end))]]

local GroupBox = Tabs.Movement:AddLeftGroupbox('Player')

GroupBox:AddToggle("velspeedy", {Text = "Speed", Default = false}):AddKeyPicker("speed_Enabled_KeyPicker", {Default = "RightAlt", SyncToggleState = true, Mode = "Toggle", Text = "Speed", NoUI = false});
    Options.speed_Enabled_KeyPicker:OnClick(function()
    velspeed = Toggles.velspeedy.Value
    if velspeed then
        SpeedHack()
    end
end)

Toggles.velspeedy:OnChanged(function()
    velspeed = Toggles.velspeedy.Value
    if velspeed then
        SpeedHack()
    end
end)

GroupBox:AddSlider("speedthing", {Text = "Speed", Min = 0, Max = 40, Default = 20, Rounding = 0}):OnChanged(function()
	speed = Options.speedthing.Value
end)

--[[GroupBox:AddToggle("velfly", {Text = "Fly", Default = false}):AddKeyPicker("fly_Enabled_KeyPicker", {Default = "LeftAlt", SyncToggleState = true, Mode = "Toggle", Text = "Fly", NoUI = false});
    Options.fly_Enabled_KeyPicker:OnClick(function()
    velfly = Toggles.velfly.Value
    if velfly then
        FlyHack()
    end
end)

Toggles.velfly:OnChanged(function()
    velfly = Toggles.velfly.Value
    if velfly then
        FlyHack()
    end
end)

GroupBox:AddSlider("speedthing2", {Text = "Fly Speed", Min = 0, Max = 40, Default = 35, Rounding = 0}):OnChanged(function()
	speed2 = Options.speedthing2.Value
end)]]

local RightGroupbox = Tabs.Exploits:AddRightGroupbox('Bases')

RightGroupbox:AddToggle("partdeleter", {Text = "Crtl + Click Delete", Default = false}):OnChanged(function()
    Mouse.Button1Down:connect(function()
        if Toggles.partdeleter.Value then
            if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
            if not Mouse.Target then return end
            PartDeleter()
        end
    end)
end)

Library:SetWatermarkVisibility(true)

Library:SetWatermark('MonkiHook v0.01')

Library.KeybindFrame.Visible = true;

Library:OnUnload(function()
    Library.Unloaded = true
end)

-- UI Settings
Library:OnUnload(function()
	print('MonkiHook gone :(')
	Library.Unloaded = true
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
local ui = Tabs['UI Settings']:AddRightGroupbox('UI')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('MonkEEEEEE')
SaveManager:SetFolder('MonkEEEEEE/configs')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
-------------
ui:AddToggle('watermark', {
	Text = 'WaterMark',
	Default = true,
	Tooltip = 'Toggles the Water Mark',
})

Toggles.watermark:OnChanged(function()
	mark = Toggles.watermark.Value
	Library:SetWatermarkVisibility(mark)
end)
-------------
ui:AddToggle('Keybinds', {
	Text = 'KeyBind List',
	Default = false,
	Tooltip = 'Toggles the KeyBind List',
})

Toggles.Keybinds:OnChanged(function()
	keybind = Toggles.Keybinds.Value
	Library.KeybindFrame.Visible = keybind
end)