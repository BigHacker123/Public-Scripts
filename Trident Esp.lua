_G.AutoUpdate = true
_G.Names = true
_G.Highlights = false

function CreateHighlight(Model)
    local Highlight = Instance.new("Highlight")
		Highlight.Parent = Model
		Highlight.OutlineColor = Color3.fromRGB(0,0,0)
		Highlight.FillColor = Color3.fromRGB(255,0,0)
		Highlight.Enabled = true
		Highlight.FillTransparency = 0.5
		Highlight.OutlineTransparency = 0
end

function CreateNameTag(Model)
    --if Model:FindFirstChild("Nametag") and Model.Nametag:FindFirstChild("tag") and Model.Nametag.tag.Text ~= "Shylou2644" then
        Player = Model.Nametag.tag.Text
        local NameTag = Instance.new("BillboardGui", Model)
        NameTag.Size = UDim2.new(1,1, 1,1)
        NameTag.Name = "1A2B3C"
        NameTag.AlwaysOnTop = true
        local NameTag2 = Instance.new("Frame", NameTag)
        NameTag2.Size = UDim2.new(1,1, 1,1)
        NameTag2.BackgroundTransparency = 1
        NameTag2.BorderSizePixel = 0
        local NameTag3 = Instance.new("TextLabel", NameTag2)
        NameTag3.Text = Player
        NameTag3.Size = UDim2.new(1,1, 1,1)
        NameTag3.BackgroundTransparency = 1
        NameTag3.BorderSizePixel = 1
        NameTag3.TextColor3 = Color3.fromRGB(255,0,0)
    --end
end

function AddEsp(object)
    if _G.Highlights then
        if object:FindFirstChild("Highlight") then
            object:FindFirstChild("Highlight"):Destroy()
            CreateHighlight(object)
        elseif not object:FindFirstChild("Highlight") then
            CreateHighlight(object)
        end
    elseif object:FindFirstChild("Highlight") then
        object:FindFirstChild("Highlight"):Destroy()
    end
    if _G.Names then
        if object:FindFirstChild("Head") then
            if object.Head:FindFirstChild("1A2B3C") then
                object.Head:FindFirstChild("1A2B3C"):Destroy()
                CreateNameTag(object.Head)
            elseif not object.Head:FindFirstChild("1A2B3C") then
                CreateNameTag(object.Head)
            end
        end
    elseif object:FindFirstChild("Head") and object.Head:FindFirstChild("1A2B3C") then
        object.Head:FindFirstChild("1A2B3C"):Destroy()
    end
end

game.workspace.ChildAdded:Connect(function(thing)
    if _G.AutoUpdate == true then
        if thing:FindFirstChild("Humanoid") and thing:FindFirstChild("HumanoidRootPart") then
            AddEsp(thing)
        end
    end
end)

for i,v in pairs(game.workspace:GetChildren()) do
    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
        if _G.Highlights then
            if v:FindFirstChild("Highlight") then
                v:FindFirstChild("Highlight"):Destroy()
                CreateHighlight(v)
            elseif not v:FindFirstChild("Highlight") then
                CreateHighlight(v)
            end
        elseif v:FindFirstChild("Highlight") then
            v:FindFirstChild("Highlight"):Destroy()
        end
        if _G.Names then
            if v:FindFirstChild("Head") then
                if v.Head:FindFirstChild("1A2B3C") then
                    v.Head:FindFirstChild("1A2B3C"):Destroy()
                    CreateNameTag(v.Head)
                elseif not v.Head:FindFirstChild("1A2B3C") then
                    CreateNameTag(v.Head)
                end
            end
        elseif v:FindFirstChild("Head") and v.Head:FindFirstChild("1A2B3C") then
            v.Head:FindFirstChild("1A2B3C"):Destroy()
        end
    end
end

--rewrite