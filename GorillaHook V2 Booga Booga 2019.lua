if not game:IsLoaded() then game.Loaded:Wait() end
local OriginalWalk = 16
local resume = coroutine.resume
local create = coroutine.create
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")
local plyrs = game:GetService("Players")
local Unloaded = false
local FlySpeed = 0
local Speed = 0
local InvisPos = CFrame.new(7.00564957, -103.000023, -512.616943)
local OldInvis = 0
local OldS = 16
local FarmSize = 1
local rs = game:GetService("ReplicatedStorage")
local _RG = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.BubbleChat)._G
local itemData = require(rs.Modules.ItemData)
getgenv()._RG = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.BubbleChat)._G

local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()
espLib.options.boundingBox = false
espLib.options.outOfViewArrows = false
espLib.options.tracerOrigin = "Top"
espLib.options.teamCheck = false
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local GetChildren = game.GetChildren
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GuiInset = GuiService.GetGuiInset
local GetMouseLocation = UserInputService.GetMouseLocation

local ExpectedArguments = {
    ArgCountRequired = 2,
    Args = {
        "Instance", "Ray", "Instance", "boolean", "boolean"
    }
}

local ValidTargetParts = {"Head", "HumanoidRootPart"}

local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 180
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = Color3.fromRGB(255, 255, 255)

function getLP()
    return plyrs.LocalPlayer.Character
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local function getMousePosition()
    return GetMouseLocation(UserInputService)
end

local function getClosestPlayer()
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        local Character = Player.Character
        if not Character then continue end
        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Options.sfov.Value or 2000) then
            Closest = Character.HumanoidRootPart
            DistanceToMouse = Distance
        end
    end
    return Closest
end

function HideTool()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Model") then
            for i2,v2 in pairs(v:GetChildren()) do
                if v2:IsA("Model") then
                    v2.CanCollide = true
                end
            end
            if v:FindFirstChild("Handle") and v.Handle:FindFirstChild("Weld") then
                v.Handle.Weld:Destroy()
            end
            if v:FindFirstChild("Handle") and v.Handle.Name == "ToolWeld" then
                v.Handle.ToolWeld:Destroy()
            end
            if v.Name == "God Rock" then
                if v.Part:FindFirstChild("Weld") then
                    v.Part.Weld:Destroy()
                end
            end
        end
    end
end

function HideArmor()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Accessory") then
            for i2,v2 in pairs(v:GetChildren()) do
                if v2:IsA("Model") then
                    v2.CanCollide = true
                end
                for i3,v3 in pairs(v2:GetChildren()) do
                    v3:Destroy()
                end
            end
        end
    end
end

function KillAura()
    for i,v in pairs(plyrs:GetChildren()) do
        if v.Character then
            v = v.Character
            local ThereRoot = v:FindFirstChild("HumanoidRootPart")
            if ThereRoot ~= nil then
                if v ~= getLP() then
                    local magnitude = (getLP().HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if magnitude <= Options.skillarua.Value and v.HumanoidRootPart ~= getLP().HumanoidRootPart then
                        rs.Events.SwingTool:FireServer(rs.RelativeTime.Value, { v.HumanoidRootPart })
                    end
                end
            end
        end
    end
end

function AutoTeleport()
    for i,v in pairs(plyrs:GetChildren()) do
        if v.Character then
            v = v.Character
            local ThereRoot = v:FindFirstChild("HumanoidRootPart")
            if ThereRoot ~= nil then
                if v ~= getLP() then
                    local magnitude = (getLP().HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if magnitude <= Options.stelerange.Value and v.HumanoidRootPart ~= getLP().HumanoidRootPart then
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position)
                    end
                end
            end
        end
    end
end

function getWorkspaceBasepartsWithin(dis)
    local tmpTable = {}
    for i,v in ipairs(game.Workspace:GetDescendants()) do
        if v ~= nil and v:IsA("BasePart") and not v:IsDescendantOf(_RG.char) then
            local distance = (_RG.root.Position - v.Position).Magnitude
            if distance <= dis then
                table.insert(tmpTable,v)
            end
        end
    end
    return tmpTable
end

function WorkAuraParts()
    parts = getWorkspaceBasepartsWithin(Options.sworkarua.Value)
end

function WorkAura()
    if parts ~= {} then
        rs.Events.SwingTool:FireServer(rs.RelativeTime.Value, parts)
    end
end

function SpeedHack()
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Q) then
        local AreRoot = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if AreRoot ~= nil then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -Speed)
        end
    end
end

function InfJump()
       _G.Jumpy = true
       local Player = game:GetService "Players".LocalPlayer
       local UIS = game:GetService "UserInputService"
    
       _G.JumpHeight = 50
    
       function Action(Object, Function)
          if Object ~= nil then
             Function(Object)
          end
       end
    
       UIS.InputBegan:connect(
       function(UserInput)
          if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
             if _G.Jumpy == true then
                Action(
                Player.Character.Humanoid,
                function(self)
                   if
                   self:GetState() == Enum.HumanoidStateType.Jumping or
                   self:GetState() == Enum.HumanoidStateType.Freefall
                   then
                      Action(
                      self.Parent.HumanoidRootPart,
                      function(self)
                         self.Velocity = Vector3.new(0, _G.JumpHeight, 0)
                      end
                      )
                   end
                end
                )
             end
          end
       end
       )
end

function Invis()
    local OldInvis = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local plyrs = game:GetService("Players")
    local lp = plyrs.LocalPlayer
    local chra = lp.Character
    local root = chra.HumanoidRootPart
    local torso = chra:FindFirstChild("LowerTorso")
    root.CFrame = InvisPos
    
    torso.Root:Destroy()
    torso.RootRigAttachment:Destroy()

    chra:FindFirstChild("HumanoidRootPart").Transparency = 0
    root.CFrame = OldInvis
end

function AutoPlant(fruit)
     local rs = game:GetService("ReplicatedStorage")
     local plyrs = game:GetService("Players")
     local function getLP()
        return plyrs.LocalPlayer.Character
     end
     for i,v in pairs(workspace.Deployables:GetChildren()) do
        coroutine.wrap(function()
        pcall(function()
        local magnitude = (getLP().HumanoidRootPart.Position - v:FindFirstChild("Part").Position).Magnitude
        if magnitude <= 256 then
           if v.Name == "Plant Box" then
              rs.Events.InteractStructure:FireServer(v, fruit)
           end
        end
        end)
        end)()
     end
end

function CreateFarm()
    local rs = game:GetService("ReplicatedStorage")
    local plyrs = game:GetService("Players")
    local PlaceStructure = rs.Events.PlaceStructure
    local lp = plyrs.LocalPlayer
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local p = root.Position
    for x=0,FarmSize - 1 do
        for z=0,FarmSize - 1 do
            PlaceStructure:FireServer("Plant Box", CFrame.new(Vector3.new(p.X + (x * 8), p.Y - 4, p.Z + (z * 8))), 0)
        end
    end
end

version = 2.1

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library:Notify("Whitelisted!", 5)
Library:Notify("Version: " .. version, 5)

local Window = Library:CreateWindow({
    Title = 'GorillaHook Private Build v' .. version,
    Center = true, 
    AutoShow = false,
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals'),
    ESP = Window:AddTab('Esp'),
    Movement = Window:AddTab('Movement'),
    Exploits = Window:AddTab('Exploits'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

--Combat

local COMBATMain = Tabs.Combat:AddLeftGroupbox('Main')

COMBATMain:AddToggle("cenabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
COMBATMain:AddToggle("ckillarua", {Text = "Kill Arua", Default = false}):OnChanged(function() end)
COMBATMain:AddToggle("csilent", {Text = "Silent Aim", Default = false}):OnChanged(function() end)
COMBATMain:AddToggle("ctele", {Text = "Auto Teleport", Default = false}):OnChanged(function() end)
COMBATMain:AddToggle("cheal", {Text = "Auto BloodFruit", Default = false}):OnChanged(function() end)

local COMBATSettings = Tabs.Combat:AddRightGroupbox('Settings')

COMBATSettings:AddToggle("svisible", {Text = "Silent Aim Fov Visible", Default = false}):OnChanged(function() end)
COMBATSettings:AddSlider('sfov', {Text = 'Silent Aim Fov', Default = 80, Min = 0, Max = 360, Rounding = 1, Compact = false}) Options.sfov:OnChanged(function() end)
COMBATSettings:AddSlider('sfovSides', {Text = 'Silent Aim Fov Sides', Default = 14, Min = 0, Max = 64, Rounding = 1, Compact = false}) Options.sfovSides:OnChanged(function() end)
COMBATSettings:AddSlider('skillarua', {Text = 'Kill Aura Range', Default = 23, Min = 0, Max = 25, Rounding = 1, Compact = false}) Options.skillarua:OnChanged(function() end)
COMBATSettings:AddSlider('stelerange', {Text = 'Auto Teleport Range', Default = 15, Min = 0, Max = 25, Rounding = 1, Compact = false}) Options.stelerange:OnChanged(function() end)
COMBATSettings:AddSlider('sheal', {Text = 'Auto Blood Under', Default = 65, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.stelerange:OnChanged(function() end)

--Visuals

local VISUALSMain = Tabs.Visuals:AddLeftGroupbox('Main')



--ESP

local ESPMain = Tabs.ESP:AddLeftGroupbox('Main')

ESPMain:AddToggle("esp", {Text = "ESP", Default = false}):OnChanged(function() espLib.options.enabled = Toggles.esp.Value end)
ESPMain:AddToggle("box", {Text = "Boxes", Default = false}):OnChanged(function() espLib.options.boxes = Toggles.box.Value end)
ESPMain:AddToggle("names", {Text = "Names", Default = false}):OnChanged(function() espLib.options.names = Toggles.names.Value end)
ESPMain:AddToggle("maxd", {Text = "Max Distance", Default = false}):OnChanged(function() espLib.options.distance = Toggles.maxd.Value end)
ESPMain:AddToggle("healtht", {Text = "Health Text", Default = false}):OnChanged(function() espLib.options.healthText = Toggles.healtht.Value end)
ESPMain:AddToggle("healthb", {Text = "Health Bars", Default = false}):OnChanged(function() espLib.options.healthBars = Toggles.healthb.Value end)
ESPMain:AddToggle("tracer", {Text = "Tracers", Default = false}):OnChanged(function() espLib.options.tracers = Toggles.tracer.Value end)
ESPMain:AddToggle("chams", {Text = "Chams", Default = false}):OnChanged(function() espLib.options.chams = Toggles.chams.Value end)
ESPMain:AddToggle("arrows", {Text = "Arrows", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutline = Toggles.arrows.Value end)

local ESPSettings = Tabs.ESP:AddRightGroupbox('Settings')

ESPSettings:AddToggle("ldistance", {Text = "Limit Distance", Default = false}):OnChanged(function() espLib.options.limitDistance = Toggles.ldistance.Value end)
ESPSettings:AddSlider('mdistance', {Text = 'Max Distance', Default = 5000, Min = 0, Max = 10000, Rounding = 1, Compact = false}) Options.mdistance:OnChanged(function() espLib.options.maxDistance = Options.mdistance.Value end)
ESPSettings:AddToggle("vcheck", {Text = "Visible Check", Default = false}):OnChanged(function() espLib.options.visibleOnly = Toggles.vcheck.Value end)
ESPSettings:AddToggle("afilled", {Text = "Arrows Filled", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutlineFilled = Toggles.afilled.Value end)
ESPSettings:AddSlider('atransparency', {Text = 'Arrows Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.atransparency:OnChanged(function() espLib.options.outOfViewArrowsOutlineTransparency = Options.atransparency.Value / 100 end)
ESPSettings:AddSlider('btransparency', {Text = 'Boxes Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.btransparency:OnChanged(function() espLib.options.boxesTransparency = Options.btransparency.Value / 100 end)
ESPSettings:AddSlider('hbsize', {Text = 'HealthBar Size', Default = 1, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.hbsize:OnChanged(function() espLib.options.healthBarsSize = Options.hbsize.Value end)
ESPSettings:AddSlider('httransparency', {Text = 'HealthText Transparency', Default = 1, Min = 0, Max = 5, Rounding = 1, Compact = false}) Options.httransparency:OnChanged(function() espLib.options.healthTextTransparency = Options.httransparency.Value / 100 end)
ESPSettings:AddSlider('ctransparency', {Text = 'Chams Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.ctransparency:OnChanged(function() espLib.options.chamsFillTransparency = Options.ctransparency.Value / 100 end)
ESPSettings:AddSlider('dtransparency', {Text = 'Distance Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.dtransparency:OnChanged(function() espLib.options.distanceTransparency = Options.dtransparency.Value / 100 end)
ESPSettings:AddDropdown("tracerf", {Text = "Tracers", Default = "Top", Values = {"Top", "Bottom", "Mouse"}}):OnChanged(function() espLib.options.tracerOrigin = Options.tracerf.Value end)

local ESPColor = Tabs.ESP:AddLeftGroupbox('Color')

ESPColor:AddLabel('Name Color'):AddColorPicker('ncolor', { Default = Color3.new(1, 1, 1), Title = 'Name Color'}) Options.ncolor:OnChanged(function() espLib.options.nameColor = Options.ncolor.Value end)
ESPColor:AddLabel('Box Color'):AddColorPicker('bcolor', { Default = Color3.new(1, 1, 1), Title = 'Box Color'}) Options.bcolor:OnChanged(function() espLib.options.boxesColor = Options.bcolor.Value end)
ESPColor:AddLabel('HealthText Color'):AddColorPicker('htcolor', { Default = Color3.new(1, 1, 1), Title = 'HealthText Color'}) Options.htcolor:OnChanged(function() espLib.options.healthTextColor = Options.htcolor.Value end)
ESPColor:AddLabel('Distance Color'):AddColorPicker('dcolor', { Default = Color3.new(1, 1, 1), Title = 'Distance Color'}) Options.dcolor:OnChanged(function() espLib.options.distanceColor = Options.dcolor.Value end)
ESPColor:AddLabel('Tracer Color'):AddColorPicker('tcolor', { Default = Color3.new(1, 1, 1), Title = 'Tracer Color'}) Options.tcolor:OnChanged(function() espLib.options.tracerColor = Options.tcolor.Value end)
ESPColor:AddLabel('Chams Color'):AddColorPicker('ccolor', { Default = Color3.new(1, 0, 0), Title = 'Chams Color'}) Options.ccolor:OnChanged(function() espLib.options.chamsFillColor = Options.ccolor.Value end)
ESPColor:AddLabel('Arrow Color'):AddColorPicker('acolor', { Default = Color3.new(1, 1, 1), Title = 'Arrow Color'}) Options.acolor:OnChanged(function() espLib.options.outOfViewArrowsOutlineColor = Options.acolor.Value end)

--Movement

local MOVEMENTMain = Tabs.Movement:AddLeftGroupbox('Main')

MOVEMENTMain:AddToggle("menabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
MOVEMENTMain:AddToggle("mwater", {Text = "Water Walk", Default = false}):OnChanged(function() end)

local MOVEMENTSettings = Tabs.Movement:AddRightGroupbox('Settings')

--Exploits

local EXPLOITSMain = Tabs.Exploits:AddLeftGroupbox('Main')

EXPLOITSMain:AddToggle("eenabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
EXPLOITSMain:AddToggle("invist", {Text = "Invisibile Tools", Default = false}):OnChanged(function() end)
EXPLOITSMain:AddToggle("invisa", {Text = "Invisibile Armor", Default = false}):OnChanged(function() end)
EXPLOITSMain:AddToggle("xplant", {Text = "Auto Plant", Default = false}):OnChanged(function() end)
EXPLOITSMain:AddButton('Create Farm', function() CreateFarm() end)

local EXPLOITSSettings = Tabs.Exploits:AddRightGroupbox('Settings')

EXPLOITSSettings:AddDropdown("splant", {Text = "Auto Plant Fruit", Default = "Bloodfruit", Values = {"Bloodfruit"}}):OnChanged(function() end)
EXPLOITSSettings:AddDropdown("sfarm", {Text = "Farm Size", Default = "1x1", Values = {"1x1", "2x2", "3x3", "4x4", "5x5", "6x6", "7x7", "8x8"}}):OnChanged(function() 
    if Options.sfarm.Value == "1x1" then 
        FarmSize = 1
    elseif Options.sfarm.Value == "2x2" then 
        FarmSize = 2
    elseif Options.sfarm.Value == "3x3" then 
        FarmSize = 3
    elseif Options.sfarm.Value == "4x4" then 
        FarmSize = 4
    elseif Options.sfarm.Value == "5x5" then 
        FarmSize = 5
    elseif Options.sfarm.Value == "6x6" then 
        FarmSize = 6
    elseif Options.sfarm.Value == "7x7" then 
        FarmSize = 7
    elseif Options.sfarm.Value == "8x8" then 
        FarmSize = 8
    end
end)

-- UI Settings
Library:SetWatermarkVisibility(true)
Library:SetWatermark('GorillaHook Private Build v' .. version)
Library.KeybindFrame.Visible = true;
Library:OnUnload(function()
    Library.Unloaded = true
end)
Library:OnUnload(function()
	print('GorillaHook gone :(')
    Unloaded = true
    espLib:Unload()
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
ThemeManager:SetFolder('GorillaHookv2')
SaveManager:SetFolder('GorillaHookv2/BoogaBooga')
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

--Hooks
espLib:Load()
parts = getWorkspaceBasepartsWithin(48)

resume(create(function()
    while wait(0.18) and Unloaded ~= true do
        if Toggles.cenabled.Value and Toggles.ckillarua.Value then
            KillAura()
        end
    end
end))

resume(create(function()
    while task.wait() and Unloaded ~= true do
        if Toggles.cenabled.Value and Toggles.ctele.Value then
            AutoTeleport()
        end
    end
end))

resume(create(function()
    while task.wait() and Unloaded ~= true do
        if Toggles.cheal.Value and Toggles.cenabled.Value then
            local player = game.Players.LocalPlayer
            local character = player.Character
            local humanoid = character.Humanoid
            if humanoid.Health <= Options.sheal.Value then
                repeat wait(0.1)
                        game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("Bloodfruit")
                until humanoid.Health == 100 or humanoid.Health <= 0 or not Toggles.cheal.Value or not Toggles.cenabled.Value
            end
        end
        task.wait()
    end
end))

--water walker

resume(create(function()
    while task.wait() and Unloaded ~= true do
        if Toggles.eenabled.Value and Toggles.invist.Value then
            HideTool()
        end
        if Toggles.eenabled.Value and Toggles.invisa.Value then
            HideArmor()
        end
        if Toggles.eenabled.Value and Toggles.xplant.Value then
            AutoPlant(Options.splant.Value)
        end
    end
    wait(1)
end))

resume(create(function()
    RenderStepped:Connect(function()
        if Toggles.svisible.Value then 
            fov_circle.Visible = Toggles.svisible.Value
            fov_circle.Color = Color3.new(255,255,255)
            fov_circle.Position = getMousePosition()
            fov_circle.NumSides = Options.sfovSides.Value
            fov_circle.Radius = Options.sfov.Value
        end
    end)
end))

oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
    local chance = true
    if Toggles.csilent.Value and self == workspace and not checkcaller() and chance == true then
        if ValidateArguments(Arguments, ExpectedArguments) then
            local A_Ray = Arguments[2]
            local HitPart = getClosestPlayer()
            if HitPart then
                local Origin = A_Ray.Origin
                local Direction = getDirection(Origin, HitPart.Position)
                Arguments[2] = Ray.new(Origin, Direction)
                return oldNamecall(unpack(Arguments))
            end
        end
    end
    return oldNamecall(...)
end))

print("Loaded!")