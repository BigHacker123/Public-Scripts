--[[
    Stuff To Do:
    Silent Aim working on this
    Corpse esp
    Item esp
    Other Esp
    
    Stuff Done:
    Aimbot Working
    Most Ui Done
    Gun Mods
    Prediction
    Viewmodel
    Other visuals
]]

--Init
if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end
local resume = coroutine.resume
local create = coroutine.create
local version = 0.1
local Players = game:GetService("Players")
local FindFirstChild = game.FindFirstChild
local Camera = workspace.CurrentCamera
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local worldToViewportPoint = Camera.WorldToViewportPoint
local repstorage = game:GetService("ReplicatedStorage")
local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()
local IsPartVisible = loadstring(game:HttpGet("https://raw.githubusercontent.com/TechHog8984/TechHub-V3/main/script/misc/ispartvisible.lua"))()
local UniversalTables = require(repstorage.Modules:WaitForChild("UniversalTables"))
local LOCAL_PLAYER = Players.LocalPlayer
local INPUT_SERVICE = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
espLib.options.boundingBox = false
espLib.options.outOfViewArrows = false
espLib.options.tracerOrigin = "Top"
espLib.options.teamCheck = false
espLib.whitelist = {}
espLib.options.whitelistColor = Color3.fromRGB(0, 255, 0)
lastpostion = Vector3.new(0,0,0)
local repStorage = game["ReplicatedStorage"]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedPlayers = ReplicatedStorage:FindFirstChild("Players")
local ESP, ESP_RenderStepped, Framework = loadstring(game:HttpGet('https://www.octohook.xyz/ionhub/ionhub_esp.lua'))()
local Old_Ammo = { -- pasted
	["762x54AP"] = {
		["Drop"]  = repStorage.AmmoTypes["762x54AP"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["762x54AP"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["762x54AP"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["762x54AP"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["762x54AP"]:GetAttribute("ArmorPen")
	},
	["9x18AP"] = {
		["Drop"]  = repStorage.AmmoTypes["9x18AP"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["9x18AP"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["9x18AP"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["9x18AP"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["9x18AP"]:GetAttribute("ArmorPen")
	},
	["762x39AP"] = {
		["Drop"]  = repStorage.AmmoTypes["762x39AP"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["762x39AP"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["762x39AP"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["762x39AP"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["762x39AP"]:GetAttribute("ArmorPen")
	},
	["9x18Z"] = {
		["Drop"]  = repStorage.AmmoTypes["9x18Z"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["9x18Z"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["9x18Z"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["9x18Z"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["9x18Z"]:GetAttribute("ArmorPen")
	},
	["762x25Tracer"] = {
		["Drop"]  = repStorage.AmmoTypes["762x25Tracer"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["762x25Tracer"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["762x25Tracer"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["762x25Tracer"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["762x25Tracer"]:GetAttribute("ArmorPen")
	},
	["556x45Tracer"] = {
		["Drop"]  = repStorage.AmmoTypes["556x45Tracer"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["556x45Tracer"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["556x45Tracer"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["556x45Tracer"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["556x45Tracer"]:GetAttribute("ArmorPen")
	},
	["762x25AP"] = {
		["Drop"]  = repStorage.AmmoTypes["762x25AP"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["762x25AP"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["762x25AP"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["762x25AP"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["762x25AP"]:GetAttribute("ArmorPen")
	},
	["762x39Tracer"] = {
		["Drop"]  = repStorage.AmmoTypes["762x39Tracer"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["762x39Tracer"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["762x39Tracer"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["762x39Tracer"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["762x39Tracer"]:GetAttribute("ArmorPen")
	},
	["762x54Tracer"] = {
		["Drop"]  = repStorage.AmmoTypes["762x54Tracer"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["762x54Tracer"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["762x54Tracer"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["762x54Tracer"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["762x54Tracer"]:GetAttribute("ArmorPen")
	},
	["9x19Tracer"] = {
		["Drop"]  = repStorage.AmmoTypes["9x19Tracer"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["9x19Tracer"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["9x19Tracer"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["9x19Tracer"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["9x19Tracer"]:GetAttribute("ArmorPen")
	},
	["9x18Tracer"] = {
		["Drop"]  = repStorage.AmmoTypes["9x18Tracer"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["9x18Tracer"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["9x18Tracer"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["9x18Tracer"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["9x18Tracer"]:GetAttribute("ArmorPen")
	},
	["9x19AP"] = {
		["Drop"]  = repStorage.AmmoTypes["9x19AP"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["9x19AP"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["9x19AP"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["9x19AP"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["9x19AP"]:GetAttribute("ArmorPen")
	},
	["556x45AP"] = {
		["Drop"]  = repStorage.AmmoTypes["556x45AP"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["556x45AP"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["556x45AP"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["556x45AP"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["556x45AP"]:GetAttribute("ArmorPen")
	},
	["9x39Z"] = {
		["Drop"]  = repStorage.AmmoTypes["9x39Z"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["9x39Z"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["9x39Z"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["9x39Z"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["9x39Z"]:GetAttribute("ArmorPen")
	},
	["9x39AP"] = {
		["Drop"]  = repStorage.AmmoTypes["9x39AP"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["9x39AP"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["9x39AP"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["9x39AP"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["9x39AP"]:GetAttribute("ArmorPen")
	},
	["12gaSlug"] = {
		["Drop"]  = repStorage.AmmoTypes["12gaSlug"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["12gaSlug"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["12gaSlug"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["12gaSlug"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["12gaSlug"]:GetAttribute("ArmorPen")
	},
	["12gaBuckshot"] = {
		["Drop"] = repStorage.AmmoTypes["12gaBuckshot"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["12gaBuckshot"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["12gaBuckshot"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["12gaBuckshot"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["12gaBuckshot"]:GetAttribute("ArmorPen")
	},
	["12gaFlechette"] = {
		["Drop"] = repStorage.AmmoTypes["12gaFlechette"]:GetAttribute("ProjectileDrop"),
		["Speed"] = repStorage.AmmoTypes["12gaFlechette"]:GetAttribute("MuzzleVelocity"),
        ["Damage"] = repStorage.AmmoTypes["12gaFlechette"]:GetAttribute("Damage"),
        ["Pellets"] = repStorage.AmmoTypes["12gaFlechette"]:GetAttribute("Pellets"),
        ["ArmorPen"] = repStorage.AmmoTypes["12gaFlechette"]:GetAttribute("ArmorPen")
	}
}
local invDrawings = {}
local cachedPlayers = {}
local connections = {};

--Instances

local SFOVCircle = Drawing.new("Circle")
SFOVCircle.Position = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
SFOVCircle.Radius = 0
SFOVCircle.Filled = false
SFOVCircle.Color = Color3.fromRGB(255, 255, 255)
SFOVCircle.Visible = false
SFOVCircle.Transparency = 0
SFOVCircle.NumSides = 0
SFOVCircle.Thickness = 0

local AFOVCircle = Drawing.new("Circle")
AFOVCircle.Position = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
AFOVCircle.Radius = 0
AFOVCircle.Filled = false
AFOVCircle.Color = Color3.fromRGB(255, 255, 255)
AFOVCircle.Visible = false
AFOVCircle.Transparency = 0
AFOVCircle.NumSides = 0
AFOVCircle.Thickness = 0

local Snapline_Line = Drawing.new("Line")
Snapline_Line.Visible = true
Snapline_Line.Thickness = 1
Snapline_Line.Transparency = 1
Snapline_Line.From = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
Snapline_Line.To = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
Snapline_Line.Color = Color3.fromRGB(255, 255, 255)

local Snapline_Line2 = Drawing.new("Line")
Snapline_Line2.Visible = true
Snapline_Line2.Thickness = 1
Snapline_Line2.Transparency = 1
Snapline_Line2.From = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
Snapline_Line2.To = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
Snapline_Line2.Color = Color3.fromRGB(255, 255, 255)

local Crosshair_Horizontal = Drawing.new("Line")
Crosshair_Horizontal.Visible = false
Crosshair_Horizontal.Thickness = 1
Crosshair_Horizontal.Transparency = 1
Crosshair_Horizontal.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
Crosshair_Horizontal.To = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
Crosshair_Horizontal.Color = Color3.fromRGB(255, 255, 255)

local Crosshair_Vertical = Drawing.new("Line")
Crosshair_Vertical.Visible = false
Crosshair_Vertical.Thickness = 1
Crosshair_Vertical.Transparency = 1
Crosshair_Vertical.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
Crosshair_Vertical.To = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
Crosshair_Vertical.Color = Color3.fromRGB(255, 255, 255)

--Functions
local speed = 35
local speed2 = 20
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

tracerDebounce = false

function createTracer(To, From)
    if not tracerDebounce then
        tracerDebounce = true
        spawn(function()
            task.wait()
            tracerDebounce = false
        end)
        local PartTo = Framework:Instance("Part", {Transparency = 1, Position = To, CanCollide = false, Anchored = true, Parent = Camera})
        local PartFrom = Framework:Instance("Part", {Transparency = 1, Position = From, CanCollide = false, Anchored = true, Parent = Camera})
        local Attachment0 = Instance.new("Attachment", PartTo)
        local Attachment1 = Instance.new("Attachment", PartFrom)
        local RaySize = 1
        local Beam = Framework:Instance("Beam", {FaceCamera = true, Color = ColorSequence.new(Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255)), Width0 = RaySize, Width1 = RaySize, LightEmission = 1, LightInfluence = 0, Attachment0 = Attachment0, Attachment1 = Attachment1, Parent = PartTo})
        task.spawn(function()
            task.wait(2)
            for i = 0.5, 0, -0.015 do
                Beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1 - i), NumberSequenceKeypoint.new(1,1 - i)})
                RunService.Stepped:Wait()
            end
            PartTo:Destroy()
            PartFrom:Destroy()
        end)
    end
end

local ExpectedArguments = {
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    }
}

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function Connection(signal,callback,...)
    local connection = signal:Connect(callback,...)
    table.insert(connections,connection)
    return connection
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

local function getClosestPlayerS()
    if not Options.stargetpart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player ~= game.Players.LocalPlayer then
            if Player == LocalPlayer then continue end

            local Character = Player.Character
            if not Character then continue end
            
            --if Toggles.svisible.Value and not IsPlayerVisible(Player) then continue end

            local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
            local Humanoid = FindFirstChild(Character, "Humanoid")
            if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

            local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
            if not OnScreen then continue end

            local Distance = (Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2) - ScreenPosition).Magnitude
            if Distance <= (DistanceToMouse or Options.sradius.Value or 2000) then
                Closest = Character or false
                DistanceToMouse = Distance
            end
        else
            Closest = false
        end
    end
    if Closest ~= false then
        return Closest
    else
        return false
    end
end

local function getClosestPlayerA()
    if not Options.atargetpart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end

        local Character = Player.Character
        if not Character then continue end
        
        --if Toggles.svisible.Value and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2) - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Options.aradius.Value or 2000) then
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

local function Fullbright()
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

local selectedPlayerDrawing = newDrawing('Text', {Text = 'PLAYERS INVENTORY:', Position = Vector2.new(10,350), Color = Color3.new(1,1,1), Outline = true, Size = 13, Font = 2})
local function updateInvDrawings()
    selectedPlayerDrawing.Visible = true
    if init then
        local pos = 350
        for i,v in next, invDrawings do
            v[1].Visible = true;
            v[1].Position = Vector2.new(10, pos + 18);
            v[1].Text = v[2] == 1 and i or i..' x'..tostring(v[2]);
            pos = v[1].Position.Y;
        end
    end
end

local InventoryViewer = {
    Size = Vector2.new(300, 14), 
    Main = Framework:Draw("Square", {Thickness = 0, Size = Vector2.new(300, 14), Filled = true, Position = Vector2.new(0, game.workspace.CurrentCamera.ViewportSize.Y / 4), Transparency = 0.4}),
    Texts = {}
}
function InventoryViewer:Clear()
    for i, v in pairs(InventoryViewer.Texts) do
        v:Remove()
        InventoryViewer.Texts[i] = nil
        InventoryViewer.Main.Size = InventoryViewer.Size
    end
end
function InventoryViewer:AddText(Text, Tabulated, Main_Text)
    local Main = InventoryViewer.Main
    local Drawing = Framework:Draw("Text", {Text = Text, Color = Color3.new(1, 1, 1), Transparency = 1, Size = 13, Font = 2, Outline = true, Visible = true})
    table.insert(InventoryViewer.Texts, Drawing)
    local Drawings = #InventoryViewer.Texts
    Main.Size = Vector2.new(InventoryViewer.Size.X, 14 * Drawings)
    Drawing.Position = Main.Position + Vector2.new(5, (Drawings - 1) * 14)
    if Main_Text then
        Drawing.Center = true
        Drawing.Position = Main.Position + Vector2.new(Main.Size.X / 2, 0)
    end
    if Tabulated then
        Drawing.Position = Main.Position + Vector2.new(20, (Drawings - 1) * 14)
    end
    return Drawing
end
function InventoryViewer:Update()
    InventoryViewer.Size = Vector2.new(300, 14)
    local Scan, _Players = {}, Toggles.inventoryv.Value
    --[[if Containers then
        for i, v in pairs(Workspace.Containers:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("Inventory") then
                table.insert(Scan, v)
            end
        end
    end]]
    if _Players then
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") then
                table.insert(Scan, v.Character)
            end
        end
    end
    local Target, Magnitude, lowMagnitude = nil, math.huge, math.huge
    for i, v in pairs(Scan) do
        local PrimaryPart = v.PrimaryPart
        if PrimaryPart then
            local Vector, onScreen = Camera:WorldToViewportPoint(PrimaryPart.Position)
            if onScreen then
                local Magnitude = (Camera.ViewportSize / 2 - Framework:V3_To_V2(Vector)).Magnitude
                if Magnitude < lowMagnitude then
                    lowMagnitude = Magnitude
                    Target = v
                end
            end
        end
    end
    if not Target then
        InventoryViewer:Clear()
        InventoryViewer:AddText("Inventory Viewer", false, true)
        return
    end
    local Humanoid = Target:FindFirstChildOfClass("Humanoid")
    InventoryViewer:Clear()
    local MainText = InventoryViewer:AddText(Target.Name, false, true)
    Scan = {}
    local Maximal_X = 0
    if Humanoid then
        local Folder = ReplicatedPlayers[Target.Name]
        table.insert(Scan, Folder.Inventory)
        table.insert(Scan, Folder.Clothing)
        for i, v in pairs(Scan) do
            local Name = v.Name
            if Name == "Inventory" then
                for _, Item in pairs(v:GetChildren()) do
                    local ItemProperties = Item:FindFirstChild("ItemProperties")
                    if ItemProperties then
                        local ammoString = ""
                        local isGun = false
                        local ItemType = ItemProperties:GetAttribute("ItemType")
                        if ItemType and ItemType == "RangedWeapon" then
                            isGun = true
                            local Attachments = Item:FindFirstChild("Attachments")
                            if Attachments then
                                local Magazine = Attachments:FindFirstChild("Magazine")
                                if Magazine then
                                    Magazine = Magazine:FindFirstChildOfClass("StringValue")
                                    if Magazine then
                                        local MagazineProperties = Magazine:FindFirstChild("ItemProperties")
                                        if MagazineProperties then
                                            local LoadedAmmo = MagazineProperties:FindFirstChild("LoadedAmmo")
                                            if LoadedAmmo then
                                                for _, Slot in pairs(LoadedAmmo:GetChildren()) do
                                                    local AmmoType, Amount = Slot:GetAttribute("AmmoType"), Slot:GetAttribute("Amount")
                                                    if AmmoType and Amount then
                                                        ammoString = ammoString .. Amount .. " - " .. AmmoType:gsub("Tracer", "T") .. "; "
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        if ammoString == "" and isGun == false then
                            InventoryViewer:AddText("[Hotbar] " .. Item.Name)
                        elseif ammoString == "" then
                            local HotbarDrawing = InventoryViewer:AddText("[Hotbar] " .. Item.Name .. " [OUT OF AMMO]")
                            local textBoundsX = HotbarDrawing.TextBounds.X
                            if textBoundsX > Maximal_X then
                                Maximal_X = textBoundsX
                            end
                            if Maximal_X > InventoryViewer.Size.X then
                                InventoryViewer.Size = Vector2.new(Maximal_X + 10, InventoryViewer.Main.Size.Y)
                                InventoryViewer.Main.Size = InventoryViewer.Size
                                MainText.Position = InventoryViewer.Main.Position + Vector2.new(InventoryViewer.Main.Size.X / 2, 0)
                            end
                        else
                            ammoString = ammoString:sub(0, ammoString:len() - 2)
                            local HotbarDrawing = InventoryViewer:AddText("[Hotbar] " .. Item.Name .. " ["..ammoString.."]")
                            local textBoundsX = HotbarDrawing.TextBounds.X
                            if textBoundsX > Maximal_X then
                                Maximal_X = textBoundsX
                            end
                            if Maximal_X > InventoryViewer.Size.X then
                                InventoryViewer.Size = Vector2.new(Maximal_X + 10, InventoryViewer.Main.Size.Y)
                                InventoryViewer.Main.Size = InventoryViewer.Size
                                MainText.Position = InventoryViewer.Main.Position + Vector2.new(InventoryViewer.Main.Size.X / 2, 0)
                            end
                        end
                    else
                        InventoryViewer:AddText("[Hotbar] " .. Item.Name)
                    end
                end
            elseif Name == "Clothing" then
                for _, Clothing in pairs(v:GetChildren()) do
                    -- Clothing
                    local Attachments = Clothing:FindFirstChild("Attachments")
                    local attachmentString = ""
                    if Attachments then
                        for _, Slot in pairs(Attachments:GetChildren()) do
                            local Attachment = Slot:FindFirstChildOfClass("StringValue")
                            if Attachment then
                                attachmentString = attachmentString .. Attachment.Name .. "; "
                            end
                        end
                    end
                    attachmentString = attachmentString:sub(0, attachmentString:len() - 2)
                    if attachmentString == "" then
                        InventoryViewer:AddText(Clothing.Name)
                    else
                        local ClothingDrawing = InventoryViewer:AddText(Clothing.Name .. " [".. attachmentString .."]")
                        local textBoundsX = ClothingDrawing.TextBounds.X
                        if textBoundsX > Maximal_X then
                            Maximal_X = textBoundsX
                        end
                        if Maximal_X > InventoryViewer.Size.X then
                            InventoryViewer.Size = Vector2.new(Maximal_X + 10, InventoryViewer.Main.Size.Y)
                            InventoryViewer.Main.Size = InventoryViewer.Size
                            MainText.Position = InventoryViewer.Main.Position + Vector2.new(InventoryViewer.Main.Size.X / 2, 0)
                        end
                    end
                    -- Clothing Inventory
                    local Inventory = Clothing:FindFirstChild("Inventory")
                    if Inventory then
                        for _, Item in pairs(Inventory:GetChildren()) do
                            local ItemProperties = Item:FindFirstChild("ItemProperties")
                            if ItemProperties then
                                local Amount = ItemProperties:GetAttribute("Amount")
                                if Amount then
                                    if Amount > 1 then
                                        InventoryViewer:AddText(Item.Name .. " [" .. tostring(Amount) .. "]", true)
                                    else
                                        InventoryViewer:AddText(Item.Name, true)
                                    end
                                else
                                    InventoryViewer:AddText(Item.Name, true)
                                end
                            else
                                InventoryViewer:AddText(Item.Name, true)
                            end
                        end
                    end
                end
            end
        end
    else
        local Inventory = Target:FindFirstChild("Inventory")
        if Inventory then
            for _, Item in pairs(Inventory:GetChildren()) do
                local ItemProperties = Item:FindFirstChild("ItemProperties")
                if ItemProperties then
                    local Amount = ItemProperties:GetAttribute("Amount")
                    if Amount then
                        if Amount > 1 then
                            InventoryViewer:AddText(Item.Name .. " [" .. tostring(Amount) .. "]")
                        else
                            InventoryViewer:AddText(Item.Name)
                        end
                    else
                        InventoryViewer:AddText(Item.Name)
                    end
                else
                    InventoryViewer:AddText(Item.Name)
                end
            end
        end
    end
end

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
    Visuals = Window:AddTab('Visuals'), -- esp and visuals
    Movement = Window:AddTab('Misc'), -- movement and exploits
    ['UI Settings'] = Window:AddTab('UI Settings')
}

--Combat

local MainCombat = Tabs.Combat:AddLeftTabbox()
local SilentA = MainCombat:AddTab('Silent Aim')
local Aimbot = MainCombat:AddTab('Aimbot')

--Silent Aim
SilentA:AddToggle("senabled", {Text = "Enabled", Default = false, Tooltip = 'Enables Silent Aim Features'}):OnChanged(function() end)
SilentA:AddDropdown('stargetpart', {Values = { 'Head', 'HumanoidRootPart', 'Random' },Default = 1,Multi = false,Text = 'Silent Aim Target',Tooltip = 'Changes the Silent Aim Target',}) Options.stargetpart:OnChanged(function() end)
SilentA:AddToggle("sprediction", {Text = "Prediction", Default = false, Tooltip = 'Enables Silent Aim Prediction'}):OnChanged(function() end)
SilentA:AddToggle('ssnapline', {Text = 'SnapLines',Default = false,Tooltip = 'Toggles Snaplines',}) Toggles.ssnapline:OnChanged(function() end)


--Aimbot
Aimbot:AddToggle("aenabled", {Text = "Enabled", Default = false, Tooltip = 'Enables Aimbot Features'}):OnChanged(function() end)
Aimbot:AddDropdown('atargetpart', {Values = { 'Head', 'HumanoidRootPart', 'Random' },Default = 1,Multi = false,Text = 'Aimbot Target',Tooltip = 'Changes the Aimbot Target',}) Options.atargetpart:OnChanged(function() end)
Aimbot:AddToggle("aprediction", {Text = "Prediction", Default = false, Tooltip = 'Enables Aimbot Prediction'}):OnChanged(function() end)
Aimbot:AddToggle('asnapline', {Text = 'SnapLines',Default = false,Tooltip = 'Toggles Snaplines',}) Toggles.asnapline:OnChanged(function() end)


local MainCombat = Tabs.Combat:AddRightTabbox()
local SilentAF = MainCombat:AddTab('Silent Aim Fov')
local AimbotF = MainCombat:AddTab('Aimbot Fov')

--Silent Aim Fov
SilentAF:AddToggle('sfovenabled', {Text = 'Silent Aim Fov Visible',Default = false,Tooltip = 'Enables the Fov',}) Toggles.sfovenabled:OnChanged(function() SFOVCircle.Visible = Toggles.sfovenabled.Value end)
SilentAF:AddSlider('sfovsides', {Text = 'Fov Sides',Default = 14,Min = 3,Max = 64,Rounding = 0,Compact = false,})Options.sfovsides:OnChanged(function() SFOVCircle.NumSides = Options.sfovsides.Value end)
SilentAF:AddSlider('strans', {Text = 'Fov Transperancy',Default = 100,Min = 0,Max = 100,Rounding = 1,Compact = false,}) Options.strans:OnChanged(function() SFOVCircle.Transparency = Options.strans.Value / 100 end)
SilentAF:AddSlider('sradius', {Text = 'Fov Size',Default = 80,Min = 0,Max = 640,Rounding = 0,Compact = false,}) Options.sradius:OnChanged(function() SFOVCircle.Radius = Options.sradius.Value end)
SilentAF:AddToggle('sfilled', {Text = 'Fov Filled',Default = false,Tooltip = 'Toggles Fov Filled',}) Toggles.sfilled:OnChanged(function() SFOVCircle.Filled = Toggles.sfilled.Value end)
SilentAF:AddSlider('sfovthick', {Text = 'Aimbot Fov thickness',Default = 0,Min = 0,Max = 10,Rounding = 1,Compact = false,}) Options.sfovthick:OnChanged(function() SFOVCircle.Thickness = Options.sfovthick.Value end)

--Aimbot Fov
AimbotF:AddToggle('afovenabled', {Text = 'Aimbot Fov Visible',Default = false,Tooltip = 'Enables the Fov',}) Toggles.afovenabled:OnChanged(function() AFOVCircle.Visible = Toggles.afovenabled.Value end)
AimbotF:AddSlider('afovsides', {Text = 'Fov Sides',Default = 14,Min = 3,Max = 64,Rounding = 0,Compact = false,})Options.afovsides:OnChanged(function() AFOVCircle.NumSides = Options.afovsides.Value end)
AimbotF:AddSlider('atrans', {Text = 'Fov Transperancy',Default = 100,Min = 0,Max = 100,Rounding = 1,Compact = false,}) Options.atrans:OnChanged(function() AFOVCircle.Transparency = Options.atrans.Value / 100 end)
AimbotF:AddSlider('aradius', {Text = 'Fov Size',Default = 80,Min = 0,Max = 640,Rounding = 0,Compact = false,}) Options.aradius:OnChanged(function() AFOVCircle.Radius = Options.aradius.Value end)
AimbotF:AddToggle('afilled', {Text = 'Fov Filled',Default = false,Tooltip = 'Toggles Fov Filled',}) Toggles.afilled:OnChanged(function() AFOVCircle.Filled = Toggles.afilled.Value end)
AimbotF:AddSlider('afovthick', {Text = 'Aimbot Fov thickness',Default = 0,Min = 0,Max = 10,Rounding = 1,Compact = false,}) Options.afovthick:OnChanged(function() AFOVCircle.Thickness = Options.afovthick.Value end)

local OtherC = Tabs.Combat:AddLeftGroupbox('Other')

OtherC:AddToggle("resolver", {Text = "Resolver", Default = false, Tooltip = 'Predicts most antiaims'}):OnChanged(function() end)

OtherC:AddToggle('inventoryv', {Text = 'Inventory Viewer',Default = false,Tooltip = 'Enables Inventory Viewer',}) Toggles.inventoryv:OnChanged(function() end)

function noRecoilToggle()
    local VFX = nil; for i,v in next, getgc(true) do
        if typeof(v) == "table" and rawget(v, "RecoilCamera") then
            VFX = v
            break
        end
    end

    local RecoilCamera = VFX.RecoilCamera;
    VFX.RecoilCamera = function(...)
        if Toggles.norecoil.Value then
            return 0
        else
           return RecoilCamera(...)
        end
    end
end

OtherC:AddToggle('norecoil', {Text = 'No Recoil',Default = false,Tooltip = 'Enables No Recoil',}) Toggles.norecoil:OnChanged(function() 
    noRecoilToggle()
end)

OtherC:AddToggle('nobob', {Text = 'No Bob',Default = false,Tooltip = 'Enables No Bob',}) Toggles.nobob:OnChanged(function(toggle) 
    local repStorage = game["ReplicatedStorage"]
    local springModule = require(repStorage.Modules.spring)
    local oldSpringIndex
    oldSpringIndex = hookfunction(springModule.update, function(...)
        if Toggles.nobob.Value then
            return;
        end

        return oldSpringIndex(...)
    end)
end)

OtherC:AddToggle('nobdrop', {Text = 'No Bullet Drop',Default = false,Tooltip = 'Enables No Bullet Drop',}) Toggles.nobdrop:OnChanged(function() 
    bool = Toggles.nobdrop.Value
    local repStorage = game["ReplicatedStorage"]
    for _, Item in pairs(repStorage.AmmoTypes:GetChildren()) do
        if bool then
            Item:SetAttribute("ProjectileDrop", 0)
        else
            Item:SetAttribute("ProjectileDrop", Old_Ammo[Item.Name]["Drop"])
        end
    end
end)

OtherC:AddToggle('nom', {Text = 'No Muzzle Flash',Default = false,Tooltip = 'Enables No Muzzle Flash',}) Toggles.nom:OnChanged(function() 
    bool1 = Toggles.nom.Value
    local repStorage = game["ReplicatedStorage"]
    for i,v in pairs(repStorage.RangedWeapons:GetChildren()) do
        v:SetAttribute("MuzzleEffect", not bool1)
    end
end)

OtherC:AddToggle('quick', {Text = 'Quick Aim',Default = false,Tooltip = 'Aims In Quickly',}) Toggles.nom:OnChanged(function() 
    for i,v in next, game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name].Inventory:GetChildren() do -- really old but still works
        local module = require(v.SettingsModule)
        module.AimInSpeed = 0
        module.AimOutSpeed = 0
    end
end)

OtherC:AddToggle('double', {Text = 'Double Bullet',Default = false,Tooltip = 'Shoots 2 bullets at the same time',}) Toggles.nom:OnChanged(function() 
    bool3 = Toggles.double.Value
    for _, Item in pairs(repStorage.AmmoTypes:GetChildren()) do
        if bool3 then
            Item:SetAttribute("Pellets", Old_Ammo[Item.Name]["Pellets"] * 2)
        else
            Item:SetAttribute("Pellets", Old_Ammo[Item.Name]["Pellets"])
        end
    end
end)

OtherC:AddToggle('rapid', {Text = 'Rapid Fire',Default = false,Tooltip = 'Shoots Faster',}) Toggles.nom:OnChanged(function() 
    bool4 = Toggles.rapid.Value
    if bool4 then
        for i,v in next, game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name].Inventory:GetChildren() do
            local module = require(v.SettingsModule)
            module.FireRate = 0
            module.FireModes = { "Semi", "Auto" }
            module.FireMode = 'Auto'
        end
    end
end)

--Visuals

local MainEsp = Tabs.Visuals:AddLeftTabbox()
local PlayerEsp = MainEsp:AddTab('Player Esp')
local OtherEsp = MainEsp:AddTab('Other Esp')

--Player Esp
PlayerEsp:AddToggle("esp", {Text = "Enabled", Default = false}):OnChanged(function() espLib.options.enabled = Toggles.esp.Value end)
PlayerEsp:AddToggle("box", {Text = "Boxes", Default = false}):OnChanged(function() espLib.options.boxes = Toggles.box.Value end)
PlayerEsp:AddToggle("names", {Text = "Names", Default = false}):OnChanged(function() espLib.options.names = Toggles.names.Value end)
PlayerEsp:AddToggle("dis", {Text = "Distance", Default = false}):OnChanged(function() espLib.options.distance = Toggles.dis.Value end)
PlayerEsp:AddToggle("healthb", {Text = "Health Bars", Default = false}):OnChanged(function() espLib.options.healthBars = Toggles.healthb.Value end)
PlayerEsp:AddToggle("healtht", {Text = "Health Text", Default = false}):OnChanged(function() espLib.options.healthText = Toggles.healtht.Value end)
PlayerEsp:AddToggle("tracer", {Text = "Tracers", Default = false}):OnChanged(function() espLib.options.tracers = Toggles.tracer.Value end)
--PlayerEsp:AddToggle("skeleton", {Text = "Skeleton", Default = false}):OnChanged(function() end)
PlayerEsp:AddToggle("chams", {Text = "Chams", Default = false}):OnChanged(function() espLib.options.chams = Toggles.chams.Value end)
PlayerEsp:AddToggle("arrows", {Text = "Arrows", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutline = Toggles.arrows.Value end)

--Other Esp

OtherEsp:AddToggle("oesp", {Text = "Enabled", Default = false}):OnChanged(function() end)


local SettingsEsp = Tabs.Visuals:AddRightTabbox()
local SettingsPlayerEsp = SettingsEsp:AddTab('P Esp Settings')
local SettingsContainerEsp = SettingsEsp:AddTab('O Esp Settings')

--Player Esp Settings visibleesp

SettingsPlayerEsp:AddToggle("ldistance", {Text = "Limit Distance", Default = false}):OnChanged(function() espLib.options.limitDistance = Toggles.ldistance.Value end)
SettingsPlayerEsp:AddSlider('mdistance', {Text = 'Max Distance', Default = 5000, Min = 0, Max = 10000, Rounding = 1, Compact = false}) Options.mdistance:OnChanged(function() espLib.options.maxDistance = Options.mdistance.Value end)
SettingsPlayerEsp:AddToggle("vcheck", {Text = "Visible Check", Default = false}):OnChanged(function() espLib.options.visibleOnly = Toggles.vcheck.Value end)
SettingsPlayerEsp:AddToggle("visibleesp", {Text = "Show Visible", Default = true}):OnChanged(function() end)
SettingsPlayerEsp:AddToggle("afilled", {Text = "Arrows Filled", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutlineFilled = Toggles.afilled.Value end)
SettingsPlayerEsp:AddSlider('atransparency', {Text = 'Arrows Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.atransparency:OnChanged(function() espLib.options.outOfViewArrowsOutlineTransparency = Options.atransparency.Value / 100 end)
SettingsPlayerEsp:AddSlider('btransparency', {Text = 'Boxes Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.btransparency:OnChanged(function() espLib.options.boxesTransparency = Options.btransparency.Value / 100 end)
SettingsPlayerEsp:AddSlider('hbsize', {Text = 'HealthBar Size', Default = 1, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.hbsize:OnChanged(function() espLib.options.healthBarsSize = Options.hbsize.Value end)
SettingsPlayerEsp:AddSlider('httransparency', {Text = 'HealthText Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.httransparency:OnChanged(function() espLib.options.healthTextTransparency = Options.httransparency.Value / 100 end)
SettingsPlayerEsp:AddSlider('ctransparency', {Text = 'Chams Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.ctransparency:OnChanged(function() espLib.options.chamsFillTransparency = Options.ctransparency.Value / 100 end)
SettingsPlayerEsp:AddSlider('dtransparency', {Text = 'Distance Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.dtransparency:OnChanged(function() espLib.options.distanceTransparency = Options.dtransparency.Value / 100 end)
SettingsPlayerEsp:AddDropdown("tracerf", {Text = "Tracers", Default = "Top", Values = {"Top", "Bottom", "Mouse"}}):OnChanged(function() espLib.options.tracerOrigin = Options.tracerf.Value end)

--Container Esp Settings



--Other Visuals

local OtherVisuals = Tabs.Visuals:AddLeftTabbox()
local OtherTab = OtherVisuals:AddTab('Other')
local OtherSettings = OtherVisuals:AddTab('Settings')

OtherTab:AddToggle("visualsenabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("viewmodel", {Text = "Viewmodel", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("fbright", {Text = "FullBright", Default = false}):OnChanged(function() Fullbright() end)
OtherTab:AddToggle("thirdp", {Text = "ThirdPerson", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("localcham", {Text = "Character Chams", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("ac", {Text = "Arm Chams", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("gm", {Text = "Gun Chams", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("zoom", {Text = "Zoom", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("cross", {Text = "Crosshair", Default = false}):OnChanged(function() Crosshair_Vertical.Visible = Toggles.cross.Value Crosshair_Horizontal.Visible = Toggles.cross.Value end)

OtherSettings:AddSlider('viewx', {Text = 'Viewmodel-X', Default = 0, Min = -5, Max = 5, Rounding = 2, Compact = false}) Options.viewx:OnChanged(function() end)
OtherSettings:AddSlider('viewy', {Text = 'Viewmodel-Y', Default = 0, Min = -5, Max = 5, Rounding = 2, Compact = false}) Options.viewy:OnChanged(function() end)
OtherSettings:AddSlider('viewz', {Text = 'Viewmodel-Z', Default = 0, Min = -5, Max = 5, Rounding = 2, Compact = false}) Options.viewz:OnChanged(function() end)
OtherSettings:AddSlider('thirdpdis', {Text = 'ThurdPerson Distance', Default = 5, Min = 0, Max = 10, Rounding = 2, Compact = false}) Options.viewz:OnChanged(function() end)
OtherSettings:AddDropdown("ccm", {Text = "Character Chams Material", Default = "SmoothPlastic", Values = {"ForceField", "Neon", "SmoothPlastic", "Glass"}}):OnChanged(function() end)
OtherSettings:AddLabel('Character Chams Color'):AddColorPicker('ccc', { Default = Color3.new(1, 1, 1), Title = 'Character Chams Color'}) Options.ccc:OnChanged(function() end)
OtherSettings:AddDropdown("acm", {Text = "Arm Chams Material", Default = "SmoothPlastic", Values = {"ForceField", "Neon", "SmoothPlastic", "Glass"}}):OnChanged(function() end)
OtherSettings:AddLabel('Arm Chams Color'):AddColorPicker('acc', { Default = Color3.new(1, 1, 1), Title = 'Character Chams Color'}) Options.acc:OnChanged(function() end)
OtherSettings:AddDropdown("gcm", {Text = "Gun Chams Material", Default = "SmoothPlastic", Values = {"ForceField", "Neon", "SmoothPlastic", "Glass"}}):OnChanged(function() end)
OtherSettings:AddLabel('Gun Chams Color'):AddColorPicker('gcc', { Default = Color3.new(1, 1, 1), Title = 'Character Chams Color'}) Options.gcc:OnChanged(function() end)
OtherSettings:AddSlider('zooma', {Text = 'Zoom Amount', Default = 5, Min = 0, Max = 30, Rounding = 1, Compact = false}) Options.zooma:OnChanged(function() end)
OtherSettings:AddSlider('crosss', {Text = 'Crosshair-Size', Default = 5, Min = 0, Max = 25, Rounding = 1, Compact = false}) Options.crosss:OnChanged(function() 
    Crosshair_Horizontal.From = Vector2.new(Camera.ViewportSize.X / 2 - Options.crosss.Value, Camera.ViewportSize.Y / 2)
    Crosshair_Horizontal.To = Vector2.new(Camera.ViewportSize.X / 2 + Options.crosss.Value, Camera.ViewportSize.Y / 2)
    Crosshair_Vertical.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2 - Options.crosss.Value)
    Crosshair_Vertical.To = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2 + Options.crosss.Value) 
end)

--Misc

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

local SettingsMovement = Tabs.Movement:AddLeftGroupbox('Settings')

SettingsMovement:AddSlider("speed", {Text = "Speed", Min = 0, Max = 40, Default = 20, Rounding = 0}):OnChanged(function()
	speed = Options.speed.Value
end)

SettingsMovement:AddSlider("speed1", {Text = "Fly Speed", Min = 0, Max = 40, Default = 35, Rounding = 0}):OnChanged(function()
	speed2 = Options.speed1.Value
end)

local MainAnti = Tabs.Movement:AddRightGroupbox('Anti-Aim')

--UI Settings

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

--Hooks / Other

espLib:Load()

--Silent Aim

__namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local Args, Method, Script = {...}, getnamecallmethod():lower(), getcallingscript()
    if Method == "fireserver" then
        if tostring(self):lower() == "errorlog" or tostring(self):lower() == "errrorlog" then
            return
        end
        local Args_4 = Args[4]
        if type(Args_4) == "table" and Args_4[1] and Args_4[1].step then
            local Call
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
            --Library:Notify("e")
        end
        Call = Call or __namecall(self, ...)
        return Call
    end
    if Method == "setprimarypartcframe" and Toggles.viewmodel.Value and Toggles.visualsenabled.Value then
        return __namecall(self, Camera.CFrame * CFrame.new(0.05, -1.35, 0.7) * CFrame.new(Options.viewx.Value, -Options.viewy.Value, -Options.viewz.Value)) -- x -y -z
    end
    return __namecall(self, ...)
end))

local __newindex = nil
__newindex = hookmetamethod(game, "__newindex", function(i, v, n_v)

    if i == Camera and v == "CFrame" then
        LastCameraCFrame = n_v
        if Toggles.thirdp.Value and Toggles.visualsenabled.Value then
            return __newindex(i, v, n_v + Camera.CFrame.LookVector * - Options.thirdpdis.Value)
        end
    end
    return __newindex(i, v, n_v)
end)

local oldHook = nil	
oldHook = hookfunction(require(ReplicatedStorage.Modules.FPS.Bullet).CreateBullet, function(...)
	local args = {...}
	if Toggles.senabled.Value and getClosestPlayerS() then
        Target = getClosestPlayerS()
		if Target ~= nil or Target ~= false then
            --if Toggles.sprediction.Value then
                local ammotype = repStorage.AmmoTypes[args[6]]
                local bulletvelocity = ammotype:GetAttribute("MuzzleVelocity")
                local traveltime = (Target:FindFirstChild("Head").Position - Camera.CFrame.p).Magnitude / bulletvelocity
                local head = Target[Options.stargetpart.Value].Position + Target:FindFirstChild("HumanoidRootPart").Velocity * traveltime
            --else
            --    local head = Target[Options.stargetpart.Value].Position
            --end
		
			args[9] = {CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + 
            Vector3.new(0, UniversalTables.UniversalTable.GameSettings.RootScanHeight, 0), head)}

			return oldHook(table.unpack(args))
		end
	end

	return oldHook(table.unpack(args))
end)

--Anti-Aim

--[[local OldNewIndex; OldNewIndex = hookmetamethod(game, "__newindex", function(self, key, value)
    local SelfName = tostring(self)
    if not checkcaller() then
        if key == "AutoRotate" then
            OriginalAutoRotate = value
            if menu.values[1].antiaim.direction.enabled.Toggle and menu.values[1].antiaim.direction["$enabled"].Active then
                value = false
            end
        end
        if SelfName == "HumanoidRootPart" and key == "CFrame" then
            if menu.values[1].antiaim.direction.enabled.Toggle and menu.values[1].antiaim.direction["$enabled"].Active and menu.values[1].antiaim.direction["force angles"].Toggle then
                value = CFrame.new(value.Position) * CFrame.Angles(0, AntiaimAngle, 0)
            end
        end
        return OldNewIndex(self, key, value)
    end
    return OldNewIndex(self, key, value)
end)]]

--Aimbot

game:GetService("UserInputService").InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        HoldingM2 = true
        Active = true
        Lock = true
        if Active then
            local The_Enemy = getClosestPlayerA()
            while HoldingM2 do task.wait(.000001)
                if Lock and The_Enemy ~= nil then
                    if Toggles.aenabled.Value then
                        local Future = The_Enemy[Options.atargetpart.Value].CFrame
                        game.workspace.CurrentCamera.CFrame = CFrame.lookAt(game.workspace.CurrentCamera.CFrame.Position, Future.Position) -- add prediction
                    end
                end
            end
        end
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        HoldingM2 = false
        Active = false
        Lock = false
    end
end)

frames = 0

resume(create(function()
    while wait(1) do
        Library:SetWatermark('GorillaHook | Alpha v' .. version .. ' | Private | ' .. frames .. ' |')
        Library:SetWatermarkVisibility(Toggles.watermark.Value)
        frames = 0
    end
end))

resume(create(function()
    while wait(0.1) do
        if Toggles.inventoryv.Value then
            InventoryViewer:Update()
        else
            InventoryViewer:Clear()
        end
    end
end))

resume(create(function()
    while wait(0.1) do
        local View = game:GetService("Workspace").Camera:FindFirstChild("ViewModel")
        if View ~= nil and View then
            for i,v in pairs(game:GetService("Workspace").Camera.ViewModel:GetDescendants()) do
                if Toggles.visualsenabled.Value and Toggles.localcham.Value then -- body
                    for i,v in pairs(game:GetService("Workspace")[game.Players.LocalPlayer.Name]:GetChildren()) do
                        if v.ClassName == "MeshPart" then
                            v.Material = (Options.ccm.Value) -- local player chams mat
                            v.Color = (Options.ccc.Value) -- local player chams color
                        end
                        task.wait()
                    end
                end
    
                if Toggles.visualsenabled.Value and Toggles.ac.Value then -- hands
                    if v.ClassName == "MeshPart" then
                        if v.Parent.Name == "WastelandShirt" or v.Parent.Name == "GhillieTorso" or v.Parent.Name == "CivilianPants" or v.Parent.Name == "CamoShirt" or v.Parent.Name == "HandWraps" or v.Parent.Name == "CombatGloves" then
                            v.Transparency = 1
                        end
                    end
                    if v.ClassName == "Part" then
                        if v.Name == "AimPartCanted" or v.Name == "AimPart" then
                            v.Size = Vector3.new(0, 0, 0)
                            v.Transparency = 1
                        end
                    end
                    if v.ClassName == "MeshPart" then
                        if v.Name == "LeftHand" or v.Name == "LeftLowerArm" or v.Name == "LeftUpperArm" or v.Name == "RightHand" or v.Name == "RightLowerArm" or v.Name == "RightUpperArm" then
                            v.Material = (Options.acm.Value) -- hands mat
                            v.Color = (Options.acc.Value) -- hands color
                        end
                    end
                end
    
                if Toggles.visualsenabled.Value and View ~= nil and Toggles.gm.Value  then -- gun
                    for i,v in pairs(game:GetService("Workspace").Camera.ViewModel.Item:GetDescendants()) do
                        if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                            v.Material = (Options.gcm.Value) -- gun mat
                            v.Color = (Options.gcc.Value) -- gun color
                        end
                        if v:FindFirstChild("SurfaceAppearance") then
                            v.SurfaceAppearance:Destroy()
                        end
                        task.wait()
                    end
                end
                task.wait()
            end
        end
    end
end))

--Skeleton



--Exit / Corpse Esp

--Exit Esp



--Corpse Esp



--Snaplines / Inventory Viewer

frames = 0

game:GetService("RunService").RenderStepped:Connect(function()
    frames = frames + 1
    if Toggles.senabled.Value and Toggles.ssnapline.Value and getClosestPlayerS() then
        local snapVector, snapOnScreen = Camera:worldToViewportPoint(getClosestPlayerS()[Options.stargetpart.Value].Position)
        if snapOnScreen then
            Snapline_Line.From = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
            Snapline_Line.To = Vector2.new(snapVector.X, snapVector.Y)
            Snapline_Line.Visible = true
        else
            Snapline_Line.Visible = false
        end
    else
        Snapline_Line.Visible = false
    end

    if Toggles.aenabled.Value and Toggles.asnapline.Value and getClosestPlayerA() then
        local snapVector, snapOnScreen = Camera:worldToViewportPoint(getClosestPlayerA()[Options.atargetpart.Value].Position)
        if snapOnScreen then
            Snapline_Line2.From = Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2)
            Snapline_Line2.To = Vector2.new(snapVector.X, snapVector.Y)
            Snapline_Line2.Visible = true
        else
            Snapline_Line2.Visible = false
        end
    else
        Snapline_Line2.Visible = false
    end

    if Toggles.visualsenabled.Value and Toggles.zoom.Value then -- zoom
        Camera.FieldOfView = Options.zooma.Value
    end
end)

--Resolver

--[[while wait(0.1) do
    if Toggles.resolver.Value then
        local Target = getClosestPlayerS()
        if Target then
            Target.HumanoidRootPart.Velocity = (lastpostion - Target.HumanoidRootPart.Position).Magnitude / 0.1
            lastpostion = Target.HumanoidRootPart.Position
        end
    end
end]]

--Other

--[[local VFX = nil
for i, v in next, getgc(true) do
    if type(v) == 'table' and rawget(v, "RecoilCamera") then
        VFX = v
        break
    end
end

local VFX_Impact = VFX.Impact
VFX_Impact = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Args = {...}
    local Call = VFX_Impact(...)
    --setthreadcontext(7)
    if true then 
        if Args[6] == false then
            createTracer(Args[2], Camera.CFrame.p)
        end
    end
    return Call
end))

createTracer(Camera.CFrame.p, Camera.CFrame.p)]]