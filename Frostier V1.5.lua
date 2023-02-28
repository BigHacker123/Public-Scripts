--//     Services     //--
local rs = game:GetService("ReplicatedStorage")
local plyrs = game:GetService("Players")

--{ Variables }--
local lp = plyrs.LocalPlayer
local PlayerGui = lp.PlayerGui
local MainGui = PlayerGui.MainGui
local LeftPanel = MainGui.LeftPanel
local Navigation = MainGui.Panels.Topbar.Right.Navigation
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
getgenv()._RG = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.BubbleChat)._G
getgenv().MassPickup = false
getgenv().Water = false
getgenv().Autoplant = false
_G.Regen = false
getgenv().__k = false
getgenv().speed = false
getgenv().AruaRange = 20
_G.Speed = 3
_G.Jumpy = false
_G.speedthing = false
_G.Level = 1000
getgenv().healys = 65
getgenv().WorkspaceAura = false

local PanelTemplate = LeftPanel.ModeratorTools
local NavigationButtonTemplate = Navigation.Social

local Data = {
   CustomNametags = true,
   CustomPlayerlistTools = true
}

--{ HTTP }--
local originalTick = tick()
local pickupData = game:HttpGet("https://pastebin.com/raw/EwKpakWj", true)
local playerauraData = game:HttpGet("https://pastebin.com/raw/qT4vVvnP", true)
local playerteleportData = game:HttpGet("https://pastebin.com/raw/aY3VquQZ", true)
local createfarmData = game:HttpGet("https://pastebin.com/raw/b7GvFBfZ", true)
local openMarketData = game:HttpGet("https://pastebin.com/raw/yUYyjGcK", true)
local godmodeData = game:HttpGet("https://pastebin.com/raw/sVkJbaYj", true)
local invisData = game:HttpGet("https://pastebin.com/raw/DpmqCwPx", true)
local regenData = game:HttpGet("https://pastebin.com/raw/qeHpR1fJ")
local WorkSpaceData = game:HttpGet("https://pastebin.com/raw/GpWhndqB")
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/ESP-Lib/main/ESP.lua"))()
---------
ESP.Boxes = false
ESP.Names = false
ESP.Color = Color3.fromRGB(255, 255, 255)
---------
if not shared.boogaNametags and Data.CustomNametags then
   shared.boogaNametags = true
   loadstring(game:HttpGet("https://pastebin.com/raw/bzHjpx9C", true))()
   print("Setting Up hooks")
elseif shared.boogaNametags then
   print("Already Hooked")
end
-------------
if not _G.BetterStats then
   _G.BetterStats = true
   loadstring(game:HttpGet("https://pastebin.com/raw/s0sS2d5M", true))()
   print("Hooked!")
elseif _G.BetterStats then
   print("Done!")
end
-------
if not shared.boogaPlayerTools and Data.CustomPlayerlistTools then
   shared.boogaPlayerTools = true
   loadstring(game:HttpGet("https://pastebin.com/raw/YQ7A8Htj", true))()
   loadstring(game:HttpGet("https://pastebin.com/raw/EvYt4LGA", true))()
   print("Loading Menu...")
elseif shared.boogaPlayerTools then
   print("Menu Already Loaded!")
end
local startupTime = tick() - originalTick

local function getItemAmount(item)
   for i,v in ipairs(_RG.Data.inventory) do
      if v.name == item then
         return v.quantity
      end
   end
   return 0
end

--{ Menu Data }--
local CoastingLibrary = loadstring(game:HttpGet("https://pastebin.com/raw/3gQQtaKX"))()

local AimbotTab = CoastingLibrary:CreateTab("Combat")
local MainSection = AimbotTab:CreateSection("Main")
local OtherSection = AimbotTab:CreateSection("Other")
-----------
MainSection:CreateToggle("Player Aura", function(boolean)
if getgenv().__k then
   getgenv().__k = false
else
   loadstring(playerauraData)()
end
end)
-----------
MainSection:CreateSlider("Player Aura Range", 20, 25, 20, false, function(value)
getgenv().AruaRange = value
end)
-----------
MainSection:CreateToggle("WorkSpace Aura", function(work)
if work then
   getgenv().WorkspaceAura = true
   loadstring(WorkSpaceData)()
else
   getgenv().WorkspaceAura = false
end
end)
-----------
MainSection:CreateToggle("Player Teleport Aura", function(boolean)
   if getgenv().__Q then
      getgenv().__Q = false
   else
      loadstring(playerteleportData)()
   end
end)
----------
MainSection:CreateSlider("Player Teleport Range", 5, 20, 10, false, function(value)
   getgenv().TeleportRange = value
end)
----------
OtherSection:CreateToggle("Blood Fruit Heal", function(regen)
if regen == true then
   _G.Regen = true
   while _G.Regen == true do
      local player = game.Players.LocalPlayer
      local character = player.Character
      local humanoid = character.Humanoid
      if humanoid.Health <= getgenv().healys then
         repeat wait(0.1)
            if getItemAmount("Bloodfruit") >= 100 then
               game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("Bloodfruit")
            end
         until humanoid.Health == 100 or humanoid.Health == 0
      end
      task.wait()
   end
else
   _G.Regen = false
end
end)
-----------
OtherSection:CreateSlider("Heal Under", 0, 100, 65, false, function(healy)
getgenv().healys = healy
end)
-----------
local MovementTab = CoastingLibrary:CreateTab("Movement")
local PlayerSection = MovementTab:CreateSection("Player")
-----------
PlayerSection:CreateToggle("Speed (Q)", function(speeder)
if speeder == false then
   getgenv().speed = false
else
   getgenv().speed = true
   if _G.speedthing == false then
      _G.speedthing = true
      mouse.KeyDown:connect(function(key)
      if getgenv().speed == true then
         if key == "q"  then
            loop = true
            while loop do
               local plr = game:GetService("Players").LocalPlayer
               local char = plr.Character
               local hum = char:FindFirstChild("HumanoidRootPart")
               local speed = _G.Speed
               hum.CFrame = hum.CFrame + hum.CFrame.lookVector * speed
               task.wait()
            end
         end
      end
      end)

      mouse.KeyUp:connect(function(key)
      if key == "q"  then
         loop = false
      end
      end)
   end
end
end)
-----------
PlayerSection:CreateSlider("Speed", 1, 10, 3, false, function(speedy)
_G.Speed = speedy
end)
-----------
PlayerSection:CreateToggle("Inf Jump", function(Jump)
if Jump then
   _G.Jumpy = true
   local Player = game:GetService'Players'.LocalPlayer;
   local UIS = game:GetService'UserInputService';

   _G.JumpHeight = 50;

   function Action(Object, Function) if Object ~= nil then Function(Object); end end

      UIS.InputBegan:connect(function(UserInput)
      if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
         if _G.Jumpy == true then
            Action(Player.Character.Humanoid, function(self)
            if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
               Action(self.Parent.HumanoidRootPart, function(self)
               self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
               end)
            end
            end)
         end
      end
      end)
   else
      _G.Jumpy = false
   end
   end)
   -----------
   PlayerSection:CreateToggle("Water Walker", function(water)
   if water == false then
      getgenv().Water = false
   else
      getgenv().Water = true
      while getgenv().Water == true do
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
         wait()
      end
   end
   end)
   -----------
   local VisualsTab = CoastingLibrary:CreateTab("Visuals")
   local EspSection = VisualsTab:CreateSection("Players")
   local WorldSection = VisualsTab:CreateSection("World") -- sooonnnnnn
   -----------
   EspSection:CreateButton("Esp", function()
   ESP:Toggle(true)
   end)
   -----------
   EspSection:CreateToggle("Boxes", function(Boxes)
   if Boxes then
      ESP.Boxes = true
   else
      ESP.Boxes = false
   end
   end)
   -----------
   EspSection:CreateToggle("Names", function(names)
   if names then
      ESP.Names = true
   else
      ESP.Names = false
   end
   end)
   -----------
   EspSection:CreateToggle("Tracers", function(tracers)
   if tracers then
      ESP.Tracers = true
   else
      ESP.Tracers = false
   end
   end)
   -----------
   EspSection:CreateColorPicker("Esp Color", Color3.fromRGB(255, 255, 255), function(color)
   ESP.Color = (color)
   end)
   -----------
   WorldSection:CreateLabel("Namey", " ")

   WorldSection:CreateLabel("Namey", "Sky Box")

   WorldSection:CreateDropdown("Sky Box", {"Light-Blue-Sky", "Setting-Sun-Sky", "Elegant-Morning-Sky", "Fade-Blue-Skybox", "Cloudy"}, 1, 2, 3, 4, 5, function(skybox) -- dont know how to change the skybox. so this is what i have so far.
   if skybox == 1 then
      print("Sky Box Changed to 148446579")
   elseif skybox == 2 then
      print("Sky Box Changed to 151165563")
   elseif skybox == 3 then
      print("Sky Box Changed to 153767620")
   elseif skybox == 4 then
      print("Sky Box Changed to 153696954")
   elseif skybox == 5 then
      print("Sky Box Changed to 150552980")
   end
   end)

   WorldSection:CreateLabel("Namey", "World Color")


   WorldSection:CreateLabel("Namey", "Lighting")

   WorldSection:CreateSlider("Light", -50, 50, 0, false, function(light)
      game:GetService("Lighting").ColorCorrection.Brightness = light/100 -- just changes the brightness on a color correction lol.
   end)
   -----------
   local MiscTab = CoastingLibrary:CreateTab("Misc")
   local MiscSection = MiscTab:CreateSection("Misc")
   local OtherMiscSection = MiscTab:CreateSection("OtherMisc")
   MiscSection:CreateButton("Build a Farm", function()
   loadstring(createfarmData)()
   end)
   -----------
   MiscSection:CreateButton("Open The Old Market", function() -- soy boy dumb didnt remove it just made it so the button doesent activate it. code simple.
   loadstring(openMarketData)()
   end)

   MiscSection:CreateButton("Changes Ur Clients lvl", function() -- fixed by copying someone elses lol.
		spawn(function()
			while task.wait() do
				_RG.Data.level = _G.Level
			end
		end)
   end)

   MiscSection:CreateSlider("Level", 1, 1000, 1000, false, function(lvl) -- fixed by copying someone elses lol.
   _G.Level = lvl
   end)

   MiscSection:CreateToggle("Auto Pick Up Items", function(pick) -- only works on synapse x 100% of the time, krnl only works about 75% of the time.
   if pick == false then
      getgenv().MassPickup = false
   else
      loadstring(pickupData)()
   end
   end)

   OtherMiscSection:CreateToggle("Auto Plant BloodFruit", function(Plant) -- auto plants blood fruit, ima add other fruits and plants later.
   if Plant == false then
      getgenv().Autoplant = false
   else
      getgenv().Autoplant = true
      while getgenv().Autoplant == true do
         --//     Services     //--
         local rs = game:GetService("ReplicatedStorage")
         local plyrs = game:GetService("Players")

         --//     Functions     //--
         local function getLP()
            return plyrs.LocalPlayer.Character
         end

         --//     Code     //--
         for i,v in pairs(workspace.Deployables:GetChildren()) do
            coroutine.wrap(function()
            pcall(function()
            local magnitude = (getLP().HumanoidRootPart.Position - v:FindFirstChild("Part").Position).Magnitude
            if magnitude <= 256 then
               if v.Name == "Plant Box" then
                  rs.Events.InteractStructure:FireServer(v, "Bloodfruit")
               end
            end
            end)
            end)()
         end
         wait(5)
      end
   end
   end)

   OtherMiscSection:CreateButton("Invis", function()
   loadstring(invisData)()
   end)

   OtherMiscSection:CreateLabel("Namey", "Reset to turn off")

   OtherMiscSection:CreateButton("God Mode", function()
   loadstring(godmodeData)()
   end)

   OtherMiscSection:CreateLabel("Namey", "Rejoin to turn off")

   OtherMiscSection:CreateButton("Instant Respawn", function()
   --//     Functions     //--
   local function GetPos()
      return plyrs.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
   end
   local function SetPos(pos)
      plyrs.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = pos
   end

   --//     Code     //--
   local oldPos = GetPos()

   spawn(function()
   while wait(0.2) do
      oldPos = GetPos()
   end
   end)

   while true do task.wait()
      rs.Events.SpawnFirst:FireServer()
      pcall(function()
      if plyrs.LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0 then
         spawn(function()
         local counter = 0
         while counter <= 75 do wait()
            counter += 1
            SetPos(oldPos)
            wait(0.05)
         end
         end)
      end
      end)
   end
   end)

   OtherMiscSection:CreateLabel("Namey", "Instantly Respawns you")

   OtherMiscSection:CreateLabel("Namey", "where you died")

   OtherMiscSection:CreateButton("God Bag Skin", function()
   --//     Variables     //--
   local bag = rs.Armor["God Bag"]

   --//     Environment     //--
   local function getrgenv()
      return getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.BubbleChat)._G
   end

   --//     Code     //--
   for i,v in ipairs(plyrs.LocalPlayer.Character:GetChildren()) do
      if v.Name:match("Bag") then
         v:Destroy()
      end
   end

   local newBag = bag:Clone()
   newBag:FindFirstChild("Handle").AccessoryWeld.Part1 = plyrs.LocalPlayer.Character.UpperTorso
   newBag.Parent = plyrs.LocalPlayer.Character
   end)

   local CreditsTab = CoastingLibrary:CreateTab("Credits")
   local CreditsSection = CreditsTab:CreateSection("Credits")
   local OtherCreditsSection = CreditsTab:CreateSection("OtherCredits")
   CreditsSection:CreateLabel("Namey", " ")
   CreditsSection:CreateLabel("Namey", "UI - Coasting UI LIB")
   CreditsSection:CreateLabel("Namey", "Player Aura - ABAS Devs")
   CreditsSection:CreateLabel("Namey", "BloodFruit Healer - Me")
   CreditsSection:CreateLabel("Namey", "Most Scripts - ABAS Devs")
   OtherCreditsSection:CreateLabel("Namey", " ")
   OtherCreditsSection:CreateLabel("Namey", "Other Things - Me")
   ---------------
   print("Loaded Frostier v1.5 in " .. startupTime .. "s")


   -- very  cool