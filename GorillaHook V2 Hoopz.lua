--Init

if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end
local resume = coroutine.resume
local create = coroutine.create
local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
_G.Aimbot = false
_G.Reach = false
_G.WS = false
_G.Range = false
_G.Arc = false
local shootingEvent = game:GetService("ReplicatedStorage").shootingEvent

if workspace:FindFirstChild("PracticeArea") then
    workspace.PracticeArea.Parent = workspace.Courts
end

local jumping = false

for i,v in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do
    for z,x in pairs(getupvalues(v.Function)) do
        if type(x) == "table" and rawget(x, 1) then
            _G.method = x
        elseif z == 10 then
            _G.key = x
        end
    end
end

for i,v in pairs(getconnections(plr.Character.HumanoidRootPart:GetPropertyChangedSignal("Size"))) do
    v:Disable()
end

for i,v in pairs(getconnections(plr.Character.HumanoidRootPart:GetPropertyChangedSignal("Color"))) do
    v:Disable()
end

for i,v in pairs(getconnections(plr.Character.HumanoidRootPart:GetPropertyChangedSignal("BrickColor"))) do
    v:Disable()
end

for i,v in pairs(getconnections(plr.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"))) do
    v:Disable()
end

local ground

local part = workspace:FindPartOnRay(Ray.new(plr.Character.Torso.Position, Vector3.new(0, -100, 5)))
if part then
    ground = part
end

local tracking = false
local player
if _G.hook ~= nil then
    _G.hook = ""; _G.hook = hookmetamethod(game, "__index", newcclosure(function(self, idx)
        if tostring(self) == "HumanoidRootPart" and idx == "Size" then
            return Vector3.new(2, 2, 1)
        elseif tostring(self) == "HumanoidRootPart" and idx == "BrickColor" then
            return BrickColor.new("Medium stone grey")
        elseif tostring(self) == "HumanoidRootPart" and idx == "Color" then
            return Color3.fromRGB(163, 162, 165)
        elseif tostring(self) == "Humanoid" and idx == "WalkSpeed" then
            return 16
        end
        return hook(self, idx)
    end))
end

shootingEvent.OnClientEvent:Connect(function(newKey)
    _G.key = newKey
end)

--functions

function updateNearestPlayerWithBall()
    local dist = 9e9
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= plr.Name and v.Character and v.Character:FindFirstChild("Basketball") and not plr.Character:FindFirstChild("Basketball") and (plr.Character.Torso.Position - v.Character.Torso.Position).Magnitude < 50 then
            local mag = (plr.Character.Torso.Position - v.Character.Torso.Position).Magnitude
            if dist > mag then
                dist = mag
                player = v
            end
        end
    end
end

function setup()
    local dist, goal = 9e9, nil
    for i,v in pairs(workspace.Courts:GetDescendants()) do
        if v.Name == "Swish" and v:IsA("Sound") and plr.Character and plr.Character:FindFirstChild("Torso") then
            local mag = (plr.Character.Torso.Position - v.Parent.Position).Magnitude
            if dist > mag then
                dist = mag; goal = v.Parent
            end
        end
    end
    return dist, goal
end

function power()
    return plr.Power
end

function changePower(goal)
    power().Value = goal
end

function table(a, b)
    local args = {
X1 = a.X,
Y1 = a.Y,
Z1 = a.Z,
X2 = b.X,
Y2 = b.Y,
Z2 = b.Z
};

return {args[_G.method[1]], args[_G.method[2]], args[_G.method[3]], args[_G.method[4]], args[_G.method[5]], args[_G.method[6]]}
end

function arc()
    local dist, goal = setup()

    dist = math.floor(dist)
    print(dist)
    if dist == 12 or dist == 13 then
        return 15
    elseif dist == 14 or dist == 15 then
        return 20
    elseif dist == 16 or dist == 17 then
        return 15
    elseif dist == 18 then
        return 25
    elseif dist == 19 then
        return 20
    elseif dist == 20 or dist == 21 then
        return 20
    elseif dist == 22 or dist == 23 then
        return 25
    elseif dist == 24 or dist == 25 then
        return 20
    elseif dist == 26 then
        return 15
    elseif dist == 27 or dist == 28 then
        return 25
    elseif dist == 29 or dist == 30 then
        return 20
    elseif dist == 31 then
        return 15
    elseif dist == 32 or dist == 33 then
        return 30
    elseif dist == 34 or dist == 35 or dist == 36 then
        return 25
    elseif dist == 37 or dist == 38 then
        return 35
    elseif dist == 39 or dist == 40 then
        return 30
    elseif dist == 41 then
        return 25
    elseif dist == 42 or dist == 43 then
        return 40
    elseif dist == 44 then
        return 35
    elseif dist == 45 or dist == 46 then
        return 30
    elseif dist == 47 or dist == 48 then
        return 45
    elseif dist == 49 then
        return 40
    elseif dist == 50 then
        return 35
    elseif dist == 51 then
        return 50
    elseif dist == 52 then
        return 55
    elseif dist == 53 or dist == 54 then
        return 50
    elseif dist == 55 then
        return 45
    elseif dist == 56 then
        return 40
    elseif dist == 57 or dist == 58 then
        return 55
    elseif dist == 59 or dist == 60 or dist == 61 then
        return 50
    elseif dist == 62 or dist == 63 then
        return 65
    elseif dist == 64 then
        return 55
    elseif dist == 65 then
        return 60
    elseif dist == 66 or dist == 67 then
        return 50
    elseif dist == 68 or dist == 69 then
        return 75
    elseif dist == 70 or dist == 71 then
        return 70
    elseif dist == 72 then
        return 65
    elseif dist == 73 then
        return 60
    elseif dist == 74 then
        return 50
    elseif jumping then
        if dist == 9 or dist == 10 then
            return 20
        elseif dist == 11 or dist == 12 then
            return 15
        end
    end
end

function getNearestPart(torso)
    local dist, part = 9e9
    for i,v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Part") and torso then
            local mag = (v.Position - torso.Position).Magnitude
            if dist > mag then
                dist = mag
                part = v
            end
        end
    end
    return part
end

function stepped() pcall(function()
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and _G.Aimbot then
        local pwr = power()
        local dist, goal = setup()
        local root = plr.Character.HumanoidRootPart
   
        dist = math.floor(dist)

        if root and hasBall then
            root.Size = Vector3.new(2.1, 2.1, 1.1)
            root.BrickColor = BrickColor.new("Lime green")
            root.Material = Enum.Material.Neon
           
            if dist >= 13 and dist <= 16 then
                changePower(30)
                _G.Range = true
            elseif dist >= 17 and dist <= 21 then
                changePower(35)
                _G.Range = true
            elseif dist >= 22 and dist <= 26 then
                changePower(40)
                _G.Range = true
            elseif dist >= 27 and dist <= 31 then
                changePower(45)
                _G.Range = true
            elseif dist >= 32 and dist <= 36 then
                changePower(50)
                _G.Range = true
            elseif dist >= 37 and dist <= 41 then
                changePower(55)
                _G.Range = true
            elseif dist >= 42 and dist <= 46 then
                changePower(60)
                _G.Range = true
            elseif dist >= 47 and dist <= 50 then
                changePower(65)
                _G.Range = true
            elseif dist >= 51 and dist <= 56 then
                changePower(70)
                _G.Range = true
            elseif dist >= 57 and dist <= 61 then
                changePower(75)
                _G.Range = true
            elseif dist >= 62 and dist <= 67 then
                changePower(80)
                _G.Range = true
            elseif dist >= 68 and dist <= 74 then
                changePower(85)
                _G.Range = true
            elseif jumping and dist == 9 or dist == 10 or dist == 11 or dist == 12 then
                changePower(25)
                _G.Range = true
            else
                _G.Range = false
            end
        elseif root and not hasBall and _G.Aimbot then
            _G.Range = false
        elseif root and not _G.Aimbot then
            _G.Range = false
        end
    end
   
    updateNearestPlayerWithBall()
   
    if _G.WS and plr.Character:WaitForChild("Humanoid").WalkSpeed ~= 0 then
        plr.Character:WaitForChild("Humanoid").WalkSpeed = 19
    elseif _G.WS == false and plr.Character:WaitForChild("Humanoid").WalkSpeed ~= 0 then
        plr.Character:WaitForChild("Humanoid").WalkSpeed = 16
    end

    --[[if true and tracking and player and plr.Character and plr.Character:FindFirstChild("Humanoid") and not plr.Character:FindFirstChild("Basketball") and player.Character and player.Character:FindFirstChild("Basketball") then
        plr.Character.Humanoid:MoveTo(player.Character.Basketball:FindFirstChildOfClass("Part").Position + player.Character.Torso.CFrame.LookVector + ((player.Character.Humanoid.MoveDirection * 2) + (plr.Character.Torso.Velocity.Unit * 3)))
       
        if (player.Character.Torso.Position.Y - ground.Position.Y) > 2.5 then
            plr.Character.Humanoid.Jump = true
        end
    elseif tracking and player ~= nil and player.Character and plr.Character and plr.Character:FindFirstChild("Basketball") or not player.Character:FindFirstChild("Basketball") then
        tracking = false
        return
    end]]
   
    for i,v in pairs(game.Players:GetPlayers()) do
        if (v.Name ~= plr.Name and v.Character and plr.Character) and _G.Reach then
            local nearestPart = getNearestPart(v.Character.Torso)
            for z,x in pairs(v.Character:GetChildren()) do
                if ((nearestPart.Position - v.Character.Torso.Position).Magnitude < 8) then
                    if (x:IsA("Tool") or x:IsA("Folder")) then
                        firetouchinterest(nearestPart, x:FindFirstChildOfClass("Part"), 0)
                        task.wait()
                        firetouchinterest(nearestPart, x:FindFirstChildOfClass("Part"), 1)
                    elseif (x:IsA("BasePart") and string.find(x.Name:lower(), "ball")) then
                        firetouchinterest(nearestPart, x, 0)
                        task.wait()
                        firetouchinterest(nearestPart, x, 1)
                    end
                end
            end
        end
    end
end) end

function shoot()
    local dist, goal = setup()
    local pwr = power()
    local arc = arc()
   
    if arc ~= nil and plr.Character and plr.Character:FindFirstChild("Humanoid") then
        local args = table(plr.Character.Torso.Position, (goal.Position + Vector3.new(0, arc, 0) - plr.Character.HumanoidRootPart.Position + plr.Character.Humanoid.MoveDirection).Unit)
   
        shootingEvent:FireServer(
            plr.Character.Basketball,
            pwr.Value,
            args,
            _G.key
        )
    end
end

function jumped()
    if _G.Aimbot and plr.Character and hasBall and plr.Character:FindFirstChild("HumanoidRootPart") and _G.Range then
        jumping = true
        task.wait(0.325)
        shoot()
        task.wait(0.1)
        jumping = false
    end
end

function added(v)
    if v.Name == "Basketball" then
        task.wait(0.5)
        hasBall = true
    end
end

function removed(v)
    if v.Name == "Basketball" then
        hasBall = false
    end
end

function began(key, gpe)
    if not gpe and key.KeyCode == Enum.KeyCode.U and _G.Autogaurd then
        updateNearestPlayerWithBall()
        if not tracking then
            tracking = true
        else
            tracking = false
        end
    end
end

--libary

local Main = Instance.new("ScreenGui")
local UI = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Aimbot = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local Lowarc = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local Reach = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Speed = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Color = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local OpenClose = Instance.new("ImageButton")
local UICorner_7 = Instance.new("UICorner")
local Range = Instance.new("TextLabel")
local range1 = Instance.new("Frame")
local range2 = Instance.new("Frame")

--Properties:

Main.Name = "Main"
Main.Parent = game.CoreGui
Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

UI.Name = "UI"
UI.Parent = Main
UI.AnchorPoint = Vector2.new(0.5, 0.5)
UI.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
UI.BorderColor3 = Color3.fromRGB(0, 0, 0)
UI.Position = UDim2.new(0.497999996, 0, 1.04176462, 0)
UI.Size = UDim2.new(0, 720, 0, 76)

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = UI

Aimbot.Name = "Aimbot"
Aimbot.Parent = UI
Aimbot.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
Aimbot.Position = UDim2.new(0.0169183444, 0, 0.126098871, 0)
Aimbot.Size = UDim2.new(0, 136, 0, 56)
Aimbot.Font = Enum.Font.SourceSans
Aimbot.Text = "Aimbot"
Aimbot.TextColor3 = Color3.fromRGB(0, 0, 0)
Aimbot.TextSize = 44.000
Aimbot.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = Aimbot

Lowarc.Name = "Lowarc"
Lowarc.Parent = UI
Lowarc.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
Lowarc.Position = UDim2.new(0.225792304, 0, 0.126098871, 0)
Lowarc.Size = UDim2.new(0, 136, 0, 56)
Lowarc.Font = Enum.Font.SourceSans
Lowarc.Text = "Low Arc"
Lowarc.TextColor3 = Color3.fromRGB(0, 0, 0)
Lowarc.TextSize = 44.000
Lowarc.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(1, 0)
UICorner_3.Parent = Lowarc

Reach.Name = "Reach"
Reach.Parent = UI
Reach.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
Reach.Position = UDim2.new(0.587658465, 0, 0.126098871, 0)
Reach.Size = UDim2.new(0, 136, 0, 56)
Reach.Font = Enum.Font.SourceSans
Reach.Text = "Reach"
Reach.TextColor3 = Color3.fromRGB(0, 0, 0)
Reach.TextSize = 44.000
Reach.TextWrapped = true

UICorner_4.CornerRadius = UDim.new(1, 0)
UICorner_4.Parent = Reach

Speed.Name = "Speed"
Speed.Parent = UI
Speed.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
Speed.Position = UDim2.new(0.794062316, 0, 0.112940975, 0)
Speed.Size = UDim2.new(0, 136, 0, 56)
Speed.Font = Enum.Font.SourceSans
Speed.Text = "Speed"
Speed.TextColor3 = Color3.fromRGB(0, 0, 0)
Speed.TextSize = 44.000
Speed.TextWrapped = true

UICorner_5.CornerRadius = UDim.new(1, 0)
UICorner_5.Parent = Speed

Color.Name = "Color"
Color.Parent = UI
Color.BackgroundColor3 = Color3.fromRGB(168, 168, 168)
Color.Position = UDim2.new(0.44127512, 0, 0.589504719, 0)
Color.Size = UDim2.new(0, 82, 0, 20)
Color.Font = Enum.Font.SourceSans
Color.Text = "UI Color"
Color.TextColor3 = Color3.fromRGB(0, 0, 0)
Color.TextSize = 27.000
Color.TextWrapped = true

UICorner_6.CornerRadius = UDim.new(1, 0)
UICorner_6.Parent = Color

OpenClose.Name = "Open/Close"
OpenClose.Parent = Main
OpenClose.AnchorPoint = Vector2.new(0.5, 0.5)
OpenClose.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
OpenClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
OpenClose.Position = UDim2.new(0.496845603, 0, 0.992000043, 0)
OpenClose.Size = UDim2.new(0, 80, 0, 80)
OpenClose.Image = "http://www.roblox.com/asset/?id=868153560"

UICorner_7.CornerRadius = UDim.new(1, 0)
UICorner_7.Parent = OpenClose

Range.Name = "Range"
Range.Parent = Main
Range.AnchorPoint = Vector2.new(0.5, 0.5)
Range.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
Range.Position = UDim2.new(0.497999996, 0, -0.011, 0)
Range.Size = UDim2.new(0, 200, 0, 50)
Range.Font = Enum.Font.SourceSans
Range.Text = "To Far"
Range.TextColor3 = Color3.fromRGB(255, 0, 4)
Range.TextScaled = true
Range.TextSize = 14.000
Range.TextWrapped = true
Range.Visible = false

range1.Name = "range1"
range1.Parent = Range
range1.AnchorPoint = Vector2.new(0.5, 0.5)
range1.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
range1.BorderSizePixel = 0
range1.Position = UDim2.new(-0.090000011, 0, -0.0399999991, 0)
range1.Rotation = 45.000
range1.Size = UDim2.new(0, 100, 0, 50)

range2.Name = "range2"
range2.Parent = Range
range2.AnchorPoint = Vector2.new(0.5, 0.5)
range2.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
range2.BorderSizePixel = 0
range2.Position = UDim2.new(1, 19, -0.0599999987, 0)
range2.Rotation = -45.000
range2.Size = UDim2.new(0, 100, 0, 50)

-- Scripts:

local function SJAIKPT_fake_script() -- Aimbot.LocalScript 
	local script = Instance.new('LocalScript', Aimbot)

	function aimbottoggle()
        if _G.Aimbot == true then
		    _G.Aimbot = false
            Range.Visible = false
        else
            _G.Aimbot = true
            Range.Visible = true
        end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		aimbottoggle()
		if script.parent.BackgroundColor3 == Color3.fromRGB(65,65,65) then
			script.parent.BackgroundColor3 = Color3.fromRGB(17, 93, 0)
		elseif script.parent.BackgroundColor3 == Color3.fromRGB(17, 93, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(65,65,65)
		end
	end)
end
coroutine.wrap(SJAIKPT_fake_script)()
local function LSNJYUN_fake_script() -- Lowarc.LocalScript 
	local script = Instance.new('LocalScript', Lowarc)

	function arctoggle()

	end
	
	script.Parent.MouseButton1Click:Connect(function()
		arctoggle()
		if script.parent.BackgroundColor3 == Color3.fromRGB(65,65,65) then
			script.parent.BackgroundColor3 = Color3.fromRGB(17, 93, 0)
		elseif script.parent.BackgroundColor3 == Color3.fromRGB(17, 93, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(65,65,65)
		end
	end)
end
coroutine.wrap(LSNJYUN_fake_script)()
local function APWSUMZ_fake_script() -- Reach.LocalScript 
	local script = Instance.new('LocalScript', Reach)

	function reachtoggle()
		if _G.Reach == true then
            _G.Reach = false
        else
            _G.Reach = true
        end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		reachtoggle()
		if script.parent.BackgroundColor3 == Color3.fromRGB(65,65,65) then
			script.parent.BackgroundColor3 = Color3.fromRGB(17, 93, 0)
		elseif script.parent.BackgroundColor3 == Color3.fromRGB(17, 93, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(65,65,65)
		end
	end)
end
coroutine.wrap(APWSUMZ_fake_script)()
local function MTURK_fake_script() -- Speed.LocalScript 
	local script = Instance.new('LocalScript', Speed)

	function speedtoggle()
		if _G.WS == true then
            _G.WS = false
        else
            _G.WS = true
        end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		speedtoggle()
		if script.parent.BackgroundColor3 == Color3.fromRGB(65,65,65) then
			script.parent.BackgroundColor3 = Color3.fromRGB(17, 93, 0)
		elseif script.parent.BackgroundColor3 == Color3.fromRGB(17, 93, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(65,65,65)
		end
	end)
end
coroutine.wrap(MTURK_fake_script)()
local function PENP_fake_script() -- Color.LocalScript 
	local script = Instance.new('LocalScript', Color)

	script.Parent.MouseButton1Click:Connect(function()
		if script.parent.parent.BackgroundColor3 == Color3.fromRGB(91, 91, 91) then
			script.parent.parent.BackgroundColor3 = Color3.fromRGB(239, 239, 239)
		elseif script.parent.parent.BackgroundColor3 == Color3.fromRGB(239, 239, 239) then
			script.parent.parent.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
		end
		if script.parent.BackgroundColor3 == Color3.fromRGB(168, 168, 168) then
			script.parent.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
		elseif script.parent.BackgroundColor3 == Color3.fromRGB(42, 42, 42) then
			script.parent.BackgroundColor3 = Color3.fromRGB(168, 168, 168)
		end
	end)
end
coroutine.wrap(PENP_fake_script)()
local function ZJLVPS_fake_script() -- OpenClose.LocalScript 
	local script = Instance.new('LocalScript', OpenClose)

	script.parent.ImageTransparency = 0
	
	local toggle = false
	local openbutton = script.Parent
	local UI = script.parent.parent.UI
	script.parent.ImageTransparency = 0.5
	UI.BackgroundTransparency = 0.5
	UI.Aimbot.BackgroundTransparency = 0.5
	UI.Color.BackgroundTransparency = 0.5
	UI.Lowarc.BackgroundTransparency = 0.5
	UI.Reach.BackgroundTransparency = 0.5
	UI.Speed.BackgroundTransparency = 0.5
	
	script.Parent.MouseButton1Click:Connect(function()
		if toggle == true then -- closes
			
			openbutton:TweenPosition(
				UDim2.new(0.497, 0,0.992, 0),
				"Out",
				"Quad",
				1.5,
				false
			)
			
			UI:TweenPosition(
				UDim2.new(0.498, 0,1.05, 0),
				"Out",
				"Quad",
				1.5,
				false
			)
			
			
	
			toggle = false -- close
			wait(2)
			script.parent.ImageTransparency = 0.5
			UI.BackgroundTransparency = 0.5
			UI.Aimbot.BackgroundTransparency = 0.5
			UI.Color.BackgroundTransparency = 0.5
			UI.Lowarc.BackgroundTransparency = 0.5
			UI.Reach.BackgroundTransparency = 0.5
			UI.Speed.BackgroundTransparency = 0.5
		elseif toggle == false then -- opens
			
			openbutton:TweenPosition(
				UDim2.new(0.497, 0,0.905, 0),
				"Out",
				"Quad",
				1.5,
				false
			)
	
			UI:TweenPosition(
				UDim2.new(0.498, 0,0.955, 0),
				"Out",
				"Quad",
				1.5,
				false
			)
			
			
			
			toggle = true -- open
			wait(1.5)
			script.parent.ImageTransparency = 0
			UI.BackgroundTransparency = 0
			UI.Aimbot.BackgroundTransparency = 0
			UI.Color.BackgroundTransparency = 0
			UI.Lowarc.BackgroundTransparency = 0
			UI.Reach.BackgroundTransparency = 0
			UI.Speed.BackgroundTransparency = 0
		end
	end)
end
coroutine.wrap(ZJLVPS_fake_script)()

--hooks

resume(create(function()
    while true do
        if _G.Range == true then
            Range.Text = "In Range"
            Range.TextColor3 = Color3.fromRGB(0, 255, 0)
        elseif _G.Range == false then
            Range.Text = "To Far"
            Range.TextColor3 = Color3.fromRGB(255, 0, 4)
        end
        task.wait(0.01)
    end
end))

_G.input = plr.Character.Humanoid.Jumping:Connect(jumped)
_G.added = plr.Character.ChildAdded:Connect(added)
_G.removed = plr.Character.ChildRemoved:Connect(removed)
_G.stepped = rs.Stepped:Connect(stepped)
_G.began = uis.InputBegan:Connect(began)

_G.charAdded = plr.CharacterAdded:Connect(function(ch)
    _G.input = ch:WaitForChild("Humanoid").Jumping:Connect(jumped)
    _G.added = ch.ChildAdded:Connect(added)
    _G.removed = ch.ChildRemoved:Connect(removed)
   
    for i,v in pairs(getconnections(ch:WaitForChild("HumanoidRootPart"):GetPropertyChangedSignal("Size"))) do
        v:Disable()
    end
    for i,v in pairs(getconnections(ch:WaitForChild("HumanoidRootPart"):GetPropertyChangedSignal("BrickColor"))) do
        v:Disable()
    end
    for i,v in pairs(getconnections(ch:WaitForChild("HumanoidRootPart"):GetPropertyChangedSignal("Color"))) do
        v:Disable()
    end
    for i,v in pairs(getconnections(ch:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"))) do
        v:Disable()
    end
end)