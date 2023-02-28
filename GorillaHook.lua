--simple whitelist
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local WhitelistedHWIDs = {"5C871688-3B28-4A7A-8FAB-F25397EF6C7D", "43C95743-C30E-4E46-AAE5-73BFF8E4BA66"}
local qNVAKkuwxNpqruLjSRHg = false
print(game:GetService("RbxAnalyticsService"):GetClientId())
function CheckHWID() for i,v in pairs(WhitelistedHWIDs) do if HWID == v then return true elseif HWID ~= v then return false end end end
qNVAKkuwxNpqruLjSRHg = CheckHWID()
if qNVAKkuwxNpqruLjSRHg == true then print("Whitlisted! Loading Script...") else game.Players.LocalPlayer:Kick("Not Whitlisted. (if this is a mistake dm Yellow_FireFighter#3625)") setclipboard("Yellow_FireFighter#3625") end
repeat task.wait() until qNVAKkuwxNpqruLjSRHg == true

-- init
if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end
local resume = coroutine.resume
local create = coroutine.create
local CoreGui = game:GetService("StarterGui")
version = 0.91
local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()
espLib.options.boundingBox = false
espLib.options.outOfViewArrows = false
espLib.options.tracerOrigin = "Top"
--local headSound = Instance.new("Sound", CoreGui)
--headSound.SoundId = "rbxassetid://1255040462"

local SilentAimSettings = {Enabled = false,ClassName = "pog",ToggleKey = "Insert",TeamCheck = false,VisibleCheck = false, TargetPart = "Head",SilentAimMethod = "Raycast",FOVRadius = 130,FOVVisible = false,ShowSilentAimTarget = false, MouseHitPrediction = false,MouseHitPredictionAmount = 0,HitChance = 100}

function Esp(things, toggle)
    if toggle then
        for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
            if v1.Name == things then
                for __,v in pairs(v1:GetChildren()) do
                    if v:IsA("Model") or v:IsA("Part") or v:IsA("MeshPart") then
                        local a = Instance.new("BillboardGui",v)
                        a.Size = UDim2.new(1,0, 1,0)
                        a.Name = "A"
                        a.AlwaysOnTop = true
                        local b = Instance.new("Frame",a)
                        b.Size = UDim2.new(1,0, 1,0)
                        b.BackgroundTransparency = 1
                        b.BorderSizePixel = 0
                        local c = Instance.new("TextLabel",b)
                        c.Text = things
                        c.Size = UDim2.new(1,0, 1,0)
                        c.BackgroundTransparency = 1
                        c.BorderSizePixel = 0
                        c.TextColor3 = Color3.fromRGB(255,255,255)
                    end
                end
            end
        end
    else
        resume(create(function()
            for i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == things then
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
        end))
    end
end

function Esp2(things, toggle)
    if toggle then
        for  i, v1 in pairs(game:GetService("Workspace").AiZones:GetDescendants()) do
            if v1.Name == things then
                --for __,v in pairs(v1:GetChildren()) do
                    --if v.Name == things then
                        local a = Instance.new("BillboardGui",v1)
                        a.Size = UDim2.new(1,0, 1,0)
                        a.Name = "A"
                        a.AlwaysOnTop = true
                        local b = Instance.new("Frame",a)
                        b.Size = UDim2.new(1,0, 1,0)
                        b.BackgroundTransparency = 1
                        b.BorderSizePixel = 0
                        local c = Instance.new("TextLabel",b)
                        c.Text = things
                        c.Size = UDim2.new(1,0, 1,0)
                        c.BackgroundTransparency = 1
                        c.BorderSizePixel = 0
                        c.TextColor3 = Color3.fromRGB(255,255,255)
                    --end
                --end
            end
        end
    else
        resume(create(function()
            for  i, v1 in pairs(game:GetService("Workspace").AiZones:GetDescendants()) do
                if v1.Name == things then
                    v1:Destroy()
                end
            end
        end))
    end
end

local aimbotisontop = false
local temaeeeee = false
local aimypart = "Head"
local locktimeee = 0
local circlesides = 64
local circletranss = 0.7
local radisfff = 80
local fillefoc = false
local foveee = false
local thiccc = 0
local floatheight = 1
local velspeed = false
local speed = 35
local LOCAL_PLAYER = game:GetService("Players").LocalPlayer
local INPUT_SERVICE = game:GetService("UserInputService")


local speed = 35
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

-- variables
getgenv().SilentAimSettings = Settings
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
local resume = coroutine.resume 
local create = coroutine.create
local ValidTargetParts = {"Head", "HumanoidRootPart"}
local PredictionAmount = 0.165
local mouse_box = Drawing.new("Square")
mouse_box.Visible = true 
mouse_box.ZIndex = 999 
mouse_box.Color = Color3.fromRGB(54, 57, 241)
mouse_box.Thickness = 20 
mouse_box.Size = Vector2.new(20, 20)
mouse_box.Filled = true 
local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 180
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = Color3.fromRGB(54, 57, 241)

local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean", "boolean"
        }
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean"
        }
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = {
            "Instance", "Ray", "Instance", "boolean", "boolean"
        }
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    }
}

function CalculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    return chance <= Percentage / 100
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

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    
    if not (PlayerCharacter or LocalPlayerCharacter) then return end 
    
    local PlayerRoot = FindFirstChild(PlayerCharacter, Options.TargetPart.Value) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end 
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function getClosestPlayer()
    if not Options.TargetPart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        if Toggles.TeamCheck.Value and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if Toggles.VisibleCheck.Value and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Options.Radius.Value or 2000) then
            Closest = ((Options.TargetPart.Value == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[Options.TargetPart.Value])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'GorillaHook Private Build v' .. version,
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals 1'),
    Visuals2 = Window:AddTab('Visuals 2'),
    Movement = Window:AddTab('Movement'),
    Exploits = Window:AddTab('Exploits'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local Main = Tabs.Combat:AddLeftGroupbox('Silent Aim')

Main:AddToggle("aim_Enabled", {Text = "Enabled"}):AddKeyPicker("aim_Enabled_KeyPicker", {Default = "]", SyncToggleState = true, Mode = "Toggle", Text = "Enabled", NoUI = false}); Options.aim_Enabled_KeyPicker:OnClick(function()SilentAimSettings.Enabled = not SilentAimSettings.Enabled Toggles.aim_Enabled.Value = SilentAimSettings.Enabled Toggles.aim_Enabled:SetValue(SilentAimSettings.Enabled) mouse_box.Visible = SilentAimSettings.Enabled end)
Main:AddToggle("TeamCheck", {Text = "Team Check", Default = SilentAimSettings.TeamCheck}):OnChanged(function() SilentAimSettings.TeamCheck = Toggles.TeamCheck.Value end)
Main:AddToggle("VisibleCheck", {Text = "Visible Check", Default = SilentAimSettings.VisibleCheck}):OnChanged(function() SilentAimSettings.VisibleCheck = Toggles.VisibleCheck.Value end)
Main:AddDropdown("TargetPart", {Text = "Target Part", Default = SilentAimSettings.TargetPart, Values = {"Head", "HumanoidRootPart", "Random"}}):OnChanged(function() SilentAimSettings.TargetPart = Options.TargetPart.Value end)
Main:AddSlider('HitChance', {Text = 'Hit chance',Default = 100,Min = 0,Max = 100,Rounding = 1,Compact = false}) Options.HitChance:OnChanged(function() SilentAimSettings.HitChance = Options.HitChance.Value end)
Main:AddToggle("Visible", {Text = "Show FOV Circle"}):AddColorPicker("Color", {Default = Color3.fromRGB(54, 57, 241)}):OnChanged(function() fov_circle.Visible = Toggles.Visible.Value SilentAimSettings.FOVVisible = Toggles.Visible.Value end)
Main:AddSlider("Radius", {Text = "FOV Circle Radius", Min = 0, Max = 360, Default = 130, Rounding = 0}):OnChanged(function() fov_circle.Radius = Options.Radius.Value SilentAimSettings.FOVRadius = Options.Radius.Value end)
Main:AddToggle("MousePosition", {Text = "Show Silent Aim Target"}):AddColorPicker("MouseVisualizeColor", {Default = Color3.fromRGB(54, 57, 241)}):OnChanged(function() mouse_box.Visible = Toggles.MousePosition.Value  SilentAimSettings.ShowSilentAimTarget = Toggles.MousePosition.Value  end)
Main:AddLabel('Silent Aim Target Color'):AddColorPicker('whitlistcolor', { Default = Color3.new(1, 0, 0), Title = 'Silent Aim Target Color'}) Options.whitlistcolor:OnChanged(function() espLib.options.whitelistColor = Options.whitlistcolor.Value end)

local RightGroupbox = Tabs.Combat:AddRightGroupbox('Aimbot')

RightGroupbox:AddToggle('Aim', {Text = 'Aimbot',Default = false,Tooltip = 'Toggles Aimbot',})
Toggles.Aim:OnChanged(function() _G.AimbotON = Toggles.Aim.Value end)
local RightGroupbox2 = Tabs.Combat:AddRightGroupbox('Aimbot Settings')
RightGroupbox2:AddToggle('teamcheck1', {Text = 'TeamCheck',Default = false,Tooltip = 'Toggles Aimbot Teamcheck',})
Toggles.teamcheck1:OnChanged(function() _G.TeamCheck = Toggles.teamcheck1.Value end)
RightGroupbox2:AddDropdown('targetpartyaaim', {Values = { 'Head', 'HumanoidRootPart' },Default = 1,Multi = false,Text = 'Aimbot Aim Target',Tooltip = 'Changes the Aimbot Target',})
Options.targetpartyaaim:OnChanged(function() _G.AimPart = Options.targetpartyaaim.Value end)
RightGroupbox2:AddSlider('prediction1', {Text = 'Prediction Amount',Default = 0.167,Min = 0,Max = 1,Rounding = 1,Compact = false,})
Options.prediction1:OnChanged(function() Epitaph = Options.prediction1.Value end)
RightGroupbox2:AddSlider('siedsfoccc', {Text = 'Fov Sides',Default = 64,Min = 3,Max = 128,Rounding = 0,Compact = false,})
Options.siedsfoccc:OnChanged(function() _G.CircleSides = Options.siedsfoccc.Value end)
RightGroupbox2:AddSlider('trannsssdasdasd', {Text = 'Fov Transperancy',Default = 70,Min = 0,Max = 100,Rounding = 1,Compact = false,})
Options.trannsssdasdasd:OnChanged(function() _G.CircleTransparency = Options.trannsssdasdasd.Value end)
RightGroupbox2:AddSlider('radsdasdasd', {Text = 'Aimbot Fov Radius',Default = 80,Min = 0,Max = 640,Rounding = 0,Compact = false,})
Options.radsdasdasd:OnChanged(function() _G.CircleRadius = Options.radsdasdasd.Value end)
RightGroupbox2:AddToggle('filledasdasda', {Text = 'Fov Filled',Default = false,Tooltip = 'Toggles Fov Filled',})
Toggles.filledasdasda:OnChanged(function() _G.CircleFilled = Toggles.filledasdasda.Value end)
RightGroupbox2:AddToggle('fovenabledvis', {Text = 'Fov Visible',Default = false,Tooltip = 'Toggles Fov Visible',})
Toggles.fovenabledvis:OnChanged(function() _G.CircleVisible = Toggles.fovenabledvis.Value end)
RightGroupbox2:AddSlider('thiccccc', {Text = 'Aimbot Fov thickness',Default = 0,Min = 0,Max = 3,Rounding = 1,Compact = false,})
Options.thiccccc:OnChanged(function() _G.CircleThickness = Options.thiccccc.Value end)

local GroupBox = Tabs.Visuals:AddLeftGroupbox('Esp')

GroupBox:AddToggle("esp", {Text = "ESP", Default = false}):OnChanged(function() espLib.options.enabled = Toggles.esp.Value end)
GroupBox:AddToggle("box", {Text = "Boxes", Default = false}):OnChanged(function() espLib.options.boxes = Toggles.box.Value end)
GroupBox:AddToggle("names", {Text = "Names", Default = false}):OnChanged(function() espLib.options.names = Toggles.names.Value end)
GroupBox:AddToggle("maxd", {Text = "Max Distance", Default = false}):OnChanged(function() espLib.options.distance = Toggles.maxd.Value end)
GroupBox:AddToggle("healtht", {Text = "Health Text", Default = false}):OnChanged(function() espLib.options.healthText = Toggles.healtht.Value end)
GroupBox:AddToggle("healthb", {Text = "Health Bars", Default = false}):OnChanged(function() espLib.options.healthBars = Toggles.healthb.Value end)
GroupBox:AddToggle("tracer", {Text = "Tracers", Default = false}):OnChanged(function() espLib.options.tracers = Toggles.tracer.Value end)
GroupBox:AddToggle("chams", {Text = "Chams", Default = false}):OnChanged(function() espLib.options.chams = Toggles.chams.Value end)
GroupBox:AddToggle("arrows", {Text = "Arrows", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutline = Toggles.arrows.Value end)

local GroupBox69 = Tabs.Visuals:AddRightGroupbox('Esp Settings')

GroupBox69:AddToggle("ldistance", {Text = "Limit Distance", Default = false}):OnChanged(function() espLib.options.limitDistance = Toggles.ldistance.Value end)
GroupBox69:AddSlider('mdistance', {Text = 'Max Distance', Default = 5000, Min = 0, Max = 10000, Rounding = 1, Compact = false}) Options.mdistance:OnChanged(function() espLib.options.maxDistance = Options.mdistance.Value end)
GroupBox69:AddToggle("vcheck", {Text = "Visible Check", Default = false}):OnChanged(function() espLib.options.visibleOnly = Toggles.vcheck.Value end)
GroupBox69:AddToggle("afilled", {Text = "Arrows Filled", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutlineFilled = Toggles.afilled.Value end)
GroupBox69:AddSlider('atransparency', {Text = 'Arrows Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.atransparency:OnChanged(function() espLib.options.outOfViewArrowsOutlineTransparency = Options.atransparency.Value / 100 end)
GroupBox69:AddSlider('btransparency', {Text = 'Boxes Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.btransparency:OnChanged(function() espLib.options.boxesTransparency = Options.btransparency.Value / 100 end)
GroupBox69:AddSlider('hbsize', {Text = 'HealthBar Size', Default = 1, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.hbsize:OnChanged(function() espLib.options.healthBarsSize = Options.hbsize.Value end)
GroupBox69:AddSlider('httransparency', {Text = 'HealthText Transparency', Default = 1, Min = 0, Max = 5, Rounding = 1, Compact = false}) Options.httransparency:OnChanged(function() espLib.options.healthTextTransparency = Options.httransparency.Value / 100 end)
GroupBox69:AddSlider('ctransparency', {Text = 'Chams Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.ctransparency:OnChanged(function() espLib.options.chamsFillTransparency = Options.ctransparency.Value / 100 end)
GroupBox69:AddSlider('dtransparency', {Text = 'Distance Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.dtransparency:OnChanged(function() espLib.options.distanceTransparency = Options.dtransparency.Value / 100 end)
GroupBox69:AddDropdown("tracerf", {Text = "Tracers", Default = "Top", Values = {"Top", "Bottom", "Mouse"}}):OnChanged(function() espLib.options.tracerOrigin = Options.tracerf.Value end)

local GroupBox70 = Tabs.Visuals:AddLeftGroupbox('Esp Color')

GroupBox70:AddLabel('Name Color'):AddColorPicker('ncolor', { Default = Color3.new(1, 1, 1), Title = 'Name Color'}) Options.ncolor:OnChanged(function() espLib.options.nameColor = Options.ncolor.Value end)
GroupBox70:AddLabel('Box Color'):AddColorPicker('bcolor', { Default = Color3.new(1, 1, 1), Title = 'Box Color'}) Options.bcolor:OnChanged(function() espLib.options.boxesColor = Options.bcolor.Value end)
GroupBox70:AddLabel('HealthText Color'):AddColorPicker('htcolor', { Default = Color3.new(1, 1, 1), Title = 'HealthText Color'}) Options.htcolor:OnChanged(function() espLib.options.healthTextColor = Options.htcolor.Value end)
GroupBox70:AddLabel('Distance Color'):AddColorPicker('dcolor', { Default = Color3.new(1, 1, 1), Title = 'Distance Color'}) Options.dcolor:OnChanged(function() espLib.options.distanceColor = Options.dcolor.Value end)
GroupBox70:AddLabel('Tracer Color'):AddColorPicker('tcolor', { Default = Color3.new(1, 1, 1), Title = 'Tracer Color'}) Options.tcolor:OnChanged(function() espLib.options.tracerColor = Options.tcolor.Value end)
GroupBox70:AddLabel('Chams Color'):AddColorPicker('ccolor', { Default = Color3.new(1, 0, 0), Title = 'Chams Color'}) Options.ccolor:OnChanged(function() espLib.options.chamsFillColor = Options.ccolor.Value end)
GroupBox70:AddLabel('Arrow Color'):AddColorPicker('acolor', { Default = Color3.new(1, 1, 1), Title = 'Arrow Color'}) Options.acolor:OnChanged(function() espLib.options.outOfViewArrowsOutlineColor = Options.acolor.Value end)

local GroupBox2 = Tabs.Visuals2:AddRightGroupbox('Player')

GroupBox2:AddToggle("playermat", {Text = "Body's Material", Default = false}):OnChanged(function()
    resume(create(function()
        if Toggles.playermat.Value then
            while Toggles.playermat.Value do
                game:GetService("Players").LocalPlayer.Character.Head.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.LeftHand.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.RightHand.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.RightUpperArm.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.RightLowerArm.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.LeftFoot.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.UpperTorso.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.RightFoot.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.LowerTorso.Material = (matisgay)
                game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Material = (matisgay)
                wait(0.5)
            end
        else
            game:GetService("Players").LocalPlayer.Character.Head.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.LeftHand.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.RightHand.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.LeftLowerArm.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.LeftUpperArm.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.RightUpperArm.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.RightLowerArm.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.LeftFoot.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.LeftLowerLeg.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.UpperTorso.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.LeftUpperLeg.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.RightFoot.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.RightLowerLeg.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.LowerTorso.Material = ("Plastic")
            game:GetService("Players").LocalPlayer.Character.RightUpperLeg.Material = ("Plastic")
        end
	end))
end)

--[[GroupBox2:AddDropdown('buddydontcare', {
	Values = { 'Plastic', 'ForceField', 'Neon', 'Metal' },
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = 'Players Body'
})

Options.buddydontcare:OnChanged(function()
	matisgay = Options.buddydontcare.Value
end)

GroupBox2:AddToggle("hidearmor", {Text = "Hide Armor", Default = false}):OnChanged(function()
    -- set armor vis to false lol
end)]]

local GroupBox3 = Tabs.Visuals2:AddLeftGroupbox('NPCs')

resume(create(function() GroupBox3:AddToggle("anton", {Text = "Anton ESP", Default = false}):OnChanged(function() Esp2("Anton", Toggles.anton.Value) end) end))

local GroupBox4 = Tabs.Visuals2:AddLeftGroupbox('Containers')

resume(create(function()GroupBox4:AddToggle("sportbagesp", {Text = "Sport Bag ESP", Default = false}):OnChanged(function() Esp("SportBag", Toggles.sportbagesp.Value) end) end))
resume(create(function() GroupBox4:AddToggle("toolboxesp", {Text = "Tool Box ESP", Default = false}):OnChanged(function() Esp("Toolbox", Toggles.toolboxesp.Value) end) end))
resume(create(function() GroupBox4:AddToggle("LargeShippingCrateesp", {Text = "Large Shipping Crate ESP", Default = false}):OnChanged(function() Esp("LargeShippingCrate", Toggles.LargeShippingCrateesp.Value) end) end))
resume(create(function() GroupBox4:AddToggle("SmallMilitaryBoxesp", {Text = "Small Military Box ESP", Default = false}):OnChanged(function() Esp("SmallMilitaryBox", Toggles.SmallMilitaryBoxesp.Value) end) end))
resume(create(function() GroupBox4:AddToggle("LargeMilitaryBoxesp", {Text = "Large Military Box ESP", Default = false}):OnChanged(function() Esp("LargeMilitaryBox", Toggles.LargeMilitaryBoxesp.Value) end) end))
resume(create(function() GroupBox4:AddToggle("MilitaryCrateesp", {Text = "Military Crate ESP", Default = false}):OnChanged(function() Esp("MilitaryCrate", Toggles.MilitaryCrateesp.Value) end) end))
resume(create(function() GroupBox4:AddToggle("Medbagesp", {Text = "Med Bag ESP", Default = false}):OnChanged(function() Esp("Medbag", Toggles.Medbagesp.Value) end) end))
resume(create(function() GroupBox4:AddToggle("SmallShippingCrateesp", {Text = "Small Shipping Crate ESP", Default = false}):OnChanged(function() Esp("SmallShippingCrate", Toggles.SmallShippingCrateesp.Value) end) end))
resume(create(function()GroupBox4:AddToggle("GrenadeCrateesp", {Text = "Grenade Crate ESP", Default = false}):OnChanged(function() Esp("GrenadeCrate", Toggles.GrenadeCrateesp.Value) end) end))

local GroupBox1 = Tabs.Visuals2:AddRightGroupbox('World')

local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Parent = game.Lighting
colorCorrection.TintColor = Color3.fromRGB(255, 0, 0)
colorCorrection.Enabled = false

GroupBox1:AddToggle("tint", {Text = "Tint", Default = false}):OnChanged(function()
    if Toggles.tint.Value == true then 
        colorCorrection.Enabled = true
    else
        colorCorrection.Enabled = false
    end
end)

GroupBox1:AddLabel('Tint Color'):AddColorPicker('tint', {
	Default = Color3.fromRGB(255, 255, 255),
	Title = 'Tint Color'
})

Options.tint:OnChanged(function()
    tint = (Options.tint.Value)
    colorCorrection.TintColor = --[[Color3.fromRGB]](tint)
end)

GroupBox1:AddToggle("fullbrifght", {Text = "FullBright", Default = false}):OnChanged(function()
    resume(create(function()
        while Toggles.fullbrifght.Value do
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            task.wait(0.001)
        end
    end))
end)

GroupBox1:AddToggle("antilag", {Text = "No Lag", Default = false}):OnChanged(function()
    if Toggles.antilag.Value then
        game:GetService("Lighting").Bloom.Enabled = false
    else
        game:GetService("Lighting").Bloom.Enabled = true
    end
end)

GroupBox1:AddToggle("hurtthing", {Text = "No Hurt Effect", Default = false}):OnChanged(function()
    while nowater do
        game:GetService("Lighting").HurtEffect.Enabled = false
        wait(0.1)
    end
end)

GroupBox1:AddToggle("nowater", {Text = "No Water Blur", Default = false}):OnChanged(function()
    while nowater do
        game:GetService("Lighting").WaterBlur.Enabled = false
        wait(0.1)
    end
end)

GroupBox1:AddToggle("timechanger", {Text = "Time Changer", Default = false}):OnChanged(function()
    -- destroy the thingy lol
	timechange = Toggles.timechanger.Value
	resume(create(function()
		while timechange do
			timer = (hours .. ":" .. minutes .. ":" .. seconds .. ":")
			game.Lighting.TimeOfDay = timer
            wait(0.1)
		end
	end))
end)

GroupBox1:AddSlider("seconds", {Text = "Seconds", Min = 0, Max = 60, Default = 0, Rounding = 0}):OnChanged(function()
	seconds = Options.seconds.Value
end)

GroupBox1:AddSlider("minutes", {Text = "Minutes", Min = 0, Max = 60, Default = 0, Rounding = 0}):OnChanged(function()
	minutes = Options.minutes.Value
end)

GroupBox1:AddSlider("hours", {Text = "Hours", Min = 0, Max = 24, Default = 0, Rounding = 0}):OnChanged(function()
	hours = Options.hours.Value
end)

local GroupBox4 = Tabs.Visuals2:AddLeftGroupbox('Other')

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

GroupBox:AddToggle("velfly", {Text = "Fly", Default = false}):AddKeyPicker("fly_Enabled_KeyPicker", {Default = "LeftAlt", SyncToggleState = true, Mode = "Toggle", Text = "Fly", NoUI = false});
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
end)

local GroupBox0 = Tabs.Exploits:AddLeftGroupbox('Player')

--[[GroupBox0:AddToggle("drown", {Text = "Anti-Drown", Default = false}):OnChanged(function()
    local namecall_hook; do
        namecall_hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local namecallMethod, arguments = (getnamecallmethod or get_namecall_method)(), {...};
            
            if (namecallMethod == "FireServer" or namecallMethod == "fireServer") and self == drowningRemote and arguments[1] and typeof(arguments[1]) == "number" then
                return
            end
            
            return namecall_hook(self, ...);
        end));
     end
end)]]

local GroupBox = Tabs.Exploits:AddRightGroupbox('Gun')

GroupBox:AddToggle("norecoil", {Text = "No Recoil", Default = false}):OnChanged(function()
    local r = require(game.ReplicatedStorage.Modules.VFX)
    local o
    o = hookfunction(r.RecoilCamera, function(...)
        if true then
            return 0
        end
        return o(...)
    end)

    getgenv().Toggle = Toggles.norecoil.Value
    getgenv().ValueCheck = true
    local FunctionCount = 0
    local ValueCount = 0

    local hookrecoil = function(func)
        local hookrecoil; hookrecoil = hookfunction(func, function(...)
            local args = {...}
            if getgenv().Toggle then
                return 0 or nil
            end
            return hookrecoil(unpack(args))
        end)
    end

    for _, func in next, getgc(true) do
        if typeof(func) == "function" and string.find(string.lower(debug.getinfo(func).name), "recoil") then
            FunctionCount = FunctionCount + 1
            hookrecoil(func)
        elseif typeof(func) == "table" then
            for i, v in next, func do
                if typeof(v) == "function" and string.find(string.lower(debug.getinfo(v).name), "recoil") then
                    FunctionCount = FunctionCount + 1
                    hookrecoil(v)
                elseif getgenv().ValueCheck and typeof(i) == "string" and string.find(i, "%a+") and rawget(func, i) then
                    for char in string.gmatch(i, "%a+") do
                        if string.find(string.lower(char), "recoil") then
                            ValueCount = ValueCount + 1
                            if typeof(v) == "number" then
                                rawset(func, i, 0)
                            elseif typeof(v) == "string" and tonumber(v) then
                                rawset(func, i, "0")
                            elseif typeof(v) == "Vector3" then
                                rawset(func, i, Vector3.new(0,0,0))
                            elseif typeof(v) == "CFrame" then
                                rawset(func, i, CFrame.new(0,0,0))
                            end
                        end
                    end
                end
            end
        end
    end

    --print("Fetched: " .. tostring(FunctionCount) .. " Functions")
    --print("Fetched: " .. tostring(ValueCount) .. " Values")
end)

--[[GroupBox:AddToggle("insta", {Text = "Insta-Hit", Default = false}):OnChanged(function()
    local getService = game.GetService;
    local runService = getService(game, "RunService");

    while Toggles.insta.Value do
        for i,v in pairs(getconnections(runService.Heartbeat)) do
            local Func = v.Function
            if not Func then break end
            setupvalue(Func, 1, 999999)
        end
    task.wait()
    end;
end)]]

GroupBox:AddToggle("aimin", {Text = "Insta-Aim", Default = false}):OnChanged(function()
    for i,v in next, game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name].Inventory:GetChildren() do
        local module = require(v.SettingsModule)
    
        module.AimInSpeed = 0
        module.AimOutSpeed = 0
    end
end)

--[[GroupBox:AddToggle("foce", {Text = "Force Auto", Default = false}):OnChanged(function()
    for i,v in next, game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name].Inventory:GetChildren() do
        local module = require(v.SettingsModule)
        module.FireModes = { "Semi", "Auto" }
        module.FireMode = 'Auto'
    end
end)

GroupBox:AddToggle("reload", {Text = "Fast Reload", Default = false}):OnChanged(function()
    for i,v in next, game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name].Inventory:GetChildren() do
        local module = require(v.SettingsModule)
        module.ReloadFadeIn = 0
        module.ReloadFadeInTimePos = 0
        module.ReloadFadeOut = 0
        module.ReloadFadeOutTimePos = 0
    end
end)]]

GroupBox:AddToggle("fire", {Text = "Fast Fire", Default = false}):OnChanged(function()
    for i,v in next, game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name].Inventory:GetChildren() do
        local module = require(v.SettingsModule)

        module.FireRate = 0
    end
end)

Library:SetWatermarkVisibility(true)

Library:SetWatermark('GorillaHook Private Build v' .. version)

Library.KeybindFrame.Visible = true;

Library:OnUnload(function()
    Library.Unloaded = true
end)

-- UI Settings
Library:OnUnload(function()
	print('GorillaHook gone :(')
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
ThemeManager:SetFolder('GorillaHook')
SaveManager:SetFolder('GorillaHook/configs/ProjectDelta')
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

espLib:Load()

resume(create(function()
    RenderStepped:Connect(function()
        if Toggles.MousePosition.Value and Toggles.aim_Enabled.Value then
            if getClosestPlayer() then
                local Root = getClosestPlayer().Parent.PrimaryPart or getClosestPlayer()
                local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position);
                espLib.whitelist = {
                    getClosestPlayer().Parent.Name
                }
                mouse_box.Visible = IsOnScreen
                mouse_box.Position = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y)
                mouse_box.Visible = false
            else 
                espLib.whitelist = {}
                mouse_box.Visible = false 
                mouse_box.Position = Vector2.new()
            end
        else
            espLib.whitelist = {}
        end
        
        if Toggles.Visible.Value then 
            fov_circle.Visible = Toggles.Visible.Value
            fov_circle.Color = Options.Color.Value
            fov_circle.Position = getMousePosition()
        end
    end)

    -- hooks
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local Method = "Raycast"
        local Arguments = {...}
        local self = Arguments[1]
        local chance = CalculateChance(SilentAimSettings.HitChance)
        if Toggles.aim_Enabled.Value and self == workspace and not checkcaller() and chance == true then
            if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                local A_Origin = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[3] = getDirection(A_Origin, HitPart.Position)

                    return oldNamecall(unpack(Arguments))
                end
            end
        end
        return oldNamecall(...)
    end))

    Camera = Workspace.CurrentCamera
    local Salo = {{stepAmount = 43, dropTiming = 0.0005}}
    __namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local Args, Method, Script = {...}, getnamecallmethod():lower(), getcallingscript()
        if Method == "fireserver" then
            if tostring(self):lower() == "errorlog" or tostring(self):lower() == "errrorlog" or self == BanRemote then
                return
            end
            local Args_4 = Args[4]
            if type(Args_4) == "table" and Args_4[1] and Args_4[1].stepAmount then
                local Call
                Args[4] = Salo
                Call = __namecall(self, unpack(Args))
                local Hit = Args[2]
                if Hit.Name:lower():find("head") then
                    --headSound:Play()
                else
                    --headSound:Play()
                end
                Call = __namecall(self, unpack(Args))
                local TargetStuds = math.floor((Hit.Position - Camera.CFrame.p).Magnitude + 0.5)
                print("Hit registration | Player: " .. Hit.Parent.Name .. ", Hit: " .. Hit.Name ..  ", Distance: " .. math.floor(TargetStuds / 3.5714285714 + 0.5) .. "m (" .. TargetStuds .. " studs)")
                --Library:Notify("Hit registration | Player: " .. Hit.Parent.Name .. ", Hit: " .. Hit.Name ..  ", Distance: " .. math.floor(TargetStuds / 3.5714285714 + 0.5) .. "m (" .. TargetStuds .. " studs)")
            end
            Call = Call or __namecall(self, ...)
            return Call
        end
        return __namecall(self, ...)
    end))

    local oldIndex = nil 
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, Index)
        if self == Mouse and not checkcaller() and Toggles.aim_Enabled.Value and Options.Method.Value == "Mouse.Hit/Target" and getClosestPlayer() then
            local HitPart = getClosestPlayer()
            
            if Index == "Target" or Index == "target" then 
                return HitPart
            elseif Index == "Hit" or Index == "hit" then 
                return ((Toggles.Prediction.Value and (HitPart.CFrame + (HitPart.Velocity * PredictionAmount))) or (not Toggles.Prediction.Value and HitPart.CFrame))
            elseif Index == "X" or Index == "x" then 
                return self.X 
            elseif Index == "Y" or Index == "y" then 
                return self.Y 
            elseif Index == "UnitRay" then 
                return Ray.new(self.Origin, (self.Hit - self.Origin).Unit)
            end
        end

        return oldIndex(self, Index)
    end))
end))

-- insta hit for silent laggy
local getService = game.GetService;
local runService = getService(game, "RunService");

while true do
    for i,v in pairs(getconnections(runService.Heartbeat)) do
        local Func = v.Function
        if not Func then break end
            setupvalue(Func, 1, 999999)
        end
    task.wait()
end