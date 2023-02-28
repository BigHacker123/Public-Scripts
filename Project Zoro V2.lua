-- init
if not game:IsLoaded() then
	game.Loaded:Wait()
end

OLDTick = tick()

if not syn or not protectgui then
	getgenv().protectgui = function() end
end

local CoreGui = game:GetService("StarterGui")

local SilentAimSettings = {
	Enabled = false,

	ClassName = "POG",
	ToggleKey = "RightAlt",

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

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
--------
ESP.Boxes = false
ESP.Names = false
ESP.Tracers = false
ESP.TeamMates = false
Cfly = false
oldfov = game.workspace.Camera.FieldOfView

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local arm1tr = 100
local arm2tr = 100
local mat11 = Plastic
local matisgay = Plastic
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

------------------------ Aimbot shit
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

_G.AimbotEnabled = aimbotisontop
_G.TeamCheck = temaeeeee -- If set to true then the script would only lock your aim at enemy team members.
_G.AimPart = aimypart -- Where the aimbot script would lock at.
_G.Sensitivity = locktimeee -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

_G.CircleSides = circlesides -- How many sides the FOV circle would have.
_G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
_G.CircleTransparency = circletranss -- Transparency of the circle.
_G.CircleRadius = radisfff -- The radius of the circle / FOV.
_G.CircleFilled = fillefoc -- Determines whether or not the circle is filled.
_G.CircleVisible = foveee -- Determines whether or not the circle is visible.
_G.CircleThickness = thiccc -- The thickness of the circle.

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

	for _, v in next, Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			if _G.TeamCheck == true then
				if v.Team ~= LocalPlayer.Team then
					if v.Character ~= nil then
						if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
								local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

								if VectorDistance < MaximumDistance then
									Target = v
								end
							end
						end
					end
				end
			else
				if v.Character ~= nil then
					if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
							local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
							local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

							if VectorDistance < MaximumDistance then
								Target = v
							end
						end
					end
				end
			end
		end
	end

	return Target
end

UserInputService.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton2 then
		Holding = true
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton2 then
		Holding = false
	end
end)

RunService.RenderStepped:Connect(function()
	FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
	FOVCircle.Radius = _G.CircleRadius
	FOVCircle.Filled = _G.CircleFilled
	FOVCircle.Color = _G.CircleColor
	FOVCircle.Visible = _G.CircleVisible
	FOVCircle.Radius = _G.CircleRadius
	FOVCircle.Transparency = _G.CircleTransparency
	FOVCircle.NumSides = _G.CircleSides
	FOVCircle.Thickness = _G.CircleThickness

	if Holding == true and _G.AimbotEnabled == true then
		TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
	end
end)

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
local UserInputService = game:GetService("UserInputService")

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
	-- // Floor the percentage
	Percentage = math.floor(Percentage)

	-- // Get the chance
	local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100

	-- // Return
	return chance <= Percentage / 100
end

-- functions
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
--------------fly stuff
local function cflyee()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/LegitH3x0R/Roblox-Scripts/main/AEBypassing/RootAnchor.lua"))()
	local UIS = game:GetService("UserInputService")
	local OnRender = game:GetService("RunService").RenderStepped

	local Player = game:GetService("Players").LocalPlayer
	local Character = Player.Character or Player.CharacterAdded:Wait()

	local Camera = workspace.CurrentCamera
	local Root = Character:WaitForChild("HumanoidRootPart")

	local C1, C2, C3;
	local Nav = {Flying = false, Forward = false, Backward = false, Left = false, Right = false}
	C1 = UIS.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == Enum.KeyCode.H then
				Nav.Flying = not Nav.Flying
				Root.Anchored = Nav.Flying
			elseif Input.KeyCode == Enum.KeyCode.W then
				Nav.Forward = true
			elseif Input.KeyCode == Enum.KeyCode.S then
				Nav.Backward = true
			elseif Input.KeyCode == Enum.KeyCode.A then
				Nav.Left = true
			elseif Input.KeyCode == Enum.KeyCode.D then
				Nav.Right = true
			end
		end
	end)

	C2 = UIS.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == Enum.KeyCode.W then
				Nav.Forward = false
			elseif Input.KeyCode == Enum.KeyCode.S then
				Nav.Backward = false
			elseif Input.KeyCode == Enum.KeyCode.A then
				Nav.Left = false
			elseif Input.KeyCode == Enum.KeyCode.D then
				Nav.Right = false
			end
		end
	end)

	C3 = Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
		if Nav.Flying then
			Root.CFrame = CFrame.new(Root.CFrame.Position, Root.CFrame.Position + Camera.CFrame.LookVector)
		end
	end)

	while true do -- not EndAll
		local Delta = OnRender:Wait()
		if Nav.Flying then
			if Nav.Forward then
				Root.CFrame = Root.CFrame + (Camera.CFrame.LookVector * (Delta * Speed))
			end
			if Nav.Backward then
				Root.CFrame = Root.CFrame + (-Camera.CFrame.LookVector * (Delta * Speed))
			end
			if Nav.Left then
				Root.CFrame = Root.CFrame + (-Camera.CFrame.RightVector * (Delta * Speed))
			end
			if Nav.Right then
				Root.CFrame = Root.CFrame + (Camera.CFrame.RightVector * (Delta * Speed))
			end
		end
	end
end
--------------
-- menu handler
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
	Title = 'Project Zoro v2',
	Center = true,
	AutoShow = true,
})

local Tabs = {
	Aim = Window:AddTab('Aim'),
	Esp = Window:AddTab('Visuals'),
	Move = Window:AddTab('Other'),
	['UI Settings'] = Window:AddTab('UI Settings')
}

local LeftGroupBox = Tabs.Aim:AddLeftGroupbox('Silent Aim')

LeftGroupBox:AddToggle('aim_Enabled', {
	Text = 'Silent Aim',
	Default = false,
	Tooltip = 'Toggles Silent Aim',
})

Toggles.aim_Enabled:OnChanged(function()
	SilentAimSettings.Enabled = Toggles.aim_Enabled.Value
end)
---------
LeftGroupBox:AddToggle('MousePosition', {
	Text = 'Show Silent Aim Target',
	Default = false,
	Tooltip = 'Toggles Silent Aim Postion',
})

Toggles.MousePosition:OnChanged(function()
	MousePosition = Toggles.MousePosition.Value
	if MousePosition then
		mouse_box.Visible = true
	else
		mouse_box.Visible = false
	end
end)
---------
local LeftGroupBox2 = Tabs.Aim:AddLeftGroupbox('Silent Aim Settings')
---------
LeftGroupBox2:AddSlider('Radius', {
	Text = 'Silent Aim Fov',

	Default = 130,
	Min = 0,
	Max = 1000,
	Rounding = 0,

	Compact = false,
})
Options.Radius:OnChanged(function()
	fov_circle.Radius = Options.Radius.Value
	SilentAimSettings.FOVRadius = Options.Radius.Value
end)

LeftGroupBox2:AddDropdown("Method", {Text = "Silent Aim Method", Default = SilentAimSettings.SilentAimMethod, Values = {
	"Raycast"}}):OnChanged(function()
	SilentAimSettings.SilentAimMethod = Options.Method.Value
end)

LeftGroupBox2:AddSlider('HitChance', {
	Text = 'Hit chance',

	Default = 100,
	Min = 0,
	Max = 100,
	Rounding = 1,

	Compact = false,
})
Options.HitChance:OnChanged(function()
	SilentAimSettings.HitChance = Options.HitChance.Value
end)

LeftGroupBox2:AddToggle('Visible', {
	Text = 'Silent Aim Fov',
	Default = false,
	Tooltip = 'Toggles Silent Aim Fov',
})

LeftGroupBox2:AddToggle('VisibleCheck', {
	Text = 'Toggles Visible Check',
	Default = false,
	Tooltip = 'Checks if the player is visible',
})

Toggles.VisibleCheck:OnChanged(function()
	SilentAimSettings.VisibleCheck = Toggles.VisibleCheck.Value
end)

LeftGroupBox2:AddToggle('TeamCheck', {
	Text = 'Toggles Team Check',
	Default = false,
	Tooltip = 'Checks if the player is on your team',
})

Toggles.TeamCheck:OnChanged(function()
	SilentAimSettings.TeamCheck = Toggles.TeamCheck.Value
end)

Toggles.Visible:OnChanged(function()
	SilentAimSettings.FOVVisible = Toggles.Visible.Value
	if Toggles.Visible.Value then
		fov_circle.Visible = true
	else
		fov_circle.Visible = false
	end
end)

LeftGroupBox2:AddDropdown('TargetPart', {
	Values = { 'Head', 'HumanoidRootPart', 'Random' },
	Default = 1,
	Multi = false,

	Text = 'Silent Aim Target',
	Tooltip = 'Changes the Silent Aim Target',
})

Options.TargetPart:OnChanged(function()
	SilentAimSettings.TargetPart = Options.TargetPart.Value
end)

local RightGroupbox = Tabs.Aim:AddRightGroupbox('Aimbot')

RightGroupbox:AddToggle('aimyy', {
	Text = 'Aimbot',
	Default = false,
	Tooltip = 'Toggles Aimbot',
})

Toggles.aimyy:OnChanged(function()
	_G.AimbotEnabled = Toggles.aimyy.Value
end)

local RightGroupbox2 = Tabs.Aim:AddRightGroupbox('Aimbot Settings')

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
	Text = 'Aimbot Lock Time',

	Default = 0,
	Min = 0,
	Max = 5,
	Rounding = 1,

	Compact = false,
})
Options.senssssss:OnChanged(function()
	_G.Sensitivity = Options.senssssss.Value
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

	Default = 0.7,
	Min = 0,
	Max = 1,
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

local GroupBox = Tabs.Esp:AddLeftGroupbox('Esp')

GroupBox:AddToggle("espppppppp", {Text = "ESP", Default = false}):OnChanged(function()
	ESP:Toggle(true)
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

local GroupBox1 = Tabs.Esp:AddLeftGroupbox('Player')

GroupBox1:AddToggle("fov3", {Text = "Player Fov", Default = false}):OnChanged(function()
	changefov = Toggles.fov3.Value
	if changefov then
		resume(create(function()
			while changefov do
				game.workspace.Camera.FieldOfView = fove
				task.wait()
			end
			game.workspace.Camera.FieldOfView = oldfov
		end))
	end
end)

GroupBox1:AddSlider('fov2', {
	Text = 'Fov',

	Default = 90,
	Min = 60,
	Max = 120,
	Rounding = 0,

	Compact = false,
})
Options.fov2:OnChanged(function()
	fove = Options.fov2.Value
end)

GroupBox1:AddToggle("arm1", {Text = "Left Arm Transperancy", Default = false}):OnChanged(function()
	if Toggles.arm1.Value then
		resume(create(function()
			while Toggles.arm1.Value do
				if Workspace.Camera:WaitForChild("Viewmodel") then
					if Workspace.Camera.Viewmodel:WaitForChild("Left Arm") then
						Workspace.Camera.Viewmodel["Left Arm"].Transparency = arm1tr/100
						wait(0.1)
					end
				end
			end
		end))
	else
		resume(create(function()
			repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
			if Workspace.Camera.Viewmodel:WaitForChild("Left Arm") then
				Workspace.Camera.Viewmodel["Left Arm"].Transparency = 0
			end
		end))
	end
end)


GroupBox1:AddSlider('arm1tra', {
	Text = 'Left Arm Transperancy',

	Default = 100,
	Min = 0,
	Max = 100,
	Rounding = 0,

	Compact = false,
})
Options.arm1tra:OnChanged(function()
	arm1tr = Options.arm1tra.Value
end)

GroupBox1:AddToggle("arm2", {Text = "Right Arm Transperancy", Default = false}):OnChanged(function()
	if Toggles.arm1.Value then
		resume(create(function()
			while Toggles.arm2.Value do
				if Workspace.Camera:WaitForChild("Viewmodel") then
					if Workspace.Camera.Viewmodel:WaitForChild("Right Arm") then
						Workspace.Camera.Viewmodel["Right Arm"].Transparency = arm2tr/100
						wait(0.1)
					end
				end
			end
		end))
	else
		resume(create(function()
			repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
			if Workspace.Camera.Viewmodel:WaitForChild("Right Arm") then
				Workspace.Camera.Viewmodel["Right Arm"].Transparency = 0
			end
		end))
	end
end)

GroupBox1:AddSlider('arm2tra', {
	Text = 'Right Arm Transperancy',

	Default = 100,
	Min = 0,
	Max = 100,
	Rounding = 0,

	Compact = false,
})
Options.arm2tra:OnChanged(function()
	arm2tr = Options.arm2tra.Value
end)

GroupBox1:AddToggle("mat1", {Text = "Left Arm Material", Default = false}):OnChanged(function()
	resume(create(function()
		repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
		if Workspace.Camera.Viewmodel:WaitForChild("Left Arm") then
			if Toggles.mat1.Value then
				repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
				while Toggles.mat1.Value do
					if Workspace.Camera:WaitForChild("Viewmodel") then
						Workspace.Camera.Viewmodel["Left Arm"].Material = (mat111)
						wait(0.1)
					end
				end
			else
				Workspace.Camera.Viewmodel["Left Arm"].Material = ("Plastic")
			end
		end
	end))
end)

GroupBox1:AddDropdown('mat11', {
	Values = { 'Plastic', 'ForceField', 'Neon', 'Metal' },
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = 'Left Arm',
})

Options.mat11:OnChanged(function()
	mat111 = Options.mat11.Value
end)

Options.mat11:SetValue('Plastic')

GroupBox1:AddToggle("mat2", {Text = "Right Arm Material", Default = false}):OnChanged(function()
	resume(create(function()
		repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
		if Workspace.Camera.Viewmodel:WaitForChild("Right Arm") then
			if Toggles.mat2.Value then
				repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
				while Toggles.mat2.Value do
					if Workspace.Camera:WaitForChild("Viewmodel") then
						Workspace.Camera.Viewmodel["Right Arm"].Material = (mat222)
						wait(0.1)
					end
				end
			else
				Workspace.Camera.Viewmodel["Right Arm"].Material = ("Plastic")
			end
		end
	end))
end)

GroupBox1:AddDropdown('mat22', {
	Values = { 'Plastic', 'ForceField', 'Neon', 'Metal' },
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = 'Right Arm'
})

Options.mat22:OnChanged(function()
	mat222 = Options.mat22.Value
end)

Options.mat22:SetValue('Plastic')

GroupBox1:AddLabel('Arm Color'):AddColorPicker('armcolors', {
	Default = Color3.fromRGB(255, 204, 153),
	Title = 'Both Arms' -- Optional. Allows you to have a custom color picker title (when you open it)
})

Options.armcolors:OnChanged(function()
	resume(create(function()
		while true do
			repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
			if Workspace.Camera.Viewmodel:WaitForChild("Right Arm") and Workspace.Camera.Viewmodel:WaitForChild("Right Arm") then
				Workspace.Camera.Viewmodel["Right Arm"].Color = Color3.fromRGB(armcolors)
				Workspace.Camera.Viewmodel["Left Arm"].Color = Color3.fromRGB(armcolors)
			end
			wait(0.1)
		end
	end))
end)

local RightGroupbox = Tabs.Esp:AddRightGroupbox('Other')

RightGroupbox:AddToggle("third", {Text = "ThirdPerson"}):AddKeyPicker("third_KeyPicker", {Default = "T", SyncToggleState = true, Mode = "Toggle", Text = "ThirdPerson", NoUI = false});
Options.third_KeyPicker:OnClick(function()
	if Toggles.third.Value then
		resume(create(function()
			while Toggles.third.Value do
				local UserInputService = game:GetService("UserInputService")
				game:GetService('Players').LocalPlayer.CameraMode = ("Classic")
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				if Workspace.Camera:WaitForChild("Viewmodel") == false then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					game:GetService('Players').LocalPlayer.CameraMode = ("Classic")
				end
				wait(0.5)
			end
		end))
	end
	resume(create(function()
		while Toggles.third.Value == false do
			if Toggles.third.Value == false then
				game:GetService('Players').LocalPlayer.CameraMode = ("LockFirstPerson")
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				if Workspace.Camera:WaitForChild("Viewmodel") == false then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					game:GetService('Players').LocalPlayer.CameraMode = ("Classic")
				end
			end
			wait(0.5)
		end
	end))
end)

Toggles.third:OnChanged(function()
	if Toggles.third.Value then
		resume(create(function()
			while Toggles.third.Value do
				local UserInputService = game:GetService("UserInputService")
				game:GetService('Players').LocalPlayer.CameraMode = ("Classic")
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				if Workspace.Camera:WaitForChild("Viewmodel") == false then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					game:GetService('Players').LocalPlayer.CameraMode = ("Classic")
				end
				wait(0.5)
			end
		end))
	end
	resume(create(function()
		while Toggles.third.Value == false do
			if Toggles.third.Value == false then
				game:GetService('Players').LocalPlayer.CameraMode = ("LockFirstPerson")
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				if Workspace.Camera:WaitForChild("Viewmodel") == false then
					UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					game:GetService('Players').LocalPlayer.CameraMode = ("Classic")
				end
			end
			wait(0.5)
		end
	end))
end)

RightGroupbox:AddSlider('thirdd', {
	Text = 'Third Person Distance',

	Default = 13,
	Min = 1,
	Max = 30,
	Rounding = 0,

	Compact = false,
})
Options.thirdd:OnChanged(function()
	thirddistance = Options.thirdd.Value
end)

RightGroupbox:AddToggle("playermat", {Text = "Body's Material", Default = false}):OnChanged(function()
	resume(create(function()
		repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
		if Workspace.Camera:WaitForChild("Viewmodel") then
			if Toggles.playermat.Value then
				repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
				while Toggles.playermat.Value do
					if Workspace.Camera:WaitForChild("Viewmodel") then
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
				end
			else
				if Workspace:WaitForChild("Camera") then
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
			end
		end
	end))
end)

RightGroupbox:AddDropdown('buddydontcare', {
	Values = { 'Plastic', 'ForceField', 'Neon', 'Metal' },
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = 'Players Body'
})

Options.buddydontcare:OnChanged(function()
	matisgay = Options.buddydontcare.Value
end)

local GroupBox2 = Tabs.Move:AddLeftGroupbox('Movement')

GroupBox2:AddToggle('speedeee', {
	Text = 'Player Speed',
	Default = false,
	Tooltip = 'Toggles the Player Speed',
})

Toggles.speedeee:OnChanged(function()
	resume(create(function()
		if Toggles.speedeee.Value then
			while Toggles.speedeee.Value do
				repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
				game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = speedsspeed
				task.wait()
			end
		else
			game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 13
		end
	end))
end)

GroupBox2:AddSlider("speedslider", {Text = "Speed", Min = 16, Max = 50, Default = 16, Rounding = 0}):OnChanged(function()
	speedsspeed = Options.speedslider.Value
end)

GroupBox2:AddToggle("noclip_Enabled", {Text = "Noclip"}):AddKeyPicker("noclip_Enabled_KeyPicker", {Default = "RightAlt", SyncToggleState = true, Mode = "Toggle", Text = "Noclip", NoUI = false});
Options.noclip_Enabled_KeyPicker:OnClick(function()
	noclip = Toggles.noclip_Enabled.Value
end)

Toggles.noclip_Enabled:OnChanged(function()
	noclip = Toggles.noclip_Enabled.Value
end)

GroupBox2:AddButton("Fly (H)", function()
	cflyee()
end)

GroupBox2:AddLabel('Click again after you die!')

GroupBox2:AddSlider("Speed", {Text = "Fly Speed", Min = 10, Max = 150, Default = 30, Rounding = 0}):OnChanged(function()
	Speed = Options.Speed.Value
end)

GroupBox2:AddToggle("gravity", {Text = "Gravity", Default = false}):OnChanged(function()
	resume(create(function()
		if Toggles.gravity.Value == true then
			repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
			while Toggles.gravity.Value == true do
				repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
				game:GetService("Workspace").Gravity = gravity
				wait(0.1)
			end
		else
			repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
			game:GetService("Workspace").Gravity = 192.5
		end
	end))
end)

GroupBox2:AddSlider("gravityee", {Text = "Gravity Strength", Min = 30, Max = 500, Default = 192.5, Rounding = 0}):OnChanged(function()
	gravity = Options.gravityee.Value
end)

local GroupBox3 = Tabs.Move:AddRightGroupbox('Exploits')

GroupBox3:AddButton("Invisable", function()
	--//     Services     //--
	local plyrs = game:GetService("Players")

	--//     Variables     //--
	local lp = plyrs.LocalPlayer
	local chra = lp.Character

	--//     Code     //--
	local torso = chra:FindFirstChild("LowerTorso")

	torso.Root:Destroy()
	torso.RootRigAttachment:Destroy() -- go invis by detaching body from player

	chra:FindFirstChild("HumanoidRootPart").Transparency = 0
end)

GroupBox3:AddToggle("hipheight", {Text = "Float", Default = false}):OnChanged(function()
	resume(create(function()
		if Toggles.hipheight.Value == true then
			repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
			while Toggles.hipheight.Value == true do
				repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
				game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = floatheight
				wait(0.1)
			end
		else
			repeat wait(0.1) until Workspace.Camera:WaitForChild("Viewmodel")
			game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = 1.8
		end
	end))
end)

GroupBox3:AddSlider("floatheight", {Text = "Float Height", Min = 0.1, Max = 50, Default = 1, Rounding = 1}):OnChanged(function()
	floatheight = Options.floatheight.Value
end)

GroupBox3:AddToggle("timechanger", {Text = "Time Changer", Default = false}):OnChanged(function()
	timechange = Toggles.timechanger.Value
	resume(create(function()
		while timechange do
			timer = (hours .. ":" .. minutes .. ":" .. seconds .. ":")
			game.Lighting.TimeOfDay = timer
			wait(0.1)
		end
	end))
end)

GroupBox3:AddSlider("seconds", {Text = "Seconds", Min = 0, Max = 60, Default = 0, Rounding = 0}):OnChanged(function()
	seconds = Options.seconds.Value
end)

GroupBox3:AddSlider("minutes", {Text = "Minutes", Min = 0, Max = 60, Default = 0, Rounding = 0}):OnChanged(function()
	minutes = Options.minutes.Value
end)

GroupBox3:AddSlider("hours", {Text = "Hours", Min = 0, Max = 24, Default = 0, Rounding = 0}):OnChanged(function()
	hours = Options.hours.Value
end)

Library:SetWatermark('Project Zoro V2 By Yellow_FireFighter#2047')

Library:OnUnload(function()
	print('Unloaded Project Zoro v2!')
	Library.Unloaded = true
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
local ui = Tabs['UI Settings']:AddRightGroupbox('UI')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'LeftControl', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('ProjectZorov2')
SaveManager:SetFolder('ProjectZorov2/configs')
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
ui:AddToggle('Hitlogs', {
	Text = 'Hit Logs',
	Default = true,
	Tooltip = 'Toggles the Hit Logs',
})

Toggles.Hitlogs:OnChanged(function()
	if Toggles.Hitlogs.Value then
		
	end
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

-- hooks
resume(create(function()
	RenderStepped:Connect(function()
		if Toggles.MousePosition.Value and Toggles.aim_Enabled.Value then
			if getClosestPlayer() then
				local Root = getClosestPlayer().Parent.PrimaryPart or getClosestPlayer()
				local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position);
				mouse_box.Visible = IsOnScreen
				mouse_box.Position = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y)
			else
				mouse_box.Visible = false
				mouse_box.Position = Vector2.new()
			end
		end

		if Toggles.Visible.Value then
			fov_circle.Visible = Toggles.Visible.Value
			fov_circle.Color = Color3.fromRGB(54, 57, 241)
			fov_circle.Position = getMousePosition()
		end
	end)
end))

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
	local Method = getnamecallmethod()
	local Arguments = {...}
	local self = Arguments[1]
	local chance = CalculateChance(SilentAimSettings.HitChance)
	if Toggles.aim_Enabled.Value and self == workspace and not checkcaller() and chance == true then
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
		elseif Method == "FindPartOnRayWithWhitelist" and Options.Method.Value == Method then
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
		elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and Options.Method.Value:lower() == Method:lower() then
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
		elseif Method == "Raycast" and Options.Method.Value == Method then
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

game:GetService("RunService").Stepped:Connect(function()
	if noclip == true then
		if Workspace.Camera:WaitForChild("Viewmodel") then
			game.Players.LocalPlayer.Character:FindFirstChild("Head").CanCollide = false
			game.Players.LocalPlayer.Character:FindFirstChild("LowerTorso").CanCollide = false
			game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso").CanCollide = false
			game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CanCollide = false
		end
	end
	task.wait()
end)

StartUpTime = tick() - OLDTick

Library:Notify("Project Zoro v2 Loaded in " .. StartUpTime, 1)

print("Project Zoro v2 Loaded Correctly!")