--[[stuff to add
    fix all aimbot and silent aim its all broken help me please 1
    add the mods working on this 4
    npc esp working on this 9
    container esp working on this 10
    shootthrough walls (when activated anchor rootpart) 9999999999999
    gunmods working on this 5
    aimbot for bots 10000
    zoom 3
    no visor 2 
    better visible check 99
    fix all aimbot and silent aim 1

    --stuff to fix
    fix hitsound error and hitlog error
]]

--Init
if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end
local resume = coroutine.resume
local create = coroutine.create
local CoreGui = game:GetService("StarterGui")
local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character
local FreeCamera = {Speed = 0.5, CFrame = CFrame.new(0, 0, 0)}
local Loaded = false
local UILoaded = false
local UserInputService = game:GetService("UserInputService")
local GetMouseLocation = UserInputService.GetMouseLocation
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local LOCAL_PLAYER = Players.LocalPlayer
local INPUT_SERVICE = game:GetService("UserInputService")
local Mouse = LocalPlayer:GetMouse()
local GetChildren = game.GetChildren
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local worldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild = game.FindFirstChild
local RenderStepped = RunService.RenderStepped
local GuiInset = GuiService.GetGuiInset
local GetMouseLocation = UserInputService.GetMouseLocation
local resume = coroutine.resume 
local create = coroutine.create
local speed = 35
local speed2 = 35
local Sportbagadded = false
local ValidTargetParts = {"Head", "HumanoidRootPart"}
local invDrawings = {};
local sorigin = "Head"
local Old_Camera = {
    FieldOfView = Camera.FieldOfView,
    DiagonalFieldOfView = Camera.DiagonalFieldOfView,
    MaxAxisFieldOfView = Camera.MaxAxisFieldOfView
}
local Esp = {
    ContainerOptions = {
        Enabled = false,
        Names = false,
        SportBag = false
    },
    NpcOptions = {
        Enabled = false,
        Names = false
    }
}
local ExpectedArguments = {
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    }
}

local Old_Ammo = {
    ["762x54SAP"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["762x54AP"]:GetAttribute("ProjectileDrop")
    },
    ["9x18AP"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["9x18AP"]:GetAttribute("ProjectileDrop")
    },
    ["762x39AP"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["762x39AP"]:GetAttribute("ProjectileDrop")
    },
    ["9x18Z"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["9x18Z"]:GetAttribute("ProjectileDrop")
    },
    ["762x25Tracer"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["762x25Tracer"]:GetAttribute("ProjectileDrop")
    },
    ["556x45Tracer"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["556x45Tracer"]:GetAttribute("ProjectileDrop")
    },
    ["762x25AP"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["762x25AP"]:GetAttribute("ProjectileDrop")
    },
    ["762x39Tracer"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["762x39Tracer"]:GetAttribute("ProjectileDrop")
    },
    ["762x54Tracer"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["762x54Tracer"]:GetAttribute("ProjectileDrop")
    },
    ["9x19Tracer"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["9x19Tracer"]:GetAttribute("ProjectileDrop")
    },
    ["9x18Tracer"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["9x18Tracer"]:GetAttribute("ProjectileDrop")
    },
    ["9x19AP"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["9x19AP"]:GetAttribute("ProjectileDrop")
    },
    ["556x45AP"] = {
        ["Drop"] = game:GetService("ReplicatedStorage").AmmoTypes["556x45AP"]:GetAttribute("ProjectileDrop")
    }
}

headSound = Instance.new("Sound", CoreGui)
headSound.SoundId = "rbxassetid://1255040462"
local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 180
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = Color3.fromRGB(54, 57, 241)

local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()
espLib.options.boundingBox = false
espLib.options.outOfViewArrows = false
espLib.options.tracerOrigin = "Top"
espLib.options.teamCheck = false
espLib.whitelist = {}

local BanRemote
local SilentAim

Camera = Workspace.CurrentCamera

version = 2.1

--Custom Esp Function

function ContainerEspAdd(Container)
    for i,v in pairs(game:GetService("Workspace").Containers:GetChildren()) do
        if v.Name == Container then
            if Esp.ContainerOptions.Names == true and Esp.ContainerOptions.Enabled == true then
                local Main = Instance.new("BillboardGui", v)
                Main.Size = UDim2.new(1,0, 1,0)
                Main.Name = "A"
                Main.AlwaysOnTop = true
                local Frame = Instance.new("Frame", Main)
                Frame.Size = UDim2.new(1,0, 1,0)
                Frame.BackgroundTransparency = 1
                Frame.BorderSizePixel = 0
                local Text = Instance.new("TextLabel", Frame)
                Text.Text = Container
                Text.Size = UDim2.new(1,0, 1,0)
                Text.BackgroundTransparency = 1
                Text.BorderSizePixel = 0
                Text.TextColor3 = Color3.fromRGB(255,255,255)
                Sportbagadded = true
            end
        end
    end
end

local function newDrawing(type, props)
    local d = Drawing.new(type);
    for i,v in next, props or {} do
        local s,e = pcall(function()
            d[i] = v;
        end)
        if not s then
            warn(e);
        end
    end
    return d;
end

local invc1, invc2
local selectedInventoryTarget;
local function viewInventory(plr)
    if plr ~= selectedInventoryTarget then
        selectedInventoryTarget = plr
        
        if invc1 then
            invc1:Disconnect();
            invc2:Disconnect();
        end
        
        for i,v in next, invDrawings do
            v[1]:Remove();
            invDrawings[i] = nil;
        end
    
        if cachedPlayers[plr.Name] then
            local function a(inst)
                if invDrawings[inst.Name] then
                    invDrawings[inst.Name][2] += 1
                else
                    invDrawings[inst.Name] = {newDrawing('Text', {Text = inst.Name, Color = Color3.new(.85,.85,.85), Outline = true, Size = 13, Font = 2}), 1};
                end
                updateInvDrawings();
            end
            for _,inst in next, cachedPlayers[plr.Name]:GetChildren() do
                a(inst)
            end
            invc1 = Connection(cachedPlayers[plr.Name].ChildAdded, a)
            invc2 = Connection(cachedPlayers[plr.Name].ChildRemoved, function(inst)
                local data = invDrawings[inst.Name]
                if data then
                    data[2] -= 1
                    if data[2] == 0 then
                        data[1]:Remove();
                        invDrawings[inst.Name] = nil;
                    end
                end
                updateInvDrawings();
            end)
            selectedPlayerDrawing.Text = plr.Name.."'s Inventory ["..#cachedPlayers[plr.Name]:GetChildren().." Items]:";
        end
    end
end

local selectedPlayerDrawing = newDrawing('Text', {Text = 'PLAYERS INVENTORY:', Position = Vector2.new(10,350), Color = Color3.new(1,1,1), Outline = true, Size = 13, Font = 2})
local function updateInvDrawings()
    selectedPlayerDrawing.Visible = true
    if init then
        local pos = 350
        for i,v in next, invDrawings do
            v[1].Visible = true
            v[1].Position = Vector2.new(10, pos + 18);
            v[1].Text = v[2] == 1 and i or i..' x'..tostring(v[2]);
            pos = v[1].Position.Y;
        end
    end
end

function ContainerEspRemove(Container)
    for i,v in pairs(game:GetService("Workspace").Containers:GetChildren()) do
        if v.Name == Container then
            for i1,v1 in pairs(v:GetChildren()) do
                if v1:IsA("BillboardGui") then
                    v1:Destroy()
                    Sportbagadded = false
                end
            end
        end
    end
end

function EspUpdate()
    if Esp.ContainerOptions.Enabled == true then
        if Esp.ContainerOptions.SportBag == true then
            if Sportbagadded ~= true then
                ContainerEspAdd("SportBag")
            end
        else
            ContainerEspRemove("SportBag")
        end
        if Esp.ContainerOptions.Names == false then
            ContainerEspRemove("SportBag")
            --add others
        end
    else
        ContainerEspRemove("SportBag")
        --add others
    end
end

--Movement Function
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

--Aim Functions
local function getMousePosition()
    return GetMouseLocation(UserInputService)
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

function instahittoggle()
    resume(create(function()
        while Toggles.instahit.Value do
            for i,v in pairs(getconnections(runService.Heartbeat)) do
                local Func = v.Function
                if not Func then break end
                    setupvalue(Func, 1, 999999)
                end
            task.wait()
        end
        task.wait()
    end))
end

function CalculateChance(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    return chance <= Percentage / 100
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

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    
    if not (PlayerCharacter or LocalPlayerCharacter) then return end 
    
    local PlayerRoot = FindFirstChild(PlayerCharacter, Options.stargetpart.Value) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end 
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function getClosestPlayer()
    if not Options.stargetpart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        --if Toggles.TeamCheck.Value and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if Toggles.svisible.Value and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Options.sfovsize.Value or 2000) then
            Closest = ((Options.stargetpart.Value == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[Options.stargetpart.Value]) or false
            DistanceToMouse = Distance
        end
    end
    if Closest ~= false then
        return Closest
    else
        return false
    end
end

local function getClosestPlayer2()
    if not Options.stargetpart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        --if Toggles.TeamCheck.Value and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if Toggles.svisible.Value and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Options.sfovsize.Value or 2000) then
            Closest = Character or false
            DistanceToMouse = Distance
        end
    end
    if Closest ~= false then
        return Closest
    else
        return false
    end
end

local function ShowTarget(Player)
    if Toggles.sshowtarget.Value then
        espLib.options.whitelist = {Player}
    else
        espLib.options.whitelist = {}
    end
end

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
local getService = game.GetService;
local runService = getService(game, "RunService");
local Epitaph = 0.167 ---Note: The Bigger The Number, The More Prediction.
local HeadOffset = Vector3.new(0, .1, 0)
_G.TeamCheck = false
_G.AimPart = "Head"
_G.Sensitivity = 0
_G.CircleSides = 14
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

function noRecoilToggle()
    local VFX = nil; for i,v in next, getgc(true) do
        if typeof(v) == "table" and rawget(v, "RecoilCamera") then
            VFX = v
            break
        end
    end

    local RecoilCamera = VFX.RecoilCamera;
    VFX.RecoilCamera = function(...)
        if Toggles.recoil.Value then
            return 0
        else
           return RecoilCamera(...)
        end
    end
end

function FindNearestPlayer()
    local dist = math.huge
    local Target = nil
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character then
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
                        local Future = The_Enemy[_G.AimPart].CFrame + (The_Enemy.HumanoidRootPart.Velocity * CalculateMPred() + HeadOffset)
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

--Other Functions
function Fullbright()
    resume(create(function()
        while Toggles.fbright.Value do
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            task.wait(0.001)
        end
    end))
end

function CalculateMPred()
    if Toggles.aauto.Value then
        if FindNearestPlayer() then
            LPlayerC = game.Players.LocalPlayer.Character
            Distance = (LPlayerC.HumanoidRootPart.Position - FindNearestPlayer().HumanoidRootPart.Position).Magnitude
            if game.Players.LocalPlayer.Character:FindFirstChild("AKMN") then
                print("AKMN - Detected")
                return Distance / 3333.3333333333335
            elseif game.Players.LocalPlayer.Character:FindFirstChild("PPSH41") then
                print("PPSH41 - Detected")
                return Distance
            elseif game.Players.LocalPlayer.Character:FindFirstChild("Makarov") then
                print("Makarov - Detected")
                return Distance / 218.75
            elseif game.Players.LocalPlayer.Character:FindFirstChild("") then
                print(" - Detected")
                return Distance / 600
            else
                return 0
            end
        end
    else
        return Epitaph
    end
end

--UI Handler

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

--Silent Aim / Aimbot (Combat)
local MainSilentAim = Tabs.Combat:AddLeftGroupbox('Silent Aim')

MainSilentAim:AddToggle("senabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
MainSilentAim:AddToggle("svisible", {Text = "Visible Check", Default = false}):OnChanged(function() end)
MainSilentAim:AddSlider('shitchance', {Text = 'HitChance', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.shitchance:OnChanged(function() end)
MainSilentAim:AddDropdown("stargetpart", {Text = "Target Part", Default = "Head", Values = {"Head", "HumanoidRootPart", "Random"}}):OnChanged(function() end)
MainSilentAim:AddDropdown("method", {Text = "Silent Aim Method", Default = "Method 1", Values = {"Method 1", "Method 2"}}):OnChanged(function() end)
MainSilentAim:AddToggle("sshowtarget", {Text = "Show Silent Aim Target", Default = false}):OnChanged(function() end)
MainSilentAim:AddToggle("ssnapline", {Text = "Snaplines", Default = false}):OnChanged(function() end)
MainSilentAim:AddLabel('Silent Aim Target Color'):AddColorPicker('stargetcolor', { Default = Color3.new(0, 1, 1), Title = 'Silent Aim Target Color'}) Options.stargetcolor:OnChanged(function() espLib.options.whitelistColor = Options.stargetcolor.Value end)

local FovSilentAim = Tabs.Combat:AddLeftGroupbox('Silent Aim Fov')

FovSilentAim:AddToggle("sshowfov", {Text = "Fov Visible", Default = false}):OnChanged(function() end)
FovSilentAim:AddSlider('sfovsize', {Text = 'Fov Size', Default = 80, Min = 0, Max = 360, Rounding = 1, Compact = false}) Options.sfovsize:OnChanged(function() end)
FovSilentAim:AddSlider('sfovside', {Text = 'Fov Sides', Default = 14, Min = 3, Max = 64, Rounding = 1, Compact = false}) Options.sfovside:OnChanged(function() end)
FovSilentAim:AddToggle("sfovfilled", {Text = "Fov Filled", Default = false}):OnChanged(function() end)
FovSilentAim:AddSlider('sfovtrans', {Text = 'Fov Tranperancy', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.sfovside:OnChanged(function() end)

local MainAimbot = Tabs.Combat:AddRightGroupbox('Aimbot')

MainAimbot:AddToggle('aenabled', {Text = 'Aimbot',Default = false,Tooltip = 'Toggles Aimbot',}) Toggles.aenabled:OnChanged(function() _G.AimbotON = Toggles.aenabled.Value end)
MainAimbot:AddDropdown('atargetpart', {Values = { 'Head', 'HumanoidRootPart' },Default = 1,Multi = false,Text = 'Aimbot Aim Target',Tooltip = 'Changes the Aimbot Target',}) Options.atargetpart:OnChanged(function() _G.AimPart = Options.atargetpart.Value end)
MainAimbot:AddToggle('aauto', {Text = 'Auto Prediction',Default = true,Tooltip = 'Turns off Manual Prediction',}) Toggles.aauto:OnChanged(function() end)
MainAimbot:AddSlider('aprediction', {Text = 'MPrediction Amount',Default = 0,Min = 0,Max = 1,Rounding = 2,Compact = false,}) Options.aprediction:OnChanged(function() Epitaph = Options.aprediction.Value end)
MainAimbot:AddToggle('asnapline', {Text = 'SnapLines',Default = false,Tooltip = 'Toggles Snaplines',}) Toggles.asnapline:OnChanged(function() end)

local FovAimbot = Tabs.Combat:AddRightGroupbox('Aimbot Fov')

FovAimbot:AddToggle('afovenabled', {Text = 'Fov Visible',Default = false,Tooltip = 'Toggles Fov Visible',}) Toggles.afovenabled:OnChanged(function() _G.CircleVisible = Toggles.afovenabled.Value end)
FovAimbot:AddSlider('afovsides', {Text = 'Fov Sides',Default = 14,Min = 3,Max = 64,Rounding = 0,Compact = false,})Options.afovsides:OnChanged(function() _G.CircleSides = Options.afovsides.Value end)
FovAimbot:AddSlider('atrans', {Text = 'Fov Transperancy',Default = 100,Min = 0,Max = 100,Rounding = 1,Compact = false,}) Options.atrans:OnChanged(function() _G.CircleTransparency = Options.atrans.Value / 100 end)
FovAimbot:AddSlider('aradius', {Text = 'Aimbot Fov Size',Default = 80,Min = 0,Max = 640,Rounding = 0,Compact = false,}) Options.aradius:OnChanged(function() _G.CircleRadius = Options.aradius.Value end)
FovAimbot:AddToggle('afilled', {Text = 'Fov Filled',Default = false,Tooltip = 'Toggles Fov Filled',}) Toggles.afilled:OnChanged(function() _G.CircleFilled = Toggles.afilled.Value end)
FovAimbot:AddSlider('afovthick', {Text = 'Aimbot Fov thickness',Default = 0,Min = 0,Max = 10,Rounding = 1,Compact = false,}) Options.afovthick:OnChanged(function() _G.CircleThickness = Options.afovthick.Value end)

--Visuals
local MainVisuals = Tabs.Visuals:AddLeftGroupbox('Main')

local Crosshair_Horizontal = Drawing.new("Line")
Crosshair_Horizontal.Visible = false
Crosshair_Horizontal.Thickness = 1
Crosshair_Horizontal.Transparency = 1
Crosshair_Horizontal.From = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Crosshair_Horizontal.To = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Crosshair_Horizontal.Color = Color3.fromRGB(255, 255, 255)

local Crosshair_Vertical = Drawing.new("Line")
Crosshair_Vertical.Visible = false
Crosshair_Vertical.Thickness = 1
Crosshair_Vertical.Transparency = 1
Crosshair_Vertical.From = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Crosshair_Vertical.To = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Crosshair_Vertical.Color = Color3.fromRGB(255, 255, 255)

MainVisuals:AddToggle("visualsenabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
MainVisuals:AddToggle("viewmodel", {Text = "Viewmodel", Default = false}):OnChanged(function() end)
MainVisuals:AddToggle("fbright", {Text = "FullBright", Default = false}):OnChanged(function() Fullbright() end)
MainVisuals:AddToggle("cross", {Text = "Crosshair", Default = false}):OnChanged(function() Crosshair_Vertical.Visible = Toggles.cross.Value Crosshair_Horizontal.Visible = Toggles.cross.Value end)

local SettingsVisuals = Tabs.Visuals:AddRightGroupbox('Settings')

SettingsVisuals:AddSlider('viewx', {Text = 'Viewmodel-X', Default = 0, Min = -5, Max = 5, Rounding = 2, Compact = false}) Options.viewx:OnChanged(function() end)
SettingsVisuals:AddSlider('viewy', {Text = 'Viewmodel-Y', Default = 0, Min = -5, Max = 5, Rounding = 2, Compact = false}) Options.viewy:OnChanged(function() end)
SettingsVisuals:AddSlider('viewz', {Text = 'Viewmodel-Z', Default = 0, Min = -5, Max = 5, Rounding = 2, Compact = false}) Options.viewz:OnChanged(function() end)
SettingsVisuals:AddSlider('crosss', {Text = 'Crosshair-Size', Default = 0, Min = 0, Max = 25, Rounding = 1, Compact = false}) Options.crosss:OnChanged(function() 
    Crosshair_Horizontal.From = Vector2.new(MyView.ViewportSize.X / 2 - Options.crosss.Value, MyView.ViewportSize.Y / 2)
    Crosshair_Horizontal.To = Vector2.new(MyView.ViewportSize.X / 2 + Options.crosss.Value, MyView.ViewportSize.Y / 2)
    Crosshair_Vertical.From = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2 - Options.crosss.Value)
    Crosshair_Vertical.To = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2 + Options.crosss.Value) 
end)

--ESP
local MainESP = Tabs.ESP:AddLeftGroupbox('Esp')

MainESP:AddToggle("esp", {Text = "Enabled", Default = false}):OnChanged(function() espLib.options.enabled = Toggles.esp.Value end)
MainESP:AddToggle("box", {Text = "Boxes", Default = false}):OnChanged(function() espLib.options.boxes = Toggles.box.Value end)
MainESP:AddToggle("names", {Text = "Names", Default = false}):OnChanged(function() espLib.options.names = Toggles.names.Value end)
MainESP:AddToggle("maxd", {Text = "Distance", Default = false}):OnChanged(function() espLib.options.distance = Toggles.maxd.Value end)
MainESP:AddToggle("healtht", {Text = "Health Text", Default = false}):OnChanged(function() espLib.options.healthText = Toggles.healtht.Value end)
MainESP:AddToggle("healthb", {Text = "Health Bars", Default = false}):OnChanged(function() espLib.options.healthBars = Toggles.healthb.Value end)
MainESP:AddToggle("tracer", {Text = "Tracers", Default = false}):OnChanged(function() espLib.options.tracers = Toggles.tracer.Value end)
MainESP:AddToggle("chams", {Text = "Chams", Default = false}):OnChanged(function() espLib.options.chams = Toggles.chams.Value end)
MainESP:AddToggle("arrows", {Text = "Arrows", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutline = Toggles.arrows.Value end)

local NpcESP = Tabs.ESP:AddLeftGroupbox('Npc Esp')



local ContainerESP = Tabs.ESP:AddLeftGroupbox('Container Esp')

ContainerESP:AddToggle("cenabled", {Text = "Enabled", Default = false}):OnChanged(function() Esp.ContainerOptions.Enabled = Toggles.cenabled.Value end)
ContainerESP:AddToggle("cnames", {Text = "Names", Default = false}):OnChanged(function() Esp.ContainerOptions.Names = Toggles.cnames.Value end)


ContainerESP:AddToggle("sportbag", {Text = "SportBags", Default = false}):OnChanged(function() Esp.ContainerOptions.SportBag = Toggles.sportbag.Value end)

local SettingsESP = Tabs.ESP:AddRightGroupbox('Esp Settings')

SettingsESP:AddToggle("ldistance", {Text = "Limit Distance", Default = false}):OnChanged(function() espLib.options.limitDistance = Toggles.ldistance.Value end)
SettingsESP:AddSlider('mdistance', {Text = 'Max Distance', Default = 5000, Min = 0, Max = 10000, Rounding = 1, Compact = false}) Options.mdistance:OnChanged(function() espLib.options.maxDistance = Options.mdistance.Value end)
SettingsESP:AddToggle("vcheck", {Text = "Visible Check", Default = false}):OnChanged(function() espLib.options.visibleOnly = Toggles.vcheck.Value end)
SettingsESP:AddToggle("afilled", {Text = "Arrows Filled", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutlineFilled = Toggles.afilled.Value end)
SettingsESP:AddSlider('atransparency', {Text = 'Arrows Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.atransparency:OnChanged(function() espLib.options.outOfViewArrowsOutlineTransparency = Options.atransparency.Value / 100 end)
SettingsESP:AddSlider('btransparency', {Text = 'Boxes Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.btransparency:OnChanged(function() espLib.options.boxesTransparency = Options.btransparency.Value / 100 end)
SettingsESP:AddSlider('hbsize', {Text = 'HealthBar Size', Default = 1, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.hbsize:OnChanged(function() espLib.options.healthBarsSize = Options.hbsize.Value end)
SettingsESP:AddSlider('httransparency', {Text = 'HealthText Transparency', Default = 1, Min = 0, Max = 5, Rounding = 1, Compact = false}) Options.httransparency:OnChanged(function() espLib.options.healthTextTransparency = Options.httransparency.Value / 100 end)
SettingsESP:AddSlider('ctransparency', {Text = 'Chams Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.ctransparency:OnChanged(function() espLib.options.chamsFillTransparency = Options.ctransparency.Value / 100 end)
SettingsESP:AddSlider('dtransparency', {Text = 'Distance Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.dtransparency:OnChanged(function() espLib.options.distanceTransparency = Options.dtransparency.Value / 100 end)
SettingsESP:AddDropdown("tracerf", {Text = "Tracers", Default = "Top", Values = {"Top", "Bottom", "Mouse"}}):OnChanged(function() espLib.options.tracerOrigin = Options.tracerf.Value end)

local ColorESP = Tabs.ESP:AddLeftGroupbox('Esp Color')

ColorESP:AddLabel('Name Color'):AddColorPicker('ncolor', { Default = Color3.new(1, 1, 1), Title = 'Name Color'}) Options.ncolor:OnChanged(function() espLib.options.nameColor = Options.ncolor.Value end)
ColorESP:AddLabel('Box Color'):AddColorPicker('bcolor', { Default = Color3.new(1, 1, 1), Title = 'Box Color'}) Options.bcolor:OnChanged(function() espLib.options.boxesColor = Options.bcolor.Value end)
ColorESP:AddLabel('HealthText Color'):AddColorPicker('htcolor', { Default = Color3.new(1, 1, 1), Title = 'HealthText Color'}) Options.htcolor:OnChanged(function() espLib.options.healthTextColor = Options.htcolor.Value end)
ColorESP:AddLabel('Distance Color'):AddColorPicker('dcolor', { Default = Color3.new(1, 1, 1), Title = 'Distance Color'}) Options.dcolor:OnChanged(function() espLib.options.distanceColor = Options.dcolor.Value end)
ColorESP:AddLabel('Tracer Color'):AddColorPicker('tcolor', { Default = Color3.new(1, 1, 1), Title = 'Tracer Color'}) Options.tcolor:OnChanged(function() espLib.options.tracerColor = Options.tcolor.Value end)
ColorESP:AddLabel('Chams Color'):AddColorPicker('ccolor', { Default = Color3.new(1, 0, 0), Title = 'Chams Color'}) Options.ccolor:OnChanged(function() espLib.options.chamsFillColor = Options.ccolor.Value end)
ColorESP:AddLabel('Arrow Color'):AddColorPicker('acolor', { Default = Color3.new(1, 1, 1), Title = 'Arrow Color'}) Options.acolor:OnChanged(function() espLib.options.outOfViewArrowsOutlineColor = Options.acolor.Value end)

local MainMovement = Tabs.Movement:AddLeftGroupbox('Main')

MainMovement:AddToggle("speed", {Text = "Speed", Default = false}):AddKeyPicker("speed_Enabled_KeyPicker", {Default = "RightAlt", SyncToggleState = true, Mode = "Toggle", Text = "Speed", NoUI = false});
    Options.speed_Enabled_KeyPicker:OnClick(function()
    velspeed = Toggles.speed.Value
    if velspeed then
        SpeedHack()
    end
end)

Toggles.speed:OnChanged(function()
    velspeed = Toggles.speed.Value
    if velspeed then
        SpeedHack()
    end
end)

MainMovement:AddToggle("velfly", {Text = "Fly", Default = false}):AddKeyPicker("fly_Enabled_KeyPicker", {Default = "LeftAlt", SyncToggleState = true, Mode = "Toggle", Text = "Fly", NoUI = false});
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

local SettingsMovement = Tabs.Movement:AddRightGroupbox('Settings')

SettingsMovement:AddSlider("speed", {Text = "Speed", Min = 0, Max = 40, Default = 20, Rounding = 0}):OnChanged(function()
	speed = Options.speed.Value
end)

SettingsMovement:AddSlider("speed1", {Text = "Fly Speed", Min = 0, Max = 40, Default = 35, Rounding = 0}):OnChanged(function()
	speed2 = Options.speed1.Value
end)

local Mod = Tabs.Exploits:AddLeftGroupbox('Mods')

Mod:AddToggle("instahit", {Text = "Insta Hit", Default = false}):OnChanged(function()
    instahittoggle()
end)

Mod:AddToggle("recoil", {Text = "No Recoil", Default = false}):OnChanged(function()
    noRecoilToggle()
end)

Mod:AddToggle("bob", {Text = "No Bob", Default = false}):OnChanged(function()
    local repStorage = game["ReplicatedStorage"]
    local springModule = require(repStorage.Modules.spring)
    local oldSpringIndex
    oldSpringIndex = hookfunction(springModule.update, function(...)
        if Toggles.bob.Value then
            return;
        end

        return oldSpringIndex(...)
    end)
end)

--[[Mod:AddToggle("muzzle", {Text = "Muzzle Effect", Default = false}):OnChanged(function()
    for i,v in pairs(repStorage.RangedWeapons:GetChildren()) do
        v:SetAttribute("MuzzleEffect", not bool)
    end
end)]]

Mod:AddToggle("drop", {Text = "No Bullet Drop", Default = false}):OnChanged(function()
    local repStorage = game["ReplicatedStorage"]
    for i,v in pairs(repStorage.AmmoTypes:GetChildren()) do
        --if bool == true then
        v:SetAttribute("ProjectileDrop", 0)
        --elseif bool == false then
            --v:SetAttribute("ProjectileDrop", Old_Ammo[v.Name]["Drop"])
        --end
    end
end)

local Other = Tabs.Exploits:AddRightGroupbox('Other')

Other:AddButton('Max Hunger (250 Rubles)', function()
    local A_1 = {
        ["Vendor"] = game:GetService("Workspace").FoodMachine, 
        ["ItemName"] = "Hunger"
    }

    local Event = game:GetService("ReplicatedStorage").Remotes.Vendor
    Event:InvokeServer(A_1)
end)

Other:AddButton('Max Thirst (250 Rubles)', function()
    local A_1 = {
        ["Vendor"] = game:GetService("Workspace").WaterMachine, 
        ["ItemName"] = "Hydration"
    }

    local Event = game:GetService("ReplicatedStorage").Remotes.Vendor
    Event:InvokeServer(A_1)
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
SaveManager:SetFolder('GorillaHookv2/ProjectDelta')
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

UILoaded = true

repeat task.wait() until UILoaded == true

--hooks
resume(create(function()
    while true do
        if Toggles.sshowfov.Value then 
            fov_circle.Visible = Toggles.sshowfov.Value
            fov_circle.Position = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
            fov_circle.Thickness = 1
            fov_circle.NumSides = Options.sfovside.Value
            fov_circle.Radius = Options.sfovsize.Value
            fov_circle.Filled = Toggles.sfovfilled.Value
            fov_circle.Transparency = Options.sfovtrans.Value / 100
            fov_circle.Color = Color3.fromRGB(255, 255, 255)
        else
            fov_circle.Visible = Toggles.sshowfov.Value
        end
        task.wait(0.01)
    end
end))

local Snapline_Line = Drawing.new("Line")
Snapline_Line.Visible = true
Snapline_Line.Thickness = 1
Snapline_Line.Transparency = 1
Snapline_Line.From = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Snapline_Line.To = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Snapline_Line.Color = Color3.fromRGB(255, 255, 255)

local Snapline_Line2 = Drawing.new("Line")
Snapline_Line2.Visible = true
Snapline_Line2.Thickness = 1
Snapline_Line2.Transparency = 1
Snapline_Line2.From = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Snapline_Line2.To = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
Snapline_Line2.Color = Color3.fromRGB(255, 255, 255)

resume(create(function()
    RenderStepped:Connect(function()
        if Toggles.senabled.Value and Toggles.sshowtarget.Value and getClosestPlayer() then
            if getClosestPlayer() then
                espLib.whitelist = {getClosestPlayer().Parent.Name}
            end
        else
            espLib.whitelist = {}
        end
        if Toggles.senabled.Value and Toggles.ssnapline.Value and getClosestPlayer() then
            local snapVector, snapOnScreen = Camera:worldToViewportPoint(getClosestPlayer2()[Options.stargetpart.Value].Position)
            if snapOnScreen then
                Snapline_Line.From = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
                Snapline_Line.To = Vector2.new(snapVector.X, snapVector.Y)
                Snapline_Line.Visible = true
            else
                Snapline_Line.Visible = false
            end
        else
            Snapline_Line.Visible = false
        end
        task.wait(0.001)
    end)
end))

resume(create(function()
    RenderStepped:Connect(function()
        if Toggles.aenabled.Value and Toggles.asnapline.Value and FindNearestPlayer() then
            local snapVector, snapOnScreen = Camera:worldToViewportPoint(FindNearestPlayer()[Options.atargetpart.Value].Position)
            if snapOnScreen then
                Snapline_Line2.From = Vector2.new(MyView.ViewportSize.X / 2, MyView.ViewportSize.Y / 2)
                Snapline_Line2.To = Vector2.new(snapVector.X, snapVector.Y)
                Snapline_Line2.Visible = true
            else
                Snapline_Line2.Visible = false
            end
        else
            Snapline_Line2.Visible = false
        end
        task.wait(0.001)
    end)
end))

resume(create(function()
    RenderStepped:Connect(function()
        EspUpdate()
        wait(1)
    end)
end))

if Character then
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        for _, connection in pairs(getconnections(Humanoid.StateChanged)) do
            local Function = connection.Function
            local Constants = getconstants(Function)
            if table.find(Constants, "FireServer") then
                connection:Disable()
                local Upvalues = getupvalues(Function)
                for i, v in pairs(Upvalues) do
                    if typeof(v) == "Instance" and v:IsA("RemoteEvent") then
                        BanRemote = v
                    end
                end
            end
        end
    end
end

local Salo = {{stepAmount = 43, dropTiming = 0.0005}}
__namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local Args, Method, Script = {...}, getnamecallmethod():lower(), getcallingscript()
    if Method == "fireserver" then
        if tostring(self):lower() == "errorlog" or tostring(self):lower() == "errrorlog" or self == BanRemote then
            return
        end
        local Args_4 = Args[4]
        if type(Args_4) == "table" and Args_4[1] and Args_4[1].step then
            local Call
            if Toggles.senabled.Value then
                Args[4] = Salo
                Call = __namecall(self, unpack(Args))
            end
            Call = Call or __namecall(self, ...)
            setthreadcontext(7)
            local Hit = Args[2]
            if Hit.Name:lower():find("head") then
                --headSound:Play()
            else
                --bodySound:Play()
            end
            local TargetStuds = math.floor((Hit.Position - Camera.CFrame.p).Magnitude + 0.5)
            --set thread identity
            print("Hit registration | Player: " .. Hit.Parent.Name .. ", Hit: " .. Hit.Name ..  ", Distance: " .. math.floor(TargetStuds / 3.5714285714 + 0.5) .. "m (" .. TargetStuds .. " studs)")
            --Library:Notify("Hit registration | Player: " .. Hit.Parent.Name .. ", Hit: " .. Hit.Name ..  ", Distance: " .. math.floor(TargetStuds / 3.5714285714 + 0.5) .. "m (" .. TargetStuds .. " studs)", 1.5)
        end
        Call = Call or __namecall(self, ...)
        return Call
    end
    if Method == "setprimarypartcframe" and Toggles.viewmodel.Value and Toggles.visualsenabled.Value then
        return __namecall(self, Camera.CFrame * CFrame.new(0.05, -1.35, 0.7) * CFrame.new(Options.viewx.Value, -Options.viewy.Value, -Options.viewz.Value)) -- x -y -z
    end
    if Toggles.senabled.Value then
        if Method == "raycast" and Options.method.Value == "Method 1" then
            if getClosestPlayer() then
                local Args_3 = Args[3]
                local Origin = Args[2]
                local Target = getClosestPlayer()
                local TargetPos = Target.CFrame
                TargetPos = TargetPos.Position
                Args[1] = TargetPos
                Args[2] = (TargetPos - Origin).unit
                if Target then
                    return __namecall(self, unpack(Args))
                end
            end
        end
    end
    return __namecall(self, ...)
end))

local oldNamecall --silent aim method 2
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = "Raycast"
    local Arguments = {...}
    local self = Arguments[1]
    local chance = true
    if Toggles.senabled.Value and self == workspace and not checkcaller() and chance == true and Options.method.Value == "Method 2" then
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

function Bypass_Client()
    for i, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "A1Sent") ~= nil then 
            rawset(v, "A1Sent", true)
        end
    end
end

local FPS = nil
for i, v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "updateClient") then
        FPS = v
    end
end

local VFX = nil
for i, v in next, getgc(true) do
    if type(v) == 'table' and rawget(v, "RecoilCamera") then
        VFX = v
        break
    end
end