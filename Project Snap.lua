--Main
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if not syn or not protectgui then
	getgenv().protectgui = function() end
end

local resume = coroutine.resume
local create = coroutine.create

local CoreGui = game:GetService("StarterGui")

--silent aim

local SilentAimSettings = {
    Enabled = false,
    
    ClassName = "Pog?",
    
    TeamCheck = false,
    VisibleCheck = false, 
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "Raycast",
    
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false, 
    
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    HitChance = 100
}

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

local ValidTargetParts = {"Head", "HumanoidRootPart"}
local PredictionAmount = 0

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
    -- // Floor the percentage
    Percentage = math.floor(Percentage)

    -- // Get the chance
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100

    -- // Return
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
    
    local PlayerRoot = FindFirstChild(PlayerCharacter, SilentAimSettings.TargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end 
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function getClosestPlayer()
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        if SilentAimSettings.TeamCheck and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if SilentAimSettings.VisibleCheck and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or SilentAimSettings.FOVRadius or 2000) then
            Closest = ((SilentAimSettings.TargetPart == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[SilentAimSettings.TargetPart])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

--

--insta hit

local function instahit()
    --[[local getService = game.GetService;
    local runService = getService(game, "RunService");
    resume(create(function()
        while instahiton do
            task.wait()
            for i,v in pairs(getconnections(runService.Heartbeat)) do
                local Func = v.Function
                if not Func then break end
                setupvalue(Func, 1, 999999)
            end
        end
    end)) patched]]
end

--

--[[local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
ESP.Boxes = false
ESP.Names = false
ESP.Tracers = false
ESP.TeamMates = false]]

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
local version = 0.55
local Top = false

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

local function Body()
    resume(create(function()
        if material then
            while material do
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
end

local function FullBright()
    resume(create(function()
        while fullbright do
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            task.wait()
        end
    end))
end

local function nohurt()
    while value do 
        game:GetService("Lighting"):WaitForChild("HurtEffect").Enabled = value 
        wait(0.1)
     end
end

local function nowater()
    while value do
        game:GetService("Lighting"):WaitForChild("WaterBlur").Enabled = value
        wait(0.1)
    end
end

local function ItemEsp(toggle, item)
    resume(create(function()
        if toggle then
            while toggle do
                for  i, v1 in pairs(game:GetService("Workspace"):WaitForChild("Containers"):GetChildren()) do
                    if v1.Name == item then
                        for __,v in pairs(v1:GetChildren()) do
                            if v:IsA("Model") or v:IsA("Part") or v:IsA("MeshPart") then
                                local a = Instance.new("BillboardGui",v)
                                a.Size = UDim2.new(1,0, 1,0)
                                a.Name = "A"
                                a.AlwaysOnTop = Top
                                local b = Instance.new("Frame",a)
                                b.Size = UDim2.new(1,0, 1,0)
                                b.BackgroundTransparency = 1
                                b.BorderSizePixel = 0
                                local c = Instance.new("TextLabel",b)
                                c.Text = item
                                c.Size = UDim2.new(sizey,0, sizey,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = realcolor
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace"):WaitForChild("Containers"):GetChildren()) do
                if v1.Name == item then
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
    end))
end

------------------------ Aimbot
    local Area = game:GetService("Workspace")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local MyCharacter = LocalPlayer.Character
    local MyRoot = MyCharacter:WaitForChild("HumanoidRootPart")
    local MyHumanoid = MyCharacter:WaitForChild("Humanoid")
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
local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()
--[[espLib.whitelist = {} -- insert string that is the player's name you want to whitelist (turns esp color to whitelistColor in options)
espLib.blacklist = {} -- insert string that is the player's name you want to blacklist (removes player from esp)
espLib.options = {
    enabled = true, --
    scaleFactorX = 4,
    scaleFactorY = 5,
    font = 2,
    fontSize = 13,
    limitDistance = true,
    maxDistance = 1000, --
    visibleOnly = false, --
    teamCheck = false, --
    teamColor = false, --
    fillColor = nil, --
    whitelistColor = Color3.new(1, 0, 0),
    outOfViewArrows = false, --
    outOfViewArrowsFilled = false,
    outOfViewArrowsSize = 25,
    outOfViewArrowsRadius = 100,
    outOfViewArrowsColor = Color3.new(1, 1, 1),
    outOfViewArrowsTransparency = 0.5,
    outOfViewArrowsOutline = true,
    outOfViewArrowsOutlineFilled = false,
    outOfViewArrowsOutlineColor = Color3.new(1, 1, 1),
    outOfViewArrowsOutlineTransparency = 1,
    names = true, -- 
    nameTransparency = 1,
    nameColor = Color3.new(1, 1, 1),
    boxes = false, -- 
    boxesTransparency = 0.5,
    boxesColor = Color3.new(1, 1, 1),
    boxFill = false, --
    boxFillTransparency = 0.5,
    boxFillColor = Color3.new(1, 1, 1),
    healthBars = true, --
    healthBarsSize = 1,
    healthBarsTransparency = 1,
    healthBarsColor = Color3.new(0, 1, 0),
    healthText = true, -- 
    healthTextTransparency = 1,
    healthTextSuffix = "%",
    healthTextColor = Color3.new(1, 1, 1),
    distance = true,
    distanceTransparency = 1,
    distanceSuffix = " Studs",
    distanceColor = Color3.new(1, 1, 1),
    tracers = false, --
    tracerTransparency = 1,
    tracerColor = Color3.new(1, 1, 1),
    tracerOrigin = "Top", -- Available [Mouse, Top, Bottom]
    chams = true, --
    chamsColor = Color3.new(1, 0, 0),
    chamsTransparency = 0.5,
}]]
------------------------
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/RQR29rtF", true))()
local Main = Library:CreateWindow("Project Snap - Project Delta", UDim2.new(492, 598), Enum.KeyCode.Insert)
local WaterMark = Library:CreateWatermark("Project Snap - Project Delta")
local Legit = Main:CreateTab("LegitBot")
local AimbotMain = Legit:CreateSector("Aimbot", "right")

AimbotMain:AddToggle("Aimbot", false, function(value) _G.AimbotON = value end, "aimbot")
---------------------------------------------------------------------
local AimbotSettings = Legit:CreateSector("Aimbot Settings", "right")
----------------------------------------------------------------------------------------------------
AimbotSettings:AddToggle("TeamCheck", false, function(value) _G.TeamCheck = value end, "teamcheck")
----------------------------------------------------------------------------------------------------
AimbotSettings:AddDropdown("Aim Part", { "Head", "HumanoidRootPart" }, "Head", false, function(value) _G.AimPart = value end, Target)
-----------------------------------------------------------------------------
AimbotSettings:AddSlider("Prediction", 0, 167, 1000, 1, function(value) Epitaph = value / 1000 end, prediction1)
----------------------------------------------------------------------------------------------------------------
AimbotSettings:AddSlider("Fov Sides", 3, 64, 128, 1, function(value) _G.CircleSides = value end, sides)
-------------------------------------------------------------------------------------------------------------
AimbotSettings:AddSlider("Fov Transparency", 0, 100, 100, 1, function(value) _G.CircleTransparency = value end, transparency)
-----------------------------------------------------------------------------------------------------------------------------
AimbotSettings:AddSlider("Fov Radius", 0, 80, 640, 1, function(value) _G.CircleRadius = value end, radius)
----------------------------------------------------------------------------------------------------------
AimbotSettings:AddToggle("Fov Visible", false, function(value) _G.CircleVisible = value end, criclevis)
---------------------------------------------------------------------------------------------------------
AimbotSettings:AddToggle("Fov Filled", false, function(value) _G.CircleFilled = value end, circlefill)
--------------------------------------------------------------------------------------------------------
AimbotSettings:AddSlider("Fov Thickness", 0, 0, 5, 1, function(value) _G.CircleThickness = value end, fovthicc)
---------------------------------------------------------------------------------------------------------------
local Rage = Main:CreateTab("RageBot")
local SilentMain = Rage:CreateSector("Silent Aim", "right")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SilentMain:AddToggle("Enabled", false, function(value) instahiton = value instahit() SilentAimSettings.Enabled = value Toggles.aim_Enabled.Value = SilentAimSettings.Enabled Toggles.aim_Enabled:SetValue(SilentAimSettings.Enabled) mouse_box.Visible = SilentAimSettings.Enabled end)
------------------------------------------------------------------------
local SilentSettings = Rage:CreateSector("Silent Aim Settings", "right")
-----------------------------------------------------------------------------------------------------
SilentSettings:AddToggle("TeamCheck", false, function(value) SilentAimSettings.TeamCheck = value end)
-------------------------------------------------------------------------------------------------------------
SilentSettings:AddToggle("Visible Check", false, function(value)  SilentAimSettings.VisibleCheck = value end)
------------------------------------------------------------------------------------------------------------------------------------------------------------
SilentSettings:AddDropdown("Target Part", { "Head", "HumanoidRootPart", "Random" }, "Head", false, function(value) SilentAimSettings.TargetPart = value end)
---------------------------------------------------------------------------------------------------------------
SilentSettings:AddSlider("Hit chance", 0, 100, 100, 1, function(value) SilentAimSettings.HitChance = value end)
---------------------------------------------------------------------------------------------------------------------------------------
SilentSettings:AddToggle("Show FOV Circle", false, function(value) SilentAimSettings.FOVVisible = value fov_circle.Visible = value end)
-----------------------------------------------------------------------------------------------------------------------------------------
SilentSettings:AddSlider("Fov Radius", 0, 130, 360, 1, function(value) fov_circle.Radius = value SilentAimSettings.FOVRadius = value end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SilentSettings:AddToggle("Show Silent Aim Target", false, function(value) mouse_box.Visible = value SilentAimSettings.ShowSilentAimTarget = mouse_box.Visible end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
local ESP = Main:CreateTab("Esp")
local esp = ESP:CreateSector("Esp", "left")

----------------------------------------------------------------------------------------
esp:AddToggle("Enabled", false, function(value) espLib.options.enabled = value end, esp)
------------------------------------------------------------------------------------
esp:AddToggle("Boxes", false, function(value) espLib.options.boxes = value end, box)
-----------------------------------------------------------------------------------------------
esp:AddToggle("Distance", false, function(value) espLib.options.distance = value end, distance)
-------------------------------------------------------------------------------------
esp:AddToggle("Names", false, function(value) espLib.options.names = value end, name)
-------------------------------------------------------------------------------------
esp:AddToggle("Health Bars", false, function(value) espLib.options.healthBars = value end, barofhealth)
-------------------------------------------------------------------------------------------------------
esp:AddToggle("Health Text", false, function(value) espLib.options.healthText = value end, healthtext)
-------------------------------------------------------------------------------------------
esp:AddToggle("Tracers", false, function(value) espLib.options.tracers = value end, tracer)
-------------------------------------------------------------------------------------
esp:AddToggle("Chams", false, function(value) espLib.options.chams = value end, cham)
--------------------------------------------------------------------------------------------------------
esp:AddToggle("Arrows", false, function(value) espLib.options.outOfViewArrowsOutline = value end, arrow)
-------------------------------------------------------------
local espsettings = ESP:CreateSector("Esp Settings", "right")
--------------------------------------------------------------------------------------------------------------
espsettings:AddToggle("Limit Distance", true, function(value) espLib.options.limitDistance = value end, limit)
-------------------------------------------------------------------------------------------------------------------------
espsettings:AddSlider("Max Distance", 0, 1000, 5000, 1, function(value) espLib.options.maxDistance = value end, distance)
----------------------------------------------------------------------------------------------------------
espsettings:AddToggle("Visible Check", false, function(value) espLib.options.visibleOnly = value end, vis)
------------------------------------------------------------------------------------------------------
espsettings:AddToggle("Team Check", false, function(value) espLib.options.teamCheck = value end, team)
----------------------------------------------------------------------------------------------------------------------------------
espsettings:AddToggle("Arrows Filled", false, function(value) espLib.options.outOfViewArrowsOutlineFilled = value end, arrowfilled)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
espsettings:AddSlider("Arrows Transparency", 0, 100, 100, 1, function(value) espLib.options.outOfViewArrowsOutlineTransparency = value / 100 end, arrowytran)
---------------------------------------------------------------------------------------------------------------------------------------
espsettings:AddSlider("Boxes Transparency", 0, 50, 100, 1, function(value) espLib.options.boxesTransparency = value / 100 end, boxtran)
--------------------------------------------------------------------------------------------------------------------------
espsettings:AddSlider("HealthBar Size", 0, 1, 5, 1, function(value) espLib.options.healthBarsSize = value end, healthsize)
---------------------------------------------------------------------------------------------------------------------------------------------------------
espsettings:AddSlider("HealthText Transparency", 0, 100, 100, 1, function(value) espLib.options.healthTextTransparency = value / 100 end, healthtexttran)
-----------------------------------------------------------------------------------------------------------------------------------------
espsettings:AddSlider("Chams Transparency", 0, 50, 100, 1, function(value) espLib.options.chamsTransparency = value / 100 end, chamstran)
----------------------------------------------------------------------------------------------------------------------------------------------
espsettings:AddSlider("Distance Transparency", 0, 100, 100, 1, function(value) espLib.options.distanceTransparency = value / 100 end, distrans)
------------------------------------------------------------------------------------------------------------------
espsettings:AddDropdown("Tracers", { "Top", "Bottom", "Mouse" }, "Top", false, function(value) espLib.options.tracerOrigin = value end, tracerorigin)
------------------------------------------------------------------------------------------------------------------
local color = ESP:CreateSector("Esp Color", "left")
-------------------------------------------------------------------------------------------------------------------
color:AddColorpicker("Name Color", Color3.fromRGB(255, 255, 255), function(value) espLib.options.nameColor = value end, namecolor)
-------------------------------------------------------------------------------------------------------------------
color:AddColorpicker("Box Color", Color3.fromRGB(255, 255, 255), function(value) espLib.options.boxesColor = value end, boxcolor)
------------------------------------------------------------------------------------------------------------------
color:AddColorpicker("HealthText Color", Color3.fromRGB(255, 255, 255), function(value) espLib.options.healthTextColor = value end, texthealthcolor)
-------------------------------------------------------------------------------------------------------------------------------------
color:AddColorpicker("Distance Color", Color3.fromRGB(255, 255, 255), function(value) espLib.options.distanceColor = value end, distancecolor)
-------------------------------------------------------------------------------------------------------------------------------
color:AddColorpicker("Tracer Color", Color3.fromRGB(255, 255, 255), function(value) espLib.options.tracerColor = value end, tracercolor)
-------------------------------------------------------------------------------------------------------------------------
color:AddColorpicker("Chams Color", Color3.fromRGB(255, 0, 0), function(value) espLib.options.chamsColor = value end, chamscolor)
------------------------------------------------------------------------------------------------------------------
color:AddColorpicker("Arrows Color", Color3.fromRGB(255, 255, 255), function(value) espLib.options.outOfViewArrowsOutlineColor = value end, arrowcolor)
-------------------------------------------------------------------------------------------------------------------------------------------------------
local container = ESP:CreateSector("Container Esp", "left")
-----------------------------------------------------------
container:AddToggle("SportBag Esp", false, function(value) ItemEsp(value, "SportBag") end, sportbag)
----------------------------------------------------------------------------------------------------
container:AddToggle("Toolbox Esp", false, function(value) ItemEsp(value, "Toolbox") end, toolbox)
-------------------------------------------------------------------------------------------------
container:AddToggle("Toolbox Esp", false, function(value) ItemEsp(value, "Toolbox") end, toolbox)
-------------------------------------------------------------------------------------------------
container:AddToggle("LargeShippingCrate Esp", false, function(value) ItemEsp(value, "LargeShippingCrate") end, largeshippingcrate)
----------------------------------------------------------------------------------------------------------------------------------
container:AddToggle("SmallMilitaryBox Esp", false, function(value) ItemEsp(value, "SmallMilitaryBox") end, smallmilitarybox)
----------------------------------------------------------------------------------------------------------------------------
container:AddToggle("LargeMilitaryBox Esp", false, function(value) ItemEsp(value, "LargeMilitaryBox") end, largemilitarybox)
----------------------------------------------------------------------------------------------------------------------------
container:AddToggle("MilitaryCrate Esp", false, function(value) ItemEsp(value, "MilitaryCrate") end, militarycrate)
-------------------------------------------------------------------------------------------------------------------
container:AddToggle("Medbag Esp", false, function(value) ItemEsp(value, "Medbag") end, medbag)
----------------------------------------------------------------------------------------------
container:AddToggle("SmallShippingCrate Esp", false, function(value) ItemEsp(value, "SmallShippingCrate") end, smallshippingcrate)
----------------------------------------------------------------------------------------------------------------------------------
container:AddToggle("GrenadeCrate Esp", false, function(value) ItemEsp(value, "GrenadeCrate") end, grenadecrate)
----------------------------------------------------------------------------------------------------------------
local containersettings = ESP:CreateSector("Container Esp Settings", "right")

containersettings:AddSlider("Size", 1, 1, 10, 1, function(value) sizey = value end, sizee)

containersettings:AddToggle("Always On Top", false, function(value) Top = value end, top)

containersettings:AddColorpicker("Text Color", Color3.fromRGB(255, 255, 255), function(value) realcolor = value end, textlolcolor)

local misc = ESP:CreateSector("Misc", "right")

local whitelist = misc:AddDropdown("Whitelisted Players", {}, default, true, function(v) espLib.whitelist = v end, whitelisted)

for i,v in pairs(Players:GetChildren()) do
    whitelist:Add(v.Name)
end

misc:AddColorpicker("Whitelisted Color", Color3.fromRGB(255, 0, 0), function(value) espLib.options.whitelistColor = value end, whitecolor)

local admin = ESP:CreateSector("Admin", "right")

admin:AddToggle("Admin Notify", false, function(value)  end, top)

local Visuals = Main:CreateTab("Visuals")

local Player = Visuals:CreateSector("Player", "right")

Player:AddToggle("Body Material", false, function(value) material = value Body() end, bodymaterial)

Player:AddDropdown("Body Material", { "ForceField", "Plastic" }, "Plastic", false, function(value) matisgay = value end, bodymat)

local World = Visuals:CreateSector("World", "Left")

local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Parent = game.Lighting
colorCorrection.TintColor = Color3.fromRGB(255, 0, 0)
colorCorrection.Enabled = false

World:AddToggle("Tint", false, function(value) colorCorrection.Enabled = value end, tint)

World:AddColorpicker("Tint Color", Color3.fromRGB(255, 255, 255), function(value) colorCorrection.TintColor = value end, flag)

World:AddToggle("FullBright", false, function(value) fullbright = value FullBright() end, fullbright)

World:AddToggle("Anti-Lag", false, function(value) game:GetService("Lighting").Bloom.Enabled = Value end, antilag)

World:AddToggle("No Hurt Effect", false, function(value) nohurt() end, nohurt)

World:AddToggle("No Water Blur", false, function(value) nowater() end, nowater)

local settings = Main:CreateTab("Settings")

-- init stuff
espLib:Load()

resume(create(function()
    RenderStepped:Connect(function()
        if SilentAimSettings.ShowSilentAimTarget then
            if getClosestPlayer() then 
                local Root = getClosestPlayer().Parent.PrimaryPart or getClosestPlayer()
                local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position);
                -- using PrimaryPart instead because if your Target Part is "Random" it will flicker the square between the Target's Head and HumanoidRootPart (its annoying)
                
                mouse_box.Visible = IsOnScreen
                mouse_box.Position = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y)
            else 
                mouse_box.Visible = false 
                mouse_box.Position = Vector2.new()
            end
        end
        
        if SilentAimSettings.FOVVisible then 
            fov_circle.Visible = SilentAimSettings.FOVVisible
            fov_circle.Color = Color3.fromRGB(255, 255, 255)
            fov_circle.Position = getMousePosition()
        end
    end)
    task.wait()
end))

-- hooks
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = "Raycast"
    local Arguments = {...}
    local self = Arguments[1]
    local chance = CalculateChance(SilentAimSettings.HitChance)
    if SilentAimSettings.Enabled and self == workspace and chance == true then
        if Method == "FindPartOnRayWithIgnoreList" and Options.Method.Value == Method then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local A_Ray = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    local Origin = A_Ray.Origin
                    local Direction = getDirection(Origin, HitPart.Position)
                    Arguments[2] = Ray.new(Origin, Direction)

                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "FindPartOnRayWithWhitelist" then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithWhitelist) then
                local A_Ray = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    local Origin = A_Ray.Origin
                    local Direction = getDirection(Origin, HitPart.Position)
                    Arguments[2] = Ray.new(Origin, Direction)

                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") then
            if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRay) then
                local A_Ray = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    local Origin = A_Ray.Origin
                    local Direction = getDirection(Origin, HitPart.Position)
                    Arguments[2] = Ray.new(Origin, Direction)

                    return oldNamecall(unpack(Arguments))
                end
            end
        elseif Method == "Raycast" then
            if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                local A_Origin = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[3] = getDirection(A_Origin, HitPart.Position)

                    return oldNamecall(unpack(Arguments))
                end
            end
        end
    end
    return oldNamecall(...)
end))