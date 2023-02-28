-- init
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if not syn or not protectgui then
	getgenv().protectgui = function() end
end

local resume = coroutine.resume
local create = coroutine.create

--variables / loadables
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
--------
ESP:Toggle(false)
ESP.Boxes = false
ESP.Names = false
ESP.Tracers = false
ESP.TeamMates = true

--aimbot
_G.TeamCheck = false
_G.AimPart = "Head"
_G.Sensitivity = 0
_G.CircleSides = 3
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 100
_G.CircleRadius = 0
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 1
_G.AimbotON = false

pcall(function()
    getgenv().Aimbot.Functions:Exit()
end)

--// Environment

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local Camera = game:GetService("Workspace").CurrentCamera

--// Variables

local LocalPlayer = Players.LocalPlayer
local RequiredDistance = math.huge
local Typing = false
local Running = false
local Animation = nil
local ServiceConnections = {RenderSteppedConnection = nil, InputBeganConnection = nil, InputEndedConnection = nil, TypingStartedConnection = nil, TypingEndedConnection = nil}

--// Script Settings

Environment.Settings = {
    SendNotifications = true,
    SaveSettings = false,
    ReloadOnTeleport = true,
    Enabled = true,
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = false, -- Laggy
    Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
    TriggerKey = "MouseButton2",
    Toggle = false,
    LockPart = "Head" -- Body part to lock on
}

Environment.FOVSettings = {
    Enabled = true,
    Visible = true,
    Amount = 90,
    Color = "255, 255, 255",
    LockedColor = "255, 70, 70",
    Transparency = 0.5,
    Sides = 60,
    Thickness = 1,
    Filled = false
}

Environment.FOVCircle = Drawing.new("Circle")
Environment.Locked = nil

local function Encode(Table)
    if Table and type(Table) == "table" then
        local EncodedTable = HttpService:JSONEncode(Table)

        return EncodedTable
    end
end

local function Decode(String)
    if String and type(String) == "string" then
        local DecodedTable = HttpService:JSONDecode(String)

        return DecodedTable
    end
end

local function GetColor(Color)
    local R = tonumber(string.match(Color, "([%d]+)[%s]*,[%s]*[%d]+[%s]*,[%s]*[%d]+"))
    local G = tonumber(string.match(Color, "[%d]+[%s]*,[%s]*([%d]+)[%s]*,[%s]*[%d]+"))
    local B = tonumber(string.match(Color, "[%d]+[%s]*,[%s]*[%d]+[%s]*,[%s]*([%d]+)"))

    return Color3.fromRGB(R, G, B)
end

local function SendNotification(TitleArg, DescriptionArg, DurationArg)
    if Environment.Settings.SendNotifications then
        StarterGui:SetCore("SendNotification", {
            Title = TitleArg,
            Text = DescriptionArg,
            Duration = DurationArg
        })
    end
end

--// Functions

local function SaveSettings()
    if Environment.Settings.SaveSettings then
        if isfile(Title.."/"..FileNames[1].."/"..FileNames[2]) then
            writefile(Title.."/"..FileNames[1].."/"..FileNames[2], Encode(Environment.Settings))
        end

        if isfile(Title.."/"..FileNames[1].."/"..FileNames[3]) then
            writefile(Title.."/"..FileNames[1].."/"..FileNames[3], Encode(Environment.FOVSettings))
        end
    end
end

local function GetClosestPlayer()
    if Environment.Locked == nil then
        if Environment.FOVSettings.Enabled then
            RequiredDistance = Environment.FOVSettings.Amount
        else
            RequiredDistance = math.huge
        end

        for _, v in next, Players:GetPlayers() do
            if v ~= LocalPlayer then
                if v.Character and v.Character[Environment.Settings.LockPart] then
                    if Environment.Settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
                    if Environment.Settings.AliveCheck and v.Character.Humanoid.Health <= 0 then continue end
                    if Environment.Settings.WallCheck and #(Camera:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end

                    local Vector, OnScreen = Camera:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
                    local Distance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude

                    if Distance < RequiredDistance and OnScreen then
                        RequiredDistance = Distance
                        Environment.Locked = v
                    end
                end
            end
        end
    elseif (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
        Environment.Locked = nil
        Animation:Cancel()
        Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
    end
end

--// Typing Check

ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

local function Load()
    ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
        if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
            Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
            Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
            Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
            Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
            Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
            Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
            Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
            Environment.FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        else
            Environment.FOVCircle.Visible = false
        end

        if Running and Environment.Settings.Enabled then
            GetClosestPlayer()

            if Environment.Settings.Sensitivity > 0 then
                Animation = TweenService:Create(Camera, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
                Animation:Play()
            else
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
            end

            Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.LockedColor)
        end
    end)

    ServiceConnections.InputBeganConnection = UserInputService.InputBegan:Connect(function(Input)
        if not Typing then
            pcall(function()
                if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running

                        if not Running then
                            Environment.Locked = nil
                            Animation:Cancel()
                            Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
                        end
                    else
                        Running = true
                    end
                end
            end)

            pcall(function()
                if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running

                        if not Running then
                            Environment.Locked = nil
                            Animation:Cancel()
                            Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
                        end
                    else
                        Running = true
                    end
                end
            end)
        end
    end)

    ServiceConnections.InputEndedConnection = UserInputService.InputEnded:Connect(function(Input)
        if not Typing then
            pcall(function()
                if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                    if not Environment.Settings.Toggle then
                        Running = false
                        Environment.Locked = nil
                        Animation:Cancel()
                        Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
                    end
                end
            end)

            pcall(function()
                if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                    if not Environment.Settings.Toggle then
                        Running = false
                        Environment.Locked = nil
                        Animation:Cancel()
                        Environment.FOVCircle.Color = GetColor(Environment.FOVSettings.Color)
                    end
                end
            end)
        end
    end)
end

Load()

--setting changer
resume(create(function()
	while true do
		Environment.FOVSettings.Enabled = _G.AimbotON
		Environment.FOVSettings.Visible = _G.CircleVisible
		Environment.Settings.LockPart = _G.AimPart
		Environment.FOVSettings.Amount = _G.CircleRadius
		Environment.FOVSettings.Sides = _G.CircleSides
		Environment.Settings.TeamCheck = _G.TeamCheck
		if _G.Sensitivity then
			Environment.Settings.Sensitivity = _G.Sensitivity
		else
			Environment.Settings.Sensitivity = 0
			print("Fixed sens for nil value:" .. Environment.Settings.Sensitivity)
		end
		wait(0.1)
	end
end))

-- ui hanlder
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Frame_3 = Instance.new("Frame")
local Tabs = Instance.new("Folder")
local Tab1 = Instance.new("TextButton")
local Tab2 = Instance.new("TextButton")
local Tab3 = Instance.new("TextButton")
local Boxs = Instance.new("Folder")
local Tab1_2 = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local Toggle = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local Slider = Instance.new("Frame")
local Button = Instance.new("ImageButton")
local TextLabel_3 = Instance.new("TextLabel")
local Toggle2 = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local Dropdown = Instance.new("TextButton")
local Select1 = Instance.new("TextButton")
local Select2 = Instance.new("TextButton")
local Slider_2 = Instance.new("Frame")
local Button_2 = Instance.new("ImageButton")
local TextLabel_4 = Instance.new("TextLabel")
local Toggle3 = Instance.new("TextLabel")
local TextButton_3 = Instance.new("TextButton")
local Slider_3 = Instance.new("Frame")
local Button_3 = Instance.new("ImageButton")
local TextLabel_5 = Instance.new("TextLabel")
local Toggle4 = Instance.new("TextLabel")
local TextButton_4 = Instance.new("TextButton")
local Tab2_2 = Instance.new("Frame")
local TextLabel_6 = Instance.new("TextLabel")
local Button_4 = Instance.new("TextButton")
local Toggle_2 = Instance.new("TextLabel")
local TextButton_5 = Instance.new("TextButton")
local Slider_4 = Instance.new("Frame")
local Button_5 = Instance.new("ImageButton")
local TextLabel_7 = Instance.new("TextLabel")
local Tab3_2 = Instance.new("Frame")
local TextLabel_8 = Instance.new("TextLabel")
local Toggle_3 = Instance.new("TextLabel")
local TextButton_6 = Instance.new("TextButton")
local Toggle2_2 = Instance.new("TextLabel")
local TextButton_7 = Instance.new("TextButton")
local Toggle3_2 = Instance.new("TextLabel")
local TextButton_8 = Instance.new("TextButton")
local Toggle4_2 = Instance.new("TextLabel")
local TextButton_9 = Instance.new("TextButton")
local Toggle5 = Instance.new("TextLabel")
local TextButton_10 = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 1

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 255)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.348816842, 0, 0.22870478, 0)
Frame.Size = UDim2.new(0, 345, 0, 465)
Frame.Draggable = true
Frame.Active = true

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 0, 0.0516129024, 0)
Frame_2.Size = UDim2.new(0, 345, 0, 2)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(0, 345, 0, 21)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Name - Game | User  - "
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

Frame_3.Parent = Frame
Frame_3.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 0.0924731195, 0)
Frame_3.Size = UDim2.new(0, 345, 0, 2)

Tabs.Name = "Tabs"
Tabs.Parent = Frame

Tab1.Name = "Tab1"
Tab1.Parent = Tabs
Tab1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tab1.BorderColor3 = Color3.fromRGB(0, 0, 127)
Tab1.BorderSizePixel = 2
Tab1.Position = UDim2.new(0, 0, 0.0541505553, 0)
Tab1.Size = UDim2.new(0, 70, 0, 19)
Tab1.Font = Enum.Font.SourceSans
Tab1.Text = "Combat"
Tab1.TextColor3 = Color3.fromRGB(0, 0, 255)
Tab1.TextScaled = true
Tab1.TextSize = 14.000
Tab1.TextWrapped = true

Tab2.Name = "Tab2"
Tab2.Parent = Tabs
Tab2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tab2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Tab2.BorderSizePixel = 2
Tab2.Position = UDim2.new(0.202898547, 0, 0.0541505553, 0)
Tab2.Size = UDim2.new(0, 70, 0, 19)
Tab2.Font = Enum.Font.SourceSans
Tab2.Text = "Visuals"
Tab2.TextColor3 = Color3.fromRGB(0, 0, 255)
Tab2.TextScaled = true
Tab2.TextSize = 14.000
Tab2.TextWrapped = true

Tab3.Name = "Tab3"
Tab3.Parent = Tabs
Tab3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tab3.BorderColor3 = Color3.fromRGB(0, 0, 255)
Tab3.BorderSizePixel = 2
Tab3.Position = UDim2.new(0.4173913, 0, 0.054150559, 0)
Tab3.Size = UDim2.new(0, 70, 0, 19)
Tab3.Font = Enum.Font.SourceSans
Tab3.Text = "Esp"
Tab3.TextColor3 = Color3.fromRGB(0, 0, 255)
Tab3.TextScaled = true
Tab3.TextSize = 14.000
Tab3.TextWrapped = true

Boxs.Name = "Boxs"
Boxs.Parent = Frame

Tab1_2.Name = "Tab1"
Tab1_2.Parent = Boxs
Tab1_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tab1_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Tab1_2.BorderSizePixel = 2
Tab1_2.Position = UDim2.new(0.0289855078, 0, 0.154838711, 0)
Tab1_2.Size = UDim2.new(0, 146, 0, 384)
Tab1_2.Visible = false

TextLabel_2.Parent = Tab1_2
TextLabel_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_2.BorderSizePixel = 2
TextLabel_2.Position = UDim2.new(0, 0, -0.0445026197, 0)
TextLabel_2.Size = UDim2.new(0, 85, 0, 17)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "Aimbot"
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 30.000
TextLabel_2.TextWrapped = true

Toggle.Name = "Toggle"
Toggle.Parent = Tab1_2
Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle.BorderSizePixel = 2
Toggle.Position = UDim2.new(0.0521738231, 0, 0.0206778347, 0)
Toggle.Size = UDim2.new(0, 129, 0, 17)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = " Enabled"
Toggle.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle.TextScaled = true
Toggle.TextSize = 14.000
Toggle.TextWrapped = true
Toggle.TextXAlignment = Enum.TextXAlignment.Left

TextButton.Parent = Toggle
TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton.Size = UDim2.new(0, 20, 0, 17)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = " "
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 14.000

Slider.Name = "Slider"
Slider.Parent = Tab1_2
Slider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Slider.BorderColor3 = Color3.fromRGB(0, 0, 255)
Slider.BorderSizePixel = 2
Slider.Position = UDim2.new(0.0521739796, 0, 0.278378963, -10)
Slider.Size = UDim2.new(0.883561552, 0, 0, 20)

Button.Name = "Button"
Button.Parent = Slider
Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button.BorderColor3 = Color3.fromRGB(0, 0, 255)
Button.BorderSizePixel = 2
Button.Position = UDim2.new(-0.0056656003, 0, 0, 0)
Button.Size = UDim2.new(-0.0360324904, 10, 1, 0)

TextLabel_3.Parent = Slider
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Size = UDim2.new(0, 129, 0, 20)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "Fov: 0"
TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

Toggle2.Name = "Toggle2"
Toggle2.Parent = Tab1_2
Toggle2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle2.BorderSizePixel = 2
Toggle2.Position = UDim2.new(0.045324564, 0, 0.182981491, 0)
Toggle2.Size = UDim2.new(0, 129, 0, 17)
Toggle2.Font = Enum.Font.SourceSans
Toggle2.Text = " Fov Visible"
Toggle2.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle2.TextScaled = true
Toggle2.TextSize = 14.000
Toggle2.TextWrapped = true
Toggle2.TextXAlignment = Enum.TextXAlignment.Left

TextButton_2.Parent = Toggle2
TextButton_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_2.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_2.Size = UDim2.new(0, 20, 0, 17)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = " "
TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.TextSize = 14.000

Dropdown.Name = "Dropdown"
Dropdown.Parent = Tab1_2
Dropdown.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 255)
Dropdown.BorderSizePixel = 2
Dropdown.Position = UDim2.new(0.0479452349, 0, 0.0994764268, 0)
Dropdown.Size = UDim2.new(0, 129, 0, 19)
Dropdown.Font = Enum.Font.SourceSans
Dropdown.Text = "Target Part"
Dropdown.TextColor3 = Color3.fromRGB(0, 0, 255)
Dropdown.TextScaled = true
Dropdown.TextSize = 14.000
Dropdown.TextWrapped = true
Dropdown.TextXAlignment = Enum.TextXAlignment.Left

Select1.Name = "Select1"
Select1.Parent = Dropdown
Select1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Select1.BorderColor3 = Color3.fromRGB(0, 0, 127)
Select1.BorderSizePixel = 2
Select1.Position = UDim2.new(-0.00631833076, 0, 1.39639044, 0)
Select1.Size = UDim2.new(0, 129, 0, 19)
Select1.Visible = false
Select1.ZIndex = 5
Select1.Font = Enum.Font.SourceSans
Select1.Text = "Head"
Select1.TextColor3 = Color3.fromRGB(0, 0, 255)
Select1.TextScaled = true
Select1.TextSize = 14.000
Select1.TextWrapped = true

Select2.Name = "Select2"
Select2.Parent = Dropdown
Select2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Select2.BorderColor3 = Color3.fromRGB(0, 0, 127)
Select2.BorderSizePixel = 2
Select2.Position = UDim2.new(-0.00631833076, 0, 2.76481152, 0)
Select2.Size = UDim2.new(0, 129, 0, 19)
Select2.Visible = false
Select2.ZIndex = 6
Select2.Font = Enum.Font.SourceSans
Select2.Text = "HumanoidRootPart"
Select2.TextColor3 = Color3.fromRGB(0, 0, 255)
Select2.TextScaled = true
Select2.TextSize = 14.000
Select2.TextWrapped = true

Slider_2.Name = "Slider"
Slider_2.Parent = Tab1_2
Slider_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Slider_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Slider_2.BorderSizePixel = 2
Slider_2.Position = UDim2.new(0.0521739796, 0, 0.367384195, -10)
Slider_2.Size = UDim2.new(0.883561552, 0, 0, 20)

Button_2.Name = "Button"
Button_2.Parent = Slider_2
Button_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Button_2.BorderSizePixel = 2
Button_2.Position = UDim2.new(-0.0056656003, 0, 0, 0)
Button_2.Size = UDim2.new(-0.0360324904, 10, 1, 0)

TextLabel_4.Parent = Slider_2
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Position = UDim2.new(-5.58793545e-09, 0, 0, 0)
TextLabel_4.Size = UDim2.new(0, 129, 0, 20)
TextLabel_4.Font = Enum.Font.SourceSans
TextLabel_4.Text = "Fov Sides: 3"
TextLabel_4.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true

Toggle3.Name = "Toggle3"
Toggle3.Parent = Tab1_2
Toggle3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle3.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle3.BorderSizePixel = 2
Toggle3.Position = UDim2.new(0.052173879, 0, 0.418583602, 0)
Toggle3.Size = UDim2.new(0, 129, 0, 17)
Toggle3.Font = Enum.Font.SourceSans
Toggle3.Text = " Aimlock"
Toggle3.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle3.TextScaled = true
Toggle3.TextSize = 14.000
Toggle3.TextWrapped = true
Toggle3.TextXAlignment = Enum.TextXAlignment.Left

TextButton_3.Parent = Toggle3
TextButton_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_3.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_3.Size = UDim2.new(0, 20, 0, 17)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = " "
TextButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_3.TextSize = 14.000

Slider_3.Name = "Slider"
Slider_3.Parent = Tab1_2
Slider_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Slider_3.BorderColor3 = Color3.fromRGB(0, 0, 255)
Slider_3.BorderSizePixel = 2
Slider_3.Position = UDim2.new(0.0521739796, 0, 0.519216716, -10)
Slider_3.Size = UDim2.new(0.883561552, 0, 0, 20)

Button_3.Name = "Button"
Button_3.Parent = Slider_3
Button_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button_3.BorderColor3 = Color3.fromRGB(0, 0, 255)
Button_3.BorderSizePixel = 2
Button_3.Position = UDim2.new(-0.0056656003, 0, 0, 0)
Button_3.Size = UDim2.new(-0.0360324904, 10, 1, 0)

TextLabel_5.Parent = Slider_3
TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.BackgroundTransparency = 1.000
TextLabel_5.Position = UDim2.new(0.0310077667, 0, 0, 0)
TextLabel_5.Size = UDim2.new(0, 129, 0, 20)
TextLabel_5.Font = Enum.Font.SourceSans
TextLabel_5.Text = "Smoothness: 0"
TextLabel_5.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_5.TextScaled = true
TextLabel_5.TextSize = 14.000
TextLabel_5.TextWrapped = true

Toggle4.Name = "Toggle4"
Toggle4.Parent = Tab1_2
Toggle4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle4.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle4.BorderSizePixel = 2
Toggle4.Position = UDim2.new(0.052173879, 0, 0.572229445, 0)
Toggle4.Size = UDim2.new(0, 129, 0, 17)
Toggle4.Font = Enum.Font.SourceSans
Toggle4.Text = " Teamcheck"
Toggle4.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle4.TextScaled = true
Toggle4.TextSize = 14.000
Toggle4.TextWrapped = true
Toggle4.TextXAlignment = Enum.TextXAlignment.Left

TextButton_4.Parent = Toggle4
TextButton_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_4.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_4.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_4.Size = UDim2.new(0, 20, 0, 17)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = " "
TextButton_4.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_4.TextSize = 14.000

Tab2_2.Name = "Tab2"
Tab2_2.Parent = Boxs
Tab2_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tab2_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Tab2_2.BorderSizePixel = 2
Tab2_2.Position = UDim2.new(0.0289855078, 0, 0.154838711, 0)
Tab2_2.Size = UDim2.new(0, 146, 0, 382)
Tab2_2.Visible = false

TextLabel_6.Parent = Tab2_2
TextLabel_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_6.BorderSizePixel = 2
TextLabel_6.Position = UDim2.new(0, 0, -0.0445026197, 0)
TextLabel_6.Size = UDim2.new(0, 85, 0, 17)
TextLabel_6.Font = Enum.Font.SourceSans
TextLabel_6.Text = "Lighting"
TextLabel_6.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_6.TextScaled = true
TextLabel_6.TextSize = 30.000
TextLabel_6.TextWrapped = true

Button_4.Name = "Button"
Button_4.Parent = Tab2_2
Button_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button_4.BorderColor3 = Color3.fromRGB(0, 0, 255)
Button_4.BorderSizePixel = 2
Button_4.Position = UDim2.new(0.0410956815, 0, 0.018324554, 0)
Button_4.Size = UDim2.new(0, 129, 0, 19)
Button_4.Font = Enum.Font.SourceSans
Button_4.Text = "Fullbright"
Button_4.TextColor3 = Color3.fromRGB(0, 0, 255)
Button_4.TextScaled = true
Button_4.TextSize = 14.000
Button_4.TextWrapped = true

Toggle_2.Name = "Toggle"
Toggle_2.Parent = Tab2_2
Toggle_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle_2.BorderSizePixel = 2
Toggle_2.Position = UDim2.new(0.0384751931, 0, 0.0992118642, 0)
Toggle_2.Size = UDim2.new(0, 129, 0, 17)
Toggle_2.Font = Enum.Font.SourceSans
Toggle_2.Text = " Fog"
Toggle_2.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle_2.TextScaled = true
Toggle_2.TextSize = 14.000
Toggle_2.TextWrapped = true
Toggle_2.TextXAlignment = Enum.TextXAlignment.Left

TextButton_5.Parent = Toggle_2
TextButton_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_5.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_5.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_5.Size = UDim2.new(0, 20, 0, 17)
TextButton_5.Font = Enum.Font.SourceSans
TextButton_5.Text = " "
TextButton_5.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_5.TextSize = 14.000

Slider_4.Name = "Slider"
Slider_4.Parent = Tab2_2
Slider_4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Slider_4.BorderColor3 = Color3.fromRGB(0, 0, 255)
Slider_4.BorderSizePixel = 2
Slider_4.Position = UDim2.new(0.0384753495, 0, 0.207698405, -10)
Slider_4.Size = UDim2.new(0.883561552, 0, 0, 20)

Button_5.Name = "Button"
Button_5.Parent = Slider_4
Button_5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button_5.BorderColor3 = Color3.fromRGB(0, 0, 255)
Button_5.BorderSizePixel = 2
Button_5.Position = UDim2.new(-0.0056656003, 0, 0, 0)
Button_5.Size = UDim2.new(-0.0360324904, 10, 1, 0)

TextLabel_7.Parent = Slider_4
TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.BackgroundTransparency = 1.000
TextLabel_7.Position = UDim2.new(-0.00775194168, 0, 0, 0)
TextLabel_7.Size = UDim2.new(0, 129, 0, 20)
TextLabel_7.Font = Enum.Font.SourceSans
TextLabel_7.Text = "Fog: 0"
TextLabel_7.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_7.TextScaled = true
TextLabel_7.TextSize = 14.000
TextLabel_7.TextWrapped = true

Tab3_2.Name = "Tab3"
Tab3_2.Parent = Boxs
Tab3_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Tab3_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Tab3_2.BorderSizePixel = 2
Tab3_2.Position = UDim2.new(0.0289855078, 0, 0.154838711, 0)
Tab3_2.Size = UDim2.new(0, 146, 0, 382)
Tab3_2.Visible = false

TextLabel_8.Parent = Tab3_2
TextLabel_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_8.BorderSizePixel = 2
TextLabel_8.Position = UDim2.new(0, 0, -0.0445026197, 0)
TextLabel_8.Size = UDim2.new(0, 85, 0, 17)
TextLabel_8.Font = Enum.Font.SourceSans
TextLabel_8.Text = "Main"
TextLabel_8.TextColor3 = Color3.fromRGB(0, 0, 255)
TextLabel_8.TextScaled = true
TextLabel_8.TextSize = 30.000
TextLabel_8.TextWrapped = true

Toggle_3.Name = "Toggle"
Toggle_3.Parent = Tab3_2
Toggle_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle_3.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle_3.BorderSizePixel = 2
Toggle_3.Position = UDim2.new(0.0384751931, 0, 0.0232956335, 0)
Toggle_3.Size = UDim2.new(0, 129, 0, 17)
Toggle_3.Font = Enum.Font.SourceSans
Toggle_3.Text = "Enabled"
Toggle_3.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle_3.TextScaled = true
Toggle_3.TextSize = 14.000
Toggle_3.TextWrapped = true
Toggle_3.TextXAlignment = Enum.TextXAlignment.Left

TextButton_6.Parent = Toggle_3
TextButton_6.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_6.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_6.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_6.Size = UDim2.new(0, 20, 0, 17)
TextButton_6.Font = Enum.Font.SourceSans
TextButton_6.Text = " "
TextButton_6.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_6.TextSize = 14.000

Toggle2_2.Name = "Toggle2"
Toggle2_2.Parent = Tab3_2
Toggle2_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle2_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle2_2.BorderSizePixel = 2
Toggle2_2.Position = UDim2.new(0.0384751931, 0, 0.104447454, 0)
Toggle2_2.Size = UDim2.new(0, 129, 0, 17)
Toggle2_2.Font = Enum.Font.SourceSans
Toggle2_2.Text = "Boxes"
Toggle2_2.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle2_2.TextScaled = true
Toggle2_2.TextSize = 14.000
Toggle2_2.TextWrapped = true
Toggle2_2.TextXAlignment = Enum.TextXAlignment.Left

TextButton_7.Parent = Toggle2_2
TextButton_7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_7.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_7.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_7.Size = UDim2.new(0, 20, 0, 17)
TextButton_7.Font = Enum.Font.SourceSans
TextButton_7.Text = " "
TextButton_7.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_7.TextSize = 14.000

Toggle3_2.Name = "Toggle3"
Toggle3_2.Parent = Tab3_2
Toggle3_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle3_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle3_2.BorderSizePixel = 2
Toggle3_2.Position = UDim2.new(0.0384751931, 0, 0.188217103, 0)
Toggle3_2.Size = UDim2.new(0, 129, 0, 17)
Toggle3_2.Font = Enum.Font.SourceSans
Toggle3_2.Text = "Names"
Toggle3_2.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle3_2.TextScaled = true
Toggle3_2.TextSize = 14.000
Toggle3_2.TextWrapped = true
Toggle3_2.TextXAlignment = Enum.TextXAlignment.Left

TextButton_8.Parent = Toggle3_2
TextButton_8.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_8.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_8.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_8.Size = UDim2.new(0, 20, 0, 17)
TextButton_8.Font = Enum.Font.SourceSans
TextButton_8.Text = " "
TextButton_8.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_8.TextSize = 14.000

Toggle4_2.Name = "Toggle4"
Toggle4_2.Parent = Tab3_2
Toggle4_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle4_2.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle4_2.BorderSizePixel = 2
Toggle4_2.Position = UDim2.new(0.0384751931, 0, 0.277222335, 0)
Toggle4_2.Size = UDim2.new(0, 129, 0, 17)
Toggle4_2.Font = Enum.Font.SourceSans
Toggle4_2.Text = "Tracers"
Toggle4_2.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle4_2.TextScaled = true
Toggle4_2.TextSize = 14.000
Toggle4_2.TextWrapped = true
Toggle4_2.TextXAlignment = Enum.TextXAlignment.Left

TextButton_9.Parent = Toggle4_2
TextButton_9.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_9.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_9.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_9.Size = UDim2.new(0, 20, 0, 17)
TextButton_9.Font = Enum.Font.SourceSans
TextButton_9.Text = " "
TextButton_9.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_9.TextSize = 14.000

Toggle5.Name = "Toggle5"
Toggle5.Parent = Tab3_2
Toggle5.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle5.BorderColor3 = Color3.fromRGB(0, 0, 255)
Toggle5.BorderSizePixel = 2
Toggle5.Position = UDim2.new(0.0384751931, 0, 0.360991955, 0)
Toggle5.Size = UDim2.new(0, 129, 0, 17)
Toggle5.Font = Enum.Font.SourceSans
Toggle5.Text = "Teamcheck"
Toggle5.TextColor3 = Color3.fromRGB(0, 0, 255)
Toggle5.TextScaled = true
Toggle5.TextSize = 14.000
Toggle5.TextWrapped = true
Toggle5.TextXAlignment = Enum.TextXAlignment.Left

TextButton_10.Parent = Toggle5
TextButton_10.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextButton_10.BorderColor3 = Color3.fromRGB(0, 0, 255)
TextButton_10.Position = UDim2.new(0.841491699, 0, 0, 0)
TextButton_10.Size = UDim2.new(0, 20, 0, 17)
TextButton_10.Font = Enum.Font.SourceSans
TextButton_10.Text = " "
TextButton_10.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_10.TextSize = 14.000

-- Scripts:

local function AWOGY_fake_script() -- TextLabel.LocalScript 
	local script = Instance.new('LocalScript', TextLabel)

	UserId = game:GetService("Players").LocalPlayer.UserId
	gamename = "Universal"
	Extra = " - " .. gamename .. " | " .. "UserID" .. " - " .. UserId
	
	while true do
		script.parent.Text = "G" .. Extra
		wait(0.5)
		script.parent.Text = "Go" .. Extra
		wait(0.5)
		script.parent.Text = "Gor" .. Extra
		wait(0.5)
		script.parent.Text = "Gori" .. Extra
		wait(0.5)
		script.parent.Text = "Goril" .. Extra
		wait(0.5)
		script.parent.Text = "Gorill" .. Extra
		wait(0.5)
		script.parent.Text = "Gorilla" .. Extra
		wait(0.5)
		script.parent.Text = "GorillaH" .. Extra
		wait(0.5)
		script.parent.Text = "GorillaHo" .. Extra
		wait(0.5)
		script.parent.Text = "GorillaHoo" .. Extra
		wait(0.5)
		script.parent.Text = "GorillaHook" .. Extra
		wait(0.5)
		script.parent.Text = "                       " .. Extra
		wait(0.5)
		script.parent.Text = "GorillaHook" .. Extra
		wait(0.5)
		script.parent.Text = "                       " .. Extra
		wait(0.5)
		script.parent.Text = "GorillaHook" .. Extra
		wait(0.5)
	end
end
coroutine.wrap(AWOGY_fake_script)()
local function QRNLKAF_fake_script() -- Tab1.LocalScript 
	local script = Instance.new('LocalScript', Tab1)

	script.parent.MouseButton1Click:Connect(function()
		script.parent.BorderColor3 = Color3.fromRGB(0, 0, 127)
		for i,v in pairs(script.parent.parent:GetChildren()) do
			if v.Name ~= script.parent.Name then
				v.BorderColor3 = Color3.fromRGB(0, 0, 255)
			end
		end
		for i,v in pairs(script.parent.parent.parent.Boxs:GetChildren()) do
			if v.Name == "Tab1"--[[ .. " left" or "Tab1" .. " right"]] then
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end)
end
coroutine.wrap(QRNLKAF_fake_script)()
local function RDHRTFN_fake_script() -- Tab2.LocalScript 
	local script = Instance.new('LocalScript', Tab2)

	script.parent.MouseButton1Click:Connect(function()
		script.parent.BorderColor3 = Color3.fromRGB(0, 0, 127)
		for i,v in pairs(script.parent.parent:GetChildren()) do
			if v.Name ~= script.parent.Name then
				v.BorderColor3 = Color3.fromRGB(0, 0, 255)
			end
		end
		for i,v in pairs(script.parent.parent.parent.Boxs:GetChildren()) do
			if v.Name == "Tab2"--[[ .. " left" or "Tab1" .. " right"]] then
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end)
end
coroutine.wrap(RDHRTFN_fake_script)()
local function RBUTKEF_fake_script() -- Tab3.LocalScript 
	local script = Instance.new('LocalScript', Tab3)

	script.parent.MouseButton1Click:Connect(function()
		script.parent.BorderColor3 = Color3.fromRGB(0, 0, 127)
		for i,v in pairs(script.parent.parent:GetChildren()) do
			if v.Name ~= script.parent.Name then
				v.BorderColor3 = Color3.fromRGB(0, 0, 255)
			end
		end
		for i,v in pairs(script.parent.parent.parent.Boxs:GetChildren()) do
			if v.Name == "Tab3"--[[ .. " left" or "Tab1" .. " right"]] then
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end)
end

coroutine.wrap(RBUTKEF_fake_script)()
local function TRWT_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)

	--false --  aimbot enabled
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		_G.AimbotON = false
	else
		print("true")
		_G.AimbotON = true
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			_G.AimbotON = true
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			_G.AimbotON = false
		end
	end)
end
coroutine.wrap(TRWT_fake_script)()
local function SGOAG_fake_script() -- Slider.Handler 
	local script = Instance.new('LocalScript', Slider)

	local Slider = script.Parent -- fov slider
	local SliderBtn = Slider.Button
	local Player = game:GetService("Players").LocalPlayer
	local UIS = game:GetService("UserInputService")
	local RuS = game:GetService("RunService")
	
	-- Properties
	local held = false
	local step = 0.01 -- how much each time 0.001 = 1
	local percentage = 0
	
	function snap(number, factor)
		if factor == 0 then
			return number
		else
			return math.floor(number/factor+0.5)*factor
		end
	end
	
	UIS.InputEnded:connect(function(input, processed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			held = false
		end
	end)
	
	SliderBtn.MouseButton1Down:connect(function()
		held = true
	end)
	
	RuS.RenderStepped:connect(function(delta)
		if held then
			local MousePos = UIS:GetMouseLocation().X
			local BtnPos = SliderBtn.Position
			local SliderSize = Slider.AbsoluteSize.X
			local SliderPos = Slider.AbsolutePosition.X
			local pos = snap((MousePos-SliderPos)/SliderSize,step)
			percentage = math.clamp(pos,0,1)
			SliderBtn.Position = UDim2.new(percentage,0,BtnPos.Y.Scale, BtnPos.Y.Offset)
			script.Parent.TextLabel.Text = "Fov: " .. math.floor(percentage * 1000)
			_G.CircleRadius = math.floor(percentage * 1000)
		end
	end)
end

coroutine.wrap(SGOAG_fake_script)()
local function IWEOKJ_fake_script() -- TextButton_2.LocalScript 
	local script = Instance.new('LocalScript', TextButton_2)

	--false fov visible
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		_G.CircleVisible = false
	else
		print("true")
		_G.CircleVisible = true
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			_G.CircleVisible = true
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			_G.CircleVisible = false
		end
	end)
end

coroutine.wrap(IWEOKJ_fake_script)()
local function NALD_fake_script() -- Dropdown.LocalScript 
	local script = Instance.new('LocalScript', Dropdown)

	for i,v in pairs(script.parent:GetChildren()) do -- hit part
		if v.Name == "Select1" or v.Name == "Select2" or v.Name == "Select3" or v.Name == "Select4" then
			v.Visible = false
		end
	end
	
	script.parent.MouseButton1Click:Connect(function()
		for i,v in pairs(script.parent:GetChildren()) do
			if v.Name == "Select1" or v.Name == "Select2" or v.Name == "Select3" or v.Name == "Select4" then
				if v.Visible == false then
					v.Visible = true
				else
					v.Visible = false
				end
			end
		end
	end)
end
coroutine.wrap(NALD_fake_script)()
local function MRXY_fake_script() -- Select1.LocalScript 
	local script = Instance.new('LocalScript', Select1)

	script.parent.MouseButton1Click:Connect(function() -- Head
		script.Parent.Parent.Text = script.parent.Text
		_G.AimPart = "Head"
	end)
end
coroutine.wrap(MRXY_fake_script)()
local function GGUGFA_fake_script() -- Select2.LocalScript 
	local script = Instance.new('LocalScript', Select2)

	script.parent.MouseButton1Click:Connect(function() -- Humanoid root part
		script.Parent.Parent.Text = script.parent.Text
		_G.TeamCheck = false
		_G.AimPart = "HumanoidRootPart"
	end)
end
coroutine.wrap(GGUGFA_fake_script)()
local function KFRNHCI_fake_script() -- Slider_2.Handler 
	local script = Instance.new('LocalScript', Slider_2)

	local Slider = script.Parent -- fov sides
	local SliderBtn = Slider.Button
	local Player = game:GetService("Players").LocalPlayer
	local UIS = game:GetService("UserInputService")
	local RuS = game:GetService("RunService")
	
	-- Properties
	local held = false
	local step = 0.01 -- how much each time 0.001 = 1
	local percentage = 0.003
	
	function snap(number, factor)
		if factor == 0 then
			return number
		else
			return math.floor(number/factor+0.5)*factor
		end
	end
	
	UIS.InputEnded:connect(function(input, processed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			held = false
		end
	end)
	
	SliderBtn.MouseButton1Down:connect(function()
		held = true
	end)
	
	RuS.RenderStepped:connect(function(delta)
		if held then
			local MousePos = UIS:GetMouseLocation().X
			local BtnPos = SliderBtn.Position
			local SliderSize = Slider.AbsoluteSize.X
			local SliderPos = Slider.AbsolutePosition.X
			local pos = snap((MousePos-SliderPos)/SliderSize,step)
			percentage = math.clamp(pos,0,1)
			SliderBtn.Position = UDim2.new(percentage,0,BtnPos.Y.Scale, BtnPos.Y.Offset)
			script.Parent.TextLabel.Text = "Fov Sides: " .. math.floor(percentage * 100)
			_G.CircleSides = math.floor(percentage * 100)
		end
	end)
end

coroutine.wrap(KFRNHCI_fake_script)()
local function SXAPE_fake_script() -- TextButton_3.LocalScript 
	local script = Instance.new('LocalScript', TextButton_3)

	--false aimlock toggle
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		_G.Sensitivity = smooththing
	else
		print("true")
		resume(create(function()
			while script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 127) do
				_G.Sensitivity = 0
				wait()
			end
		end))
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			resume(create(function()
				while script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 127) do
					_G.Sensitivity = 0
					wait()
				end
			end))
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			_G.Sensitivity = smooththing
		end
	end)
end
coroutine.wrap(SXAPE_fake_script)()
local function AEBIO_fake_script() -- Slider_3.Handler 
	local script = Instance.new('LocalScript', Slider_3)

	local Slider = script.Parent -- aimbot smoothness
	local SliderBtn = Slider.Button
	local Player = game:GetService("Players").LocalPlayer
	local UIS = game:GetService("UserInputService")
	local RuS = game:GetService("RunService")
	
	-- Properties
	local held = false
	local step = 0.01 -- how much each time 0.001 = 1
	local percentage = 0.001
	
	function snap(number, factor)
		if factor == 0 then
			return number
		else
			return math.floor(number/factor+0.5)*factor
		end
	end
	
	UIS.InputEnded:connect(function(input, processed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			held = false
		end
	end)
	
	SliderBtn.MouseButton1Down:connect(function()
		held = true
	end)
	
	RuS.RenderStepped:connect(function(delta)
		if held then
			local MousePos = UIS:GetMouseLocation().X
			local BtnPos = SliderBtn.Position
			local SliderSize = Slider.AbsoluteSize.X
			local SliderPos = Slider.AbsolutePosition.X
			local pos = snap((MousePos-SliderPos)/SliderSize,step)
			percentage = math.clamp(pos,0,1)
			SliderBtn.Position = UDim2.new(percentage,0,BtnPos.Y.Scale, BtnPos.Y.Offset)
			script.Parent.TextLabel.Text = "Smoothness: " .. math.floor(percentage * 10)
			smooththing = math.floor(percentage * 10)
			if _G.Sensitivity then
				_G.Sensitivity = math.floor(percentage * 10)
			else
				_G.Sensitivity = 0
				print("Fixed Sensitivity Value Nil: " .. _G.Sensitivity)
			end
		end
	end)
end
coroutine.wrap(AEBIO_fake_script)()
local function CMLVY_fake_script() -- TextButton_4.LocalScript 
	local script = Instance.new('LocalScript', TextButton_4)

	--false teamcheck
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		_G.TeamCheck = false
	else
		print("true")
		_G.TeamCheck = true
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			_G.TeamCheck = true
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			_G.TeamCheck = false
		end
	end)
end
coroutine.wrap(CMLVY_fake_script)()
local function TTDPZ_fake_script() -- Button_4.LocalScript 
	local script = Instance.new('LocalScript', Button_4)

	script.parent.MouseButton1Click:Connect(function() -- full bright button
		print("Pushed")
	end)
end
coroutine.wrap(TTDPZ_fake_script)()
local function MGOZLSP_fake_script() -- TextButton_5.LocalScript 
	local script = Instance.new('LocalScript', TextButton_5)

	--false fog toggle
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		--set variable to false
	else
		print("true")
		--set variable true
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			--set variable true
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			--set variable to false
		end
	end)
end
coroutine.wrap(MGOZLSP_fake_script)()
local function VSXE_fake_script() -- Slider_4.Handler 
	local script = Instance.new('LocalScript', Slider_4)

	local Slider = script.Parent -- fog slider
	local SliderBtn = Slider.Button
	local Player = game:GetService("Players").LocalPlayer
	local UIS = game:GetService("UserInputService")
	local RuS = game:GetService("RunService")
	
	-- Properties
	local held = false
	local step = 0.01 -- how much each time 0.001 = 1
	local percentage = 0.003
	
	function snap(number, factor)
		if factor == 0 then
			return number
		else
			return math.floor(number/factor+0.5)*factor
		end
	end
	
	UIS.InputEnded:connect(function(input, processed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			held = false
		end
	end)
	
	SliderBtn.MouseButton1Down:connect(function()
		held = true
	end)
	
	RuS.RenderStepped:connect(function(delta)
		if held then
			local MousePos = UIS:GetMouseLocation().X
			local BtnPos = SliderBtn.Position
			local SliderSize = Slider.AbsoluteSize.X
			local SliderPos = Slider.AbsolutePosition.X
			local pos = snap((MousePos-SliderPos)/SliderSize,step)
			percentage = math.clamp(pos,0,1)
			SliderBtn.Position = UDim2.new(percentage,0,BtnPos.Y.Scale, BtnPos.Y.Offset)
			script.Parent.TextLabel.Text = "Fog: " .. math.floor(percentage * 10)
			-- change the value
		end
	end)
end
coroutine.wrap(VSXE_fake_script)()
local function WRFSCVF_fake_script() -- TextButton_6.LocalScript 
	local script = Instance.new('LocalScript', TextButton_6)

	--false esp enabled
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		--set variable to false
		ESP:Toggle(false)

	else
		print("true")
		ESP:Toggle(true)
		--set variable true
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			ESP:Toggle(true)
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			ESP:Toggle(false)
		end
	end)
end
coroutine.wrap(WRFSCVF_fake_script)()
local function CATT_fake_script() -- TextButton_7.LocalScript 
	local script = Instance.new('LocalScript', TextButton_7)

	--false esp boxes
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		ESP.Boxes = false
	else
		print("true")
		ESP.Boxes = true
	end

	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			ESP.Boxes = true
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			ESP.Boxes = false
		end
	end)
end
coroutine.wrap(CATT_fake_script)()
local function NKWDXB_fake_script() -- TextButton_8.LocalScript 
	local script = Instance.new('LocalScript', TextButton_8)

	--false name esp
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		ESP.Names = false
	else
		print("true")
		ESP.Names = true
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			ESP.Names = true
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			ESP.Names = false
		end
	end)
end
coroutine.wrap(NKWDXB_fake_script)()
local function JKXSAX_fake_script() -- TextButton_9.LocalScript 
	local script = Instance.new('LocalScript', TextButton_9)

	--false tracers
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		ESP.Tracers = false
	else
		print("true")
		ESP.Tracers = true
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			ESP.Tracers = true
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			ESP.Tracers = false
		end
	end)
end
coroutine.wrap(JKXSAX_fake_script)()
local function LWLY_fake_script() -- TextButton_10.LocalScript 
	local script = Instance.new('LocalScript', TextButton_10)

	--false teamcheck
	script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	--true
	--script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
	
	if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
		print("false")
		ESP.TeamMates = true
	else
		print("true")
		ESP.TeamMates = false
	end
	
	script.parent.MouseButton1Click:Connect(function()
		if script.parent.BackgroundColor3 == Color3.fromRGB(0, 0, 0) then
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 127)
			print("true")
			ESP.TeamMates = false
		else
			script.parent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			print("false")
			ESP.TeamMates = true
		end
	end)
end
coroutine.wrap(LWLY_fake_script)()
local function PMIYBUM_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	for i,v in pairs(script.parent.Boxs:GetChildren()) do
		if v.Name == "Tab1"--[[ .. " left" or "Tab1" .. " right"]] then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end
coroutine.wrap(PMIYBUM_fake_script)()
local function SJLS_fake_script() -- Frame.Keybind hander 
	local script = Instance.new('LocalScript', Frame)

	--keybind thing
	
	local uis = game:GetService("UserInputService")
	
	uis.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.Insert then
			if script.parent.Visible == false then
				script.parent.Visible = true
			else
				script.parent.Visible = false
			end
		end
	end)
end
coroutine.wrap(SJLS_fake_script)()