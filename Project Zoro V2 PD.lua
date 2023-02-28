-- init
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if not syn or not protectgui then
	getgenv().protectgui = function() end
end

OLDTick = tick()

local resume = coroutine.resume
local create = coroutine.create

local CoreGui = game:GetService("StarterGui")

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
--------
ESP.Boxes = false
ESP.Names = false
ESP.Tracers = false
ESP.TeamMates = false

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

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Project Zoro V2,
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

--local LeftGroupBox = Tabs.Combat:AddLeftGroupbox('Silent Aim') --coming soon

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

local GroupBox2 = Tabs.Visuals:AddLeftGroupbox('Player')

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

GroupBox2:AddDropdown('buddydontcare', {
	Values = { 'Plastic', 'ForceField', 'Neon', 'Metal' },
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = 'Players Body'
})

Options.buddydontcare:OnChanged(function()
	matisgay = Options.buddydontcare.Value
end)

--[[GroupBox1:AddLabel('Tint Color'):AddColorPicker('tint', {
	Default = Color3.fromRGB(255, 255, 255),
	Title = 'Tint Color'
})]]

GroupBox2:AddToggle("hidearmor", {Text = "Hide Armor", Default = false}):OnChanged(function()
    -- set armor vis to false lol
end)

local GroupBox4 = Tabs.Visuals:AddLeftGroupbox('Containers')

resume(create(function()
    GroupBox4:AddToggle("sportbagesp", {Text = "Sport Bag ESP", Default = false}):OnChanged(function()
        if Toggles.sportbagesp.Value then
            while Toggles.sportbagesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "SportBag" then
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
                                c.Text = "Sport's Bag"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "SportBag" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("toolboxesp", {Text = "Tool Box ESP", Default = false}):OnChanged(function()
        if Toggles.toolboxesp.Value then
            while Toggles.toolboxesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "Toolbox" then
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
                                c.Text = "Tool Box"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "Toolbox" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("LargeShippingCrateesp", {Text = "Large Shipping Crate ESP", Default = false}):OnChanged(function()
        if Toggles.LargeShippingCrateesp.Value then
            while Toggles.LargeShippingCrateesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "LargeShippingCrate" then
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
                                c.Text = "Large Shipping Crate ESP"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "LargeShippingCrate" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("SmallMilitaryBoxesp", {Text = "Small Military Box ESP", Default = false}):OnChanged(function()
        if Toggles.SmallMilitaryBoxesp.Value then
            while Toggles.SmallMilitaryBoxesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "SmallMilitaryBox" then
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
                                c.Text = "Small Military Box ESP"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "SmallMilitaryBox" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("LargeMilitaryBoxesp", {Text = "Large Military Box ESP", Default = false}):OnChanged(function()
        if Toggles.LargeMilitaryBoxesp.Value then
            while Toggles.LargeMilitaryBoxesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "LargeMilitaryBox" then
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
                                c.Text = "Large Military Box"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "LargeMilitaryBox" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("MilitaryCrateesp", {Text = "Military Crate ESP", Default = false}):OnChanged(function()
        if Toggles.MilitaryCrateesp.Value then
            while Toggles.MilitaryCrateesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "MilitaryCrate" then
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
                                c.Text = "Military Crate"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "MilitaryCrate" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("Medbagesp", {Text = "Med Bag ESP", Default = false}):OnChanged(function()
        if Toggles.Medbagesp.Value then
            while Toggles.Medbagesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "Medbag" then
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
                                c.Text = "Med Bag"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "Medbag" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("SmallShippingCrateesp", {Text = "Small Shipping Crate ESP", Default = false}):OnChanged(function()
        if Toggles.SmallShippingCrateesp.Value then
            while Toggles.SmallShippingCrateesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "SmallShippingCrate" then
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
                                c.Text = "Small Shipping Crate"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "SmallShippingCrate" then
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
end))

resume(create(function()
    GroupBox4:AddToggle("GrenadeCrateesp", {Text = "Grenade Crate ESP", Default = false}):OnChanged(function()
        if Toggles.GrenadeCrateesp.Value then
            while Toggles.GrenadeCrateesp.Value do
                for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                    if v1.Name == "GrenadeCrate" then
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
                                c.Text = "Grenade Crate"
                                c.Size = UDim2.new(1,0, 1,0)
                                c.BackgroundTransparency = 1
                                c.BorderSizePixel = 0
                                c.TextColor3 = Color3.fromRGB(255,255,255)
                            end
                        end
                    end
                end
                wait(10)
            end
        else
            for  i, v1 in pairs(game:GetService("Workspace").Containers:GetChildren()) do
                if v1.Name == "GrenadeCrate" then
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
end))

--[[ local GroupBox3 = Tabs.Visuals:AddRightGroupbox('Viewmodel')

GroupBox3:AddToggle("Armtran", {Text = "Arm's Transperancy", Default = false}):OnChanged(function()

end)

GroupBox3:AddToggle("Armmat", {Text = "Arm's Material", Default = false}):OnChanged(function()

end)

GroupBox3:AddLabel('Arm Color'):AddColorPicker('armcolor', {
	Default = Color3.fromRGB(255, 255, 255),
	Title = 'Arm Color'
})

Options.armcolor:OnChanged(function()
    armcolor = (Options.armcolor.Value)
end)

GroupBox3:AddToggle("removething", {Text = "Remove Sleeves", Default = false}):OnChanged(function()

end) ]]

local GroupBox1 = Tabs.Visuals:AddRightGroupbox('World')

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
            task.wait()
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

local GroupBox = Tabs.Exploits:AddRightGroupbox('Gun')

GroupBox:AddToggle("norecoil", {Text = "No Recoil", Default = false}):OnChanged(function()
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

    print("Fetched: " .. tostring(FunctionCount) .. " Functions")
    print("Fetched: " .. tostring(ValueCount) .. " Values")
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
ThemeManager:SetFolder('ProjectZorov2')
SaveManager:SetFolder('ProjectZorov2/configs/ProjectDelta')
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

StartUpTime = tick() - OLDTick

Library:Notify("Project Zoro v2 Loaded in " .. StartUpTime, 1)

print("Project Zoro v2 Loaded Correctly!")