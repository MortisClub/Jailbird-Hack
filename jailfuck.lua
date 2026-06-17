--[[
    ⚡ JailFUCK v2.3 by MortisHAck
    ✓ Исправлен прицел (точное наведение)
    ✓ FOV Lock (защита от анимаций)
    ✓ Правильный расчёт углов камеры
    ✓ Gravity Control
    ✓ Advanced Humanizer
    ✓ Full ESP Configuration
]]

print("🔄 Загрузка ⚡ JailFUCK v2.3 by MortisHAck...")

-- ================================================
-- LOAD LIBRARY
-- ================================================
local success, err = pcall(function()
    local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
    _G.Library      = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    _G.ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    _G.SaveManager  = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
    print("✅ Библиотека загружена")
end)

if not success then
    warn("❌ Ошибка загрузки библиотеки:", err)
    return
end

local Library      = _G.Library
local ThemeManager = _G.ThemeManager
local SaveManager  = _G.SaveManager

-- ================================================
-- СЕРВИСЫ
-- ================================================
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local Workspace        = game:GetService("Workspace")
local Camera           = Workspace.CurrentCamera
local LocalPlayer      = Players.LocalPlayer

-- ================================================
-- КОНФИГ
-- ================================================
local Config = {
    ESP = {
        Enabled           = false,
        Box               = true,
        BoxThickness      = 2,
        BoxFilled         = false,
        BoxFillTrans      = 0.8,
        Name              = true,
        NameSize          = 14,
        NameOutline       = true,
        HealthBar         = true,
        HealthBarWidth    = 4,
        Distance          = true,
        DistanceMax       = 2000,
        Chams             = false,
        ChamsTransparency = 0.3,
        ChamsOutlineTrans = 0,
        TeamCheck         = true,
        EnemyColor        = Color3.fromRGB(255, 85, 85),
        TextColor         = Color3.fromRGB(255, 255, 255),
    },

    Aimbot = {
        Enabled           = false,
        AimKey            = "MouseButton2",
        FOV               = 150,
        FOVColor          = Color3.fromRGB(255, 255, 255),
        FOVThickness      = 1,
        Smoothness        = 8.0,
        ShowFOV           = true,
        TargetPart        = "Head",
        PredictionEnabled = false,
        PredictionAmount  = 0.135,
        VisibilityCheck   = false,
        MaxDistance       = 1000,
        StickyAim         = false,
        StickyStrength    = 0.5,
        IgnoreTeam        = true,
        TargetColor       = Color3.fromRGB(255, 85, 85),

        Humanizer = {
            Enabled       = false,
            ReactionTime  = 0.08,
            ShakeAmount   = 0.5,
            ShakeSpeed    = 1.0,
            MissChance    = 0,
            AimDrift      = false,
            DriftStrength = 0.3,
            DriftSpeed    = 1.0,
            RandomSeed    = true,
        },
    },

    Movement = {
        GravityEnabled  = false,
        GravityValue    = 196.2,
        OriginalGravity = Workspace.Gravity,
        GravityActive   = false,
        SpeedEnabled    = false,
        SpeedValue      = 16,
        JumpEnabled     = false,
        JumpValue       = 50,
        NoFallDamage    = false,
        InfiniteJump    = false,
    },

    Visual = {
        Crosshair      = false,
        CrosshairSize  = 12,
        CrosshairGap   = 5,
        CrosshairThick = 2,
        CrosshairColor = Color3.fromRGB(255, 255, 255),
        CrosshairDot   = false,
        DotSize        = 3,
        DotColor       = Color3.fromRGB(255, 0, 0),
        Watermark      = true,
        FPSCounter     = true,
        PingCounter    = true,
    },

    Misc = {
        AntiAFK         = false,
        AntiAFKConn     = nil,
        NoRecoil        = false,
        RecoilReduction = 1.0,
        BunnyHop        = false,
        AutoSprint      = false,
        ThirdPerson     = false,
        CameraDistance  = 10,
        FOVChanger      = false,
        CameraFOV       = 70,
        OriginalFOV     = 70,
        TimeOfDay       = false,
        TimeValue       = 14,
        AmbientEnabled  = false,
        AmbientColor    = Color3.fromRGB(128, 128, 128),
    },
}

-- ================================================
-- DRAWINGS
-- ================================================
local DrawingCache = {}

local function NewDrawing(dtype, props)
    local d = Drawing.new(dtype)
    for k, v in pairs(props or {}) do
        pcall(function() d[k] = v end)
    end
    table.insert(DrawingCache, d)
    return d
end

-- ================================================
-- FPS HELPER
-- ================================================
local _fps = 60
local _lastFrame = tick()

RunService.RenderStepped:Connect(function()
    local now = tick()
    local delta = now - _lastFrame
    _lastFrame = now
    _fps = math.floor(1 / math.max(delta, 1e-5))
end)

-- ================================================
-- FOV LOCK
-- ================================================
local FOVLock = {
    Enabled       = false,
    TargetFOV     = 70,
    Connection    = nil,
}

function FOVLock:Start()
    if self.Connection then return end
    self.Enabled = true
    self.Connection = RunService.RenderStepped:Connect(function()
        if self.Enabled and Camera.FieldOfView ~= self.TargetFOV then
            Camera.FieldOfView = self.TargetFOV
        end
    end)
end

function FOVLock:Stop()
    self.Enabled = false
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function FOVLock:SetFOV(value)
    self.TargetFOV = value
    Camera.FieldOfView = value
end

Config.Misc.OriginalFOV = Camera.FieldOfView

-- ================================================
-- GRAVITY CONTROL
-- ================================================
local GravityControl = { Indicator = nil, Active = false }

function GravityControl:Initialize()
    self.Indicator = NewDrawing("Text", {
        Text     = "🌙 LOW GRAVITY",
        Size     = 18,
        Center   = true,
        Outline  = true,
        Font     = 3,
        Color    = Color3.fromRGB(100, 200, 255),
        Position = Vector2.new(Camera.ViewportSize.X / 2, 30),
        Visible  = false,
    })
end

function GravityControl:Toggle()
    self.Active = not self.Active
    Config.Movement.GravityActive = self.Active
    if self.Active then
        Workspace.Gravity = Config.Movement.GravityValue
        self.Indicator.Visible = true
        Library:Notify("🌙 Гравитация активирована", 2)
    else
        Workspace.Gravity = Config.Movement.OriginalGravity
        self.Indicator.Visible = false
        Library:Notify("🌍 Гравитация восстановлена", 2)
    end
end

function GravityControl:Update()
    if not self.Indicator then return end
    local vp = Camera.ViewportSize
    self.Indicator.Position = Vector2.new(vp.X / 2, 30)
    if self.Active then
        local p = math.abs(math.sin(tick() * 3))
        self.Indicator.Color = Color3.fromRGB(
            math.clamp(100 + p * 155, 0, 255),
            math.clamp(200 + p * 55,  0, 255),
            255
        )
        self.Indicator.Visible = true
        if Workspace.Gravity ~= Config.Movement.GravityValue then
            Workspace.Gravity = Config.Movement.GravityValue
        end
    else
        self.Indicator.Visible = false
    end
end

-- ================================================
-- AIMBOT (PERFECT FIX)
-- ================================================
local Aimbot = {
    FOVCircle      = nil,
    TargetDot      = nil,
    CurrentTarget  = nil,
    LastAimTime    = 0,
}

function Aimbot:Initialize()
    self.FOVCircle = NewDrawing("Circle", {
        Thickness    = Config.Aimbot.FOVThickness,
        NumSides     = 64,
        Radius       = Config.Aimbot.FOV,
        Filled       = false,
        Visible      = false,
        Color        = Config.Aimbot.FOVColor,
        Transparency = 1,
    })
    self.TargetDot = NewDrawing("Circle", {
        Thickness    = 1,
        NumSides     = 16,
        Radius       = 5,
        Filled       = true,
        Visible      = false,
        Color        = Config.Aimbot.TargetColor,
        Transparency = 1,
    })
end

function Aimbot:GetBestTarget()
    local vp         = Camera.ViewportSize
    local center     = Vector2.new(vp.X / 2, vp.Y / 2)
    local bestDist   = Config.Aimbot.FOV
    local bestTarget = nil

    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Config.Aimbot.IgnoreTeam and player.Team == LocalPlayer.Team then continue end

        local char = player.Character
        if not char then continue end

        local part = char:FindFirstChild(Config.Aimbot.TargetPart)
            or char:FindFirstChild("Head")
            or char:FindFirstChild("HumanoidRootPart")
        if not part then continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        local worldPos = part.Position

        -- Prediction
        if Config.Aimbot.PredictionEnabled then
            local velocity = Vector3.new(0, 0, 0)
            pcall(function()
                velocity = part.AssemblyLinearVelocity
            end)
            local horizontalVel = Vector3.new(velocity.X, 0, velocity.Z)
            worldPos = worldPos + (horizontalVel * Config.Aimbot.PredictionAmount)
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(worldPos)
        if not onScreen then continue end

        local dist3D = myRoot and (myRoot.Position - part.Position).Magnitude or 9999
        if dist3D > Config.Aimbot.MaxDistance then continue end

        -- Visibility Check
        if Config.Aimbot.VisibilityCheck then
            local origin    = Camera.CFrame.Position
            local direction = (part.Position - origin).Unit * dist3D
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {myChar, char}
            rayParams.FilterType = Enum.RaycastFilterType.Blacklist
            
            local result = Workspace:Raycast(origin, direction, rayParams)
            if result then continue end
        end

        local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if screenDist < bestDist then
            bestDist   = screenDist
            bestTarget = {
                player    = player,
                part      = part,
                screenPos = Vector2.new(screenPos.X, screenPos.Y),
                worldPos  = worldPos,
            }
        end
    end

    return bestTarget
end

function Aimbot:Update()
    if not self.FOVCircle then return end
    local vp     = Camera.ViewportSize
    local center = Vector2.new(vp.X / 2, vp.Y / 2)

    -- FOV круг
    self.FOVCircle.Position  = center
    self.FOVCircle.Radius    = Config.Aimbot.FOV
    self.FOVCircle.Color     = Config.Aimbot.FOVColor
    self.FOVCircle.Thickness = Config.Aimbot.FOVThickness
    self.FOVCircle.Visible   = Config.Aimbot.Enabled and Config.Aimbot.ShowFOV

    if not Config.Aimbot.Enabled then
        self.TargetDot.Visible = false
        return
    end

    local target = self:GetBestTarget()
    self.CurrentTarget = target

    if target then
        self.TargetDot.Position = target.screenPos
        self.TargetDot.Color    = Config.Aimbot.TargetColor
        self.TargetDot.Visible  = true

        -- проверка клавиши
        local holdingKey = false
        if Config.Aimbot.AimKey == "MouseButton2" then
            holdingKey = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        else
            pcall(function()
                holdingKey = UserInputService:IsKeyDown(Enum.KeyCode[Config.Aimbot.AimKey])
            end)
        end

        if holdingKey then
            local now = tick()

            -- Humanizer: Reaction Time
            if Config.Aimbot.Humanizer.Enabled then
                if (now - self.LastAimTime) < Config.Aimbot.Humanizer.ReactionTime then
                    return
                end
                -- Miss Chance
                if Config.Aimbot.Humanizer.MissChance > 0 then
                    if math.random(0, 100) < Config.Aimbot.Humanizer.MissChance then
                        self.LastAimTime = now
                        return
                    end
                end
            end
            self.LastAimTime = now

            local targetPos = target.worldPos

            -- ✅ HUMANIZER: Shake & Drift (в 3D пространстве)
            if Config.Aimbot.Humanizer.Enabled then
                local shake = Config.Aimbot.Humanizer.ShakeAmount * 0.01
                local speed = Config.Aimbot.Humanizer.ShakeSpeed
                local seed  = Config.Aimbot.Humanizer.RandomSeed and math.random(-100, 100) or 0
                
                targetPos = targetPos + Vector3.new(
                    math.sin(tick() * speed * 10 + seed) * shake,
                    math.cos(tick() * speed * 10 + seed) * shake,
                    math.sin(tick() * speed * 7 + seed) * shake
                )

                if Config.Aimbot.Humanizer.AimDrift then
                    local ds  = Config.Aimbot.Humanizer.DriftStrength * 0.01
                    local dsp = Config.Aimbot.Humanizer.DriftSpeed
                    targetPos = targetPos + Vector3.new(
                        math.sin(tick() * dsp)       * ds,
                        math.cos(tick() * dsp * 0.7) * ds,
                        0
                    )
                end
            end

            -- ✅ ПРАВИЛЬНОЕ НАВЕДЕНИЕ (через LookVector)
            local camPos = Camera.CFrame.Position
            local direction = (targetPos - camPos).Unit
            
            local newCFrame = CFrame.new(camPos, camPos + direction)
            
            -- ✅ ПЛАВНОСТЬ через Lerp
            local smoothness = Config.Aimbot.Smoothness
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, 1 / smoothness)
        end
    else
        self.TargetDot.Visible = false
    end
end

-- ================================================
-- ESP
-- ================================================
local ESPObjects = {}

local function GetHealthColor(pct)
    local r = math.clamp(math.floor(255 * (1 - pct)), 0, 255)
    local g = math.clamp(math.floor(255 * pct),       0, 255)
    return Color3.fromRGB(r, g, 0)
end

Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, d in pairs(ESPObjects[player]) do
            pcall(function()
                if typeof(d) == "Instance" then
                    d:Destroy()
                else
                    d:Remove()
                end
            end)
        end
        ESPObjects[player] = nil
    end
end)

local function UpdateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end

        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum  = char and char:FindFirstChildOfClass("Humanoid")

        local function hideESP()
            if ESPObjects[player] then
                for k, d in pairs(ESPObjects[player]) do
                    if k ~= "Highlight" then
                        pcall(function() d.Visible = false end)
                    end
                end
            end
        end

        if not (char and root and hum) then
            hideESP()
            continue
        end

        if Config.ESP.TeamCheck and player.Team == LocalPlayer.Team then
            hideESP()
            if ESPObjects[player] and ESPObjects[player].Highlight then
                pcall(function()
                    ESPObjects[player].Highlight.Enabled = false
                end)
            end
            continue
        end

        local dist = (root.Position - Camera.CFrame.Position).Magnitude
        if dist > Config.ESP.DistanceMax then
            hideESP()
            continue
        end

        if not ESPObjects[player] then
            ESPObjects[player] = {
                Box       = NewDrawing("Square", {Thickness = 2, Filled = false, Visible = false}),
                BoxFill   = NewDrawing("Square", {Thickness = 0, Filled = true,  Visible = false}),
                Name      = NewDrawing("Text",   {Size = 14, Center = true, Outline = true, Visible = false}),
                DistLabel = NewDrawing("Text",   {Size = 12, Center = true, Outline = true, Visible = false}),
                HealthBG  = NewDrawing("Square", {Thickness = 0, Filled = true,  Visible = false,
                                                  Color = Color3.fromRGB(0, 0, 0), Transparency = 1}),
                HealthBar = NewDrawing("Square", {Thickness = 0, Filled = true,  Visible = false}),
                Highlight = nil,
            }
        end

        local esp = ESPObjects[player]

        -- Chams
        if Config.ESP.Chams then
            local hl = esp.Highlight
            if not hl or not hl.Parent then
                pcall(function()
                    local old = char:FindFirstChild("ESP_Highlight")
                    if old then old:Destroy() end

                    local h = Instance.new("Highlight")
                    h.Name                = "ESP_Highlight"
                    h.Adornee             = char
                    h.FillColor           = Config.ESP.EnemyColor
                    h.OutlineColor        = Config.ESP.EnemyColor
                    h.FillTransparency    = Config.ESP.ChamsTransparency
                    h.OutlineTransparency = Config.ESP.ChamsOutlineTrans
                    h.DepthMode           = Enum.HighlightDepthMode.AlwaysOnTop
                    h.Enabled             = true
                    h.Parent              = char
                    esp.Highlight         = h
                end)
            else
                pcall(function()
                    hl.Enabled             = true
                    hl.FillColor           = Config.ESP.EnemyColor
                    hl.FillTransparency    = Config.ESP.ChamsTransparency
                    hl.OutlineTransparency = Config.ESP.ChamsOutlineTrans
                end)
            end
        else
            if esp.Highlight then
                pcall(function() esp.Highlight.Enabled = false end)
            end
        end

        if not Config.ESP.Enabled then
            hideESP()
            continue
        end

        local head = char:FindFirstChild("Head")
        if not head then hideESP(); continue end

        local rootScreen, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then hideESP(); continue end

        local headScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
        local boxH  = math.max(math.abs(rootScreen.Y - headScreen.Y) * 2.2, 10)
        local boxW  = boxH * 0.6
        local boxX  = rootScreen.X - boxW / 2
        local boxY  = headScreen.Y - 4

        local healthPct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
        local color     = Config.ESP.EnemyColor

        -- Box
        esp.Box.Visible      = Config.ESP.Box
        esp.Box.Position     = Vector2.new(boxX, boxY)
        esp.Box.Size         = Vector2.new(boxW, boxH)
        esp.Box.Color        = color
        esp.Box.Thickness    = Config.ESP.BoxThickness
        esp.Box.Transparency = 1

        -- Box Fill
        esp.BoxFill.Visible      = Config.ESP.Box and Config.ESP.BoxFilled
        esp.BoxFill.Position     = Vector2.new(boxX, boxY)
        esp.BoxFill.Size         = Vector2.new(boxW, boxH)
        esp.BoxFill.Color        = color
        esp.BoxFill.Transparency = 1 - Config.ESP.BoxFillTrans

        -- Name
        esp.Name.Visible   = Config.ESP.Name
        esp.Name.Text      = player.DisplayName
        esp.Name.Size      = Config.ESP.NameSize
        esp.Name.Position  = Vector2.new(rootScreen.X, boxY - Config.ESP.NameSize - 2)
        esp.Name.Color     = Config.ESP.TextColor
        esp.Name.Outline   = Config.ESP.NameOutline

        -- Distance
        esp.DistLabel.Visible  = Config.ESP.Distance
        esp.DistLabel.Text     = string.format("[%dm]", math.floor(dist / 5))
        esp.DistLabel.Size     = 11
        esp.DistLabel.Position = Vector2.new(rootScreen.X, boxY + boxH + 2)
        esp.DistLabel.Color    = Color3.fromRGB(200, 200, 200)
        esp.DistLabel.Transparency = 1

        -- Health Bar
        local barW    = Config.ESP.HealthBarWidth
        local barX    = boxX - barW - 2
        local barH    = boxH * healthPct
        local barOffY = boxH - barH

        esp.HealthBG.Visible      = Config.ESP.HealthBar
        esp.HealthBG.Position     = Vector2.new(barX, boxY)
        esp.HealthBG.Size         = Vector2.new(barW, boxH)
        esp.HealthBG.Transparency = 1

        esp.HealthBar.Visible      = Config.ESP.HealthBar
        esp.HealthBar.Position     = Vector2.new(barX, boxY + barOffY)
        esp.HealthBar.Size         = Vector2.new(barW, math.max(barH, 1))
        esp.HealthBar.Color        = GetHealthColor(healthPct)
        esp.HealthBar.Transparency = 1
    end
end

-- ================================================
-- CROSSHAIR
-- ================================================
local CrosshairDraw = { Lines = {}, Dot = nil }

function CrosshairDraw:Initialize()
    for i = 1, 4 do
        self.Lines[i] = NewDrawing("Line", {
            Thickness    = 2,
            Visible      = false,
            Transparency = 1,
            Color        = Color3.fromRGB(255, 255, 255),
        })
    end
    self.Dot = NewDrawing("Circle", {
        Radius       = 3,
        Filled       = true,
        NumSides     = 16,
        Visible      = false,
        Transparency = 1,
        Color        = Color3.fromRGB(255, 0, 0),
    })
end

function CrosshairDraw:Update()
    if not Config.Visual.Crosshair then
        for i = 1, 4 do self.Lines[i].Visible = false end
        self.Dot.Visible = false
        return
    end

    local vp     = Camera.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2
    local sz     = Config.Visual.CrosshairSize
    local gap    = Config.Visual.CrosshairGap
    local thick  = Config.Visual.CrosshairThick
    local color  = Config.Visual.CrosshairColor

    local positions = {
        {Vector2.new(cx, cy - gap),      Vector2.new(cx, cy - gap - sz)},
        {Vector2.new(cx, cy + gap),      Vector2.new(cx, cy + gap + sz)},
        {Vector2.new(cx - gap, cy),      Vector2.new(cx - gap - sz, cy)},
        {Vector2.new(cx + gap, cy),      Vector2.new(cx + gap + sz, cy)},
    }

    for i = 1, 4 do
        self.Lines[i].Visible   = true
        self.Lines[i].Color     = color
        self.Lines[i].Thickness = thick
        self.Lines[i].From      = positions[i][1]
        self.Lines[i].To        = positions[i][2]
    end

    self.Dot.Visible  = Config.Visual.CrosshairDot
    self.Dot.Position = Vector2.new(cx, cy)
    self.Dot.Radius   = Config.Visual.DotSize
    self.Dot.Color    = Config.Visual.DotColor
end

-- ================================================
-- WATERMARK
-- ================================================
local WatermarkObj = { Label = nil }

function WatermarkObj:Initialize()
    self.Label = NewDrawing("Text", {
        Text         = "⚡ JailFUCK v2.3 by MortisHAck",
        Size         = 14,
        Center       = false,
        Outline      = true,
        Font         = 3,
        Color        = Color3.fromRGB(255, 255, 255),
        Position     = Vector2.new(10, 10),
        Visible      = true,
        Transparency = 1,
    })
end

function WatermarkObj:Update()
    if not self.Label then return end
    if not Config.Visual.Watermark then
        self.Label.Visible = false
        return
    end
    local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
    local text = "⚡ JailFUCK v2.3 by MortisHAck"
    if Config.Visual.FPSCounter  then text = text .. string.format(" | FPS: %d",    _fps)  end
    if Config.Visual.PingCounter then text = text .. string.format(" | Ping: %dms", ping)  end
    self.Label.Text    = text
    self.Label.Visible = true
end

-- ================================================
-- ANTI-AFK
-- ================================================
local _antiAFKConn = nil

local function SetAntiAFK(enabled)
    if enabled and not _antiAFKConn then
        pcall(function()
            local VirtualUser = game:GetService("VirtualUser")
            _antiAFKConn = LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end)
    elseif not enabled and _antiAFKConn then
        pcall(function() _antiAFKConn:Disconnect() end)
        _antiAFKConn = nil
    end
end

-- ================================================
-- CREATE WINDOW
-- ================================================
print("🔄 Создание GUI...")

local Window = Library:CreateWindow({
    Title        = '⚡ JailFUCK v2.3 by MortisHAck',
    Center       = true,
    AutoShow     = true,
    TabPadding   = 8,
    MenuFadeTime = 0.2,
})

local Tabs = {
    Main     = Window:AddTab('🏠 Main'),
    ESP      = Window:AddTab('👁️ ESP'),
    Aimbot   = Window:AddTab('🎯 Aimbot'),
    Movement = Window:AddTab('🏃 Movement'),
    Visual   = Window:AddTab('🎨 Visual'),
    Misc     = Window:AddTab('🔧 Misc'),
    Settings = Window:AddTab('⚙️ Settings'),
}

print("✅ Window & табы созданы")

-- ================================================
-- MAIN TAB
-- ================================================
do
    local InfoBox = Tabs.Main:AddLeftGroupbox('Информация')
    InfoBox:AddLabel('⚡  JailFUCK v2.3 by MortisHAck')
    InfoBox:AddLabel('🎯 новая система аима')
    InfoBox:AddDivider()
    InfoBox:AddLabel('✅ Голова яйца')
    InfoBox:AddLabel('✅ CFrame.Lerp ')
    InfoBox:AddLabel('✅ фикс фова')
    InfoBox:AddLabel('✅ ESP новый дизайн Chams(тест)')
    InfoBox:AddLabel('✅ + Gravity Control')
    InfoBox:AddLabel('✅ + Advanced Humanizer')
    InfoBox:AddDivider()
    InfoBox:AddLabel('RightShift — меню')
    InfoBox:AddLabel('V — гравитация (тест)')

    local CtrlBox = Tabs.Main:AddRightGroupbox('Статус системы')
    CtrlBox:AddLabel('Версия: v2.3')
    CtrlBox:AddLabel('Находиться в бета тестировании')
    CtrlBox:AddDivider()
    CtrlBox:AddButton({
        Text = '🗑️ Выгрузить (двойной клик)',
        Func = function()
            if GravityControl.Active then GravityControl:Toggle() end
            Workspace.Gravity = Config.Movement.OriginalGravity
            FOVLock:Stop()
            Camera.FieldOfView = Config.Misc.OriginalFOV
            SetAntiAFK(false)
            Library:Unload()
            for _, d in pairs(DrawingCache) do
                pcall(function() d:Remove() end)
            end
        end,
        DoubleClick = true,
    })
end

-- ================================================
-- ESP TAB
-- ================================================
do
    local E1 = Tabs.ESP:AddLeftGroupbox('🔧 Основные')

    E1:AddToggle('ESPEnabled', {
        Text     = 'Включить ESP',
        Default  = false,
        Callback = function(v)
            Config.ESP.Enabled = v
            Library:Notify(v and '✅ ESP вкл' or '❌ ESP выкл', 2)
        end,
    })

    E1:AddToggle('ESPBox', {
        Text     = 'Рамка вокруг игрока',
        Default  = true,
        Callback = function(v) Config.ESP.Box = v end,
    })

    E1:AddToggle('ESPBoxFilled', {
        Text     = 'Заливка рамки',
        Default  = false,
        Callback = function(v) Config.ESP.BoxFilled = v end,
    })

    E1:AddSlider('ESPBoxFillTrans', {
        Text     = 'Прозрачность заливки',
        Default  = 0.8,
        Min      = 0.1,
        Max      = 1.0,
        Rounding = 2,
        Callback = function(v) Config.ESP.BoxFillTrans = v end,
    })

    E1:AddSlider('ESPBoxThick', {
        Text     = 'Толщина рамки',
        Default  = 2,
        Min      = 1,
        Max      = 6,
        Rounding = 0,
        Callback = function(v) Config.ESP.BoxThickness = v end,
    })

    E1:AddDivider()

    E1:AddToggle('ESPName', {
        Text     = 'Имя игрока',
        Default  = true,
        Callback = function(v) Config.ESP.Name = v end,
    })

    E1:AddSlider('ESPNameSize', {
        Text     = 'Размер имени',
        Default  = 14,
        Min      = 8,
        Max      = 24,
        Rounding = 0,
        Callback = function(v) Config.ESP.NameSize = v end,
    })

    E1:AddToggle('ESPNameOutline', {
        Text     = 'Обводка имени',
        Default  = true,
        Callback = function(v) Config.ESP.NameOutline = v end,
    })

    E1:AddToggle('ESPDistance', {
        Text     = 'Дистанция',
        Default  = true,
        Callback = function(v) Config.ESP.Distance = v end,
    })

    E1:AddSlider('ESPDistMax', {
        Text     = 'Макс. дистанция (studs)',
        Default  = 2000,
        Min      = 100,
        Max      = 5000,
        Rounding = 0,
        Callback = function(v) Config.ESP.DistanceMax = v end,
    })

    local E2 = Tabs.ESP:AddRightGroupbox('🎨 Цвета & Chams')

    E2:AddToggle('ESPHealthBar', {
        Text     = 'Полоса здоровья',
        Default  = true,
        Callback = function(v) Config.ESP.HealthBar = v end,
    })

    E2:AddSlider('ESPHealthBarW', {
        Text     = 'Ширина полосы HP',
        Default  = 4,
        Min      = 2,
        Max      = 10,
        Rounding = 0,
        Callback = function(v) Config.ESP.HealthBarWidth = v end,
    })

    E2:AddDivider()

    E2:AddLabel('Цвет врагов'):AddColorPicker('ESPEnemyColor', {
        Default  = Color3.fromRGB(255, 85, 85),
        Title    = 'Цвет врагов',
        Callback = function(v) Config.ESP.EnemyColor = v end,
    })

    E2:AddLabel('Цвет текста'):AddColorPicker('ESPTextColor', {
        Default  = Color3.fromRGB(255, 255, 255),
        Title    = 'Цвет текста',
        Callback = function(v) Config.ESP.TextColor = v end,
    })

    E2:AddToggle('ESPTeamCheck', {
        Text     = 'Скрывать своих',
        Default  = true,
        Callback = function(v) Config.ESP.TeamCheck = v end,
    })

    E2:AddDivider()

    E2:AddToggle('ESPChams', {
        Text     = 'Chams (тестирование)',
        Default  = false,
        Callback = function(v)
            Config.ESP.Chams = v
            Library:Notify(v and '✅ Chams вкл' or '❌ Chams выкл', 2)
        end,
    })

    E2:AddSlider('ESPChamsFillTrans', {
        Text     = 'Прозрачность заливки Chams',
        Default  = 0.3,
        Min      = 0.0,
        Max      = 1.0,
        Rounding = 2,
        Callback = function(v) Config.ESP.ChamsTransparency = v end,
    })

    E2:AddSlider('ESPChamsOutlineTrans', {
        Text     = 'Прозрачность контура Chams',
        Default  = 0.0,
        Min      = 0.0,
        Max      = 1.0,
        Rounding = 2,
        Callback = function(v) Config.ESP.ChamsOutlineTrans = v end,
    })
end

-- ================================================
-- AIMBOT TAB
-- ================================================
do
    local A1 = Tabs.Aimbot:AddLeftGroupbox('🎯 Aimbot Core')

    A1:AddToggle('AimbotEnabled', {
        Text     = 'Включить Aimbot',
        Default  = false,
        Callback = function(v)
            Config.Aimbot.Enabled = v
            Library:Notify(v and '✅ Aimbot вкл' or '❌ Aimbot выкл', 2)
        end,
    })

    A1:AddDropdown('AimbotKey', {
        Values   = {'MouseButton2', 'LeftAlt', 'LeftControl', 'CapsLock', 'Z', 'X', 'C'},
        Default  = 1,
        Text     = 'Клавиша прицела',
        Callback = function(v) Config.Aimbot.AimKey = v end,
    })

    A1:AddDropdown('AimbotPart', {
        Values   = {'Head', 'UpperTorso', 'LowerTorso', 'HumanoidRootPart'},
        Default  = 1,
        Text     = 'Целиться в',
        Callback = function(v) Config.Aimbot.TargetPart = v end,
    })

    A1:AddSlider('AimbotFOV', {
        Text     = 'Размер FOV',
        Default  = 150,
        Min      = 10,
        Max      = 600,
        Rounding = 0,
        Callback = function(v) Config.Aimbot.FOV = v end,
    })

    A1:AddSlider('AimbotSmooth', {
        Text     = 'Плавность (больше = плавнее)',
        Default  = 8.0,
        Min      = 1.0,
        Max      = 20.0,
        Rounding = 1,
        Tooltip  = 'Рекомендую: 6-10',
        Callback = function(v) Config.Aimbot.Smoothness = v end,
    })

    A1:AddSlider('AimbotMaxDist', {
        Text     = 'Макс. дистанция',
        Default  = 1000,
        Min      = 50,
        Max      = 3000,
        Rounding = 0,
        Callback = function(v) Config.Aimbot.MaxDistance = v end,
    })

    A1:AddDivider()

    A1:AddToggle('AimbotShowFOV', {
        Text     = 'Показать FOV круг',
        Default  = true,
        Callback = function(v) Config.Aimbot.ShowFOV = v end,
    })

    A1:AddSlider('AimbotFOVThick', {
        Text     = 'Толщина FOV',
        Default  = 1,
        Min      = 1,
        Max      = 4,
        Rounding = 0,
        Callback = function(v) Config.Aimbot.FOVThickness = v end,
    })

    A1:AddLabel('Цвет FOV'):AddColorPicker('AimbotFOVColor', {
        Default  = Color3.fromRGB(255, 255, 255),
        Title    = 'Цвет FOV',
        Callback = function(v) Config.Aimbot.FOVColor = v end,
    })

    A1:AddLabel('Цвет цели'):AddColorPicker('AimbotTargetColor', {
        Default  = Color3.fromRGB(255, 0, 0),
        Title    = 'Цвет точки цели',
        Callback = function(v) Config.Aimbot.TargetColor = v end,
    })

    local A2 = Tabs.Aimbot:AddRightGroupbox('⚙️ Дополнительно')

    A2:AddToggle('AimbotVisCheck', {
        Text     = 'Проверка видимости',
        Default  = false,
        Tooltip  = 'Не целиться сквозь стены',
        Callback = function(v) Config.Aimbot.VisibilityCheck = v end,
    })

    A2:AddToggle('AimbotIgnoreTeam', {
        Text     = 'Игнорировать команду',
        Default  = true,
        Callback = function(v) Config.Aimbot.IgnoreTeam = v end,
    })

    A2:AddToggle('AimbotPrediction', {
        Text     = 'Предсказание (Prediction)',
        Default  = false,
        Tooltip  = 'Учитывает движение цели',
        Callback = function(v) Config.Aimbot.PredictionEnabled = v end,
    })

    A2:AddSlider('AimbotPredAmount', {
        Text     = 'Сила предсказания',
        Default  = 0.135,
        Min      = 0.01,
        Max      = 0.5,
        Rounding = 3,
        Callback = function(v) Config.Aimbot.PredictionAmount = v end,
    })

    A2:AddDivider()
    A2:AddLabel('═══ Humanizer ═══')

    A2:AddToggle('HumanizerEnabled', {
        Text     = 'Включить Humanizer',
        Default  = false,
        Tooltip  = 'Имитирует человеческий аим',
        Callback = function(v) Config.Aimbot.Humanizer.Enabled = v end,
    })

    A2:AddSlider('HumanizerReact', {
        Text     = 'Время реакции (мс)',
        Default  = 80,
        Min      = 0,
        Max      = 500,
        Rounding = 0,
        Callback = function(v) Config.Aimbot.Humanizer.ReactionTime = v / 1000 end,
    })

    A2:AddSlider('HumanizerShake', {
        Text     = 'Тряска прицела',
        Default  = 0.5,
        Min      = 0.0,
        Max      = 10.0,
        Rounding = 1,
        Callback = function(v) Config.Aimbot.Humanizer.ShakeAmount = v end,
    })

    A2:AddSlider('HumanizerShakeSpd', {
        Text     = 'Скорость тряски',
        Default  = 1.0,
        Min      = 0.1,
        Max      = 5.0,
        Rounding = 1,
        Callback = function(v) Config.Aimbot.Humanizer.ShakeSpeed = v end,
    })

    A2:AddSlider('HumanizerMiss', {
        Text     = 'Шанс промаха (%)',
        Default  = 0,
        Min      = 0,
        Max      = 50,
        Rounding = 0,
        Tooltip  = '0 = никогда не мажет',
        Callback = function(v) Config.Aimbot.Humanizer.MissChance = v end,
    })

    A2:AddToggle('HumanizerDrift', {
        Text     = 'Дрейф прицела',
        Default  = false,
        Tooltip  = 'Плавное покачивание',
        Callback = function(v) Config.Aimbot.Humanizer.AimDrift = v end,
    })

    A2:AddSlider('HumanizerDriftStr', {
        Text     = 'Сила дрейфа',
        Default  = 0.3,
        Min      = 0.1,
        Max      = 5.0,
        Rounding = 1,
        Callback = function(v) Config.Aimbot.Humanizer.DriftStrength = v end,
    })

    A2:AddSlider('HumanizerDriftSpd', {
        Text     = 'Скорость дрейфа',
        Default  = 1.0,
        Min      = 0.1,
        Max      = 5.0,
        Rounding = 1,
        Callback = function(v) Config.Aimbot.Humanizer.DriftSpeed = v end,
    })

    A2:AddToggle('HumanizerRandSeed', {
        Text     = 'Случайный сид тряски',
        Default  = true,
        Callback = function(v) Config.Aimbot.Humanizer.RandomSeed = v end,
    })
end

-- ================================================
-- MOVEMENT TAB
-- ================================================
do
    local G1 = Tabs.Movement:AddLeftGroupbox('🌙 Gravity Control (тестирование)')

    G1:AddToggle('GravityEnabled', {
        Text     = 'Включить управление (клавиша V)',
        Default  = false,
        Callback = function(v)
            Config.Movement.GravityEnabled = v
            if not v and GravityControl.Active then
                GravityControl:Toggle()
            end
        end,
    })

    G1:AddSlider('GravityValue', {
        Text     = 'Значение гравитации',
        Default  = 196,
        Min      = 0,
        Max      = 400,
        Rounding = 0,
        Tooltip  = 'Земля: 196 | Луна: 32 | Космос: 0',
        Callback = function(v)
            Config.Movement.GravityValue = v
            if GravityControl.Active then
                Workspace.Gravity = v
            end
        end,
    })

    G1:AddButton({
        Text = '🌍 Земля (196)',
        Func = function()
            Config.Movement.GravityValue = 196
            if GravityControl.Active then Workspace.Gravity = 196 end
            Library:Notify('🌍 Земная гравитация', 2)
        end,
    })

    G1:AddButton({
        Text = '🌙 Луна (32)',
        Func = function()
            Config.Movement.GravityValue = 32
            if GravityControl.Active then Workspace.Gravity = 32 end
            Library:Notify('🌙 Лунная гравитация', 2)
        end,
    })

    G1:AddButton({
        Text = '🪐 Марс (74)',
        Func = function()
            Config.Movement.GravityValue = 74
            if GravityControl.Active then Workspace.Gravity = 74 end
            Library:Notify('🪐 Марсианская гравитация', 2)
        end,
    })

    G1:AddButton({
        Text = '🚀 Космос (0)',
        Func = function()
            Config.Movement.GravityValue = 0
            if GravityControl.Active then Workspace.Gravity = 0 end
            Library:Notify('🚀 Невесомость!', 2)
        end,
    })

    G1:AddButton({
        Text = '⚡ Активировать / Деактивировать',
        Func = function()
            if Config.Movement.GravityEnabled then
                GravityControl:Toggle()
            else
                Library:Notify('❌ Сначала включи управление', 2)
            end
        end,
    })

    local M2 = Tabs.Movement:AddRightGroupbox('⚡ Скорость & Прыжок')

    M2:AddToggle('SpeedEnabled', {
        Text     = 'Изменить скорость',
        Default  = false,
        Callback = function(v)
            Config.Movement.SpeedEnabled = v
            local char = LocalPlayer.Character
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = v and Config.Movement.SpeedValue or 16
            end
        end,
    })

    M2:AddSlider('SpeedValue', {
        Text     = 'Скорость ходьбы',
        Default  = 16,
        Min      = 1,
        Max      = 200,
        Rounding = 0,
        Callback = function(v)
            Config.Movement.SpeedValue = v
            if Config.Movement.SpeedEnabled then
                local char = LocalPlayer.Character
                local hum  = char and char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = v end
            end
        end,
    })

    M2:AddDivider()

    M2:AddToggle('JumpEnabled', {
        Text     = 'Изменить прыжок',
        Default  = false,
        Callback = function(v)
            Config.Movement.JumpEnabled = v
            local char = LocalPlayer.Character
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.JumpPower = v and Config.Movement.JumpValue or 50
            end
        end,
    })

    M2:AddSlider('JumpValue', {
        Text     = 'Сила прыжка',
        Default  = 50,
        Min      = 1,
        Max      = 500,
        Rounding = 0,
        Callback = function(v)
            Config.Movement.JumpValue = v
            if Config.Movement.JumpEnabled then
                local char = LocalPlayer.Character
                local hum  = char and char:FindFirstChildOfClass("Humanoid")
                if hum then hum.JumpPower = v end
            end
        end,
    })

    M2:AddDivider()

    M2:AddToggle('InfiniteJump', {
        Text     = 'Бесконечный прыжок',
        Default  = false,
        Callback = function(v) Config.Movement.InfiniteJump = v end,
    })

    M2:AddToggle('NoFallDamage', {
        Text     = 'Нет урона от падения',
        Default  = false,
        Callback = function(v) Config.Movement.NoFallDamage = v end,
    })

    M2:AddToggle('BunnyHop', {
        Text     = 'BunnyHop (тест)',
        Default  = false,
        Tooltip  = 'Авто-прыжок при приземлении',
        Callback = function(v) Config.Misc.BunnyHop = v end,
    })

    M2:AddToggle('AutoSprint', {
        Text     = 'Авто-бег',
        Default  = false,
        Callback = function(v) Config.Misc.AutoSprint = v end,
    })
end

-- ================================================
-- VISUAL TAB
-- ================================================
do
    local V1 = Tabs.Visual:AddLeftGroupbox('🎯 Прицел')

    V1:AddToggle('Crosshair', {
        Text     = 'Включить прицел',
        Default  = false,
        Callback = function(v) Config.Visual.Crosshair = v end,
    })

    V1:AddSlider('CrosshairSize', {
        Text     = 'Длина линий',
        Default  = 12,
        Min      = 3,
        Max      = 50,
        Rounding = 0,
        Callback = function(v) Config.Visual.CrosshairSize = v end,
    })

    V1:AddSlider('CrosshairGap', {
        Text     = 'Зазор (gap)',
        Default  = 5,
        Min      = 0,
        Max      = 20,
        Rounding = 0,
        Callback = function(v) Config.Visual.CrosshairGap = v end,
    })

    V1:AddSlider('CrosshairThick', {
        Text     = 'Толщина линий',
        Default  = 2,
        Min      = 1,
        Max      = 6,
        Rounding = 0,
        Callback = function(v) Config.Visual.CrosshairThick = v end,
    })

    V1:AddLabel('Цвет прицела'):AddColorPicker('CrosshairColor', {
        Default  = Color3.fromRGB(255, 255, 255),
        Title    = 'Цвет прицела',
        Callback = function(v) Config.Visual.CrosshairColor = v end,
    })

    V1:AddToggle('CrosshairDot', {
        Text     = 'Центральная точка',
        Default  = false,
        Callback = function(v) Config.Visual.CrosshairDot = v end,
    })

    V1:AddSlider('DotSize', {
        Text     = 'Размер точки',
        Default  = 3,
        Min      = 1,
        Max      = 10,
        Rounding = 0,
        Callback = function(v) Config.Visual.DotSize = v end,
    })

    V1:AddLabel('Цвет точки'):AddColorPicker('DotColor', {
        Default  = Color3.fromRGB(255, 0, 0),
        Title    = 'Цвет точки',
        Callback = function(v) Config.Visual.DotColor = v end,
    })

    local V2 = Tabs.Visual:AddRightGroupbox('🖥️ Информация')

    V2:AddToggle('Watermark', {
        Text     = 'Watermark',
        Default  = true,
        Callback = function(v) Config.Visual.Watermark = v end,
    })

    V2:AddToggle('FPSCounter', {
        Text     = 'Счётчик FPS',
        Default  = true,
        Callback = function(v) Config.Visual.FPSCounter = v end,
    })

    V2:AddToggle('PingCounter', {
        Text     = 'Счётчик Ping',
        Default  = true,
        Callback = function(v) Config.Visual.PingCounter = v end,
    })

    V2:AddDivider()

    V2:AddToggle('FOVChanger', {
        Text     = 'Изменить FOV камеры + Lock',
        Default  = false,
        Tooltip  = 'Защищает от сброса анимациями',
        Callback = function(v)
            Config.Misc.FOVChanger = v
            if v then
                FOVLock:SetFOV(Config.Misc.CameraFOV)
                FOVLock:Start()
            else
                FOVLock:Stop()
                Camera.FieldOfView = Config.Misc.OriginalFOV
            end
        end,
    })

    V2:AddSlider('CameraFOV', {
        Text     = 'FOV камеры',
        Default  = 70,
        Min      = 30,
        Max      = 120,
        Rounding = 0,
        Callback = function(v)
            Config.Misc.CameraFOV = v
            if Config.Misc.FOVChanger then
                FOVLock:SetFOV(v)
            end
        end,
    })

    V2:AddDivider()

    V2:AddToggle('ThirdPerson', {
        Text     = 'Третье лицо',
        Default  = false,
        Callback = function(v)
            Config.Misc.ThirdPerson = v
            if not v then
                LocalPlayer.CameraMaxZoomDistance = 12.5
                LocalPlayer.CameraMinZoomDistance = 0.5
            else
                LocalPlayer.CameraMaxZoomDistance = Config.Misc.CameraDistance
                LocalPlayer.CameraMinZoomDistance = Config.Misc.CameraDistance
            end
        end,
    })

    V2:AddSlider('CameraDistance', {
        Text     = 'Дистанция камеры',
        Default  = 10,
        Min      = 5,
        Max      = 60,
        Rounding = 0,
        Callback = function(v)
            Config.Misc.CameraDistance = v
            if Config.Misc.ThirdPerson then
                LocalPlayer.CameraMaxZoomDistance = v
                LocalPlayer.CameraMinZoomDistance = v
            end
        end,
    })
end

-- ================================================
-- MISC TAB
-- ================================================
do
    local Mc1 = Tabs.Misc:AddLeftGroupbox('🔧 Разное')

    Mc1:AddToggle('AntiAFK', {
        Text     = 'Anti-AFK',
        Default  = false,
        Callback = function(v)
            Config.Misc.AntiAFK = v
            SetAntiAFK(v)
            Library:Notify(v and '✅ Anti-AFK вкл' or '❌ Anti-AFK выкл', 2)
        end,
    })

    Mc1:AddToggle('NoRecoil', {
        Text     = 'Уменьшить отдачу',
        Default  = false,
        Tooltip  = 'Снижает разброс камеры при стрельбе',
        Callback = function(v) Config.Misc.NoRecoil = v end,
    })

    Mc1:AddSlider('RecoilReduction', {
        Text     = 'Уровень подавления (%)',
        Default  = 100,
        Min      = 10,
        Max      = 100,
        Rounding = 0,
        Callback = function(v) Config.Misc.RecoilReduction = v / 100 end,
    })

    local Mc2 = Tabs.Misc:AddRightGroupbox('🌍 Мир')

    Mc2:AddToggle('TimeOfDay', {
        Text     = 'Изменить время суток',
        Default  = false,
        Callback = function(v) Config.Misc.TimeOfDay = v end,
    })

    Mc2:AddSlider('TimeValue', {
        Text     = 'Время (часы)',
        Default  = 14,
        Min      = 0,
        Max      = 24,
        Rounding = 0,
        Callback = function(v)
            Config.Misc.TimeValue = v
            if Config.Misc.TimeOfDay then
                pcall(function() Lighting.ClockTime = v end)
            end
        end,
    })

    Mc2:AddDivider()

    Mc2:AddToggle('AmbientEnabled', {
        Text     = 'Свой ambient',
        Default  = false,
        Callback = function(v)
            Config.Misc.AmbientEnabled = v
            if not v then
                Workspace.Ambient        = Color3.fromRGB(127, 127, 127)
                Workspace.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            end
        end,
    })

    Mc2:AddLabel('Цвет ambient'):AddColorPicker('AmbientColor', {
        Default  = Color3.fromRGB(128, 128, 128),
        Title    = 'Ambient цвет',
        Callback = function(v)
            Config.Misc.AmbientColor = v
            if Config.Misc.AmbientEnabled then
                Workspace.Ambient        = v
                Workspace.OutdoorAmbient = v
            end
        end,
    })
end

-- ================================================
-- SETTINGS TAB
-- ================================================
do
    local S1 = Tabs.Settings:AddLeftGroupbox('⚙️ Меню')

    S1:AddLabel('Горячая клавиша меню'):AddKeyPicker('MenuKeybind', {
        Default = 'RightShift',
        NoUI    = true,
        Text    = 'Menu keybind',
    })

    Library.ToggleKeybind = Options.MenuKeybind

    S1:AddDivider()

    S1:AddButton({
        Text = '🗑️ Выгрузить скрипт (двойной клик)',
        Func = function()
            if GravityControl.Active then GravityControl:Toggle() end
            Workspace.Gravity = Config.Movement.OriginalGravity
            FOVLock:Stop()
            Camera.FieldOfView = Config.Misc.OriginalFOV
            SetAntiAFK(false)
            Library:Unload()
            for _, d in pairs(DrawingCache) do
                pcall(function() d:Remove() end)
            end
        end,
        DoubleClick = true,
    })

    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    ThemeManager:SetFolder('JailbirdThemes')
    SaveManager:SetFolder('JailbirdConfigs')
    SaveManager:BuildConfigSection(Tabs.Settings)
    ThemeManager:ApplyToTab(Tabs.Settings)
end

print("✅ GUI создан")

-- ================================================
-- INPUT
-- ================================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    if input.KeyCode == Enum.KeyCode.V and Config.Movement.GravityEnabled then
        GravityControl:Toggle()
    end

    if input.KeyCode == Enum.KeyCode.Space and Config.Movement.InfiniteJump then
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ================================================
-- MAIN LOOP
-- ================================================
RunService.RenderStepped:Connect(function(dt)
    UpdateESP()
    Aimbot:Update()
    CrosshairDraw:Update()
    GravityControl:Update()
    WatermarkObj:Update()

    -- BunnyHop
    if Config.Misc.BunnyHop then
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum:GetState() == Enum.HumanoidStateType.Landed then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end

    -- Speed
    if Config.Movement.SpeedEnabled then
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Config.Movement.SpeedValue end
    end

    -- Jump Power
    if Config.Movement.JumpEnabled then
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Config.Movement.JumpValue end
    end

    -- Time of Day
    if Config.Misc.TimeOfDay then
        pcall(function() Lighting.ClockTime = Config.Misc.TimeValue end)
    end

    -- Ambient
    if Config.Misc.AmbientEnabled then
        Workspace.Ambient        = Config.Misc.AmbientColor
        Workspace.OutdoorAmbient = Config.Misc.AmbientColor
    end

    -- No Fall Damage
    if Config.Movement.NoFallDamage then
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        end
    end
end)

-- ================================================
-- INITIALIZE
-- ================================================
Aimbot:Initialize()
CrosshairDraw:Initialize()
GravityControl:Initialize()
WatermarkObj:Initialize()

SaveManager:LoadAutoloadConfig()

Library:Notify('⚡ JailFUCK v2.3 by MortisHAck загружен!', 5)

print([[
╔════════════════════════════════════╗
║ ⚡ JailFUCK v2.3 by MortisHAck     ║
╠════════════════════════════════════╣
║  ✅ Точное наведение на цель       ║
║  ✅ CFrame.Lerp плавность          ║
║  ✅ FOV Lock (защита от анимаций)  ║
║  ✅ ESP + Chams                    ║
║  ✅ Gravity Control                ║
║  ✅ Advanced Humanizer             ║
║  ✅ BunnyHop + Anti-AFK           ║
║  ✅ Watermark + FPS + Ping        ║
║                                    ║
║  🎮 Клавиши:                       ║
║  RightShift — меню                 ║
║  V          — гравитация           ║
║  Space      — infinite jump        ║
╚════════════════════════════════════╝
]])