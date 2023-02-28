local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()

espLib.whitelist = {}
espLib.options.whitelistColor = 

local espLib.options = {
    enabled = true,
    minScaleFactorX = 1,
    maxScaleFactorX = 10,
    minScaleFactorY = 1,
    maxScaleFactorY = 10,
    boundingBox = true, -- WARNING | Significant Performance Decrease when true
    boundingBoxDescending = true,
    font = 2,
    fontSize = 13,
    limitDistance = false,
    maxDistance = 1000,
    visibleOnly = false,
    teamCheck = false,
    teamColor = false,
    fillColor = nil,
    whitelistColor = Color3.new(1, 0, 0),
    outOfViewArrows = true,
    outOfViewArrowsFilled = true,
    outOfViewArrowsSize = 25,
    outOfViewArrowsRadius = 100,
    outOfViewArrowsColor = Color3.new(1, 1, 1),
    outOfViewArrowsTransparency = 0.5,
    outOfViewArrowsOutline = true,
    outOfViewArrowsOutlineFilled = false,
    outOfViewArrowsOutlineColor = Color3.new(1, 1, 1),
    outOfViewArrowsOutlineTransparency = 1,
    names = false,
    nameTransparency = 1,
    nameColor = Color3.new(1, 1, 1),
    boxes = false,
    boxesTransparency = 1,
    boxesColor = Color3.new(1, 0, 0),
    boxFill = false,
    boxFillTransparency = 0.5,
    boxFillColor = Color3.new(1, 0, 0),
    healthBars = false,
    healthBarsSize = 1,
    healthBarsTransparency = 1,
    healthBarsColor = Color3.new(0, 1, 0),
    healthText = false,
    healthTextTransparency = 1,
    healthTextSuffix = "%",
    healthTextColor = Color3.new(1, 1, 1),
    distance = false,
    distanceTransparency = 1,
    distanceSuffix = " Studs",
    distanceColor = Color3.new(1, 1, 1),
    tracers = false,
    tracerTransparency = 1,
    tracerColor = Color3.new(1, 1, 1),
    tracerOrigin = "Top", -- Available [Mouse, Top, Bottom]
    chams = false,
    chamsFillColor = Color3.new(1, 0, 0),
    chamsFillTransparency = 0.5,
    chamsOutlineColor = Color3.new(),
    chamsOutlineTransparency = 0
};

GroupBox:AddToggle("esp", {Text = "ESP", Default = false}):OnChanged(function() espLib.options.enabled = Toggles.esp.Value end)
GroupBox:AddToggle("box", {Text = "Boxes", Default = false}):OnChanged(function() espLib.options.boxes = Toggles.box.Value end)
GroupBox:AddToggle("names", {Text = "Names", Default = false}):OnChanged(function() espLib.options.names = Toggles.names.Value end)
GroupBox:AddToggle("maxd", {Text = "Max Distance", Default = false}):OnChanged(function() espLib.options.distance = Toggles.maxd.Value end)
GroupBox:AddToggle("healtht", {Text = "Health Text", Default = false}):OnChanged(function() espLib.options.healthText = Toggles.healtht.Value end)
GroupBox:AddToggle("healthb", {Text = "Health Bars", Default = false}):OnChanged(function() espLib.options.healthBars = Toggles.healthb.Value end)
GroupBox:AddToggle("tracer", {Text = "Tracers", Default = false}):OnChanged(function() espLib.options.tracers = Toggles.tracer.Value end)
GroupBox:AddToggle("chams", {Text = "Chams", Default = false}):OnChanged(function() espLib.options.chams = Toggles.chams.Value end)
GroupBox:AddToggle("arrows", {Text = "Arrows", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutline = Toggles.arrows.Value end)

GroupBox69:AddToggle("ldistance", {Text = "Limit Distance", Default = false}):OnChanged(function() espLib.options.limitDistance = Toggles.ldistance.Value end)
GroupBox69:AddSlider('mdistance', {Text = 'Max Distance', Default = 5000, Min = 0, Max = 10000, Rounding = 1, Compact = false}) Options.mdistance:OnChanged(function() espLib.options.maxDistance = Options.mdistance.Value end)
GroupBox69:AddToggle("vcheck", {Text = "Visible Check", Default = false}):OnChanged(function() espLib.options.visibleOnly = Toggles.vcheck.Value end)
GroupBox69:AddToggle("afilled", {Text = "Arrows Filled", Default = false}):OnChanged(function() espLib.options.outOfViewArrowsOutlineFilled = Toggles.afilled.Value end)
GroupBox69:AddSlider('atransparency', {Text = 'Arrows Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.atransparency:OnChanged(function() espLib.options.outOfViewArrowsOutlineTransparency = Options.atransparency.Value / 100 end)
GroupBox69:AddSlider('btransparency', {Text = 'Boxes Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.btransparency:OnChanged(function() espLib.options.boxesTransparency = Options.btransparency.Value / 100 end)
GroupBox69:AddSlider('hbsize', {Text = 'HealthBar Size', Default = 1, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.hbsize:OnChanged(function() espLib.options.healthBarsSize = Options.hbsize.Value end)
GroupBox69:AddSlider('httransparency', {Text = 'HealthText Transparency', Default = 1, Min = 0, Max = 5, Rounding = 1, Compact = false}) Options.httransparency:OnChanged(function() espLib.options.healthTextTransparency = Options.httransparency.Value / 100 end)
GroupBox69:AddSlider('ctransparency', {Text = 'Chams Transparency', Default = 50, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.ctransparency:OnChanged(function() espLib.options.chamsFillTransparency = Options.ctransparency.Value / 100 end)
GroupBox69:AddSlider('dtransparency', {Text = 'Distance Transparency', Default = 100, Min = 0, Max = 100, Rounding = 1, Compact = false}) Options.dtransparency:OnChanged(function() espLib.options.distanceTransparency = Options.dtransparency.Value / 100 end)
GroupBox69:AddDropdown("tracerf", {Text = "Tracers", Default = "Top", Values = {"Top", "Bottom", "Mouse"}}):OnChanged(function() espLib.options.tracerOrigin = Options.tracerf.Value end)

GroupBox70:AddLabel('Name Color'):AddColorPicker('ncolor', { Default = Color3.new(1, 1, 1), Title = 'Name Color'}) Options.ncolor:OnChanged(function() espLib.options.nameColor = Options.ncolor.Value end)
GroupBox70:AddLabel('Box Color'):AddColorPicker('bcolor', { Default = Color3.new(1, 1, 1), Title = 'Box Color'}) Options.bcolor:OnChanged(function() espLib.options.boxesColor = Options.bcolor.Value end)
GroupBox70:AddLabel('HealthText Color'):AddColorPicker('htcolor', { Default = Color3.new(1, 1, 1), Title = 'HealthText Color'}) Options.htcolor:OnChanged(function() espLib.options.healthTextColor = Options.htcolor.Value end)
GroupBox70:AddLabel('Distance Color'):AddColorPicker('dcolor', { Default = Color3.new(1, 1, 1), Title = 'Distance Color'}) Options.dcolor:OnChanged(function() espLib.options.distanceColor = Options.dcolor.Value end)
GroupBox70:AddLabel('Tracer Color'):AddColorPicker('tcolor', { Default = Color3.new(1, 1, 1), Title = 'Tracer Color'}) Options.tcolor:OnChanged(function() espLib.options.tracerColor = Options.tcolor.Value end)
GroupBox70:AddLabel('Chams Color'):AddColorPicker('ccolor', { Default = Color3.new(1, 0, 0), Title = 'Chams Color'}) Options.ccolor:OnChanged(function() espLib.options.chamsFillColor = Options.ccolor.Value end)
GroupBox70:AddLabel('Arrow Color'):AddColorPicker('acolor', { Default = Color3.new(1, 1, 1), Title = 'Arrow Color'}) Options.acolor:OnChanged(function() espLib.options.outOfViewArrowsOutlineColor = Options.acolor.Value end)

espLib:Load()