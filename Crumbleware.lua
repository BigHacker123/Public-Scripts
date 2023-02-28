--Init
if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end
local resume = coroutine.resume
local create = coroutine.create
local version = 0.45
local Players = game:GetService("Players")
local FindFirstChild = game.FindFirstChild
local Camera = workspace.CurrentCamera
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local worldToViewportPoint = Camera.WorldToViewportPoint
local repstorage = game:GetService("ReplicatedStorage")
local UniversalTables = require(repstorage.Modules:WaitForChild("UniversalTables"))
local LOCAL_PLAYER = Players.LocalPlayer
local INPUT_SERVICE = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players     = game:GetService("Players")
local RunService  = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character
local zoomamount = 5
local RootPart    = Character:FindFirstChild("HumanoidRootPart")
local Heartbeat, RStepped, Stepped = RunService.Heartbeat, RunService.RenderStepped, RunService.Stepped
local RVelocity, YVelocity = nil, 0.5
local FlyToggle = false
local SpeedToggle = false
local Speed = 20
local FlySpeed = 20
local frames = 0
local LocalPlayerName = game.Players.LocalPlayer
local ValidTargetParts = {"Head", "HumanoidRootPart"}
local Drawingnew = Drawing.new
local Color3fromRGB = Color3.fromRGB
local Vector3new = Vector3.new
local Vector2new = Vector2.new
local mathfloor = math.floor
local BulletTracer = false
local mathceil = math.ceil
lastpostion = Vector3.new(0,0,0)
shoot = false
hitlog = false
local repStorage = game["ReplicatedStorage"]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedPlayers = ReplicatedStorage:FindFirstChild("Players")
local ESP, ESP_RenderStepped, Framework = loadstring(game:HttpGet('https://www.octohook.xyz/ionhub/ionhub_esp.lua'))()
local headshot_sound = Instance.new("Sound", game.CoreGui)
headshot_sound.Volume = 10
local bodyshot_sound = Instance.new("Sound", game.CoreGui)
bodyshot_sound.Volume = 10
local hit_sounds = {
    Neverlose = "rbxassetid://8726881116",
    Gamesense = "rbxassetid://4817809188",
    Bell = "rbxassetid://6534947240",
    Rust = "rbxassetid://1255040462",
    Minecraft = "rbxassetid://4018616850",
    Osu = "rbxassetid://7149255551",
    Weeb = "rbxassetid://6442965016",
}
local all_hit_sounds = {}
all_hit_sounds[1] = "None"
for i, v in pairs(hit_sounds) do
    all_hit_sounds[#all_hit_sounds + 1] = i
end
local function gs(a)
    return game:GetService(a);
end

function Beam(v1, v2)
    local colorSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1,  Color3.fromRGB(255, 0, 255)),
    })
    -- main part
    local Part = Instance.new("Part", Instance.new("Part", workspace))
    Part.Size = Vector3.new(1, 1, 1)
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CFrame = CFrame.new(v1)
    Part.Anchored = true
    -- attachment
    local Attachment = Instance.new("Attachment", Part)
    -- part 2
    local Part2 = Instance.new("Part", Instance.new("Part", workspace))
    Part2.Size = Vector3.new(1, 1, 1)
    Part2.Transparency =  1
    Part2.CanCollide = false
    Part2.CFrame = CFrame.new(v2)
    Part2.Anchored = true
    Part2.Color = Color3.fromRGB(255, 0, 255)
    -- another attachment
    local Attachment2 = Instance.new("Attachment", Part2)
    -- beam
    local Beam = Instance.new("Beam", Part)
    Beam.FaceCamera = true
    Beam.Color = colorSequence
    Beam.Attachment0 = Attachment
    Beam.Attachment1 = Attachment2
    Beam.LightEmission = 6
    Beam.LightInfluence = 1
    Beam.Width0 = 1
    Beam.Width1 = 0.6
    Beam.Texture = "rbxassetid://446111271"
    Beam.LightEmission = 1
    Beam.LightInfluence = 1
    Beam.TextureMode = Enum.TextureMode.Wrap -- wrap so length can be set by TextureLength
    Beam.TextureLength = 3 -- repeating texture is 1 stud long 
    Beam.TextureSpeed = 3
    delay(2, function()
    for i = 0.5, 1, 0.02 do
    wait()
    Beam.Transparency = NumberSequence.new(i)
    end
    Part:Destroy()
    Part2:Destroy()
    end)
end

function hitmarker()
    coroutine.wrap(function()
		if BulletTracer then
			local Line = Drawing.new("Line")
			local Line2 = Drawing.new("Line")
			local Line3 = Drawing.new("Line")
			local Line4 = Drawing.new("Line")

			local x, y = Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2

			Line.From = Vector2.new(x + 4, y + 4)
			Line.To = Vector2.new(x + 10, y + 10)
			Line.Color = Color3.fromRGB(255,255,255)
			Line.Visible = true 

			Line2.From = Vector2.new(x + 4, y - 4)
			Line2.To = Vector2.new(x + 10, y - 10)
			Line2.Color = Color3.fromRGB(255,255,255)
			Line2.Visible = true 

			Line3.From = Vector2.new(x - 4, y - 4)
			Line3.To = Vector2.new(x - 10, y - 10)
			Line3.Color = Color3.fromRGB(255,255,255)
			Line3.Visible = true 

			Line4.From = Vector2.new(x - 4, y + 4)
			Line4.To = Vector2.new(x - 10, y + 10)
			Line4.Color = Color3.fromRGB(255,255,255)
			Line4.Visible = true

			Line.Transparency = 1
			Line2.Transparency = 1
			Line3.Transparency = 1
			Line4.Transparency = 1

			Line.Thickness = 1
			Line2.Thickness = 1
			Line3.Thickness = 1
			Line4.Thickness = 1

			wait(0.3)
			for i = 1,0,-0.1 do
				wait()
				Line.Transparency = i 
				Line2.Transparency = i
				Line3.Transparency = i
				Line4.Transparency = i
			end
			Line:Remove()
			Line2:Remove()
			Line3:Remove()
			Line4:Remove()
		end
	end)()
end

------------------------------------------------- -- Private Script esp

--[Main Variables]

local plrs = game["Players"]
local rs = game["RunService"]

local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local camera = workspace.CurrentCamera
local worldToViewportPoint = camera.worldToViewportPoint

--[Optimisation Variables]

local Drawingnew = Drawing.new
local Color3fromRGB = Color3.fromRGB
local Vector3new = Vector3.new
local Vector2new = Vector2.new
local mathfloor = math.floor
local mathceil = math.ceil

--[Setup Table]

local esp = {
    players = {},
    objects = {},
    enabled = true,
    teamcheck = false,
    fontsize = 13,
    font = 2,
    maxdist = 0,
    settings = {
        name = {enabled = true, outline = true, displaynames = true, color = Color3fromRGB(255, 255, 255)},
        box = {enabled = false, outline = true, color = Color3fromRGB(255, 255, 255)},
        filledbox = {enabled = false, outline = true, transparency = 0.5, color = Color3fromRGB(255, 255, 255)},
        healthbar = {enabled = true, size = 3, outline = true},
        healthtext = {enabled = true, outline = true, color = Color3fromRGB(255, 255, 255)},
        distance = {enabled = true, outline = true, color = Color3fromRGB(255, 255, 255)},
        viewangle = {enabled = true, size = 6, color = Color3fromRGB(255, 255, 255)},
        skeleton = {enabled = true, color = Color3fromRGB(255, 255, 255)},
        tracer = {enabled = true, origin = "Middle", color = Color3fromRGB(255, 255, 255)}
    },
    settings_chams = {
        enabled = true,
        teamcheck = false,
        outline = false,
        fill_color = Color3fromRGB(255, 255, 255),
        outline_color = Color3fromRGB(0, 0, 0), 
        fill_transparency = 0,
        outline_transparency = 0,
        autocolor = true,
        visible_Color = Color3fromRGB(0, 255, 0),
        invisible_Color = Color3fromRGB(255, 0, 0),
    },
    customsettings = {

    }
}

esp.NewDrawing = function(type, properties)
    local newDrawing = Drawingnew(type)

    for i,v in next, properties or {} do
        newDrawing[i] = v
    end

    return newDrawing
end

esp.NewCham = function(properties)
    local newCham = Instance.new("Highlight", game.CoreGui)

    for i,v in next, properties or {} do
        newCham[i] = v
    end

    return newCham
end

esp.WallCheck = function(v)
    local ray = Ray.new(camera.CFrame.p, (v.Position - camera.CFrame.p).Unit * 300)
    local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {plr.Character, camera}, false, true)
    if part then
        local hum = part.Parent:FindFirstChildOfClass("Humanoid")
        if not hum then
            hum = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if hum and v and hum.Parent == v.Parent then
            local Vector, Visible = camera:WorldToScreenPoint(v.Position)
            if Visible then
                return true
            end
        end
    end
end

esp.TeamCheck = function(v)
    if plr.TeamColor == v.TeamColor then
        return false
    end

    return true
end

esp.GetEquippedTool = function(v)
    return (v.Character:FindFirstChildOfClass("Tool") and tostring(v.Character:FindFirstChildOfClass("Tool"))) or "Hands"
end

esp.NewPlayer = function(v)
    esp.players[v] = {
        name = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
        filledbox = esp.NewDrawing("Square", {Color = Color3fromRGB(255, 255, 255), Thickness = 1, Filled = true}),
        boxOutline = esp.NewDrawing("Square", {Color = Color3fromRGB(0, 0, 0), Thickness = 3}),
        box = esp.NewDrawing("Square", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
        healthBarOutline = esp.NewDrawing("Line", {Color = Color3fromRGB(0, 0, 0), Thickness = 3}),
        healthBar = esp.NewDrawing("Line", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
        healthText = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
        distance = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
        viewAngle = esp.NewDrawing("Line", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
        weapon = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
        tracer = esp.NewDrawing("Line", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
        cham = esp.NewCham({FillColor = esp.settings_chams.fill_color, OutlineColor = esp.settings_chams.outline_color, FillTransparency = esp.settings_chams.fill_transparency, OutlineTransparency = esp.settings_chams.outline_transparency})
    }
end

local esp_Loop
esp_Loop = rs.RenderStepped:Connect(function()
    for i,v in pairs(esp.players) do
        if i.Character and i.Character:FindFirstChild("Humanoid") and i.Character:FindFirstChild("HumanoidRootPart") and i.Character:FindFirstChild("Head") and i.Character:FindFirstChild("Humanoid").Health > 0 and (esp.maxdist == 0 or (i.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < esp.maxdist) then
            local hum = i.Character.Humanoid
            local hrp = i.Character.HumanoidRootPart
            local head = i.Character.Head

            local Vector, onScreen = camera:WorldToViewportPoint(i.Character.HumanoidRootPart.Position)
    
            local Size = (camera:WorldToViewportPoint(hrp.Position - Vector3new(0, 3, 0)).Y - camera:WorldToViewportPoint(hrp.Position + Vector3new(0, 2.6, 0)).Y) / 2
            local BoxSize = Vector2new(mathfloor(Size * 1.5), mathfloor(Size * 1.9))
            local BoxPos = Vector2new(mathfloor(Vector.X - Size * 1.5 / 2), mathfloor(Vector.Y - Size * 1.6 / 2))
    
            local BottomOffset = BoxSize.Y + BoxPos.Y + 1

            if onScreen and esp.settings_chams.enabled then
                v.cham.Adornee = i.Character
                v.cham.Enabled = esp.settings_chams.enabled
                v.cham.OutlineTransparency = esp.settings_chams.outline and esp.settings_chams.outline_transparency or 1
                v.cham.OutlineColor = esp.settings_chams.autocolor and esp.settings_chams.autocolor_outline and esp.WallCheck(i.Character.Head) and esp.settings_chams.visible_Color or esp.settings_chams.autocolor and esp.settings_chams.autocolor_outline and not esp.WallCheck(i.Character.Head) and esp.settings_chams.invisible_Color or esp.settings_chams.outline_color
                v.cham.FillColor = esp.settings_chams.autocolor and esp.WallCheck(i.Character.Head) and esp.settings_chams.visible_Color or esp.settings_chams.autocolor and not esp.WallCheck(i.Character.Head) and esp.settings_chams.invisible_Color or esp.settings_chams.fill_color
                v.cham.FillTransparency = esp.settings_chams.fill_transparency

                if esp.settings_chams.teamcheck then
                    if not esp.TeamCheck(i) then
                        v.cham.Enabled = false
                    end
                end
            else
                v.cham.Enabled = false
            end

            if esp.settings.tracer.enabled and esp.enabled then
                if esp.settings.tracer.origin == "Bottom" then
                    v.tracer.From = Vector2new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                elseif esp.settings.tracer.origin == "Top" then
                    v.tracer.From = Vector2new(workspace.CurrentCamera.ViewportSize.X / 2,0)
                elseif esp.settings.tracer.origin == "Middle" then
                    v.tracer.From = Vector2new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
                else
                    v.tracer.From = Vector2new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
                end

                v.tracer.To = Vector2new(Vector.X, Vector.Y)
                v.tracer.Color = esp.settings.tracer.color
                v.tracer.Visible = true
            else
                v.tracer.Visible = false
            end

            if onScreen and esp.enabled then
                if esp.settings.name.enabled then
                    v.name.Position = Vector2new(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
                    v.name.Outline = esp.settings.name.outline
                    v.name.Color = esp.settings.name.color

                    v.name.Font = esp.font
                    v.name.Size = esp.fontsize

                    if esp.settings.name.displaynames then
                        v.name.Text = i.DisplayName
                    else
                        v.name.Text = i.Name
                    end

                    v.name.Visible = true
                else
                    v.name.Visible = false
                end

                if esp.settings.distance.enabled and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    v.distance.Position = Vector2new(BoxSize.X / 2 + BoxPos.X, BottomOffset)
                    v.distance.Outline = esp.settings.distance.outline
                    v.distance.Text = "[" .. mathfloor((hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude) .. "m]"
                    v.distance.Color = esp.settings.distance.color
                    BottomOffset = BottomOffset + 15

                    v.distance.Font = esp.font
                    v.distance.Size = esp.fontsize

                    v.distance.Visible = true
                else
                    v.distance.Visible = false
                end

                if esp.settings.filledbox.enabled then
                    v.filledbox.Size = BoxSize + Vector2.new(-2, -2)
                    v.filledbox.Position = BoxPos + Vector2.new(1, 1)
                    v.filledbox.Color = esp.settings.filledbox.color
                    v.filledbox.Transparency = esp.settings.filledbox.transparency
                    v.filledbox.Visible = true
                else
                    v.filledbox.Visible = false
                end

                if esp.settings.box.enabled then
                    v.boxOutline.Size = BoxSize
                    v.boxOutline.Position = BoxPos
                    v.boxOutline.Visible = esp.settings.box.outline
    
                    v.box.Size = BoxSize
                    v.box.Position = BoxPos
                    v.box.Color = esp.settings.box.color
                    v.box.Visible = true
                else
                    v.boxOutline.Visible = false
                    v.box.Visible = false
                end

                if esp.settings.healthbar.enabled then
                    v.healthBar.From = Vector2new((BoxPos.X - 5), BoxPos.Y + BoxSize.Y)
                    v.healthBar.To = Vector2new(v.healthBar.From.X, v.healthBar.From.Y - (hum.Health / hum.MaxHealth) * BoxSize.Y)
                    v.healthBar.Color = Color3fromRGB(255 - 255 / (hum["MaxHealth"] / hum["Health"]), 255 / (hum["MaxHealth"] / hum["Health"]), 0)
                    v.healthBar.Visible = true
                    v.healthBar.Thickness = esp.settings.healthbar.size

                    v.healthBarOutline.From = Vector2new(v.healthBar.From.X, BoxPos.Y + BoxSize.Y + 1)
                    v.healthBarOutline.To = Vector2new(v.healthBar.From.X, (v.healthBar.From.Y - 1 * BoxSize.Y) -1)
                    v.healthBarOutline.Visible = esp.settings.healthbar.outline
                    v.healthBarOutline.Thickness = esp.settings.healthbar.size + 2
                else
                    v.healthBarOutline.Visible = false
                    v.healthBar.Visible = false
                end

                if esp.settings.healthtext.enabled then
                    v.healthText.Text = tostring(mathfloor(hum.Health))
                    v.healthText.Position = Vector2new((BoxPos.X - 20), (BoxPos.Y + BoxSize.Y - 1 * BoxSize.Y) -1)
                    v.healthText.Color = esp.settings.healthtext.color
                    v.healthText.Outline = esp.settings.healthtext.outline

                    v.healthText.Font = esp.font
                    v.healthText.Size = esp.fontsize

                    v.healthText.Visible = true
                else
                    v.healthText.Visible = false
                end

                if esp.settings.viewangle.enabled and head and head.CFrame then
                    v.viewAngle.From = Vector2new(camera:worldToViewportPoint(head.CFrame.p).X, camera:worldToViewportPoint(head.CFrame.p).Y)
                    v.viewAngle.To = Vector2new(camera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * esp.settings.viewangle.size)).p).X, camera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * esp.settings.viewangle.size)).p).Y)
                    v.viewAngle.Color = esp.settings.viewangle.color
                    v.viewAngle.Visible = true
                else
                    v.viewAngle.Visible = false
                end

                --[[if esp.settings.weapon.enabled then
                    v.weapon.Visible = true
                    v.weapon.Position = Vector2new(BoxSize.X + BoxPos.X + v.weapon.TextBounds.X / 2 + 3, BoxPos.Y - 3)
                    v.weapon.Outline = esp.settings.name.outline
                    v.weapon.Color = esp.settings.name.color

                    v.weapon.Font = esp.font
                    v.weapon.Size = esp.fontsize

                    v.weapon.Text = esp.GetEquippedTool(i)
                else
                    v.weapon.Visible = false
                end]]

                if esp.teamcheck then
                    if esp.TeamCheck(i) then
                        v.name.Visible = esp.settings.name.enabled
                        v.box.Visible = esp.settings.box.enabled
                        v.filledbox.Visible = esp.settings.box.enabled
                        v.healthBar.Visible = esp.settings.healthbar.enabled
                        v.healthText.Visible = esp.settings.healthtext.enabled
                        v.distance.Visible = esp.settings.distance.enabled
                        v.viewAngle.Visible = esp.settings.viewangle.enabled
                        v.weapon.Visible = esp.settings.weapon.enabled
                        v.tracer.Visible = esp.settings.tracer.enabled
                    else
                        v.name.Visible = false
                        v.boxOutline.Visible = false
                        v.box.Visible = false
                        v.filledbox.Visible = false
                        v.healthBarOutline.Visible = false
                        v.healthBar.Visible = false
                        v.healthText.Visible = false
                        v.distance.Visible = false
                        v.viewAngle.Visible = false
                        v.weapon.Visible = false
                        v.tracer.Visible = false
                    end
                end
            else
                v.name.Visible = false
                v.boxOutline.Visible = false
                v.box.Visible = false
                v.filledbox.Visible = false
                v.healthBarOutline.Visible = false
                v.healthBar.Visible = false
                v.healthText.Visible = false
                v.distance.Visible = false
                v.viewAngle.Visible = false
                v.weapon.Visible = false
                v.tracer.Visible = false
            end
        else
            v.name.Visible = false
            v.boxOutline.Visible = false
            v.box.Visible = false
            v.filledbox.Visible = false
            v.healthBarOutline.Visible = false
            v.healthBar.Visible = false
            v.healthText.Visible = false
            v.distance.Visible = false
            v.viewAngle.Visible = false
            v.cham.Enabled = false
            v.weapon.Visible = false
            v.tracer.Visible = false
        end
    end
end)

local function DrawLine()
    local l = Drawing.new("Line")
    l.Visible = false
    l.From = Vector2.new(0, 0)
    l.To = Vector2.new(1, 1)
    l.Color = esp.settings.skeleton.color
    l.Thickness = 1
    l.Transparency = 1
    return l
end

local function Skeletonesp(plr)
    repeat wait() until plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil
    local limbs = {}
    local R15 = (plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15) and true or false
    limbs = {
        -- Spine
        Head_UpperTorso = DrawLine(),
        UpperTorso_LowerTorso = DrawLine(),
        -- Left Arm
        UpperTorso_LeftUpperArm = DrawLine(),
        LeftUpperArm_LeftLowerArm = DrawLine(),
        LeftLowerArm_LeftHand = DrawLine(),
        -- Right Arm
        UpperTorso_RightUpperArm = DrawLine(),
        RightUpperArm_RightLowerArm = DrawLine(),
        RightLowerArm_RightHand = DrawLine(),
        -- Left Leg
        LowerTorso_LeftUpperLeg = DrawLine(),
        LeftUpperLeg_LeftLowerLeg = DrawLine(),
        LeftLowerLeg_LeftFoot = DrawLine(),
        -- Right Leg
        LowerTorso_RightUpperLeg = DrawLine(),
        RightUpperLeg_RightLowerLeg = DrawLine(),
        RightLowerLeg_RightFoot = DrawLine(),
    }
    local function Visibility(state)
        for i, v in pairs(limbs) do
            v.Visible = state
        end
    end

    local function Colorize(color)
        for i, v in pairs(limbs) do
            v.Color = color
        end
    end

    local function UpdaterR15()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 then
                local HUM, vis = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if vis and esp.settings.skeleton.enabled and esp.enabled then
                    -- Head
                    local H = camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if limbs.Head_UpperTorso.From ~= Vector2.new(H.X, H.Y) then
                        --Spine
                        local UT = camera:WorldToViewportPoint(plr.Character.UpperTorso.Position)
                        local LT = camera:WorldToViewportPoint(plr.Character.LowerTorso.Position)
                        -- Left Arm
                        local LUA = camera:WorldToViewportPoint(plr.Character.LeftUpperArm.Position)
                        local LLA = camera:WorldToViewportPoint(plr.Character.LeftLowerArm.Position)
                        local LH = camera:WorldToViewportPoint(plr.Character.LeftHand.Position)
                        -- Right Arm
                        local RUA = camera:WorldToViewportPoint(plr.Character.RightUpperArm.Position)
                        local RLA = camera:WorldToViewportPoint(plr.Character.RightLowerArm.Position)
                        local RH = camera:WorldToViewportPoint(plr.Character.RightHand.Position)
                        -- Left leg
                        local LUL = camera:WorldToViewportPoint(plr.Character.LeftUpperLeg.Position)
                        local LLL = camera:WorldToViewportPoint(plr.Character.LeftLowerLeg.Position)
                        local LF = camera:WorldToViewportPoint(plr.Character.LeftFoot.Position)
                        -- Right leg
                        local RUL = camera:WorldToViewportPoint(plr.Character.RightUpperLeg.Position)
                        local RLL = camera:WorldToViewportPoint(plr.Character.RightLowerLeg.Position)
                        local RF = camera:WorldToViewportPoint(plr.Character.RightFoot.Position)

                        --Head
                        limbs.Head_UpperTorso.From = Vector2.new(H.X, H.Y)
                        limbs.Head_UpperTorso.To = Vector2.new(UT.X, UT.Y)

                        --Spine
                        limbs.UpperTorso_LowerTorso.From = Vector2.new(UT.X, UT.Y)
                        limbs.UpperTorso_LowerTorso.To = Vector2.new(LT.X, LT.Y)

                        -- Left Arm
                        limbs.UpperTorso_LeftUpperArm.From = Vector2.new(UT.X, UT.Y)
                        limbs.UpperTorso_LeftUpperArm.To = Vector2.new(LUA.X, LUA.Y)

                        limbs.LeftUpperArm_LeftLowerArm.From = Vector2.new(LUA.X, LUA.Y)
                        limbs.LeftUpperArm_LeftLowerArm.To = Vector2.new(LLA.X, LLA.Y)

                        limbs.LeftLowerArm_LeftHand.From = Vector2.new(LLA.X, LLA.Y)
                        limbs.LeftLowerArm_LeftHand.To = Vector2.new(LH.X, LH.Y)

                        -- Right Arm
                        limbs.UpperTorso_RightUpperArm.From = Vector2.new(UT.X, UT.Y)
                        limbs.UpperTorso_RightUpperArm.To = Vector2.new(RUA.X, RUA.Y)

                        limbs.RightUpperArm_RightLowerArm.From = Vector2.new(RUA.X, RUA.Y)
                        limbs.RightUpperArm_RightLowerArm.To = Vector2.new(RLA.X, RLA.Y)

                        limbs.RightLowerArm_RightHand.From = Vector2.new(RLA.X, RLA.Y)
                        limbs.RightLowerArm_RightHand.To = Vector2.new(RH.X, RH.Y)

                        -- Left Leg
                        limbs.LowerTorso_LeftUpperLeg.From = Vector2.new(LT.X, LT.Y)
                        limbs.LowerTorso_LeftUpperLeg.To = Vector2.new(LUL.X, LUL.Y)

                        limbs.LeftUpperLeg_LeftLowerLeg.From = Vector2.new(LUL.X, LUL.Y)
                        limbs.LeftUpperLeg_LeftLowerLeg.To = Vector2.new(LLL.X, LLL.Y)

                        limbs.LeftLowerLeg_LeftFoot.From = Vector2.new(LLL.X, LLL.Y)
                        limbs.LeftLowerLeg_LeftFoot.To = Vector2.new(LF.X, LF.Y)

                        -- Right Leg
                        limbs.LowerTorso_RightUpperLeg.From = Vector2.new(LT.X, LT.Y)
                        limbs.LowerTorso_RightUpperLeg.To = Vector2.new(RUL.X, RUL.Y)

                        limbs.RightUpperLeg_RightLowerLeg.From = Vector2.new(RUL.X, RUL.Y)
                        limbs.RightUpperLeg_RightLowerLeg.To = Vector2.new(RLL.X, RLL.Y)

                        limbs.RightLowerLeg_RightFoot.From = Vector2.new(RLL.X, RLL.Y)
                        limbs.RightLowerLeg_RightFoot.To = Vector2.new(RF.X, RF.Y)
                    end

                    --Colorize(esp.settings.skeleton.color)

                    if limbs.Head_UpperTorso.Visible ~= true then
                        Visibility(true)
                    end
                else 
                    if limbs.Head_UpperTorso.Visible ~= false then
                        Visibility(false)
                    end
                end
            else 
                if limbs.Head_UpperTorso.Visible ~= false then
                    Visibility(false)
                end
                if game.Players:FindFirstChild(plr.Name) == nil then 
                    for i, v in pairs(limbs) do
                        v:Remove()
                    end
                    connection:Disconnect()
                end
            end
        end)
    end
    
    coroutine.wrap(UpdaterR15)()
end

for _,v in ipairs(plrs:GetPlayers()) do
    if v ~= plr then
        esp.NewPlayer(v)
        Skeletonesp(v)
    end
end

plrs.ChildAdded:Connect(function(v)
    esp.NewPlayer(v)
    Skeletonesp(v)
end)

plrs.PlayerRemoving:Connect(function(v)
    for i2,v2 in pairs(esp.players[v]) do
        pcall(function()
            v2:Remove()
            v2:Destroy()
        end)
    end

    esp.players[v] = nil
end)

esp.Unload = function()
    esp_Loop:Disconnect()
    esp_Loop = nil
    
    for i,v in pairs(esp.players) do
        for i2, v2 in pairs(v) do
            if v2 == "cham" then
                v2:Destroy()
            else
                v2:Remove()
            end
        end
    end

    table.clear(esp)
    esp = nil
end

getgenv().esp = esp
-------------------------------------------------

local VFX = nil; for i,v in next, getgc(true) do
    if typeof(v) == "table" and rawget(v, "RecoilCamera") then
        VFX = v
        break
    end
end

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

function SpeedHack()
    resume(create(function()
        while SpeedToggle do
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

                local newDir = Vector3.new(travel.x * Speed, rootpart.Velocity.y, travel.Z * Speed)

                if travel.Unit.x == travel.Unit.x then
                    rootpart.Velocity = newDir
                end
            end
            task.wait(0.01)
        end
    end))
end

function CalculateVelocity(Before, After, deltaTime)
	-- // Vars
	local Displacement = (After - Before)
	local Velocity = Displacement / deltaTime

	-- // Return
	return Velocity
end

function Connection(signal,callback,...)
    local connection = signal:Connect(callback,...)
    table.insert(connections,connection)
    return connection
end

function FlyHack()
    local rootpart = LOCAL_PLAYER.Character:FindFirstChild("HumanoidRootPart")

    for lI, lV in pairs(LOCAL_PLAYER.Character:GetDescendants()) do
        if lV:IsA("BasePart") then
            lV.CanCollide = false
        end
    end

    resume(create(function()
        while FlyToggle do
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
                rootpart.Velocity = travel.Unit * FlySpeed --multiplaye the unit by the speed to make
            else
                rootpart.Velocity = Vector3.new(0, 0, 0)
                rootpart.Anchored = false
            end
            task.wait(0.01)
        end
    end))
end

function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

function getClosestPlayerS()
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

    if Toggles.aisilent.Value then
        for i,v in pairs(game:GetService("Workspace").AiZones:GetDescendants()) do
            if v:IsA("Model") and v.Name ~= "ElectricityAnomaly" or v.Name ~= "PMN2" then

                local Character = v

                local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
                local Humanoid = FindFirstChild(Character, "Humanoid")
                if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

                local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
                if not OnScreen then continue end
                
                local Distance = (Vector2.new(game.workspace.CurrentCamera.ViewportSize.X / 2, game.workspace.CurrentCamera.ViewportSize.Y / 2) - ScreenPosition).Magnitude
                if Distance <= (DistanceToMouse or Options.sradius.Value or 2000) then
                    Closest = v or false
                    DistanceToMouse = Distance
                end
            end
        end
    end

    if Closest ~= false then
        return Closest
    else
        return false
    end
end

function getClosestPlayerA()
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

function newDrawing(type, props)
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
function updateInvDrawings()
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

local Window = Library:CreateWindow({
    Title = 'Crumbleware | Alpha v' .. version .. ' | Paid',
    Center = true, 
    AutoShow = false,
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals'),
    Movement = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings')
}

--Combat

local MainCombat = Tabs.Combat:AddLeftTabbox()
local SilentA = MainCombat:AddTab('Silent Aim')
local Aimbot = MainCombat:AddTab('Aimbot')

--Silent Aim
SilentA:AddToggle("senabled", {Text = "Enabled", Default = false, Tooltip = 'Enables Silent Aim Features'}):OnChanged(function() end)
SilentA:AddToggle("aisilent", {Text = "Target Bots", Default = false, Tooltip = 'Enables Silent Aim to Target Bots'}):OnChanged(function() end)
SilentA:AddDropdown('stargetpart', {Values = { 'Head', 'HumanoidRootPart', 'Random' },Default = 1,Multi = false,Text = 'Silent Aim Target',Tooltip = 'Changes the Silent Aim Target',}) Options.stargetpart:OnChanged(function() end)
SilentA:AddToggle("sprediction", {Text = "Prediction", Default = false, Tooltip = 'Enables Silent Aim Prediction'}):OnChanged(function() silentprediction = Toggles.sprediction.Value end)
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
SilentAF:AddSlider('sradius', {Text = 'Fov Size',Default = 80,Min = 0,Max = 1280,Rounding = 0,Compact = false,}) Options.sradius:OnChanged(function() SFOVCircle.Radius = Options.sradius.Value end)
SilentAF:AddToggle('sfilled', {Text = 'Fov Filled',Default = false,Tooltip = 'Toggles Fov Filled',}) Toggles.sfilled:OnChanged(function() SFOVCircle.Filled = Toggles.sfilled.Value end)
SilentAF:AddSlider('sfovthick', {Text = 'Aimbot Fov thickness',Default = 0,Min = 0,Max = 10,Rounding = 1,Compact = false,}) Options.sfovthick:OnChanged(function() SFOVCircle.Thickness = Options.sfovthick.Value end)

--Aimbot Fov
AimbotF:AddToggle('afovenabled', {Text = 'Aimbot Fov Visible',Default = false,Tooltip = 'Enables the Fov',}) Toggles.afovenabled:OnChanged(function() AFOVCircle.Visible = Toggles.afovenabled.Value end)
AimbotF:AddSlider('afovsides', {Text = 'Fov Sides',Default = 14,Min = 3,Max = 64,Rounding = 0,Compact = false,})Options.afovsides:OnChanged(function() AFOVCircle.NumSides = Options.afovsides.Value end)
AimbotF:AddSlider('atrans', {Text = 'Fov Transperancy',Default = 100,Min = 0,Max = 100,Rounding = 1,Compact = false,}) Options.atrans:OnChanged(function() AFOVCircle.Transparency = Options.atrans.Value / 100 end)
AimbotF:AddSlider('aradius', {Text = 'Fov Size',Default = 80,Min = 0,Max = 1280,Rounding = 0,Compact = false,}) Options.aradius:OnChanged(function() AFOVCircle.Radius = Options.aradius.Value end)
AimbotF:AddToggle('afilled', {Text = 'Fov Filled',Default = false,Tooltip = 'Toggles Fov Filled',}) Toggles.afilled:OnChanged(function() AFOVCircle.Filled = Toggles.afilled.Value end)
AimbotF:AddSlider('afovthick', {Text = 'Aimbot Fov thickness',Default = 0,Min = 0,Max = 10,Rounding = 1,Compact = false,}) Options.afovthick:OnChanged(function() AFOVCircle.Thickness = Options.afovthick.Value end)

local OtherF = Tabs.Combat:AddRightGroupbox('Other')

OtherF:AddToggle('inventoryv', {Text = 'Inventory Viewer',Default = false,Tooltip = 'Enables Inventory Viewer',}) Toggles.inventoryv:OnChanged(function() end)
OtherF:AddToggle('nobob', {Text = 'No Bob',Default = false,Tooltip = 'Enables No Bob',}) Toggles.nobob:OnChanged(function(toggle) 
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

OtherF:AddDropdown('Hitsound_HeadSound', {Values = all_hit_sounds, Default = 1, Multi = false, Text = 'Headshot Sound'}):OnChanged(function()
    if Options.Hitsound_HeadSound.Value == "None" then
        return
    end
    headshot_sound.SoundId = hit_sounds[Options.Hitsound_HeadSound.Value]
end)

OtherF:AddSlider('Hitsound_HeadVolume', {Text = 'Volume', Default = 1, Min = 0, Max = 10, Rounding = 2, Compact = true}):OnChanged(function()
    headshot_sound.Volume = Options.Hitsound_HeadVolume.Value
end)

OtherF:AddDropdown('Hitsound_BodySound', {Values = all_hit_sounds, Default = 1, Multi = false, Text = 'Bodyshot Sound'}):OnChanged(function()
    if Options.Hitsound_BodySound.Value == "None" then 
        return
    end
    bodyshot_sound.SoundId =  hit_sounds[Options.Hitsound_BodySound.Value]
end)

OtherF:AddSlider('Hitsound_BodyVolume', {Text = 'Volume', Default = 1, Min = 0, Max = 10, Rounding = 2, Compact = true}):OnChanged(function()
    bodyshot_sound.Volume = Options.Hitsound_BodyVolume.Value
end)

local OtherE = Tabs.Combat:AddLeftGroupbox('Resolver')

OtherE:AddToggle("resolver", {Text = "Enabled", Default = false, Tooltip = 'Resolves Antiaim'}):OnChanged(function() resolve = Toggles.resolver.Value end)
OtherE:AddToggle("resolvevelo", {Text = "Velocity Rebuilder", Default = false, Tooltip = 'Resolves Velocity Breaker'}):OnChanged(function() veloresolve = Toggles.resolvevelo.Value end)
OtherE:AddToggle("resolvenohead", {Text = "No Head", Default = false, Tooltip = 'Resolves No Head'}):OnChanged(function() resolvenohead = Toggles.resolvenohead.Value end)

--[[local OtherC = Tabs.Combat:AddLeftGroupbox('Gun Mods')

OtherC:AddToggle('GunMods_MagicBullets', {Text = 'Magic Bullets', Default = false, Tooltip = "Allows bullets to pass 1 walls (may hit blanks)"})
OtherC:AddToggle('GunMods_NoMuzzleEffect', {Text = 'No Muzzle Effect', Default = false})
OtherC:AddToggle('GunMods_NoRecoil', {Text = 'No Recoil', Default = false}):OnChanged(function()
    local RecoilCamera = VFX.RecoilCamera;
    VFX.RecoilCamera = function(...)
    if Toggles.GunMods_NoRecoil.Value then
        return 0
    else
       return RecoilCamera(...)
    end
end

end)
OtherC:AddToggle('GunMods_NoProjectileDrop', {Text = 'No Projectile drop', Default = false})
OtherC:AddToggle('GunMods_NoSpread', {Text = 'No Spread', Default = false})
OtherC:AddToggle('GunMods_NoTracer', {Text = 'No Tracer', Default = false})
OtherC:AddToggle('GunMods_ManipulationToggle', {Text = 'Bullet Replay', Default = false, Tooltip = "Shoots multiple bullets at once"})
OtherC:AddSlider('GunMods_ManipulationValue', {Text = 'Amount', Default = 1, Min = 1, Max = 20, Rounding = 0, Compact = true})]]

local OtherU = Tabs.Combat:AddLeftGroupbox('HitBox')

OtherU:AddToggle('Hitbox_OverrideToggle', {Text = 'Override Hitboxes', Default = false})     
OtherU:AddDropdown('Hitbox_OverridePart', {Values = { 'Head', 'Face', 'HeadTopHitBox', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso'}, Default = 1, Multi = false, Text = 'Override Part'})

--Visuals

local MainEsp = Tabs.Visuals:AddLeftTabbox()
local PlayerEsp = MainEsp:AddTab('Player Esp')
local OtherEsp = MainEsp:AddTab('Other Esp')

PlayerEsp:AddToggle("penabled", {Text = "Enabled", Default = false, Tooltip = 'Enables Esp'}):OnChanged(function() esp.enabled = Toggles.penabled.Value end)
PlayerEsp:AddToggle("name", {Text = "Name", Default = false, Tooltip = 'Enables Name Esp'}):OnChanged(function() esp.settings.name.enabled = Toggles.name.Value end)
PlayerEsp:AddToggle("filledbox", {Text = "Box", Default = false, Tooltip = 'Enables Box Esp'}):OnChanged(function() esp.settings.filledbox.enabled = Toggles.filledbox.Value end)
PlayerEsp:AddToggle("healthbar", {Text = "Health Bar", Default = false, Tooltip = 'Enables Health Bar Esp'}):OnChanged(function() esp.settings.healthbar.enabled = Toggles.healthbar.Value end)
PlayerEsp:AddToggle("healthtext", {Text = "Health Text", Default = false, Tooltip = 'Enables Health Text Esp'}):OnChanged(function() esp.settings.healthtext.enabled = Toggles.healthtext.Value end)
PlayerEsp:AddToggle("distance", {Text = "Distance", Default = false, Tooltip = 'Enables Distance Esp'}):OnChanged(function() esp.settings.distance.enabled = Toggles.distance.Value end)
PlayerEsp:AddToggle("viewangle", {Text = "View Angle", Default = false, Tooltip = 'Enables View Angle Esp'}):OnChanged(function() esp.settings.viewangle.enabled = Toggles.viewangle.Value end)
PlayerEsp:AddToggle("skeleton", {Text = "Skeleton", Default = false, Tooltip = 'Enables Skeleton Esp'}):OnChanged(function() esp.settings.skeleton.enabled = Toggles.skeleton.Value end)
PlayerEsp:AddToggle("tracer", {Text = "Tracers", Default = false, Tooltip = 'Enables Tracer Esp'}):OnChanged(function() esp.settings.tracer.enabled = Toggles.tracer.Value end)
PlayerEsp:AddToggle("cenabled", {Text = "Chams", Default = false, Tooltip = 'Enables Chams Esp'}):OnChanged(function() esp.settings_chams.enabled = Toggles.cenabled.Value end)


local OtherVisuals = Tabs.Visuals:AddRightTabbox()
local OtherTab = OtherVisuals:AddTab('Other')
local OtherSettings = OtherVisuals:AddTab('Settings')

OtherTab:AddToggle("visualsenabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("viewmodel", {Text = "Viewmodel", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("fbright", {Text = "FullBright", Default = false}):OnChanged(function() Fullbright() end)
OtherTab:AddToggle("thirdp", {Text = "Third Peron", Default = false}):AddKeyPicker("thirdp_Enabled_KeyPicker", {Default = "P", SyncToggleState = true, Mode = "Toggle", Text = "Third Person", NoUI = false});
OtherTab:AddToggle("localcham", {Text = "Character Chams", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("ac", {Text = "Arm Chams", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("gm", {Text = "Gun Chams", Default = false}):OnChanged(function() end)
OtherTab:AddToggle("htmark", {Text = "Hit Markers", Default = false}):OnChanged(function() BulletTracer = Toggles.htmark.Value end)
OtherTab:AddToggle("httrace", {Text = "Hit Tracers", Default = false}):OnChanged(function() hittracer = Toggles.httrace.Value end)
OtherTab:AddToggle("hlog", {Text = "Hit Logs", Default = false}):OnChanged(function() hitlog = Toggles.hlog.Value end)
OtherTab:AddToggle("zoom", {Text = "Zoom", Default = false}):AddKeyPicker("zoom_Enabled_KeyPicker", {Default = "X", SyncToggleState = true, Mode = "Toggle", Text = "Zoom", NoUI = false}):OnChanged(function() repeat if not Toggles.zoom.Value then Camera.FieldOfView = 90 end until Camera.FieldOfView ~= zoomamount end)
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
OtherSettings:AddSlider('zooma', {Text = 'Zoom Amount', Default = 5, Min = 0, Max = 30, Rounding = 1, Compact = false}) Options.zooma:OnChanged(function() zoomamount = Options.zooma.Value end)
OtherSettings:AddSlider('crosss', {Text = 'Crosshair-Size', Default = 5, Min = 0, Max = 25, Rounding = 1, Compact = false}) Options.crosss:OnChanged(function() 
    Crosshair_Horizontal.From = Vector2.new(Camera.ViewportSize.X / 2 - Options.crosss.Value, Camera.ViewportSize.Y / 2)
    Crosshair_Horizontal.To = Vector2.new(Camera.ViewportSize.X / 2 + Options.crosss.Value, Camera.ViewportSize.Y / 2)
    Crosshair_Vertical.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2 - Options.crosss.Value)
    Crosshair_Vertical.To = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2 + Options.crosss.Value) 
end)

--Movement

local MainMovement = Tabs.Movement:AddLeftGroupbox('Main')

MainMovement:AddToggle("speed", {Text = "Speed", Default = false}):AddKeyPicker("speed_Enabled_KeyPicker", {Default = "RightAlt", SyncToggleState = true, Mode = "Toggle", Text = "Speed", NoUI = false});
    Options.speed_Enabled_KeyPicker:OnClick(function()
    SpeedToggle = Toggles.speed.Value
    if SpeedToggle then
        SpeedHack()
    end
end)

Toggles.speed:OnChanged(function()
    SpeedToggle = Toggles.speed.Value
    if SpeedToggle then
        SpeedHack()
    end
end)

--[[MainMovement:AddToggle("velfly", {Text = "Fly", Default = false}):AddKeyPicker("fly_Enabled_KeyPicker", {Default = "LeftAlt", SyncToggleState = true, Mode = "Toggle", Text = "Fly", NoUI = false});
    Options.fly_Enabled_KeyPicker:OnClick(function()
    FlyToggle = Toggles.velfly.Value
    if FlyToggle then
        FlyHack()
    end
end)

Toggles.velfly:OnChanged(function()
    FlyToggle = Toggles.velfly.Value
    if FlyToggle then
        FlyHack()
    end
end)]]

MainMovement:AddToggle("bhop", {Text = "Bunny Hop", Default = false}):OnChanged(function() 
    local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, connectTable in pairs({
            getconnections(humanoid.StateChanged);
            getconnections(humanoid:GetPropertyChangedSignal("WalkSpeed"));
            getconnections(humanoid:GetPropertyChangedSignal("JumpHeight"))
        }) do
            for _, event in pairs(connectTable) do
                if Toggles.bhop.Value then
                    event:Disable()
                else
                    event:Enable()
                end
            end
        end
    end
end)

--[[MainMovement:AddToggle("hip", {Text = "Hip-Height", Default = false}):OnChanged(function() 
    if not Toggles.hip.Value then
        game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = 2
    end
end)]]

MainMovement:AddButton('Teleport To A Car', function()
    for i,v in next, workspace:GetDescendants() do 
        if v:IsA('VehicleSeat') then 
            v:Sit(game.Players.LocalPlayer.Character.Humanoid)
        end
    end
end)

local SettingsMovement = Tabs.Movement:AddLeftGroupbox('Settings')

SettingsMovement:AddSlider("speed", {Text = "Speed", Min = 0, Max = 24, Default = 20, Rounding = 0}):OnChanged(function()
	Speed = Options.speed.Value
end)

--[[SettingsMovement:AddSlider("speed1", {Text = "Fly Speed", Min = 0, Max = 350, Default = 50, Rounding = 0}):OnChanged(function()
	FlySpeed = Options.speed1.Value
end)]]

--SettingsMovement:AddSlider("hiph", {Text = "Hip-Height", Min = 0, Max = 6, Default = 2, Rounding = 1})

--AntiAim

local MainAnti = Tabs.Movement:AddRightGroupbox('Anti-Aim')

MainAnti:AddToggle("aaenabled", {Text = "Enabled", Default = false}):OnChanged(function() end)
MainAnti:AddToggle("velobreak", {Text = "Velocity Breaker", Default = false}):OnChanged(function() end)
MainAnti:AddToggle("force", {Text = "Force Angles", Default = false})
MainAnti:AddToggle("head", {Text = "Head Spoofer", Default = false})
MainAnti:AddToggle("arms", {Text = "Arm Spoofer", Default = false})
MainAnti:AddToggle("legs", {Text = "Leg Spoofer", Default = false})

local SettingsAnti = Tabs.Movement:AddRightGroupbox('Anti-Aim Settings')

SettingsAnti:AddSlider('velo', {Text = 'Velocity', Default = 200, Min = 0, Max = 1000, Rounding = 1, Compact = false}) Options.velo:OnChanged(function() Velocity = Vector3.new(Options.velo.Value, 0, Options.velo.Value) end)
SettingsAnti:AddDropdown('yawbase', {Values = { "camera", "random", "spin", 'target' },Default = "camera",Multi = false,Text = 'Yaw Base',Tooltip = 'Changes the Yaw Base',})
SettingsAnti:AddSlider("yawoff", {Text = "Yaw Offset", Min = -180, Max = 180, Default = 0, Rounding = 0})
SettingsAnti:AddDropdown('yawm', {Values = {"none", "jitter", "offset jitter"},Default = "none",Multi = false,Text = 'Yaw Modifier',Tooltip = 'Changes the Yaw Modifer',})
SettingsAnti:AddSlider("modoff", {Text = "Modifier Offset", Min = -180, Max = 180, Default = 0, Rounding = 0})

--Chat Spammer

local MainChat = Tabs.Movement:AddLeftGroupbox('Chat')

MainChat:AddToggle("chatspam", {Text = "Enabled", Default = false}):OnChanged(function() end)
MainChat:AddInput('message', {
    Default = 'Crumbleware > Octohook (.gg/Eytqrxtdv7)',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'Message',
    Tooltip = 'What Message is spammed',

    Placeholder = 'Crumbleware > Octohook (.gg/Eytqrxtdv7)'
})
MainChat:AddSlider("delayc", {Text = "Chat Delay", Min = 2, Max = 10, Default = 2, Rounding = 1})

task.spawn(function()
    while task.wait(Options.delayc.Value) do
        if Toggles.chatspam.Value then
            local args = {
                [1] = Options.message.Value,
                [2] = "Global"
            }
            repStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
        end
    end
end)

--UI Settings

Library:SetWatermarkVisibility(true)
Library:SetWatermark('Crumbleware | Alpha v' .. version .. ' | Paid | 0 |')
Library.KeybindFrame.Visible = true;
Library:OnUnload(function()
    Library.Unloaded = true
end)
Library:OnUnload(function()
	Library.Unloaded = true
end)
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
local UI = Tabs['UI Settings']:AddRightGroupbox('UI')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Delete', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Crumbleware')
SaveManager:SetFolder('Crumbleware/ProjectDelta')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
-------------
UI:AddToggle('watermark', {
	Text = 'WaterMark',
	Default = true,
	Tooltip = 'Toggles the Water Mark',
})

Toggles.watermark:OnChanged(function()
	mark = Toggles.watermark.Value
	Library:SetWatermarkVisibility(mark)
end)
-------------
UI:AddToggle('Keybinds', {
	Text = 'KeyBind List',
	Default = false,
	Tooltip = 'Toggles the KeyBind List',
})

Toggles.Keybinds:OnChanged(function()
	keybind = Toggles.Keybinds.Value
	Library.KeybindFrame.Visible = keybind
end)

--Hooks / Other

--Combat

local oldHook = nil	
oldHook = hookfunction(require(ReplicatedStorage.Modules.FPS.Bullet).CreateBullet, function(...)
	local args = {...}
	if Toggles.senabled.Value and getClosestPlayerS() then
        Target = getClosestPlayerS()
		if Target ~= nil or Target ~= false then
            if silentprediction then
                local ammotype = repStorage.AmmoTypes[args[6]]
                local bulletvelocity = ammotype:GetAttribute("MuzzleVelocity")
                local traveltime = (Target:FindFirstChild("Head").Position - Camera.CFrame.p).Magnitude / bulletvelocity
                if resolve ~= true or veloresolve ~= true then
                    head = Target[Options.stargetpart.Value].Position + Target:FindFirstChild("HumanoidRootPart").Velocity * traveltime
                    backup = head
                else
                    head = Target[Options.stargetpart.Value].Position + resolvedvelocity * traveltime
                    backup = head
                end
            else
                head = Target[Options.stargetpart.Value].Position
                backup = head
            end

            shoot = true

            if not head then
                head = backup
            end

            if head ~= nil then
                args[9] = {CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + 
                Vector3.new(0, UniversalTables.UniversalTable.GameSettings.RootScanHeight, 0), head)}
            end

			return oldHook(table.unpack(args))
		end
	end
	return oldHook(table.unpack(args))
end)

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

LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
   Character = NewCharacter
end)

local droppedItems = workspace.DroppedItems;
local itemClasses = {'Guns', 'Clothes', 'Throwables', 'Attachments'}
local attachments, weapons, throwables, clothing = repstorage.Attachments:GetChildren(), repstorage.RangedWeapons:GetChildren(), repstorage.Throwable:GetChildren(), repstorage.RealClothing:GetChildren()

--[[do
    local function a(b)
        local class = (
            table.find(attachments,b.Name) and 'Attachments' or
            table.find(weapons,b.Name) and 'Weapons' or
            table.find(throwables,b.Name) and 'Throwables' or
            table.find(clothing,b.Name) and 'Clothing' or
            Players:FindFirstChild(b.Name) and 'Corpse'
        )
        if class == 'Corpse' then
            corpseDrawings[b] = newDrawing('Text', {Size = 13, Font = 2, Outline = true, Center = true});
        elseif class then
            itemESPDrawings[b] = {newDrawing('Text', {Size = 13, Font = 2, Outline = true, Center = true}), class};
        end
    end

    Connection(droppedItems.ChildAdded, a);
    Connection(droppedItems.ChildRemoved, function(inst)
        if itemESPDrawings[inst] then
            itemESPDrawings[inst][1]:Remove();
            itemESPDrawings[inst] = nil;
        elseif corpseDrawings[inst] then
            corpseDrawings[inst]:Remove();
            corpseDrawings[inst] = nil;
        end
    end)

    for _,v in next, droppedItems:GetChildren() do
        a(v);
    end
end]]

game:GetService("RunService").RenderStepped:Connect(function(step) 
    frames = frames + 1

    --[[for _,Player in pairs(Players:GetPlayers()) do
		if Player.Character and Player ~= LocalPlayer and Player.Character:FindFirstChild("HumanoidRootPart") and not Player.Character.HumanoidRootPart:FindFirstChild("OldPosition") then
			coroutine.wrap(function()
				local Position = Player.Character.HumanoidRootPart.Position
				RunService.RenderStepped:Wait()
				if Player.Character and Player ~= LocalPlayer and Player.Character:FindFirstChild("HumanoidRootPart") then
					if Player.Character.HumanoidRootPart:FindFirstChild("OldPosition") then
						Player.Character.HumanoidRootPart.OldPosition.Value = Position
					else
						local Value = Instance.new("Vector3Value")
						Value.Name = "OldPosition"
						Value.Value = Position
						Value.Parent = Player.Character.HumanoidRootPart
					end
				end
			end)()
		end
	end]]

    LastStep = step
    SFOVCircle.Radius = Options.sradius.Value / Camera.FieldOfView * 60
    AFOVCircle.Radius = Options.aradius.Value / Camera.FieldOfView * 60
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

    local Check = game:GetService("Workspace").Camera:FindFirstChild("ViewModel")
    if Toggles.visualsenabled.Value and Check ~= nil then
        for i,v in pairs(game:GetService("Workspace").Camera.ViewModel:GetDescendants()) do
            if Toggles.ac.Value then
                if v.ClassName == "MeshPart" then
                    if v.Parent.Name == "WastelandShirt" or v.Parent.Name == "GhillieTorso" or v.Parent.Name == "CivilianPants" or v.Parent.Name == "CamoShirt" or v.Parent.Name == "HandWraps" or v.Parent.Name == "CombatGloves" then
                        v.Transparency = 1
                    end
                end
                if v.ClassName == "MeshPart" then
                    if v.Name == "LeftHand" or v.Name == "LeftLowerArm" or v.Name == "LeftUpperArm" or v.Name == "RightHand" or v.Name == "RightLowerArm" or v.Name == "RightUpperArm" then
                        v.Material = (Options.acm.Value)
                        v.Color = (Options.acc.Value)
                    end
                end
                if v.ClassName == "Part" then
                    if v.Name == "AimPartCanted" or v.Name == "AimPart" then
                        v.Size = Vector3.new(0, 0, 0)
                        v.Transparency = 1
                    end
                end
            end
        end
        --[[if Toggles.localcham.Value then
            for i,v in pairs(game:GetService("Workspace")[LocalPlayerName]:GetChildren()) do
                if v.ClassName == "MeshPart" then
                    v.Material = (Options.ccm.Value)
                    v.Color = (Options.ccc.Value)
                end
            end
        end]]
        if Toggles.gm.Value then
            for i,v in pairs(game:GetService("Workspace").Camera.ViewModel.Item:GetDescendants()) do
                if v.ClassName == "MeshPart" or v.ClassName == "Part" then
                    v.Material = (Options.gcm.Value)
                    v.Color = (Options.gcc.Value)
                end
                if v:FindFirstChild("SurfaceAppearance") then
                    v.SurfaceAppearance:Destroy()
                end
            end
        end
    end

    --[[for inst, item in next, corpseDrawings do
        --if Toggles. and Toggles. then
            local pos, vis = camera:WorldToViewportPoint(inst.PrimaryPart.CFrame.p);
            local mag = floor((inst.PrimaryPart.CFrame.p - camera.CFrame.p).magnitude);
            item.Visible = vis and (mag <= library.flags.corpseesp_maxdistance) and #inst.Inventory:GetChildren() ~= 0
            if item.Visible then
                item.Position = Vector2.new(pos.X,pos.Y);
                item.Color = library.flags.corpseesp_color;
                item.Text = inst.Name..' [Corpse] - '..mag..' studs - '..#inst.Inventory:GetChildren()..' items';
            end
        --else
        --    item.Visible = false;
        --end
    end]]
end)

--Velo Breaker

resume(create(function()
    while true do
        if Toggles.aaenabled.Value and Toggles.velobreak.Value then
            if (not RootPart) or (not RootPart.Parent) or (not RootPart.Parent.Parent) then
                RootPart = Character:FindFirstChild("HumanoidRootPart")
            else
                RVelocity = RootPart.Velocity
        
                RootPart.Velocity = type(Velocity) == "vector" and Vector3.new(Options.velo.Value,0,Options.velo.Value) or Velocity(RVelocity)
            
                RStepped:wait()
            
                RootPart.Velocity = RVelocity
            end
        end
        Heartbeat:wait()
    end
end))

--Other AntiAim

local PreviousPosition = Vector3.new(0,0,0)
local OriginalAutoRotate = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate or true
local AntiaimAngle = CFrame.new()
local Jitter = false
RunService.RenderStepped:Connect(function(delta)
    local Player = game.Players.LocalPlayer
    local Head = Player.Character:FindFirstChild("Head")
    local HumanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")

    if Toggles.head.Value and Player.Character:FindFirstChild("Head") then
        if Head:FindFirstChild("Neck") then
            Neck = Head.Neck
            Head.Neck.Parent = nil  
        end
        Head.CanCollide = false
        Head.CFrame = Head.CFrame + Vector3.new(0, -10 ,0)

        if Head.Position.Y < -150000 then
            Neck.Parent = Head
            task.wait()
            Head.Neck.Parent = nil 
        end
    else
        if not Head:FindFirstChild("Neck") then
            Neck.Parent = Head  
        end
    end

    if Toggles.arms.Value and Player.Character:FindFirstChild("LeftUpperArm") then
        if Player.Character.LeftUpperArm:FindFirstChild("LeftShoulder") then
            Left = Player.Character.LeftUpperArm.LeftShoulder
            Left.Parent = nil
        end
        if Player.Character.RightUpperArm:FindFirstChild("RightShoulder") then
            Right = Player.Character.RightUpperArm.RightShoulder
            Right.Parent = nil
        end
    
        Player.Character.RightUpperArm.CFrame = Player.Character.RightUpperArm.CFrame + Vector3.new(0,-10,0)
        Player.Character.LeftUpperArm.CFrame = Player.Character.RightUpperArm.CFrame + Vector3.new(0,-10,0)

        if Player.Character.LeftUpperArm.Position.Y < -150000 then
            Left.Parent = Player.Character.LeftUpperArm
            Right.Parent = Player.Character.RightUpperArm
            task.wait()
            Left.Parent = nil
            Right.Parent = nil
        end
    else
        if not Player.Character.LeftUpperArm:FindFirstChild("LeftShoulder") then
            Left.Parent = Player.Character.LeftUpperArm
            Right.Parent = Player.Character.RightUpperArm
        end
    end

    if Toggles.legs.Value and Player.Character:FindFirstChild("LeftUpperLeg") then
        if Player.Character.LeftUpperLeg:FindFirstChild("LeftHip") then
            LeftL = Player.Character.LeftUpperLeg.LeftHip
            LeftL.Parent = nil
        end
        if Player.Character.RightUpperLeg:FindFirstChild("RightHip") then
            RightL = Player.Character.RightUpperLeg.RightHip
            RightL.Parent = nil
        end

        Player.Character.LeftUpperLeg.CFrame = Player.Character.LeftUpperLeg.CFrame + Vector3.new(0,-10,0)
        Player.Character.RightUpperLeg.CFrame = Player.Character.RightUpperLeg.CFrame + Vector3.new(0,-10,0)

        if Player.Character.LeftUpperLeg.Position.Y < -150000 then
            Left.Parent = Player.Character.LeftUpperLeg
            Right.Parent = Player.Character.RightUpperLeg
            task.wait()
            LeftL.Parent = nil
            RightL.Parent = nil
        end
    else
        if not Player.Character.LeftUpperLeg:FindFirstChild("LeftHip") then
            LeftL.Parent = Player.Character.LeftUpperLeg
            RightL.Parent = Player.Character.RightUpperLeg
        end
    end

    local Target = getClosestPlayerS()
    if Target ~= false and Target ~= nil and Target:FindFirstChild("HumanoidRootPart") and Toggles.resolver.Value and Toggles.resolvevelo.Value and Target then
        local HumanoidRootPart = getClosestPlayerS():FindFirstChild("HumanoidRootPart")
        local CurrentPosition = HumanoidRootPart.Position
	    resolvedvelocity = CalculateVelocity(PreviousPosition, CurrentPosition, delta)
	    PreviousPosition = CurrentPosition
    end


    local SelfCharacter = LocalPlayer.Character
    local SelfRootPart, SelfHumanoid = SelfCharacter and SelfCharacter:FindFirstChild("HumanoidRootPart"), SelfCharacter and SelfCharacter:FindFirstChildOfClass("Humanoid")
    if not SelfCharacter or not SelfRootPart or not SelfHumanoid then return end

    if Toggles.aaenabled.Value and shoot == false then
        SelfHumanoid.AutoRotate = false

        local Angle do
            Angle = -math.atan2(Camera.CFrame.LookVector.Z, Camera.CFrame.LookVector.X) + math.rad(-90)
            if Options.yawbase.Value == "random" then
                Angle = -math.atan2(Camera.CFrame.LookVector.Z, Camera.CFrame.LookVector.X) + math.rad(math.random(0, 360))
            elseif Options.yawbase.Value == "spin" then
                Angle = -math.atan2(Camera.CFrame.LookVector.Z, Camera.CFrame.LookVector.X) + tick() * 10 % 360
            end
        end

        local Offset = math.rad(Options.yawoff.Value)
        Jitter = not Jitter
        if Jitter then
            if Options.yawm.Value == "jitter" then
                Offset = math.rad(Options.modoff.Value)
            elseif Options.yawm.Value == "offset jitter" then
                Offset = Offset + math.rad(Options.modoff.Value)
            end
        end
        local NewAngle = CFrame.new(SelfRootPart.Position) * CFrame.Angles(0, Angle + Offset, 0)
        local function ToYRotation(_CFrame)
            local X, Y, Z = _CFrame:ToOrientation()
            return CFrame.new(_CFrame.Position) * CFrame.Angles(0, Y, 0)
        end
        if Options.yawbase.Value == "targets" then
            local Target
            local Closest = 9999
            for _,Player in next, Players:GetPlayers() do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end

                local Pos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
                local Magnitude = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if Closest > Magnitude then
                    Target = Player.Character.HumanoidRootPart
                    Closest = Magnitude
                end
            end
            if Target ~= nil then
                NewAngle = CFrame.new(SelfRootPart.Position, Target.Position) * CFrame.Angles(0, 0, 0)
            end
        end
        AntiaimAngle = Angle + Offset
        SelfRootPart.CFrame = ToYRotation(NewAngle)
    else
        SelfHumanoid.AutoRotate = OriginalAutoRotate
    end
end)

local OldNewIndex; OldNewIndex = hookmetamethod(game, "__newindex", function(self, key, value)
    local SelfName = tostring(self)
    if not checkcaller() then
        if key == "AutoRotate" then
            OriginalAutoRotate = value
            if Options.aaenabled.Value and shoot == false then
                value = false
            end
        end
        if SelfName == "HumanoidRootPart" and key == "CFrame" then
            if Options.aaenabled.Value and Options.force.Value and shoot == false then
                value = CFrame.new(value.Position) * CFrame.Angles(0, AntiaimAngle, 0)
            end
        end

        return OldNewIndex(self, key, value)
    end

    return OldNewIndex(self, key, value)
end)

resume(create(function()
    while true do
        if shoot == true then
            shoot = false
        end
        wait(0.001)
    end
end))

--Visuals

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

            local TargetStuds = math.floor((Hit.Position - Camera.CFrame.p).Magnitude + 0.5)

            function Notif(Text, Time)
                --Main = game:GetService('TextService'):GetTextSize(Text, 14, 14, Vector2.new(1920, 1080))
                XSize = 600
                YSize = 14
            
                YSize = YSize + 7
            
                local NotifyOuter = Library:Create('Frame', {
                    BorderColor3 = Color3.new(0, 0, 0);
                    Position = UDim2.new(0, 100, 0, 10);
                    Size = UDim2.new(0, 0, 0, YSize);
                    ClipsDescendants = true;
                    ZIndex = 100;
                    Parent = Library.NotificationArea;
                });
            
                local NotifyInner = Library:Create('Frame', {
                    BackgroundColor3 = Library.MainColor;
                    BorderColor3 = Library.OutlineColor;
                    BorderMode = Enum.BorderMode.Inset;
                    Size = UDim2.new(1, 0, 1, 0);
                    ZIndex = 101;
                    Parent = NotifyOuter;
                });
            
                Library:AddToRegistry(NotifyInner, {
                    BackgroundColor3 = 'MainColor';
                    BorderColor3 = 'OutlineColor';
                }, true);
            
                local InnerFrame = Library:Create('Frame', {
                    BackgroundColor3 = Color3.new(1, 1, 1);
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, 1, 0, 1);
                    Size = UDim2.new(1, -2, 1, -2);
                    ZIndex = 102;
                    Parent = NotifyInner;
                });
            
                local Gradient = Library:Create('UIGradient', {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                        ColorSequenceKeypoint.new(1, Library.MainColor),
                    });
                    Rotation = -90;
                    Parent = InnerFrame;
                });
            
                Library:AddToRegistry(Gradient, {
                    Color = function()
                        return ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Library:GetDarkerColor(Library.MainColor)),
                            ColorSequenceKeypoint.new(1, Library.MainColor),
                        });
                    end
                });
            
                local NotifyLabel = Library:CreateLabel({
                    Position = UDim2.new(0, 4, 0, 0);
                    Size = UDim2.new(1, -4, 1, 0);
                    Text = Text;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextSize = 14;
                    ZIndex = 103;
                    Parent = InnerFrame;
                });
            
                local LeftColor = Library:Create('Frame', {
                    BackgroundColor3 = Library.AccentColor;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0, -1, 0, -1);
                    Size = UDim2.new(0, 3, 1, 2);
                    ZIndex = 104;
                    Parent = NotifyOuter;
                });
            
                Library:AddToRegistry(LeftColor, {
                    BackgroundColor3 = 'AccentColor';
                }, true);
            
                pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, XSize + 8 + 4, 0, YSize), 'Out', 'Quad', 0.4, true);
            
                task.spawn(function()
                    wait(Time or 5);
            
                    pcall(NotifyOuter.TweenSize, NotifyOuter, UDim2.new(0, 0, 0, YSize), 'Out', 'Quad', 0.4, true);
            
                    wait(0.4);
            
                    NotifyOuter:Destroy();
                end);
            end;
            if hitlog then
                Notif("Hit registration | Player: " .. Hit.Parent.Name .. ", Hit: " .. Hit.Name ..  ", Distance: " .. math.floor(TargetStuds / 3.5714285714 + 0.5) .. "m (" .. TargetStuds .. " studs)")
            end
            if hittracer then
                Beam(Camera.CFrame.p, Hit.CFrame.p)
            end
            hitmarker()
        end
        Call = Call or __namecall(self, ...)
        return Call
    end
    if Method == "setprimarypartcframe" and Toggles.viewmodel.Value and Toggles.visualsenabled.Value and not Toggles.thirdp.Value then
        return __namecall(self, Camera.CFrame * CFrame.new(0.05, -1.35, 0.7) * CFrame.new(Options.viewx.Value, -Options.viewy.Value, -Options.viewz.Value)) -- x -y -z
    end
    if Method == "setprimarypartcframe" and Toggles.visualsenabled.Value and Toggles.thirdp.Value then
        return __namecall(self, Camera.CFrame * CFrame.new(0.05, -1.35, 0.7) * CFrame.new(999, -999, -999)) -- x -y -z
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

local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}

    do
        if getnamecallmethod() == "GetAttribute" then
            --[[if args[1] == "MuzzleEffect" and Toggles.GunMods_NoMuzzleEffect.Value then
                return false
            end
    
            if args[1] == "AccuracyDeviation" and Toggles.GunMods_NoSpread.Value then
                return 1
            end

            if args[1] == "ProjectileDrop" and Toggles.GunMods_NoProjectileDrop.Value then
                return 0
            end
    
            if args[1] == "Tracer" and Toggles.GunMods_NoTracer.Value then
                return false
            end

            if args[1] == "RecoilStrength" and Toggles.GunMods_NoRecoil.Value then
                return 0
            end

            if args[1] == "RecoilRecoveryTimeMod" and Toggles.GunMods_NoRecoil.Value then
                return 0
            end

            if args[1] == "NoPen" and Toggles.GunMods_MagicBullets.Value then
                return false
            end

            if args[1] == "PenResistance" and Toggles.GunMods_MagicBullets.Value then
                return 0
            end]]
        end
    
        if getnamecallmethod() == "FireServer" then
            if tostring(self) == "ProjectileInflict" then
                task.spawn(function()
                    setthreadcontext(7)
                    if args[2].Name == "Head" or args[2].Name == "FaceHitBox" or args[2].Name == "HeadTopHitBox" then
                        headshot_sound:Play()
                    else
                        bodyshot_sound:Play()
                    end
                end)

                if Toggles.Hitbox_OverrideToggle.Value and args[1][Options.Hitbox_OverridePart.Value] ~= nil then
                    args[2] = args[1][Options.Hitbox_OverridePart.Value]
                    return __namecall(self, unpack(args))
                end
            end

            if tostring(self):lower():find("rlog") and args[1] and tonumber(args[1]) <= 1 then
                return
            end
        end
    end
    return __namecall(self, unpack(args));
end);

--[[local old_create_bullet
old_create_bullet = hookfunction(require(repStorage.Modules.FPS.Bullet).CreateBullet, function(...)
    local args = {...};
    if #args > 4 and Toggles.GunMods_ManipulationToggle.Value then 
        for i = 1, Options.GunMods_ManipulationValue.Value do
            old_create_bullet(unpack(args))
        end
    end
    return old_create_bullet(unpack(args))
end)]]

resume(create(function()
    while wait(1) do
        Library:SetWatermark('Crumbleware | Alpha v' .. version .. ' | Paid | ' .. frames .. ' |')
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

SaveManager:LoadAutoloadConfig()