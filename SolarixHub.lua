local HttpService = game:GetService('HttpService')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local CoreGui = gethui and gethui() or game:GetService('CoreGui')
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local Request = (syn and syn.request) or (http and http.request) or http_request or request
local Http = HttpService
local Twen = TweenService
local Plys = Players
local Uid = Plys.LocalPlayer and tostring(Plys.LocalPlayer.UserId) or '000000'
local Req = Request
local SetClip = setclipboard or toclipboard or function() end
local function Get(Url)
    if not Req then
        return false
    end
    local Ok, Res = pcall(Req, {
        Url = Url,
        Method = 'GET',
    })
    if Ok and Res and Res.Body then
        local DecOk, Dat = pcall(Http.JSONDecode, Http, Res.Body)
        if DecOk and tostring(Dat.result) == 'true' then
            return true
        end
    end
    return false
end
local SolarixFps = 60
local SolarixBaseFps = 60
local function SolarixActiveDelay()
    return 0.035
end
local function SolarixIdleDelay()
    return 1
end
local function SolarixStream(Enabled)
    if Enabled then
        task.wait(SolarixActiveDelay())
        return true
    end
    task.wait(SolarixIdleDelay())
    return false
end
local function SolarixStreamDelay(Time)
    task.wait(Time or 0.22)
    return true
end
local function InTree(Object, Root)
    if not Object or not Root then
        return false
    end
    if Object == Root then
        return true
    end
    local Parent = Object.Parent
    while Parent do
        if Parent == Root then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end
local function SolarixBF()
    local player = game:GetService('Players').LocalPlayer
    local team = player.Team and player.Team.Name
    if team ~= 'Marines' and team ~= 'Pirates' then
        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetTeam', 'Marines')
    end
    HttpService = game:GetService('HttpService')
    local WindUI = loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/latest/download/main.lua'))()
    local Library = WindUI
    pcall(function()
        Library:SetFont('rbxasset://fonts/families/FredokaOne.json')
    end)
    Library:AddTheme({
        Name = 'SolarixFlare',
        Accent = Color3.fromHex('#FF8A3D'),
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#1A0B08'), Transparency = 0.03},
            ['46'] = {Color = Color3.fromHex('#3A120B'), Transparency = 0.05},
            ['100'] = {Color = Color3.fromHex('#7A2413'), Transparency = 0.08},
        }, {
            Rotation = 28,
        }),
        Outline = Color3.fromHex('#FFC68A'),
        Text = Color3.fromHex('#FFF8EF'),
        Placeholder = Color3.fromHex('#D6A383'),
        Button = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#30100A'), Transparency = 0.02},
            ['52'] = {Color = Color3.fromHex('#6E2112'), Transparency = 0.04},
            ['100'] = {Color = Color3.fromHex('#FF7A22'), Transparency = 0.08},
        }, {
            Rotation = 22,
        }),
        Icon = Color3.fromHex('#FFD2A1'),
    })
    Library:SetTheme('SolarixFlare')
    local Window = Library:CreateWindow({
        Title = 'Solarix Hub',
        Icon = 'lucide:flame',
        Folder = 'Solarix Hub',
        Size = UDim2.fromOffset(580, 460),
        MinSize = Vector2.new(560, 350),
        MaxSize = Vector2.new(580, 460),
        ToggleKey = Enum.KeyCode.G,
        Transparent = true,
        Theme = 'SolarixFlare',
        Acrylic = false,
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#160807'), Transparency = 0.08},
            ['38'] = {Color = Color3.fromHex('#42130B'), Transparency = 0.03},
            ['67'] = {Color = Color3.fromHex('#D94C1A'), Transparency = 0.16},
            ['100'] = {Color = Color3.fromHex('#160807'), Transparency = 0.06},
        }, {
            Rotation = 35,
        }),
        Resizable = false,
        SideBarWidth = 190,
        HideSearchBar = false,
        ScrollBarEnabled = false,
        User = {
            Enabled = false,
        },
        OpenButton = {
            Title = 'Solarix Hub',
            Icon = 'lucide:flame',
            Enabled = true,
            Draggable = true,
            CornerRadius = UDim.new(0, 14),
            StrokeThickness = 1.5,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex('#24100B')),
                ColorSequenceKeypoint.new(0.45, Color3.fromHex('#FF6B1A')),
                ColorSequenceKeypoint.new(0.7, Color3.fromHex('#FFE0B5')),
                ColorSequenceKeypoint.new(1, Color3.fromHex('#5A1A0E')),
            }),
        },
    })
    local Colors = {
        Info = Color3.fromHex('#FFD1A1'),
        Green = Color3.fromHex('#FF8A3D'),
        Yellow = Color3.fromHex('#FFD166'),
        Purple = Color3.fromHex('#E0A3FF'),
        Cyan = Color3.fromHex('#FFB26B'),
        Orange = Color3.fromHex('#FF9E4A'),
        Red = Color3.fromHex('#FF5A3D'),
        Blue = Color3.fromHex('#F08B5F'),
        Grey = Color3.fromHex('#B98C75'),
    }
    local function TabOptions(Title, Icon, IconColor)
        return {
            Title = Title,
            Icon = Icon,
            IconColor = IconColor,
            IconShape = 'Square',
            Border = true,
        }
    end
    local Tabs = {
        Info = Window:Tab(TabOptions('Info', 'solar:info-circle-bold', Colors.Info)),
        General = Window:Tab(TabOptions('General', 'solar:play-circle-bold', Colors.Green)),
        Stats = Window:Tab(TabOptions('Stats', 'solar:graph-up-bold', Colors.Yellow)),
        Dungeon = Window:Tab(TabOptions('Dungeon', 'solar:ghost-bold', Colors.Purple)),
        Race = Window:Tab(TabOptions('Race V4', 'solar:user-id-bold', Colors.Cyan)),
        Travel = Window:Tab(TabOptions('Travel', 'solar:map-point-bold', Colors.Orange)),
        Sea = Window:Tab(TabOptions('Sea Events', 'lucide:anchor', Colors.Blue)),
        Fruit = Window:Tab(TabOptions('Fruits', 'lucide:apple', Colors.Red)),
        Inventory = Window:Tab(TabOptions('Inventory', 'solar:backpack-bold', Colors.Orange)),
        Shop = Window:Tab(TabOptions('Shop', 'solar:cart-large-minimalistic-bold', Colors.Green)),
        Fishing = Window:Tab(TabOptions('Fishing', 'lucide:fish', Colors.Cyan)),
        Player = Window:Tab(TabOptions('Player', 'solar:user-circle-bold', Colors.Purple)),
        Misc = Window:Tab(TabOptions('Misc', 'solar:box-bold', Colors.Grey)),
        Status = Window:Tab(TabOptions('Status', 'solar:clipboard-list-bold', Colors.Green)),
    }
    local InitialToggleCallbacks = {}
    local function EnableInitialToggleCallback(Tab)
        local OriginalToggle = Tab.Toggle
        if type(OriginalToggle) ~= 'function' then
            return
        end
        Tab.Toggle = function(Self, Config)
            local Element = OriginalToggle(Self, Config)
            if type(Config) == 'table' and type(Config.Callback) == 'function' and Config.Value ~= nil then
                InitialToggleCallbacks[#InitialToggleCallbacks + 1] = function()
                    Config.Callback(Config.Value)
                end
            end
            return Element
        end
    end
    for _, Tab in pairs(Tabs) do
        EnableInitialToggleCallback(Tab)
    end
    local Status = {Items = {}}
    function Status:Set(Text)
        local Raw = tostring(Text or '')
        local Title, Desc = Raw:match('^([^:]+):%s*(.*)$')
        Title = Title or 'Status'
        Desc = Desc ~= nil and Desc or Raw
        if not self.Items[Title] then
            self.Items[Title] = Tabs.Status:Paragraph({
                Title = Title,
                Desc = Desc,
                Color = 'Orange',
            })
            return
        end
        if self.Items[Title].SetDesc then
            self.Items[Title]:SetDesc(Desc)
        end
    end
    Tabs.Info:Paragraph({
        Title = 'Info',
        Desc = "Press 'G' to toggle UI.",
        Color = 'Orange',
    })
    Tabs.Info:Paragraph({
        Title = 'Support Game',
        Desc = '[+] Blox Fruits\n[+] Doors\n[+] Sailor Piece\n[+] Survive Zombie Arena',
        Color = 'Orange',
    })
    local vu = game:GetService('VirtualUser')
    game:GetService('Players').LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait()
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    local Sea1, Sea2, Sea3, Dungeon = false, false, false, false
    local CurrentMap = workspace:GetAttribute('MAP')
    if CurrentMap == 'Sea1' then
        Sea1 = true
    elseif CurrentMap == 'Sea2' then
        Sea2 = true
    elseif CurrentMap == 'Sea3' then
        Sea3 = true
    elseif CurrentMap == 'Dungeons' then
        Dungeon = true
    end
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    local TableAttribute = require(ReplicatedStorage.Modules.Util.TableAttribute)
    local oldSetKey = TableAttribute.SetKey
    TableAttribute.SetKey = function(self, instance, attributeName, key, value)
        if attributeName == 'Locks' and key == 'SeatLock' then
            return
        end
        return oldSetKey(self, instance, attributeName, key, value)
    end
    Players = game:GetService('Players')
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    local Player = Players.LocalPlayer
    local QuestData = require(ReplicatedStorage.Quests)
    local MobPositions = {}
    local function RefreshMobPositions()
        local enemySpawns = workspace:FindFirstChild('_WorldOrigin') and workspace._WorldOrigin:FindFirstChild('EnemySpawns')
        if enemySpawns then
            for _, spawn in pairs(enemySpawns:GetChildren()) do
                local cleanName = spawn.Name:gsub('%s*%[Lv%.%s*%d+%]', ''):gsub('%s*$', '')
                if spawn:IsA('BasePart') then
                    MobPositions[cleanName] = spawn.CFrame
                elseif spawn:IsA('Model') then
                    MobPositions[cleanName] = spawn:GetPivot()
                end
            end
        end
    end
    local SortedQuests = {}
    for qName, qLevels in pairs(QuestData) do
        for qIndex, qInfo in pairs(qLevels) do
            local mobName = nil
            if qInfo.Task then
                for k, _ in pairs(qInfo.Task) do
                    mobName = k
                    break
                end
            end
            if mobName then
                table.insert(SortedQuests, {
                    Req = qInfo.LevelReq,
                    Name = qName,
                    Index = qIndex,
                    Mob = mobName,
                })
            end
        end
    end
    table.sort(SortedQuests, function(a, b)
        return a.Req > b.Req
    end)
    function CheckLevel()
        local Lv = Player.Data.Level.Value
        local Team = Player.Team.Name
        IsTravel = false
        Monster = nil
        NameQuest = nil
        QuestLv = nil
        CFrameMonster = nil
        local MaxSeaLvl = math.huge
        if Sea1 then
            MaxSeaLvl = 699
        end
        if Sea2 then
            MaxSeaLvl = 1499
        end
        if Lv <= 9 then
            if Team == 'Pirates' then
                NameQuest = 'BanditQuest1'
                QuestLv = 1
                Monster = 'Bandit'
            elseif Team == 'Marines' then
                NameQuest = 'MarineQuest'
                QuestLv = 1
                Monster = 'Trainee'
            end
            if Monster and MobPositions[Monster] then
                CFrameMonster = MobPositions[Monster]
            end
            return
        end
        RefreshMobPositions()
        for _, quest in ipairs(SortedQuests) do
            if Lv >= quest.Req and quest.Req <= MaxSeaLvl then
                if MobPositions[quest.Mob] then
                    NameQuest = quest.Name
                    QuestLv = quest.Index
                    Monster = quest.Mob
                    CFrameMonster = MobPositions[quest.Mob]
                    break
                end
            end
        end
    end
    function MaterialMon()
        if SelectMaterial == 'Radioactive Material' then
            MMon = 'Factory Staff'
            MPos = CFrame.new(295, 73,-56)
            SP = 'Default'
        elseif SelectMaterial == 'Mystic Droplet' then
            MMon = 'Water Fighter'
            MPos = CFrame.new(-3385, 239,-10542)
            SP = 'Default'
        elseif SelectMaterial == 'Magma Ore' then
            if Sea1 then
                MMon = 'Military Spy'
                MPos = CFrame.new(-5815, 84, 8820)
                SP = 'Default'
            elseif Sea2 then
                MMon = 'Magma Ninja'
                MPos = CFrame.new(-5428, 78,-5959)
                SP = 'Default'
            end
        elseif SelectMaterial == 'Angel Wings' then
            MMon = "God's Guard"
            MPos = CFrame.new(-4698, 845,-1912)
            SP = 'Default'
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-7859.09814, 5544.19043,-381.476196)).Magnitude >= 5000 then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-7859.09814, 5544.19043,-381.476196))
            end
        elseif SelectMaterial == 'Leather' then
            if Sea1 then
                MMon = 'Brute'
                MPos = CFrame.new(-1145, 15, 4350)
                SP = 'Default'
            elseif Sea2 then
                MMon = 'Marine Captain'
                MPos = CFrame.new(-2010.5059814453125, 73.00115966796875,-3326.620849609375)
                SP = 'Default'
            elseif Sea3 then
                MMon = 'Jungle Pirate'
                MPos = CFrame.new(-11975.78515625, 331.7734069824219,-10620.0302734375)
                SP = 'Default'
            end
        elseif SelectMaterial == 'Scrap Metal' then
            if Sea1 then
                MMon = 'Brute'
                MPos = CFrame.new(-1145, 15, 4350)
                SP = 'Default'
            elseif Sea2 then
                MMon = 'Swan Pirate'
                MPos = CFrame.new(878, 122, 1235)
                SP = 'Default'
            elseif Sea3 then
                MMon = 'Jungle Pirate'
                MPos = CFrame.new(-12107, 332,-10549)
                SP = 'Default'
            end
        elseif SelectMaterial == 'Fish Tail' then
            if Sea3 then
                MMon = 'Fishman Raider'
                MPos = CFrame.new(-10993, 332,-8940)
                SP = 'Default'
            elseif Sea1 then
                MMon = 'Fishman Warrior'
                MPos = CFrame.new(61123, 19, 1569)
                SP = 'Default'
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
                end
            end
        elseif SelectMaterial == 'Demonic Wisp' then
            MMon = 'Demonic Soul'
            MPos = CFrame.new(-9507, 172, 6158)
            SP = 'Default'
        elseif SelectMaterial == 'Vampire Fang' then
            MMon = 'Vampire'
            MPos = CFrame.new(-6033, 7,-1317)
            SP = 'Default'
        elseif SelectMaterial == 'Conjured Cocoa' then
            MMon = 'Chocolate Bar Battler'
            MPos = CFrame.new(620.6344604492188, 78.93644714355469,-12581.369140625)
            SP = 'Default'
        elseif SelectMaterial == 'Dragon Scale' then
            MMon = 'Dragon Crew Archer'
            MPos = CFrame.new(6827.91455078125, 609.4127197265625, 252.3538055419922)
            SP = 'Default'
        elseif SelectMaterial == 'Gunpowder' then
            MMon = 'Pistol Billionaire'
            MPos = CFrame.new(-469, 74, 5904)
            SP = 'Default'
        elseif SelectMaterial == 'Mini Tusk' then
            MMon = 'Mythological Pirate'
            MPos = CFrame.new()
            SP = 'Default'
        end
    end
    function BKP(Point)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
    end
    Players = game:GetService('Players')
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    RunService = game:GetService('RunService')
    Workspace = game:GetService("Workspace")
    TweenService = game:GetService("TweenService")
    LocalPlayer = Players.LocalPlayer
    local WorldOrigin = Workspace:WaitForChild("_WorldOrigin")
    local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    local Remote = CommF_
    local TweenSpeed = 350
    local TweenProxy = Workspace:FindFirstChild('SolarixTweenProxy')
    if TweenProxy then
        TweenProxy:Destroy()
    end
    TweenProxy = Instance.new('Part')
    TweenProxy.Name = 'SolarixTweenProxy'
    TweenProxy.Size = Vector3.new(1, 1, 1)
    TweenProxy.Transparency = 1
    TweenProxy.CanCollide = false
    TweenProxy.CanTouch = false
    TweenProxy.Anchored = true
    TweenProxy.Parent = Workspace
    local ActiveTween = nil
    local ActiveTweenConnection = nil
    local TweenFollowConnection = nil
    local LastTweenPosition = nil
    local LastTweenClock = 0
    local SolarixCharacterNoclip = {}
    local SolarixBoatNoclip = {}
    local SolarixCurrentBoat = nil
    local function SetNoclipPart(Part, Storage)
        if Part and Part:IsA('BasePart') then
            if Storage[Part] == nil then
                Storage[Part] = Part.CanCollide
            end
            Part.CanCollide = false
        end
    end
    local function ScanNoclipObject(Object, Storage)
        if not Object then
            return
        end
        SetNoclipPart(Object, Storage)
        local Children = Object:GetChildren()
        for i = 1, #Children do
            local Child = Children[i]
            SetNoclipPart(Child, Storage)
            local SubChildren = Child:GetChildren()
            for j = 1, #SubChildren do
                SetNoclipPart(SubChildren[j], Storage)
            end
        end
    end
    local function RestoreNoclip(Storage)
        for Part, OldValue in pairs(Storage) do
            if Part and Part.Parent then
                Part.CanCollide = OldValue
            end
            Storage[Part] = nil
        end
    end
    local function StartCharacterNoclip(Character)
        Character = Character or LocalPlayer.Character
        if Character then
            ScanNoclipObject(Character, SolarixCharacterNoclip)
        end
    end
    local function StopCharacterNoclip()
        RestoreNoclip(SolarixCharacterNoclip)
    end
    local function StartBoatNoclip(Boat)
        if not Boat then
            return
        end
        if SolarixCurrentBoat ~= Boat then
            RestoreNoclip(SolarixBoatNoclip)
            SolarixCurrentBoat = Boat
            ScanNoclipObject(Boat, SolarixBoatNoclip)
        end
    end
    local function StopBoatNoclip()
        SolarixCurrentBoat = nil
        RestoreNoclip(SolarixBoatNoclip)
    end
    local function GetRoot()
        local Character = LocalPlayer.Character
        return Character and Character:FindFirstChild('HumanoidRootPart')
    end
    local function ToCF(Position)
        if typeof(Position) == 'Vector3' then
            return CFrame.new(Position)
        elseif typeof(Position) == 'CFrame' then
            return Position
        elseif typeof(Position) == 'Instance' then
            if Position:IsA('BasePart') then
                return Position.CFrame
            elseif Position:IsA('Model') then
                return Position:GetPivot()
            end
        elseif typeof(Position) == 'table' and Position.x and Position.y and Position.z then
            return CFrame.new(Position.x, Position.y, Position.z)
        end
        return nil
    end
    local function ToVector3(Position)
        local CF = ToCF(Position)
        return CF and CF.Position or nil
    end
    local function GetArea(Position)
        local CF = ToCF(Position)
        if not CF then
            return {Name = ''}
        end
        local Locations = WorldOrigin:FindFirstChild('Locations')
        if Locations then
            local Items = Locations:GetChildren()
            for i = 1, #Items do
                local Location = Items[i]
                local Mesh = Location:FindFirstChild('Mesh')
                if Mesh and (CF.Position - Location.Position).Magnitude <= Mesh.Scale.X then
                    return Location
                end
            end
        end
        return {Name = ''}
    end
    local function ResetPhysics(Character)
        local Root = Character and Character:FindFirstChild('HumanoidRootPart')
        local Humanoid = Character and Character:FindFirstChild('Humanoid')
        if Root then
            Root.Velocity = Vector3.zero
            Root.RotVelocity = Vector3.zero
            local BodyClip = Root:FindFirstChild('BodyClip') or Root:FindFirstChild('SolarixTweenVelocity') or Root:FindFirstChild('TweenBodyVelocity')
            if BodyClip then
                BodyClip:Destroy()
            end
        end
        if Humanoid then
            Humanoid.PlatformStand = false
            Humanoid:SetStateEnabled(5, true)
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    local function StartTweenFollow()
        if TweenFollowConnection then
            return
        end
        TweenFollowConnection = RunService.Heartbeat:Connect(function()
            local Character = LocalPlayer.Character
            local Root = Character and Character:FindFirstChild('HumanoidRootPart')
            local Humanoid = Character and Character:FindFirstChild('Humanoid')
            if not ActiveTween or ActiveTween.PlaybackState ~= Enum.PlaybackState.Playing or not Root or not Humanoid or Humanoid.Health <= 0 then
                if TweenFollowConnection then
                    TweenFollowConnection:Disconnect()
                    TweenFollowConnection = nil
                end
                return
            end
            Root.CFrame = TweenProxy.CFrame
            Root.Velocity = Vector3.zero
            Root.RotVelocity = Vector3.zero
            Humanoid.PlatformStand = true
            Humanoid:ChangeState(11)
            if Humanoid.Sit then
                Humanoid.Sit = false
            end
        end)
    end
    function StopTween()
        if ActiveTweenConnection then
            ActiveTweenConnection:Disconnect()
            ActiveTweenConnection = nil
        end
        if TweenFollowConnection then
            TweenFollowConnection:Disconnect()
            TweenFollowConnection = nil
        end
        if ActiveTween then
            ActiveTween:Cancel()
            ActiveTween = nil
        end
        LastTweenPosition = nil
        LastTweenClock = 0
        StopCharacterNoclip()
        ResetPhysics(LocalPlayer.Character)
        local Root = GetRoot()
        if Root then
            TweenProxy.CFrame = Root.CFrame
        end
    end
    function Tween(TargetInput)
        local TargetCF = ToCF(TargetInput)
        if not TargetCF then
            return
        end
        local Character = LocalPlayer.Character
        local Root = Character and Character:FindFirstChild('HumanoidRootPart')
        local Humanoid = Character and Character:FindFirstChild('Humanoid')
        if not Character or not Root or not Humanoid or Humanoid.Health <= 0 then
            return
        end
        local RawTargetPosition = TargetCF.Position
        local TargetPosition = RawTargetPosition
        local CurrentArea = GetArea(Root.Position).Name
        local TargetArea = GetArea(TargetCF).Name
        local ExitPosition = Vector3.new(11422.1, -2154.98, 9736.16)
        local EnterPosition = Vector3.new(-16270, 25, 1379)
        local GoingToExit = false
        local GoingToEnter = false
        if Sea3 and Root.Position.Y < -300 and TargetPosition.Y > -50 then
            if (Root.Position - ExitPosition).Magnitude <= 18 then
                pcall(function()
                    ReplicatedStorage.Modules.Net['RF/SubmarineTransportation']:InvokeServer('InitiateTeleport', 'Tiki Outpost')
                end)
                task.wait(0.15)
                Tween(RawTargetPosition)
                return
            end
            TargetPosition = ExitPosition
            GoingToExit = true
        elseif Sea3 and (TargetArea == 'Submerged Island' or TargetArea == 'Sealed Cavern' or TargetPosition.Y < -300) and CurrentArea ~= TargetArea then
            if (Root.Position - EnterPosition).Magnitude <= 35 then
                pcall(function()
                    ReplicatedStorage.Modules.Net['RF/SubmarineWorkerSpeak']:InvokeServer('TravelToSubmergedIsland')
                end)
                task.wait(0.15)
                Tween(RawTargetPosition)
                return
            end
            TargetPosition = EnterPosition
            GoingToEnter = true
        end
        local Distance = (TargetPosition - Root.Position).Magnitude
        if ActiveTween and ActiveTween.PlaybackState == Enum.PlaybackState.Playing and LastTweenPosition and (TargetPosition - LastTweenPosition).Magnitude <= 12 and tick() - LastTweenClock <= 0.28 then
            return
        end
        if Distance <= 45 then
            StopTween()
            Root.CFrame = CFrame.new(TargetPosition)
            TweenProxy.CFrame = Root.CFrame
            return
        end
        if ActiveTweenConnection then
            ActiveTweenConnection:Disconnect()
            ActiveTweenConnection = nil
        end
        if ActiveTween then
            ActiveTween:Cancel()
            ActiveTween = nil
        end
        local LastSpawnPoint = Character:FindFirstChild('LastSpawnPoint')
        if LastSpawnPoint then
            LastSpawnPoint.Enabled = true
        end
        local Busy = Character:FindFirstChild('Busy')
        local Stun = Character:FindFirstChild('Stun')
        if Busy then
            Busy.Value = false
        end
        if Stun then
            Stun.Value = 0
        end
        Humanoid:SetStateEnabled(5, false)
        if Humanoid.Sit then
            Humanoid.Sit = false
        end
        StartCharacterNoclip(Character)
        local BodyClip = Root:FindFirstChild('BodyClip')
        if not BodyClip then
            BodyClip = Instance.new('BodyVelocity')
            BodyClip.Name = 'BodyClip'
            BodyClip.MaxForce = Vector3.new(100000, 100000, 100000)
            BodyClip.Velocity = Vector3.zero
            BodyClip.Parent = Root
        end
        if (TweenProxy.Position - Root.Position).Magnitude > 10 then
            TweenProxy.CFrame = Root.CFrame
        end
        LastTweenPosition = TargetPosition
        LastTweenClock = tick()
        ActiveTween = TweenService:Create(TweenProxy, TweenInfo.new(math.max(Distance / TweenSpeed, 0.02), Enum.EasingStyle.Linear), {CFrame = CFrame.new(TargetPosition)})
        StartTweenFollow()
        ActiveTween:Play()
        ActiveTweenConnection = ActiveTween.Completed:Connect(function(State)
            if ActiveTweenConnection then
                ActiveTweenConnection:Disconnect()
                ActiveTweenConnection = nil
            end
            if State == Enum.PlaybackState.Completed then
                local NowCharacter = LocalPlayer.Character
                local NowRoot = NowCharacter and NowCharacter:FindFirstChild('HumanoidRootPart')
                StopTween()
                if NowRoot then
                    NowRoot.CFrame = CFrame.new(TargetPosition)
                    TweenProxy.CFrame = NowRoot.CFrame
                end
                if GoingToExit then
                    pcall(function()
                        ReplicatedStorage.Modules.Net['RF/SubmarineTransportation']:InvokeServer('InitiateTeleport', 'Tiki Outpost')
                    end)
                    task.wait(0.15)
                    Tween(RawTargetPosition)
                elseif GoingToEnter then
                    pcall(function()
                        ReplicatedStorage.Modules.Net['RF/SubmarineWorkerSpeak']:InvokeServer('TravelToSubmergedIsland')
                    end)
                    task.wait(0.15)
                    Tween(RawTargetPosition)
                end
            end
        end)
    end
    LocalPlayer.CharacterAdded:Connect(function(Character)
        StopTween()
        local Humanoid = Character:WaitForChild('Humanoid', 10)
        if Humanoid then
            Humanoid.Died:Connect(StopTween)
        end
    end)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('Humanoid') then
        LocalPlayer.Character.Humanoid.Died:Connect(StopTween)
    end
    local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
    local OldCoreGui = gethui and gethui() or game:GetService('CoreGui')
    if OldCoreGui:FindFirstChild('StopTweenGui') then
        OldCoreGui.StopTweenGui:Destroy()
    end
    if PlayerGui:FindFirstChild('StopTweenGui') then
        PlayerGui.StopTweenGui:Destroy()
    end
    local gui = Instance.new('ScreenGui')
    gui.Name = 'StopTweenGui'
    gui.Parent = PlayerGui
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 1
    gui.ResetOnSpawn = false
    local frame = Instance.new('Frame')
    frame.Name = 'MainFrame'
    frame.Parent = gui
    frame.AnchorPoint = Vector2.new(1, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(26, 12, 8)
    frame.BackgroundTransparency = 0.18
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(0, 108, 0, 36)
    frame.Position = UDim2.new(1, -10, 0.5, 0)
    frame.Active = true
    frame.ClipsDescendants = true
    local corner = Instance.new('UICorner')
    corner.Parent = frame
    corner.CornerRadius = UDim.new(0, 14)
    local gradient = Instance.new('UIGradient')
    gradient.Parent = frame
    gradient.Rotation = 45
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(44, 15, 8)),
        ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 105, 26)),
        ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 221, 170)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(95, 27, 12)),
    })
    local btn = Instance.new('TextButton')
    btn.Name = 'ActionButton'
    btn.Parent = frame
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1, -8, 1, 0)
    btn.Position = UDim2.new(0, 4, 0, 0)
    btn.Font = Enum.Font.FredokaOne
    btn.Text = 'Stop Tween'
    btn.TextColor3 = Color3.fromRGB(246, 255, 250)
    btn.TextStrokeTransparency = 0.72
    btn.TextStrokeColor3 = Color3.fromRGB(20, 8, 6)
    btn.TextSize = 14
    btn.TextScaled = true
    btn.TextWrapped = false
    btn.TextTruncate = Enum.TextTruncate.None
    btn.MouseButton1Click:Connect(StopTween)
    function Equip(ToolSe)
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
        end
    end
    function UnEquip(Weapon)
        local character = game.Players.LocalPlayer.Character
        local backpack = game.Players.LocalPlayer.Backpack
        if character and character:FindFirstChild(Weapon) then
            local tool = character:FindFirstChild(Weapon)
            if tool:IsA('Tool') then
                tool.Parent = backpack
            end
        end
    end
    function CheckMaterial(matname)
        local inventory = game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory')
        for _, v in pairs(inventory)do
            if type(v) == 'table' and v.Type == 'Material' and v.Name == matname then
                return v.Count
            end
        end
        return 0
    end
    function GetValuable(name)
        for _, v in pairs(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory'))do
            if v.Name == name then
                return v.Count or v.count or 0
            end
        end
        return 0
    end
    function GetInventory(Name)
        LP = game:GetService('Players').LocalPlayer
        if LP.Backpack:FindFirstChild(Name) or (LP.Character and LP.Character:FindFirstChild(Name)) then
            return true
        end
        local Inventory = game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory')
        for _, v in pairs(Inventory)do
            if v.Name == Name then
                return true
            end
        end
        return false
    end
    Tabs.Settings:Dropdown({
        Title = "Fruit Skills",
        Values = {"Z", "X", "C", "V", "F"},
        Multi = true,
        Value = {"Z", "X", "C", "V", "F"},
        Callback = function(v) _G.Select_BloxFruit = v end
    })
    Tabs.Settings:Dropdown({
        Title = "Melee Skills",
        Values = {"Z", "X", "C"},
        Multi = true,
        Value = {"Z", "X", "C"},
        Callback = function(v) _G.Select_Melee = v end
    })
    Tabs.Settings:Dropdown({
        Title = "Sword Skills",
        Values = {"Z", "X"},
        Multi = true,
        Value = {"Z", "X"},
        Callback = function(v) _G.Select_Sword = v end
    })
    Tabs.Settings:Dropdown({
        Title = "Gun Skills",
        Values = {"Z", "X"},
        Multi = true,
        Value = {"Z", "X"},
        Callback = function(v) _G.Select_Gun = v end
    })
    function CallSkills()
        local Player = game:GetService("Players").LocalPlayer
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChild("Humanoid")
        local Backpack = Player.Backpack
        if not Character or not Humanoid then return end
        local function GetTool(toolType)
            for _, item in ipairs(Character:GetChildren()) do
                if item:IsA("Tool") and item.ToolTip == toolType then return item end
            end
            for _, item in ipairs(Backpack:GetChildren()) do
                if item:IsA("Tool") and item.ToolTip == toolType then return item end
            end
            return nil
        end
        local ToolConfigs = {
            ["Blox Fruit"] = _G.Select_BloxFruit,
            ["Melee"] = _G.Select_Melee,
            ["Sword"] = _G.Select_Sword,
            ["Gun"] = _G.Select_Gun
        }
        local Order = {"Melee", "Blox Fruit", "Sword", "Gun"}
        for _, toolType in ipairs(Order) do
            local rawKeys = ToolConfigs[toolType]
            local activeKeys = {}
            if type(rawKeys) == "table" then
                for k, v in pairs(rawKeys) do
                    if type(k) == "number" then
                        table.insert(activeKeys, v)
                    elseif v == true then
                        table.insert(activeKeys, k)
                    end
                end
            end
            if #activeKeys > 0 then
                local tool = GetTool(toolType)
                if tool then
                    if tool.Parent ~= Character then
                        Humanoid:EquipTool(tool)
                        task.wait(0.2)
                    end
                    for _, keyStr in ipairs(activeKeys) do
                        local key = Enum.KeyCode[keyStr]
                        if key then
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
                            task.wait(0.05)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
                            task.wait(0.15)
                        end
                    end
                end
            end
        end
    end
    function AutoRaceV3()
        game.ReplicatedStorage.Remotes.CommE:FireServer('ActivateAbility')
    end
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    Players = game:GetService('Players')
    Workspace = game:GetService('Workspace')
    local Player = Players.LocalPlayer
    local Modules = ReplicatedStorage:WaitForChild('Modules')
    local Net = Modules:WaitForChild('Net')
    local CombatUtil = require(Modules:WaitForChild('CombatUtil'))
    local DamageCounterModule = require(ReplicatedStorage:WaitForChild('DamageCounter'))
    local OldIncrement = DamageCounterModule.Increment
    local HitFunction = nil
    pcall(function()
        local LocalScript = Player:WaitForChild("PlayerScripts"):FindFirstChildOfClass("LocalScript")
        if LocalScript and getsenv then
            local env = getsenv(LocalScript)
            if env and env._G then
                HitFunction = env._G.SendHitsToServer
            end
        end
    end)
    task.spawn(function()
        pcall(function()
            local Util = ReplicatedStorage:FindFirstChild('Util')
            if Util and Util:FindFirstChild('CameraShaker') then
                local CameraShaker = require(Util.CameraShaker)
                if CameraShaker then
                    CameraShaker.Shake = function() end
                    CameraShaker.Stop = function() end
                end
            end
        end)
    end)
    local RegisterAttack = Net:WaitForChild('RE/RegisterAttack')
    local RegisterHit = Net:WaitForChild('RE/RegisterHit')
    local ShootGunEvent = Net:FindFirstChild('RE/ShootGunEvent')
    local GunValidator = ReplicatedStorage:FindFirstChild('Remotes') and ReplicatedStorage.Remotes:FindFirstChild('Validator2')
    local CombatFlags = nil
    local ShootFunction = nil
    pcall(function()
        CombatFlags = require(Modules.Flags).COMBAT_REMOTE_THREAD
    end)
    pcall(function()
        local Controllers = ReplicatedStorage:FindFirstChild('Controllers')
        local CombatController = Controllers and Controllers:FindFirstChild('CombatController')
        if CombatController and getupvalue then
            ShootFunction = getupvalue(require(CombatController).Attack, 9)
        end
    end)

    local EnemiesFolder = Workspace:FindFirstChild('Enemies')
    local CharactersFolder = Workspace:FindFirstChild('Characters')

    local AttackKey = nil
    task.spawn(function()
        local key = tostring(Player.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
        AttackKey = key
        RegisterHit:FireServer(key)
    end)

    if DamageCounterModule and DamageCounterModule.Increment == OldIncrement then
        DamageCounterModule.Increment = function(self, amount)
            OldIncrement(self, amount)
            task.spawn(function()
                for i = 1, math.random(3, 6) do
                    task.wait(math.random(1, 3) / 100)
                    OldIncrement(self, math.floor(amount * (math.random(90, 110) / 100)))
                end
            end)
        end
    end

    local AttackDistance = 65
    local GunDistance = 120
    local AttackCooldown = 0
    local ComboResetTime = 0.3
    local MaxCombo = 4
    local LastAttack = 0
    local LastCombo = 0
    local LastShoot = 0
    local M1Combo = 0
    local HitboxLimbs = {'RightLowerArm', 'RightUpperArm', 'LeftLowerArm', 'LeftUpperArm', 'RightHand', 'LeftHand'}
    local SpecialGuns = {
        ['Skull Guitar'] = 'TAP',
        ['Bazooka'] = 'Position',
        ['Cannon'] = 'Position',
        ['Dragonstorm'] = 'Position',
    }
    local function IsAlive(Model)
        local Humanoid = Model and Model:FindFirstChild('Humanoid')
        return Humanoid and Humanoid.Health > 0
    end
    local function CanAttack(Character, Humanoid, ToolTip)
        local Stun = Character:FindFirstChild('Stun')
        local Busy = Character:FindFirstChild('Busy')
        if Humanoid.Sit and (ToolTip == 'Sword' or ToolTip == 'Melee' or ToolTip == 'Blox Fruit' or ToolTip == 'Demon Fruit') then
            return false
        end
        if Stun and Stun.Value > 0 then
            return false
        end
        if Busy and Busy.Value then
            return false
        end
        return true
    end
    local function GetHitPart(Model)
        for i = 1, #HitboxLimbs do
            local Part = Model:FindFirstChild(HitboxLimbs[i])
            if Part then
                return Part
            end
        end
        return Model:FindFirstChild('HumanoidRootPart') or Model:FindFirstChild('Head') or Model:FindFirstChild('Torso')
    end
    local function AddTargets(Folder, Character, Position, Distance, BladeHits, EnemyRootPart)
        if not Folder then
            return EnemyRootPart
        end
        local Children = Folder:GetChildren()
        for i = 1, #Children do
            local Enemy = Children[i]
            if Enemy ~= Character and IsAlive(Enemy) then
                local Part = GetHitPart(Enemy)
                if Part and (Position - Part.Position).Magnitude <= Distance then
                    if not EnemyRootPart then
                        EnemyRootPart = Part
                    elseif #BladeHits < 30 then
                        BladeHits[#BladeHits + 1] = {Enemy, Part}
                    end
                end
            end
        end
        return EnemyRootPart
    end
    local function GetBladeHits(Character, Distance)
        local Position = Character:GetPivot().Position
        local BladeHits = {}
        local EnemyRootPart = nil
        EnemyRootPart = AddTargets(EnemiesFolder, Character, Position, Distance or AttackDistance, BladeHits, EnemyRootPart)
        EnemyRootPart = AddTargets(CharactersFolder, Character, Position, Distance or AttackDistance, BladeHits, EnemyRootPart)
        return EnemyRootPart, BladeHits
    end
    local function GetClosestTarget(Character, Distance)
        local Position = Character:GetPivot().Position
        local BestPart = nil
        local BestDistance = math.huge
        local function Scan(Folder)
            if not Folder then
                return
            end
            local Children = Folder:GetChildren()
            for i = 1, #Children do
                local Enemy = Children[i]
                if Enemy ~= Character and IsAlive(Enemy) then
                    local Part = GetHitPart(Enemy)
                    if Part then
                        local Range = (Position - Part.Position).Magnitude
                        if Range <= Distance and Range < BestDistance then
                            BestDistance = Range
                            BestPart = Part
                        end
                    end
                end
            end
        end
        Scan(EnemiesFolder)
        Scan(CharactersFolder)
        return BestPart
    end
    local function GetCombo()
        if tick() - LastCombo > ComboResetTime then
            M1Combo = 0
        end
        M1Combo = M1Combo >= MaxCombo and 1 or M1Combo + 1
        LastCombo = tick()
        return M1Combo
    end
    local function GetValidator2()
        if not ShootFunction or not getupvalue or not setupvalue then
            return nil
        end
        local Ok, A, B = pcall(function()
            local V1 = getupvalue(ShootFunction, 15)
            local V2 = getupvalue(ShootFunction, 13)
            local V3 = getupvalue(ShootFunction, 16)
            local V4 = getupvalue(ShootFunction, 17)
            local V5 = getupvalue(ShootFunction, 14)
            local V6 = getupvalue(ShootFunction, 12)
            local V7 = getupvalue(ShootFunction, 18)
            local V8 = V6 * V2
            local V9 = (V5 * V2 + V6 * V1) % V3
            V9 = (V9 * V3 + V8) % V4
            V5 = math.floor(V9 / V3)
            V6 = V9 - V5 * V3
            V7 = V7 + 1
            setupvalue(ShootFunction, 15, V1)
            setupvalue(ShootFunction, 13, V2)
            setupvalue(ShootFunction, 16, V3)
            setupvalue(ShootFunction, 17, V4)
            setupvalue(ShootFunction, 14, V5)
            setupvalue(ShootFunction, 12, V6)
            setupvalue(ShootFunction, 18, V7)
            return math.floor(V9 / V4 * 16777215), V7
        end)
        if Ok then
            return A, B
        end
        return nil
    end
    local function ShootGun(Equipped, TargetPosition)
        local Cooldown = 0
        local ShootType = SpecialGuns[Equipped.Name]
        if ShootType == 'TAP' and Equipped:FindFirstChild('RemoteEvent') then
            Equipped:SetAttribute('LocalTotalShots', (Equipped:GetAttribute('LocalTotalShots') or 0) + 1)
            if GunValidator then
                task.defer(pcall, GunValidator.FireServer, GunValidator, GetValidator2())
            end
            task.defer(pcall, Equipped.RemoteEvent.FireServer, Equipped.RemoteEvent, 'TAP', TargetPosition)
        elseif ShootType == 'Position' and ShootGunEvent then
            Equipped:SetAttribute('LocalTotalShots', (Equipped:GetAttribute('LocalTotalShots') or 0) + 1)
            if GunValidator then
                task.defer(pcall, GunValidator.FireServer, GunValidator, GetValidator2())
            end
            task.defer(pcall, ShootGunEvent.FireServer, ShootGunEvent, TargetPosition)
        elseif Equipped:FindFirstChild('RemoteEvent') then
            task.defer(pcall, Equipped.RemoteEvent.FireServer, Equipped.RemoteEvent, 'TAP', TargetPosition)
        else
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end
        LastShoot = tick()
    end
    function Attack()
        if AttackCooldown > 0 and tick() - LastAttack < AttackCooldown then
            return
        end
        local Banned = Player:FindFirstChild('Banned')
        if Banned then
            Banned:Destroy()
        end
        local Character = Player.Character
        if not IsAlive(Character) then
            return
        end
        local Humanoid = Character:FindFirstChild('Humanoid')
        if not Humanoid then
            return
        end
        local Equipped = Character:FindFirstChildOfClass('Tool')
        if not Equipped then
            return
        end
        local ToolTip = Equipped.ToolTip
        if ToolTip ~= 'Melee' and ToolTip ~= 'Sword' and ToolTip ~= 'Blox Fruit' and ToolTip ~= 'Demon Fruit' and ToolTip ~= 'Gun' then
            return
        end
        if not CanAttack(Character, Humanoid, ToolTip) then
            return
        end
        local Combo = GetCombo()
        local Cooldown = 0
        LastAttack = tick()
        if (ToolTip == 'Blox Fruit' or ToolTip == 'Demon Fruit') and Equipped:FindFirstChild('LeftClickRemote') then
            local EnemyRootPart = GetClosestTarget(Character, AttackDistance)
            if not EnemyRootPart then
                return
            end
            local Direction = EnemyRootPart.Position - Character:GetPivot().Position
            Direction = Direction.Magnitude > 0 and Direction.Unit or Vector3.zero
            task.defer(pcall, Equipped.LeftClickRemote.FireServer, Equipped.LeftClickRemote, Direction, Combo)
            return
        end
        if ToolTip == 'Gun' then
            local Target = GetClosestTarget(Character, GunDistance)
            if Target then
                ShootGun(Equipped, Target.Position)
            end
            return
        end
        local EnemyRootPart, BladeHits = GetBladeHits(Character, AttackDistance)
        if not EnemyRootPart then
            return
        end
        task.defer(function()
            pcall(function()
                RegisterAttack:FireServer(0)
                if CombatFlags and HitFunction then
                    HitFunction(EnemyRootPart, BladeHits)
                else
                    RegisterHit:FireServer(EnemyRootPart, BladeHits)
                end
            end)
        end)
    end
    local Y = 20
    local Pos = Vector3.new(0, Y, 0)
    Tabs.Settings:Input({
        Title = 'Height',
        Value = tostring(Y),
        Placeholder = 'Max 50',
        Callback = function(Text)
            local newY = tonumber(Text)
            if newY then
                Y = newY
                Pos = Vector3.new(0, Y, 0)
            end
        end,
    })
    function AutoHaki()
        if not game:GetService('Players').LocalPlayer.Character:FindFirstChild('HasBuso') then
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Buso')
        end
    end
    local ChooseWeapon = 'Melee'
    local SelectWeapon = ''
    local function UpdateSelectedWeapon()
        local TargetToolTip = ChooseWeapon == 'Fruits (M1)' and 'Blox Fruit' or ChooseWeapon
        SelectWeapon = ''
        local Backpack = game.Players.LocalPlayer.Backpack
        local Character = game.Players.LocalPlayer.Character
        local function Scan(container)
            if not container then
                return false
            end
            for _, v in pairs(container:GetChildren()) do
                if v:IsA('Tool') and v.ToolTip == TargetToolTip then
                    SelectWeapon = v.Name
                    return true
                end
            end
            return false
        end
        if not Scan(Character) then
            Scan(Backpack)
        end
    end
    Tabs.General:Dropdown({
        Title = 'Weapon',
        Values = {
            'Melee',
            'Sword',
            'Fruits (M1)',
            'Gun',
        },
        Value = 'Melee',
        Multi = false,
        Callback = function(Value)
            ChooseWeapon = Value
            UpdateSelectedWeapon()
        end,
    })
    UpdateSelectedWeapon()
    game.Players.LocalPlayer.Backpack.ChildAdded:Connect(UpdateSelectedWeapon)
    game.Players.LocalPlayer.Backpack.ChildRemoved:Connect(UpdateSelectedWeapon)
    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(UpdateSelectedWeapon)
        char.ChildRemoved:Connect(UpdateSelectedWeapon)
        UpdateSelectedWeapon()
    end)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.ChildAdded:Connect(UpdateSelectedWeapon)
        game.Players.LocalPlayer.Character.ChildRemoved:Connect(UpdateSelectedWeapon)
    end
    local FarmTypeSelected = ''
    local IsAutoFarmEnabled = false
    local FarmValues = {
        'Level',
        'Near Mob',
    }
    if Sea3 then
        table.insert(FarmValues, 'Bone')
        table.insert(FarmValues, 'Tyrant Skies')
        table.insert(FarmValues, 'Cake')
    end
    Tabs.General:Dropdown({
        Title = 'Farm Type',
        Values = FarmValues,
        Value = '',
        Multi = false,
        Callback = function(Value)
            FarmTypeSelected = Value
            if IsAutoFarmEnabled then
                _G.AutoLevel = false
                _G.AutoNear = false
                _G.AutoBone = false
                _G.Cake = false
                _G.AutoTyrant = false
                _G.AutoLevel = Value == 'Level'
                _G.AutoNear = Value == 'Near Mob'
                _G.AutoBone = Value == 'Bone'
                _G.Cake = Value == 'Cake'
                _G.AutoTyrant = Value == 'Tyrant Skies'
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Auto Farm',
        Value = false,
        Callback = function(Value)
            IsAutoFarmEnabled = Value
            if Value then
                _G.AutoLevel = FarmTypeSelected == 'Level'
                _G.AutoNear = FarmTypeSelected == 'Near Mob'
                _G.AutoBone = FarmTypeSelected == 'Bone'
                _G.Cake = FarmTypeSelected == 'Cake'
                _G.AutoTyrant = FarmTypeSelected == 'Tyrant Skies'
            else
                _G.AutoLevel = false
                _G.AutoNear = false
                _G.AutoBone = false
                _G.Cake = false
                _G.AutoTyrant = false
            end
        end,
    })
    Players = game:GetService('Players')
    RS = game:GetService('ReplicatedStorage')
    HttpService = game:GetService('HttpService')
    LP = Players.LocalPlayer
    local CommF = RS.Remotes.CommF_
    local Redeem = RS.Remotes.Redeem
    task.spawn(function()
        local success, result = pcall(function()
            return game:HttpGet('https://github.com/LeafHubAcademy/SolarixHub/raw/refs/heads/main/Code.json')
        end)
        if success and result then
            local successDecode, codes = pcall(function()
                return HttpService:JSONDecode(result)
            end)
            if successDecode and codes then
                for _, code in ipairs(codes)do
                    task.spawn(function()
                        pcall(function()
                            Redeem:InvokeServer(code)
                        end)
                    end)
                end
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoLevel) then continue end
            if _G.AutoLevel then
                pcall(function()
                    local Character = LP.Character
                    local HRP = Character and Character:FindFirstChild('HumanoidRootPart')
                    local Humanoid = Character and Character:FindFirstChild('Humanoid')
                    if not HRP or not Humanoid or Humanoid.Health <= 0 then
                        return
                    end
                    CheckLevel()
                    local QuestGui = LP.PlayerGui.Main.Quest
                    local QuestTitle = QuestGui.Container.QuestTitle.Title.Text
                    if not QuestGui.Visible or not string.find(QuestTitle, Monster, 1, true) then
                        if CFrameMonster then
                            Tween(CFrameMonster)
                        end
                        task.spawn(function()
                            if not QuestGui.Visible then
                                CommF:InvokeServer('StartQuest', NameQuest, QuestLv)
                            elseif not string.find(QuestTitle, Monster, 1, true) then
                                CommF:InvokeServer('AbandonQuest')
                            end
                        end)
                    elseif QuestGui.Visible and string.find(QuestTitle, Monster, 1, true) then
                        local foundMonster = false
                        for _, v in pairs(workspace.Enemies:GetChildren()) do
                            if v.Name == Monster and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                                AutoHaki()
                                Equip(SelectWeapon)
                                FarmPos = v.HumanoidRootPart.CFrame
                                MonFarm = v.Name
                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                Attack()
                                foundMonster = true
                                break
                            end
                        end
                        if not foundMonster then
                            if CFrameMonster then
                                Tween(CFrameMonster)
                            end
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Cake) then continue end
            if _G.Cake then
                pcall(function()
                    local rs = game:GetService('ReplicatedStorage')
                    local enemies = game:GetService('Workspace').Enemies
                    local boss = enemies:FindFirstChild('Cake Prince') or enemies:FindFirstChild('Dough King')
                    if boss and boss:FindFirstChild('Humanoid') and boss.Humanoid.Health > 0 and boss:FindFirstChild('HumanoidRootPart') then
                        AutoHaki()
                        Equip(SelectWeapon)
                        Tween(boss.HumanoidRootPart.CFrame + Pos)
                        Attack()
                        return
                    elseif rs:FindFirstChild('Cake Prince') or rs:FindFirstChild('Dough King') then
                        Tween(CFrame.new(-2009.28, 4532.97,-14937.3))
                        return
                    end
                    for _, v in pairs(enemies:GetChildren())do
                        if (v.Name == 'Baking Staff' or v.Name == 'Head Baker' or v.Name == 'Cake Guard' or v.Name == 'Cookie Crafter') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                            AutoHaki()
                            Equip(SelectWeapon)
                            MonFarm = v.Name
                            FarmPos = v.HumanoidRootPart.CFrame
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            Attack()
                            return
                        end
                    end
                    Tween(CFrame.new(-1579.91, 329.73,-12310.36))
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoNear) then continue end
            if _G.AutoNear then
                pcall(function()
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.HumanoidRootPart.Position).Magnitude <= 10000 then
                                repeat
                                    task.wait()
                                    Attack()
                                    AutoHaki()
                                    Equip(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                until not _G.AutoNear or not v.Parent or v.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                end)
            end
        end
    end)
    local BoneCFrame = CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoBone) then continue end
            if _G.AutoBone then
                pcall(function()
                    local Player = game:GetService('Players').LocalPlayer
                    local QuestUI = Player.PlayerGui.Main.Quest
                    local CommF = game:GetService('ReplicatedStorage').Remotes.CommF_
                    if not QuestUI.Visible then
                        CommF:InvokeServer('StartQuest', 'HauntedQuest2', 2)
                        return
                    end
                    local QuestTitle = QuestUI.Container.QuestTitle.Title.Text
                    if not string.find(QuestTitle, 'Posessed Mummys') then
                        CommF:InvokeServer('AbandonQuest')
                        return
                    end
                    for _, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                        if (v.Name == 'Reborn Skeleton' or v.Name == 'Living Zombie' or v.Name == 'Demonic Soul' or v.Name == 'Posessed Mummy') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
                            AutoHaki()
                            Equip(SelectWeapon)
                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            Attack()
                            return
                        end
                    end
                    Tween(BoneCFrame)
                end)
            end
        end
    end)
    if Sea3 then
        Tabs.General:Toggle({
            Title = 'Pirate Castle',
            Value = false,
            Callback = function(Value)
                _G.CastleRaid = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.CastleRaid) then continue end
                if _G.CastleRaid then
                    pcall(function()
                        local CFrameCastleRaid = CFrame.new(-5496.17432, 313.768921,-2841.53027, 0.924894512, 7.37058015e-9, 0.380223751, 3.5881019e-8, 1,-1.06665446E-7,-0.380223751, 1.12297109e-7, 0.924894512)
                        if (CFrame.new(-5539.3115234375, 313.800537109375,-2972.372314453125).Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if _G.CastleRaid and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
                                    if (v.HumanoidRootPart.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                        repeat
                                            task.wait()
                                            Attack()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            MonFarm = v.Name
                                            FarmPos = v.HumanoidRootPart.CFrame
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                        until v.Humanoid.Health <= 0 or not v.Parent or not _G.CastleRaid
                                    end
                                end
                            end
                        else
                            Tween(CFrameCastleRaid)
                        end
                    end)
                end
            end
        end)
        Tabs.General:Toggle({
            Title = 'Auto Activate Color (Rip Indra)',
            Value = false,
            Callback = function(Value)
                _G.AutoRipIndra = Value
            end,
        })
        local hakiMap = {
            Oyster = 'Snow White',
            ['Really red'] = 'Pure Red',
            ['Hot pink'] = 'Winter Sky',
        }
        task.spawn(function()
            ReplicatedStorage = game:GetService('ReplicatedStorage')
            local RF = ReplicatedStorage.Modules.Net['RF/FruitCustomizerRF']
            Workspace = game:GetService('Workspace')
            Players = game:GetService('Players')
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    if not _G.AutoRipIndra then
                        return
                    end
                    local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                    if not hrp then
                        return
                    end
                    local circle = Workspace.Map['Boat Castle'].Summoner.Circle
                    local handled = {}
                    for _, part in ipairs(circle:GetChildren())do
                        if part:IsA('Part') and part:FindFirstChild('Part') and part.Part.BrickColor.Name == 'Dark stone grey' and not table.find(handled, part) then
                            local haki = hakiMap[part.BrickColor.Name]
                            if haki then
                                RF:InvokeServer({
                                    StorageName = haki,
                                    Type = 'AuraSkin',
                                    Context = 'Equip',
                                })
                            end
                            Tween(CFrame.new(part.Position))
                            repeat
                                task.wait()
                            until not _G.AutoRipIndra or (hrp.Position-part.Position).Magnitude <= 5
                            if part:FindFirstChild('TouchInterest') then
                                firetouchinterest(hrp, part, 0)
                                firetouchinterest(hrp, part, 1)
                            end
                            repeat
                                task.wait()
                            until not _G.AutoRipIndra or not (InTree(part, circle) and part:FindFirstChild('Part') and part.Part.BrickColor.Name == 'Dark stone grey')
                            table.insert(handled, part)
                        end
                    end
                end)
            end
        end)
    end
    local LiveChests = {}
    local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('Chest').OnClientEvent
    local CollectionService = game:GetService('CollectionService')
    Remote:Connect(function(Chest, IsSpawning)
        if IsSpawning then
            LiveChests[Chest] = true
        else
            LiveChests[Chest] = nil
        end
    end)
    for _, Chest in pairs(CollectionService:GetTagged('_ChestTagged'))do
        LiveChests[Chest] = true
    end
    CollectionService:GetInstanceAddedSignal('_ChestTagged'):Connect(function(Chest)
        LiveChests[Chest] = true
    end)
    Tabs.General:Toggle({
        Title = 'Collect Chest',
        Value = false,
        Callback = function(Value)
            _G.AutoFarmChest = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmChest) then continue end
            if _G.AutoFarmChest then
                pcall(function()
                    local Character = game:GetService('Players').LocalPlayer.Character
                    if not Character or not Character:FindFirstChild('HumanoidRootPart') then
                        return
                    end
                    local RootPart = Character.HumanoidRootPart
                    local MyPos = RootPart.Position
                    local Nearest, MinDist = nil, math.huge
                    for Chest, _ in pairs(LiveChests)do
                        if Chest and Chest.Parent then
                            local Dist = (Chest.Position-MyPos).Magnitude
                            if Dist < MinDist then
                                if (not SelectedIsland or InTree(Chest, SelectedIsland)) and not Chest:GetAttribute('IsDisabled') then
                                    MinDist = Dist
                                    Nearest = Chest
                                end
                            end
                        else
                            LiveChests[Chest] = nil
                        end
                    end
                    if Nearest then
                        Tween(Nearest.CFrame)
                    end
                end)
            end
        end
    end)
    Tabs.General:Toggle({
        Title = 'Collect Berry',
        Value = false,
        Callback = function(Value)
            _G.AutoBerry = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoBerry) then continue end
            if _G.AutoBerry then
                local CollectionService = game:GetService('CollectionService')
                Players = game:GetService('Players')
                local Player = Players.LocalPlayer
                local BerryBush = CollectionService:GetTagged('BerryBush')
                local Distance, Nearest = math.huge
                for i = 1, #BerryBush do
                    local Bush = BerryBush[i]
                    for AttributeName, BerryName in pairs(Bush:GetAttributes())do
                        if not BerryArray or table.find(BerryArray, BerryName) then
                            Tween(Bush.Parent:GetPivot())
                            for j = 1, #BerryBush do
                                local SubBush = BerryBush[j]
                                for _, Child in pairs(SubBush:GetChildren())do
                                    if not BerryArray or table.find(BerryArray, Child.Name) then
                                        Tween(Child.WorldPivot)
                                        fireproximityprompt(Child.ProximityPrompt, math.huge)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
    if Sea2 or Sea3 then
        local DropdownMastery = Tabs.General:Dropdown({
            Title = 'Mastery Type',
            Values = {},
            Multi = false,
            Callback = function(Value)
                TypeMastery = Value
            end,
        })
        local function UpdateDropdownValues()
            if Sea3 then
                DropdownMastery:Refresh({
                    'Level',
                    'Near Mob',
                    'Bone',
                    'Cake',
                })
            elseif Sea2 then
                DropdownMastery:Refresh({
                    'Level',
                    'Near Mob',
                    'Ecto',
                })
            else
                DropdownMastery:Refresh({})
            end
        end
        UpdateDropdownValues()
        local SkillOptions = {
            'Skill Z',
            'Skill X',
            'Skill C',
            'Skill V',
            'Skill F',
        }
        Tabs.General:Dropdown({
            Title = 'Select Skills',
            Values = SkillOptions,
            Multi = true,
            Value = SkillOptions,
            Callback = function(Value)
                SkillZ = false
                SkillX = false
                SkillC = false
                SkillV = false
                SkillF = false
                for _, v in pairs(Value)do
                    if v == 'Skill Z' then
                        SkillZ = true
                    end
                    if v == 'Skill X' then
                        SkillX = true
                    end
                    if v == 'Skill C' then
                        SkillC = true
                    end
                    if v == 'Skill V' then
                        SkillV = true
                    end
                    if v == 'Skill F' then
                        SkillF = true
                    end
                end
            end,
        })
        local MasterySelected = ''
        local IsMasteryFarmEnabled = false
        _G.AutoFarmMasDevilFruit = false
        _G.AutoFarmMasGun = false
        Tabs.General:Dropdown({
            Title = 'Farm Mastery Type',
            Values = {
                'Fruit',
                'Gun',
            },
            Multi = false,
            Callback = function(Value)
                MasterySelected = Value
                if IsMasteryFarmEnabled then
                    if Value == 'Fruit' then
                        _G.AutoFarmMasDevilFruit = true
                        _G.AutoFarmMasGun = false
                    elseif Value == 'Gun' then
                        _G.AutoFarmMasGun = true
                        _G.AutoFarmMasDevilFruit = false
                    end
                end
            end,
        })
        Tabs.General:Toggle({
            Title = 'Mastery Farm',
            Value = false,
            Callback = function(Value)
                IsMasteryFarmEnabled = Value
                if Value then
                    if MasterySelected == 'Fruit' then
                        _G.AutoFarmMasDevilFruit = true
                        _G.AutoFarmMasGun = false
                    elseif MasterySelected == 'Gun' then
                        _G.AutoFarmMasGun = true
                        _G.AutoFarmMasDevilFruit = false
                    end
                else
                    _G.AutoFarmMasDevilFruit = false
                    _G.AutoFarmMasGun = false
                end
            end,
        })
        Tabs.General:Input({
            Title = 'Health Mob %',
            Value = 40,
            Placeholder = 'Enter %.',
            Callback = function(Value)
                KillPercent = tonumber(Value)
            end,
        })
    end
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.UseSkill) then continue end
            if _G.UseSkill then
                pcall(function()
                    for _, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                        if v.Name == MonFarm and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                            repeat
                                task.wait()
                                EquipFruit()
                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                PositionSkillMasteryDevilFruit = v.HumanoidRootPart.Position
                                if SkillZ then
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                                    task.wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                                end
                                if SkillX then
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                                    task.wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                                end
                                if SkillC then
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'C', false, game)
                                    task.wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'C', false, game)
                                end
                                if SkillV then
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'V', false, game)
                                    task.wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'V', false, game)
                                end
                                if SkillF then
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'F', false, game)
                                    task.wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'F', false, game)
                                end
                            until not _G.AutoFarmMasDevilFruit or not _G.UseSkill or v.Humanoid.Health == 0
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasDevilFruit and TypeMastery == 'Near Mob') then continue end
            if _G.AutoFarmMasDevilFruit and TypeMastery == 'Near Mob' then
                pcall(function()
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.HumanoidRootPart.Position).Magnitude <= 5000 then
                                repeat
                                    task.wait()
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        _G.UseSkill = true
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                    else
                                        _G.UseSkill = false
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Attack()
                                    end
                                until not _G.AutoFarmMasDevilFruit or TypeMastery ~= 'Near Mob' or not v.Parent or v.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(v.Name)
                                _G.UseSkill = false
                            end
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasDevilFruit and TypeMastery == 'Ecto') then continue end
            if _G.AutoFarmMasDevilFruit and TypeMastery == 'Ecto' then
                pcall(function()
                    local EctoMobPos = Vector3.new(904.407, 181.058, 33341.387)
                    local Distance = (EctoMobPos-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if Distance > 20000 then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(923.213, 126.976, 32852.832))
                    end
                    Tween(CFrame.new(EctoMobPos))
                    for i, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') then
                            if v.Name == 'Ship Steward' or v.Name == 'Ship Engineer' or v.Name == 'Ship Deckhand' or v.Name == 'Ship Officer' then
                                repeat
                                    task.wait()
                                    if not v.Parent or v.Humanoid.Health <= 0 then
                                        break
                                    end
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        _G.UseSkill = true
                                    else
                                        _G.UseSkill = false
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Attack()
                                    end
                                until not _G.AutoFarmMasDevilFruit or MasteryType ~= 'Ecto' or not v.Parent or v.Humanoid.Health <= 0 or TypeMastery ~= 'Ecto'
                                _G.UseSkill = false
                            end
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasDevilFruit and TypeMastery == 'Cake') then continue end
            if _G.AutoFarmMasDevilFruit and TypeMastery == 'Cake' then
                pcall(function()
                    local cakepos = CFrame.new(-1579.91, 329.73,-12310.36)
                    Tween(cakepos)
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') then
                            if table.find({
                                'Cookie Crafter',
                                'Cake Guard',
                                'Baking Staff',
                                'Head Baker',
                            }, v.Name) then
                                repeat
                                    task.wait()
                                    if not v.Parent or v.Humanoid.Health <= 0 then
                                        break
                                    end
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        _G.UseSkill = true
                                    else
                                        _G.UseSkill = false
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Attack()
                                    end
                                until not _G.AutoFarmMasDevilFruit or TypeMastery ~= 'Cake' or not v.Parent or v.Humanoid.Health <= 0
                                _G.UseSkill = false
                            end
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasDevilFruit and TypeMastery == 'Level') then continue end
            if _G.AutoFarmMasDevilFruit and TypeMastery == 'Level' then
                pcall(function()
                    CheckLevel()
                    local player = game:GetService('Players').LocalPlayer
                    local gui = player.PlayerGui.Main.Quest
                    local questTitle = gui.Container.QuestTitle.Title.Text
                    local CommF = game:GetService('ReplicatedStorage').Remotes.CommF_
                    if gui.Visible == false or not string.find(questTitle, Monster, 1, true) then
                        CommF:InvokeServer('AbandonQuest')
                        CommF:InvokeServer('StartQuest', NameQuest, QuestLv)
                        return
                    end
                    for _, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                        if v.Name == Monster and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                _G.UseSkill = true
                            else
                                _G.UseSkill = false
                                AutoHaki()
                                Equip(SelectWeapon)
                                Attack()
                            end
                            return
                        end
                    end
                    _G.UseSkill = false
                    Tween(CFrameMonster)
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasDevilFruit and TypeMastery == 'Bone') then continue end
            if _G.AutoFarmMasDevilFruit and TypeMastery == 'Bone' then
                pcall(function()
                    local boneframe = CFrame.new(-9508.567, 142.139, 5737.36)
                    Tween(boneframe)
                    for i, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') then
                            local isTarget = v.Name == 'Reborn Skeleton' or v.Name == 'Living Zombie' or v.Name == 'Demonic Soul' or v.Name == 'Posessed Mummy'
                            if isTarget then
                                repeat
                                    task.wait()
                                    if not v.Parent or v.Humanoid.Health <= 0 then
                                        break
                                    end
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        _G.UseSkill = true
                                    else
                                        _G.UseSkill = false
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Attack()
                                    end
                                until not _G.AutoFarmMasDevilFruit or TypeMastery ~= 'Bone' or not v.Parent or v.Humanoid.Health <= 0
                                _G.UseSkill = false
                            end
                        end
                    end
                    for _, v in pairs(game:GetService('ReplicatedStorage'):GetChildren())do
                        local isStorageTarget = v.Name == 'Reborn Skeleton' or v.Name == 'Living Zombie' or v.Name == 'Demonic Soul' or v.Name == 'Posessed Mummy'
                        if isStorageTarget and v:FindFirstChild('HumanoidRootPart') then
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.UseSkillGun) then continue end
            if _G.UseSkillGun then
                pcall(function()
                    if _G.UseSkillGun then
                        for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                            if v.Name == MonFarm and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                repeat
                                    task.wait()
                                    EquipGun()
                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                    PositionSkillMasteryGun = v.HumanoidRootPart.Position
                                    if SkillZ then
                                        game:service('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                                        task.wait()
                                        game:service('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                                    end
                                    if SkillX then
                                        game:service('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                                        task.wait()
                                        game:service('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                                    end
                                    if SkillC then
                                        game:service('VirtualInputManager'):SendKeyEvent(true, 'C', false, game)
                                        task.wait()
                                        game:service('VirtualInputManager'):SendKeyEvent(false, 'C', false, game)
                                    end
                                    if SkillV then
                                        game:service('VirtualInputManager'):SendKeyEvent(true, 'V', false, game)
                                        task.wait()
                                        game:service('VirtualInputManager'):SendKeyEvent(false, 'V', false, game)
                                    end
                                    if SkillF then
                                        game:GetService('VirtualInputManager'):SendKeyEvent(true, 'F', false, game)
                                        task.wait()
                                        game:GetService('VirtualInputManager'):SendKeyEvent(false, 'F', false, game)
                                    end
                                until not _G.AutoFarmMasGun or not _G.UseSkillGun or v.Humanoid.Health == 0
                            end
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasGun and TypeMastery == 'Near Mob') then continue end
            if _G.AutoFarmMasGun and TypeMastery == 'Near Mob' then
                pcall(function()
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.HumanoidRootPart.Position).Magnitude <= 5000 then
                                repeat
                                    task.wait()
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        _G.UseSkillGun = true
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                    else
                                        _G.UseSkillGun = false
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Attack()
                                    end
                                until not _G.AutoFarmMasGun or TypeMastery ~= 'Near Mob' or not v.Parent or v.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(v.Name)
                                _G.UseSkillGun = false
                            end
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasGun and TypeMastery == 'Ecto') then continue end
            if _G.AutoFarmMasGun and TypeMastery == 'Ecto' then
                pcall(function()
                    local ectoCFrame = CFrame.new(904.407, 181.058, 33341.387)
                    Tween(ectoCFrame)
                    local distance = (ectoCFrame.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance > 20000 then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(923.213, 126.976, 32852.832))
                    end
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') then
                            local isTarget = v.Name == 'Ship Steward' or v.Name == 'Ship Engineer' or v.Name == 'Ship Deckhand' or v.Name == 'Ship Officer'
                            if isTarget then
                                repeat
                                    task.wait()
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        _G.UseSkillGun = true
                                    else
                                        _G.UseSkillGun = false
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Attack()
                                    end
                                until not _G.AutoFarmMasGun or TypeMastery ~= 'Ecto' or not v.Parent or v.Humanoid.Health <= 0
                                _G.UseSkillGun = false
                            end
                        end
                    end
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        local isTarget = v.Name == 'Ship Steward' or v.Name == 'Ship Engineer' or v.Name == 'Ship Deckhand' or v.Name == 'Ship Officer'
                        if isTarget and v:FindFirstChild('HumanoidRootPart') then
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasGun and TypeMastery == 'Cake') then continue end
            if _G.AutoFarmMasGun and TypeMastery == 'Cake' then
                pcall(function()
                    local cakePos = CFrame.new(-1579.91, 329.73,-12310.36)
                    Tween(cakePos)
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') then
                            local isTarget = v.Name == 'Cookie Crafter' or v.Name == 'Cake Guard' or v.Name == 'Baking Staff' or v.Name == 'Head Baker'
                            if isTarget then
                                repeat
                                    task.wait()
                                    if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                        _G.UseSkillGun = true
                                    else
                                        _G.UseSkillGun = false
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Attack()
                                    end
                                until not _G.AutoFarmMasGun or TypeMastery ~= 'Cake' or not v.Parent or v.Humanoid.Health <= 0
                                _G.UseSkillGun = false
                            end
                        end
                    end
                    for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                        local isTarget = v.Name == 'Cookie Crafter' or v.Name == 'Cake Guard' or v.Name == 'Baking Staff' or v.Name == 'Head Baker'
                        if isTarget and v:FindFirstChild('HumanoidRootPart') then
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasGun and TypeMastery == 'Level') then continue end
            if _G.AutoFarmMasGun and TypeMastery == 'Level' then
                pcall(function()
                    CheckLevel()
                    local playerGui = game:GetService('Players').LocalPlayer.PlayerGui
                    local questGui = playerGui.Main.Quest
                    local questTitle = questGui.Container.QuestTitle.Title.Text
                    local CommF = game:GetService('ReplicatedStorage').Remotes.CommF_
                    if questGui.Visible == false or not string.find(questTitle, Monster, 1, true) then
                        CommF:InvokeServer('AbandonQuest')
                        CommF:InvokeServer('StartQuest', NameQuest, QuestLv)
                        return
                    end
                    for _, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                        if v.Name == Monster and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                _G.UseSkillGun = true
                            else
                                _G.UseSkillGun = false
                                AutoHaki()
                                Equip(SelectWeapon)
                                Attack()
                            end
                            return
                        end
                    end
                    _G.UseSkillGun = false
                    Tween(CFrameMonster)
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoFarmMasGun and TypeMastery == 'Bone') then continue end
            if _G.AutoFarmMasGun and TypeMastery == 'Bone' then
                pcall(function()
                    local enemies = game:GetService('Workspace').Enemies
                    local replicatedStorage = game:GetService('ReplicatedStorage')
                    for _, v in pairs(enemies:GetChildren())do
                        if (v.Name == 'Reborn Skeleton' or v.Name == 'Living Zombie' or v.Name == 'Demonic Soul' or v.Name == 'Posessed Mummy') and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
                                    _G.UseSkillGun = true
                                else
                                    _G.UseSkillGun = false
                                    AutoHaki()
                                    Equip(SelectWeapon)
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                    Attack()
                                end
                            until not _G.AutoFarmMasGun or TypeMastery ~= 'Bone' or not v.Parent or v.Humanoid.Health <= 0
                            _G.UseSkillGun = false
                            return
                        end
                    end
                    for _, v in pairs(replicatedStorage:GetChildren())do
                        if (v.Name == 'Reborn Skeleton' or v.Name == 'Living Zombie' or v.Name == 'Demonic Soul' or v.Name == 'Posessed Mummy') and v:FindFirstChild('HumanoidRootPart') then
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            return
                        end
                    end
                    Tween(CFrame.new(-9508.567, 142.14, 5737.36))
                end)
            end
        end
    end)
    function EquipGun()
        pcall(function()
            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren())do
                if v:IsA('Tool') and v.ToolTip == 'Gun' then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    break
                end
            end
        end)
    end
    function EquipFruit()
        pcall(function()
            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren())do
                if v:IsA('Tool') and v.ToolTip == 'Blox Fruit' then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    break
                end
            end
        end)
    end
    task.spawn(function()
        local gg = getrawmetatable(game)
        local old = gg.__namecall
        setreadonly(gg, false)
        gg.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {...}
            if tostring(method) == 'FireServer' then
                if tostring(args[1]) == 'RemoteEvent' then
                    if tostring(args[2]) ~= 'true' and tostring(args[2]) ~= 'false' then
                        if _G.UseSkillGun then
                            if typeof(args[2]) == 'Vector3' then
                                args[2] = PositionSkillMasteryGun
                            else
                                args[2] = CFrame.new(PositionSkillMasteryGun)
                            end
                            return old(unpack(args))
                        end
                        if _G.UseSkill then
                            if typeof(args[2]) == 'Vector3' then
                                args[2] = PositionSkillMasteryDevilFruit
                            else
                                args[2] = CFrame.new(PositionSkillMasteryDevilFruit)
                            end
                            return old(unpack(args))
                        end
                    end
                end
            end
            return old(...)
        end)
        setreadonly(gg, true)
    end)
    task.spawn(function()
        Players = game:GetService('Players')
        LocalPlayer = Players.LocalPlayer
        while task.wait() do
            if not SolarixStream(_G.AutoFarmRace or _G.AutoTurnV4 or _G.AutoFarmSea or _G.AutoQuestRace or _G.AutoKillTrial or _G.Auto_Dungeon or _G.AttackLeviathan) then continue end
            if _G.AutoFarmRace or _G.AutoTurnV4 or _G.AutoFarmSea or _G.AutoQuestRace or _G.AutoKillTrial or _G.Auto_Dungeon or _G.AttackLeviathan then
                pcall(function()
                    local Character = LocalPlayer.Character
                    if Character and Character:FindFirstChild('RaceEnergy') and Character.RaceEnergy.Value == 1 then
                        game.ReplicatedStorage.Events.ActivateRaceV4:Fire()
                    end
                end)
            end
        end
    end)
    if Sea3 then
        local StatusBone = Tabs.General:Paragraph({
            Title = 'Bone Status',
            Desc = 'Calculating...',
            Color = 'Orange',
        })
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                local bones = CheckMaterial('Bones')
                StatusBone:SetDesc('You Have: ' .. tostring(bones) .. ' Bone')
            end
        end)
        local BoneNoQuest = CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFarmRace) then continue end
                if _G.AutoFarmRace then
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local char = player.Character or player.CharacterAdded:Wait()
                        local root = char:FindFirstChild('HumanoidRootPart')
                        if root then
                            Tween(BoneNoQuest)
                        end
                        if root and (BoneNoQuest.Position-root.Position).Magnitude <= 5 then
                            for _, v in pairs(workspace.Enemies:GetChildren())do
                                if v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
                                    if v.Name == 'Reborn Skeleton' or v.Name == 'Living Zombie' or v.Name == 'Demonic Soul' or v.Name == 'Posessed Mummy' then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Attack()
                                            if v:FindFirstChild('HumanoidRootPart') then
                                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                                FarmPos = v.HumanoidRootPart.CFrame
                                                MonFarm = v.Name
                                            end
                                        until not _G.AutoFarmRace or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Tabs.General:Button({
            Title = 'Pray',
            Callback = function()
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('gravestoneEvent', 1)
            end,
        })
        Tabs.General:Button({
            Title = 'Try Luck',
            Callback = function()
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('gravestoneEvent', 2)
            end,
        })
        Tabs.General:Toggle({
            Title = 'Random Bone',
            Value = false,
            Callback = function(Value)
                _G.AutoRandomBone = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoRandomBone) then continue end
                if _G.AutoRandomBone then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Bones', 'Buy', 1, 1)
                end
            end
        end)
        local Mob_Kill_Cake_Prince = Tabs.General:Paragraph({
            Title = 'Cake Status',
            Desc = 'Waiting...',
            Color = 'Orange',
        })
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    local response = game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')
                    local responseLength = string.len(response)
                    if responseLength == 88 then
                        Mob_Kill_Cake_Prince:SetDesc('Killed: ' .. string.sub(response, 39, 41))
                    elseif responseLength == 87 then
                        Mob_Kill_Cake_Prince:SetDesc('Killed: ' .. string.sub(response, 39, 40))
                    elseif responseLength == 86 then
                        Mob_Kill_Cake_Prince:SetDesc('Killed: ' .. string.sub(response, 39, 39))
                    else
                        Mob_Kill_Cake_Prince:SetDesc('\u{2705}\u{fe0f}')
                    end
                end)
            end
        end)
        Tabs.General:Toggle({
            Title = 'Spawn Cake Prince',
            Value = true,
            Callback = function(Value)
                _G.SpawnCakePrince = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.SpawnCakePrince) then continue end
                if _G.SpawnCakePrince then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')
                end
            end
        end)
    end
    local tableBoss = {}
    if Sea1 then
        tableBoss = {
            'The Gorilla King',
            'Chef',
            'Yeti',
            'Mob Leader',
            'Vice Admiral',
            'Warden',
            'Chief Warden',
            'Swan',
            'Magma Admiral',
            'Fishman Lord',
            'Wysper',
            'Thunder God',
            'Cyborg',
            'Saber Expert',
        }
    elseif Sea2 then
        tableBoss = {
            'Diamond',
            'Jeremy',
            'Orbitus',
            'Don Swan',
            'Smoke Admiral',
            'Cursed Captain',
            'Darkbeard',
            'Order',
            'Awakened Ice Admiral',
            'Tide Keeper',
        }
    elseif Sea3 then
        tableBoss = {
            'Stone',
            'Hydra Leader',
            'Kilo Admiral',
            'Captain Elephant',
            'Beautiful Pirate',
            'rip_indra True Form',
            'Longma',
            'Soul Reaper',
            'Cake Queen',
            'Tyrant of the Skies',
        }
    end
    local function getAvailableBosses()
        local available = {}
        for _, boss in pairs(tableBoss)do
            local inWorkspace = game:GetService('Workspace').Enemies:FindFirstChild(boss)
            local inReplicated = game:GetService('ReplicatedStorage'):FindFirstChild(boss)
            if inWorkspace or inReplicated then
                table.insert(available, boss)
            end
        end
        return available
    end
    local currentBossList = getAvailableBosses()
    local DropdownBoss = Tabs.General:Dropdown({
        Title = 'Boss Type',
        Values = currentBossList,
        Multi = false,
        Callback = function(Value)
            _G.SelectBoss = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            local newBossList = getAvailableBosses()
            local changed = false
            if #newBossList ~= #currentBossList then
                changed = true
            else
                for i = 1, #newBossList do
                    if newBossList[i] ~= currentBossList[i] then
                        changed = true
                        break
                    end
                end
            end
            if changed then
                currentBossList = newBossList
                DropdownBoss:Refresh(currentBossList)
                if not table.find(currentBossList, _G.SelectBoss) then
                    _G.SelectBoss = nil
                end
            end
        end
    end)
    Tabs.General:Toggle({
        Title = 'Farm Boss',
        Value = false,
        Callback = function(Value)
            _G.AutoBoss = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoBoss and _G.SelectBoss) then continue end
            if _G.AutoBoss and _G.SelectBoss then
                pcall(function()
                    local enemies = game:GetService('Workspace').Enemies
                    local replicatedStorage = game:GetService('ReplicatedStorage')
                    for _, v in pairs(enemies:GetChildren())do
                        if v.Name == _G.SelectBoss and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                Equip(SelectWeapon)
                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                Attack()
                                sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
                            until not _G.AutoBoss or not v.Parent or v.Humanoid.Health <= 0 or _G.SelectBoss ~= v.Name
                            return
                        end
                    end
                    for _, v in pairs(replicatedStorage:GetChildren())do
                        if v.Name == _G.SelectBoss and v:FindFirstChild('HumanoidRootPart') then
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            return
                        end
                    end
                end)
            end
        end
    end)
    local MaterialList = {}
    if Sea1 then
        MaterialList = {
            'Scrap Metal',
            'Leather',
            'Angel Wings',
            'Magma Ore',
            'Fish Tail',
        }
    elseif Sea2 then
        MaterialList = {
            'Scrap Metal',
            'Leather',
            'Radioactive Material',
            'Mystic Droplet',
            'Magma Ore',
            'Vampire Fang',
            'Ectoplasm',
        }
    elseif Sea3 then
        MaterialList = {
            'Scrap Metal',
            'Leather',
            'Demonic Wisp',
            'Conjured Cocoa',
            'Dragon Scale',
            'Gunpowder',
            'Fish Tail',
            'Mini Tusk',
        }
    end
    Tabs.General:Dropdown({
        Title = 'Material Type',
        Values = MaterialList,
        Multi = false,
        Value = MaterialList[1],
        Callback = function(Value)
            SelectMaterial = Value
        end,
    })
    Tabs.General:Toggle({
        Title = 'Farm Material',
        Value = false,
        Callback = function(Value)
            _G.AutoMaterial = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoMaterial) then continue end
            if _G.AutoMaterial then
                pcall(function()
                    if SelectMaterial == 'Ectoplasm' then
                        if game:GetService('Workspace').Enemies:FindFirstChild('Ship Deckhand') or game:GetService('Workspace').Enemies:FindFirstChild('Ship Engineer') or game:GetService('Workspace').Enemies:FindFirstChild('Ship Steward') or game:GetService('Workspace').Enemies:FindFirstChild('Ship Officer') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if (v.Name == 'Ship Steward' or v.Name == 'Ship Engineer' or v.Name == 'Ship Deckhand' or v.Name == 'Ship Officer') and v:FindFirstChild('Humanoid') then
                                    if v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            Attack()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            FarmPos = v.HumanoidRootPart.CFrame
                                            MonFarm = v.Name
                                        until not _G.AutoMaterial or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            local Distance = (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875)-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if Distance > 20000 then
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                            end
                            Tween(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875))
                        end
                    else
                        MaterialMon(SelectMaterial)
                        Tween(MPos)
                        if game:GetService('Workspace').Enemies:FindFirstChild(MMon) then
                            for i, v in pairs(game.Workspace.Enemies:GetChildren())do
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                    if v.Name == MMon then
                                        repeat
                                            task.wait()
                                            Attack()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            FarmPos = v.HumanoidRootPart.CFrame
                                            MonFarm = v.Name
                                        until not _G.AutoMaterial or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            for i, v in pairs(game:GetService('Workspace')._WorldOrigin.EnemySpawns:GetChildren())do
                                if string.find(v.Name, Mon) then
                                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-v.Position).Magnitude >= 10 then
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
    if Sea3 then
        Tabs.Sea:Toggle({
            Title = 'Auto Complete Kitsune',
            Value = false,
            Callback = function(Value)
                _G.AutoKitsune = Value
            end,
        })
        task.spawn(function()
            local kitsuneIsland
            repeat
                kitsuneIsland = game:GetService('Workspace'):WaitForChild('Map', 5):FindFirstChild('KitsuneIsland')
                task.wait()
            until kitsuneIsland
            local KitsuneDone = false
            while task.wait() do
                if not SolarixStream(_G.AutoKitsune) then continue end
                if _G.AutoKitsune then
                    for _, obj in ipairs(kitsuneIsland:GetDescendants())do
                        if obj:IsA('ProximityPrompt') and obj.ActionText == '...' and obj.ObjectText == 'Kitsune Shrine' then
                            local parentPart = obj.Parent
                            if parentPart:IsA('BasePart') then
                                Tween(parentPart.CFrame)
                                repeat
                                    task.wait()
                                until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-parentPart.Position).Magnitude <= 5
                                fireproximityprompt(obj, 0)
                                local touchEvent = game:GetService('ReplicatedStorage').Modules.Net:FindFirstChild('RE/TouchKitsuneStatue')
                                if touchEvent then
                                    touchEvent:FireServer()
                                end
                                KitsuneDone = true
                                break
                            end
                        end
                    end
                    local collectEvent = game:GetService('ReplicatedStorage'):WaitForChild('Modules'):WaitForChild('Net'):WaitForChild('RE/CollectBlueEmber')
                    if collectEvent then
                        collectEvent:FireServer()
                    end
                    if CheckMaterial('Azure Ember') == 25 then
                        local modules = game:GetService('ReplicatedStorage'):WaitForChild('Modules', 5)
                        if modules then
                            local net = modules:FindFirstChild('Net')
                            if net then
                                local tradeFunction = net:FindFirstChild('RF/KitsuneStatuePray')
                                if tradeFunction then
                                    tradeFunction:InvokeServer()
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
    if Sea3 then
        Players = game:GetService('Players')
        TweenService = game:GetService('TweenService')
        Workspace = game:GetService('Workspace')
        ReplicatedStorage = game:GetService('ReplicatedStorage')
        RunService = game:GetService('RunService')
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local SetSpeedBoat = 350
        local IslandTypeSelected = ''
        local selectedBoat = 'Guardian'
        local notified = false
        local isBoatTeleporting = false
        local isBuyingBoat = false
        local foundIslandPos = nil
        local KitsuneEventTriggered = false
        local FarPoint = Vector3.new(-111907.734, 150, 32081.475) * 100
        local DockPosition = CFrame.new(-16917.154, 7.757, 511.82)
        local function getIslandConfig(name)
            local config = {
                Prehistoric = {
                    Target = 'PrehistoricIsland',
                    Notify = 'Found Prehistoric Island',
                },
                Mirage = {
                    Target = 'MysticIsland',
                    Notify = 'Found Mirage Island',
                },
                Frozen = {
                    Target = 'LeviathanGate',
                    Notify = 'Found Frozen Dimension',
                },
                Kitsune = {
                    Target = 'KitsuneIsland',
                    Notify = 'Found Kitsune Island',
                },
            }
            return config[name]
        end
        Tabs.Sea:Dropdown({
            Title = 'Island Type',
            Values = {
                'Prehistoric',
                'Mirage',
                'Frozen',
                'Kitsune',
            },
            Multi = false,
            Callback = function(Value)
                IslandTypeSelected = Value
                foundIslandPos = nil
                KitsuneEventTriggered = false
                if _G.AutoFindIsland and Value then
                    local config = getIslandConfig(Value)
                    if config and Workspace.Map:FindFirstChild(config.Target) then
                        foundIslandPos = Workspace.Map:FindFirstChild(config.Target):GetModelCFrame().Position
                        Library:Notify({
                            Title = 'Solarix',
                            Content = config.Notify,
                            Duration = 5,
                        })
                    end
                end
            end,
        })
        Tabs.Sea:Toggle({
            Title = 'Auto Find Island',
            Value = false,
            Callback = function(Value)
                _G.AutoFindIsland = Value
                if not Value then
                    foundIslandPos = nil
                    isBuyingBoat = false
                    StopBoatNoclip()
                    StopCharacterNoclip()
                else
                    notified = false
                    isBuyingBoat = false
                    foundIslandPos = nil
                    KitsuneEventTriggered = false
                    if IslandTypeSelected ~= '' then
                        local config = getIslandConfig(IslandTypeSelected)
                        if config and Workspace.Map:FindFirstChild(config.Target) then
                            foundIslandPos = Workspace.Map:FindFirstChild(config.Target):GetModelCFrame().Position
                            Library:Notify({
                                Title = 'Solarix',
                                Content = config.Notify,
                                Duration = 5,
                            })
                        end
                    end
                end
            end,
        })
        local function CheckFullMoon()
            local notifGui = player.PlayerGui:FindFirstChild('Notifications')
            if notifGui then
                for _, v in pairs(notifGui:GetChildren())do
                    if v:IsA('TextLabel') and string.find(v.Text, 'The light of a full moon peaks through the clouds') then
                        return true
                    end
                end
            end
            return false
        end
        local function GetMyBoat()
            for _, boat in pairs(Workspace.Boats:GetChildren())do
                local owner = boat:FindFirstChild('Owner')
                if owner and owner.Value == player then
                    return boat
                end
            end
            return nil
        end
        local function teleportToBoat()
            if isBoatTeleporting then
                return
            end
            isBoatTeleporting = true
            local myBoat = GetMyBoat()
            if myBoat then
                local seat = myBoat:FindFirstChild('VehicleSeat')
                if seat and not seat.Occupant then
                    if player.Character and player.Character:FindFirstChild('HumanoidRootPart') then
                        Tween(seat.CFrame + Vector3.new(0, 5, 0))
                    end
                end
            end
            isBoatTeleporting = false
        end
        local boatList = {
            'Beast Hunter',
            'Sleigh',
            'Miracle',
            'The Sentinel',
            'Guardian',
            'Lantern',
            'Dinghy',
            'PirateSloop',
            'PirateBrigade',
            'PirateGrandBrigade',
            'MarineGrandBrigade',
            'MarineBrigade',
            'MarineSloop',
        }
        Tabs.Sea:Dropdown({
            Title = 'Boat Type',
            Values = boatList,
            Multi = false,
            Callback = function(Value)
                selectedBoat = Value
            end,
        })
        local function buyBoat(boatName)
            ReplicatedStorage.Remotes.CommF_:InvokeServer('BuyBoat', boatName)
        end
        Tabs.Sea:Button({
            Title = 'Buy Boat',
            Callback = function()
                isBuyingBoat = false
                buyBoat(selectedBoat)
            end,
        })
        Tabs.Sea:Button({
            Title = 'Teleport To My Boat',
            Callback = function()
                teleportToBoat()
            end,
        })
        local function handleBoatMovement(seat, deltaTime)
            local currentPos = seat.Position
            local targetY = 190
            local targetPos
            if foundIslandPos then
                targetPos = Vector3.new(foundIslandPos.X, targetY, foundIslandPos.Z)
                local distanceToIsland = (Vector3.new(currentPos.X, 0, currentPos.Z)-Vector3.new(foundIslandPos.X, 0, foundIslandPos.Z)).Magnitude
                if distanceToIsland <= 2000 then
                    _G.AutoFindIsland = false
                    seat.AssemblyLinearVelocity = Vector3.zero
                    seat.AssemblyAngularVelocity = Vector3.zero
                    seat.CFrame = CFrame.new(seat.Position, foundIslandPos)
                    StopBoatNoclip()
                    StopCharacterNoclip()
                    return
                end
            else
                targetPos = Vector3.new(FarPoint.X, targetY, FarPoint.Z)
            end
            if targetPos then
                local direction = (targetPos-currentPos).Unit
                seat.AssemblyLinearVelocity = direction * SetSpeedBoat
                seat.AssemblyAngularVelocity = Vector3.zero
                local nextPos = currentPos + (direction * SetSpeedBoat * deltaTime)
                seat.CFrame = CFrame.new(Vector3.new(nextPos.X, targetY, nextPos.Z), targetPos) * CFrame.Angles(0, math.rad(-35), 0)
                seat.MaxSpeed = SetSpeedBoat
            end
        end
        local function ProcessBuyBoat()
            if isBuyingBoat then
                return
            end
            isBuyingBoat = true
            local char = player.Character
            if char and char:FindFirstChild('Humanoid') then
                char.Humanoid.Sit = false
            end
            local hrp = char and char:FindFirstChild('HumanoidRootPart')
            if hrp then
                if (hrp.Position-DockPosition.Position).Magnitude > 20 then
                    Tween(DockPosition)
                    task.wait(0.5)
                end
                local updatedHrp = player.Character and player.Character:FindFirstChild('HumanoidRootPart')
                if updatedHrp and (updatedHrp.Position-DockPosition.Position).Magnitude <= 20 then
                    buyBoat(selectedBoat ~= '' and selectedBoat or 'Guardian')
                    task.wait(1.5)
                end
            end
            isBuyingBoat = false
        end
        Workspace.Map.ChildAdded:Connect(function(child)
            if not _G.AutoFindIsland or not getIslandConfig(IslandTypeSelected) then
                return
            end
            local config = getIslandConfig(IslandTypeSelected)
            if child.Name == config.Target then
                foundIslandPos = child:GetModelCFrame().Position
                Library:Notify({
                    Title = 'Solarix',
                    Content = config.Notify,
                    Duration = 5,
                })
                notified = true
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFindIsland and getIslandConfig(IslandTypeSelected) ~= nil) then continue end
                if _G.AutoFindIsland and getIslandConfig(IslandTypeSelected) then
                    StartCharacterNoclip()
                    local myBoat = GetMyBoat()
                    if myBoat then
                        StartBoatNoclip(myBoat)
                    end
                    SolarixStreamDelay(0.25)
                end
            end
        end)
        RunService.Heartbeat:Connect(function(deltaTime)
            if not _G.AutoFindIsland or not getIslandConfig(IslandTypeSelected) then
                return
            end
            character = player.Character
            if not character or not character:FindFirstChild('Humanoid') or not character:FindFirstChild('HumanoidRootPart') then
                return
            end
            local myBoat = GetMyBoat()
            if myBoat then
                local seat = myBoat:FindFirstChild('VehicleSeat')
                if seat then
                    local isWaitingInCrazy = false
                    if IslandTypeSelected == 'Kitsune' and not KitsuneEventTriggered then
                        local dangerLabel = player.PlayerGui.Main.Compass.Frame.DangerText
                        if dangerLabel and dangerLabel.ContentText:find('Crazy') then
                            isWaitingInCrazy = true
                        end
                    end
                    if isWaitingInCrazy then
                        seat.AssemblyLinearVelocity = Vector3.zero
                        seat.AssemblyAngularVelocity = Vector3.zero
                        if seat.Occupant == character.Humanoid then
                            character.Humanoid.Sit = false
                        end
                        local hrp = character.HumanoidRootPart
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        hrp.CFrame = CFrame.new(hrp.Position.X, 500, hrp.Position.Z)
                        if CheckFullMoon() then
                            KitsuneEventTriggered = true
                        end
                    else
                        if seat.Occupant == character.Humanoid then
                            handleBoatMovement(seat, deltaTime)
                        else
                            local hrp = character.HumanoidRootPart
                            local dist = (hrp.Position-seat.Position).Magnitude
                            if dist > 15 then
                                teleportToBoat()
                            else
                                seat:Sit(character.Humanoid)
                            end
                        end
                    end
                end
            else
                if not isBuyingBoat then
                    task.spawn(ProcessBuyBoat)
                end
            end
        end)
    end
    if Sea3 then
        Players = game:GetService('Players')
        TweenService = game:GetService('TweenService')
        Workspace = game:GetService('Workspace')
        RunService = game:GetService('RunService')
        local player = Players.LocalPlayer
        local SetSpeedBoat = 350
        local DriveDestinations = {
            ['Hydra Town'] = Vector3.new(5186.62, 0.36, 1625.89),
            ['Tiki Outpost'] = Vector3.new(-16217.76, 9.32, 480.29),
        }
        local CurrentDriveTarget = nil
        Tabs.Sea:Dropdown({
            Title = 'Drive Destination',
            Values = {
                'Hydra Town',
                'Tiki Outpost',
            },
            Multi = false,
            Callback = function(Value)
                CurrentDriveTarget = DriveDestinations[Value]
            end,
        })
        Tabs.Sea:Toggle({
            Title = 'Auto Drive Boat',
            Value = false,
            Callback = function(Value)
                _G.AutoDrive = Value
                if not Value then
                    StopBoatNoclip()
                    StopCharacterNoclip()
                end
            end,
        })
        local function GetMyBoat()
            for _, boat in pairs(Workspace.Boats:GetChildren())do
                local owner = boat:FindFirstChild('Owner')
                if owner and owner.Value == player then
                    return boat
                end
            end
            return nil
        end
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoDrive) then continue end
                if _G.AutoDrive then
                    StartCharacterNoclip()
                    local myBoat = GetMyBoat()
                    if myBoat then
                        StartBoatNoclip(myBoat)
                    end
                    SolarixStreamDelay(0.25)
                end
            end
        end)
        RunService.Heartbeat:Connect(function(deltaTime)
            if not _G.AutoDrive or not CurrentDriveTarget then
                return
            end
            local myBoat = GetMyBoat()
            local char = player.Character
            if myBoat and char and char:FindFirstChild('Humanoid') and char:FindFirstChild('HumanoidRootPart') then
                local seat = myBoat:FindFirstChild('VehicleSeat')
                if seat then
                    if seat.Occupant == char.Humanoid then
                        local currentPos = seat.Position
                        local targetY = 190
                        local targetPos = Vector3.new(CurrentDriveTarget.X, targetY, CurrentDriveTarget.Z)
                        local dist = (Vector3.new(currentPos.X, 0, currentPos.Z)-Vector3.new(targetPos.X, 0, targetPos.Z)).Magnitude
                        if dist > 50 then
                            local direction = (targetPos-currentPos).Unit
                            seat.AssemblyLinearVelocity = direction * SetSpeedBoat
                            seat.AssemblyAngularVelocity = Vector3.zero
                            local nextPos = currentPos + (direction * SetSpeedBoat * deltaTime)
                            seat.CFrame = CFrame.new(Vector3.new(nextPos.X, targetY, nextPos.Z), targetPos) * CFrame.Angles(0, math.rad(-35), 0)
                        else
                            seat.AssemblyLinearVelocity = Vector3.zero
                            seat.AssemblyAngularVelocity = Vector3.zero
                            _G.AutoDrive = false
                            StopBoatNoclip()
                            StopCharacterNoclip()
                        end
                    else
                        local dist = (char.HumanoidRootPart.Position-seat.Position).Magnitude
                        if dist > 50 then
                            Tween(seat.CFrame + Vector3.new(0, 5, 0))
                        else
                            seat:Sit(char.Humanoid)
                        end
                    end
                end
            end
        end)
    end
    if Sea3 then
        Players = game:GetService('Players')
        TweenService = game:GetService('TweenService')
        Workspace = game:GetService('Workspace')
        ReplicatedStorage = game:GetService('ReplicatedStorage')
        RunService = game:GetService('RunService')
        local player = Players.LocalPlayer
        local SetSpeedBoat = 350
        local selectedBoat = 'Guardian'
        local isBuyingBoat = false
        local FarPoint = Vector3.new(-111907.734, 150, 32081.475) * 100
        local DockPosition = CFrame.new(-16917.154, 7.757, 511.82)
        local currentEnemy = nil
        local currentEnemyType = nil
        Tabs.Sea:Dropdown({
            Title = 'Farm Sea Type',
            Values = {
                'All',
                'TerrorShark',
                'Shark',
                'Piranha',
            },
            Multi = true,
            Callback = function(Value)
                local selected = {}
                for _, v in pairs(Value) do
                    selected[v] = true
                end
                if selected.All then
                    _G.AutoTerrorshark = true
                    _G.Piranha = true
                    _G.Shark = true
                else
                    _G.AutoTerrorshark = selected.TerrorShark or false
                    _G.Piranha = selected.Piranha or false
                    _G.Shark = selected.Shark or false
                end
            end,
        })
        Tabs.Sea:Toggle({
            Title = 'Auto Farm Sea',
            Value = false,
            Callback = function(Value)
                _G.AutoFarmSea = Value
                if not Value then
                    currentEnemy = nil
                    currentEnemyType = nil
                    StopBoatNoclip()
                    StopCharacterNoclip()
                end
            end,
        })
        local function GetMyBoat()
            for _, boat in pairs(Workspace.Boats:GetChildren()) do
                local owner = boat:FindFirstChild('Owner')
                if owner and owner.Value == player then
                    return boat
                end
            end
            return nil
        end
        local function buyBoat(boatName)
            ReplicatedStorage.Remotes.CommF_:InvokeServer('BuyBoat', boatName)
        end
        local function ProcessBuyBoat()
            if isBuyingBoat then return end
            isBuyingBoat = true
            local char = player.Character
            if char and char:FindFirstChild('Humanoid') then
                char.Humanoid.Sit = false
            end
            local hrp = char and char:FindFirstChild('HumanoidRootPart')
            if hrp then
                if (hrp.Position - DockPosition.Position).Magnitude > 50 then
                    Tween(DockPosition)
                    task.wait(1)
                end
                local updatedHrp = player.Character and player.Character:FindFirstChild('HumanoidRootPart')
                if updatedHrp and (updatedHrp.Position - DockPosition.Position).Magnitude <= 50 then
                    buyBoat(selectedBoat)
                    task.wait(1.5)
                end
            end
            isBuyingBoat = false
        end
        local function CheckDangerLevel()
            local gui = player.PlayerGui
            if gui and gui:FindFirstChild('Main') and gui.Main:FindFirstChild('Compass') and gui.Main.Compass:FindFirstChild('Frame') then
                local danger = gui.Main.Compass.Frame:FindFirstChild('DangerText')
                if danger then
                    return danger.ContentText
                end
            end
            return 'Normal'
        end
        local function HasObstacle()
            local enemies = Workspace.Enemies:GetChildren()
            for _, v in pairs(enemies) do
                if v.Name == 'PirateGrandBrigade' or v.Name == 'PirateBrigade' or v.Name == 'FishBoat' or v.Name == 'Fish Crew Member' then
                    return true
                end
                if not _G.Shark and v.Name == 'Shark' then
                    return true
                end
                if not _G.Piranha and v.Name == 'Piranha' then
                    return true
                end
                if not _G.AutoTerrorshark and v.Name == 'Terrorshark' then
                    return true
                end
            end
            if Workspace:FindFirstChild('SeaBeasts') then
                if #Workspace.SeaBeasts:GetChildren() > 0 then
                    return true
                end
            end
            return false
        end
        local function IsInRoughSea(position)
            if Workspace:FindFirstChild('_WorldOrigin') and Workspace._WorldOrigin:FindFirstChild('Locations') and Workspace._WorldOrigin.Locations:FindFirstChild('Rough Sea') then
                local roughSea = Workspace._WorldOrigin.Locations['Rough Sea']
                local radius = 4500
                if roughSea:IsA('BasePart') then
                    local partRadius = math.max(roughSea.Size.X, roughSea.Size.Z) / 2
                    if partRadius > radius then
                        radius = partRadius
                    end
                end
                if (position - roughSea.Position).Magnitude < radius then
                    return true
                end
            end
            return false
        end
        local function GetPriorityTarget()
            if _G.AutoTerrorshark then
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v.Name == 'Terrorshark' and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                        return v, 'Terrorshark'
                    end
                end
            end
            if _G.Shark then
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v.Name == 'Shark' and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                        return v, 'Shark'
                    end
                end
            end
            if _G.Piranha then
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v.Name == 'Piranha' and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                        return v, 'Mob'
                    end
                end
            end
            return nil, nil
        end
        local function handleBoatMovement(seat, deltaTime)
            local currentPos = seat.Position
            local dangerLevel = CheckDangerLevel()
            local isHighDanger = (dangerLevel:find('?') or dangerLevel:find('6'))
            local obstaclePresent = HasObstacle()
            local shouldStop = false
            if _G.AutoTerrorshark and isHighDanger then
                if obstaclePresent then
                    shouldStop = false
                else
                    shouldStop = true
                end
            end
            if shouldStop then
                seat.AssemblyLinearVelocity = Vector3.zero
                seat.AssemblyAngularVelocity = Vector3.zero
                seat.CFrame = CFrame.new(seat.Position.X, 25, seat.Position.Z)
            else
                local targetY = 190
                local targetPos = Vector3.new(FarPoint.X, targetY, FarPoint.Z)
                if targetPos then
                    local direction = (targetPos - currentPos).Unit
                    seat.AssemblyLinearVelocity = direction * SetSpeedBoat
                    seat.AssemblyAngularVelocity = Vector3.zero
                    local nextPos = currentPos + (direction * SetSpeedBoat * deltaTime)
                    seat.CFrame = CFrame.new(Vector3.new(nextPos.X, targetY, nextPos.Z), targetPos) * CFrame.Angles(0, math.rad(-35), 0)
                    seat.MaxSpeed = SetSpeedBoat
                end
            end
        end
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFarmSea) then continue end
                if _G.AutoFarmSea then
                    StartCharacterNoclip()
                    local myBoat = GetMyBoat()
                    if myBoat then
                        StartBoatNoclip(myBoat)
                    end
                    SolarixStreamDelay(0.25)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFarmSea) then continue end
                if _G.AutoFarmSea then
                    currentEnemy, currentEnemyType = GetPriorityTarget()
                    if currentEnemy then
                        pcall(function()
                            local target = currentEnemy
                            local char = player.Character
                            local valid = false
                            if target:FindFirstChild('Humanoid') and target.Humanoid.Health > 0 and char and char:FindFirstChild('Humanoid') and char:FindFirstChild('HumanoidRootPart') then
                                valid = true
                            end
                            if valid then
                                Equip(SelectWeapon)
                                Attack()
                                AutoHaki()
                                if currentEnemyType == 'Terrorshark' then
                                    AutoRaceV3()
                                    if char.Humanoid.Health < 7000 then
                                        Tween(CFrame.new(char.HumanoidRootPart.Position.X, 500, char.HumanoidRootPart.Position.Z))
                                    else
                                        Tween(target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    end
                                elseif currentEnemyType == 'Shark' or currentEnemyType == 'Mob' then
                                    Tween(target.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                end
                            end
                        end)
                    end
                end
            end
        end)
        RunService.Heartbeat:Connect(function(deltaTime)
            if not _G.AutoFarmSea then return end
            local myBoat = GetMyBoat()
            local char = player.Character
            if currentEnemy then
                if char and char:FindFirstChild('Humanoid') then
                    if char.Humanoid.Sit then
                        char.Humanoid.Sit = false
                    end
                end
                if myBoat then
                    local seat = myBoat:FindFirstChild('VehicleSeat')
                    if seat then
                        if IsInRoughSea(seat.Position) then
                            local targetY = 190
                            local targetPos = Vector3.new(FarPoint.X, targetY, FarPoint.Z)
                            local direction = (targetPos - seat.Position).Unit
                            seat.AssemblyLinearVelocity = direction * SetSpeedBoat
                            seat.AssemblyAngularVelocity = Vector3.zero
                            local nextPos = seat.Position + (direction * SetSpeedBoat * deltaTime)
                            seat.CFrame = CFrame.new(Vector3.new(nextPos.X, targetY, nextPos.Z), targetPos)
                        else
                            seat.AssemblyLinearVelocity = Vector3.zero
                            seat.AssemblyAngularVelocity = Vector3.zero
                        end
                    end
                end
                return
            end
            if not myBoat then
                if not isBuyingBoat then
                    task.spawn(ProcessBuyBoat)
                end
            else
                if char and char:FindFirstChild('Humanoid') and char:FindFirstChild('HumanoidRootPart') then
                    local seat = myBoat:FindFirstChild('VehicleSeat')
                    if seat then
                        if seat.Occupant == char.Humanoid then
                            if IsInRoughSea(seat.Position) then
                                local targetY = 190
                                local targetPos = Vector3.new(FarPoint.X, targetY, FarPoint.Z)
                                local direction = (targetPos - seat.Position).Unit
                                seat.AssemblyLinearVelocity = direction * SetSpeedBoat
                                seat.AssemblyAngularVelocity = Vector3.zero
                                local nextPos = seat.Position + (direction * SetSpeedBoat * deltaTime)
                                seat.CFrame = CFrame.new(Vector3.new(nextPos.X, targetY, nextPos.Z), targetPos) * CFrame.Angles(0, math.rad(-35), 0)
                            else
                                handleBoatMovement(seat, deltaTime)
                            end
                        else
                            local dist = (char.HumanoidRootPart.Position - seat.Position).Magnitude
                            if dist > 50 then
                                Tween(seat.CFrame + Vector3.new(0, 5, 0))
                            else
                                seat:Sit(char.Humanoid)
                            end
                        end
                    end
                end
            end
        end)
    end
    if Sea3 then
        Tabs.General:Toggle({
            Title = 'Hunt Elite',
            Value = false,
            Callback = function(Value)
                _G.AutoElite = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoElite) then continue end
                if _G.AutoElite then
                    pcall(function()
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter')
                        local questVisible = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible
                        local questTitle = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                        if questVisible then
                            if string.find(questTitle, 'Diablo') or string.find(questTitle, 'Deandre') or string.find(questTitle, 'Urban') then
                                if game:GetService('Workspace').Enemies:FindFirstChild('Diablo') or game:GetService('Workspace').Enemies:FindFirstChild('Deandre') or game:GetService('Workspace').Enemies:FindFirstChild('Urban') then
                                    for _, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                        if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                            if v.Name == 'Diablo' or v.Name == 'Deandre' or v.Name == 'Urban' then
                                                repeat
                                                    task.wait()
                                                    Attack()
                                                    Equip(SelectWeapon)
                                                    AutoHaki()
                                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                                until not _G.AutoElite or v.Humanoid.Health <= 0 or not v.Parent
                                            end
                                        end
                                    end
                                else
                                    if game:GetService('ReplicatedStorage'):FindFirstChild('Diablo') then
                                        Tween(game:GetService('ReplicatedStorage'):FindFirstChild('Diablo').HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Deandre') then
                                        Tween(game:GetService('ReplicatedStorage'):FindFirstChild('Deandre').HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Urban') then
                                        Tween(game:GetService('ReplicatedStorage'):FindFirstChild('Urban').HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                    end
                                end
                            end
                        else
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter')
                        end
                    end)
                end
            end
        end)
    end
    if Sea3 then
        local function getHighestPoint()
            local MysticIsland = game:GetService('Workspace'):FindFirstChild('Map') and game.Workspace.Map:FindFirstChild('MysticIsland')
            if not MysticIsland then
                return nil
            end
            for _, v in pairs(MysticIsland:GetDescendants())do
                if v:IsA('MeshPart') and v.MeshId == 'rbxassetid://6745037796' then
                    return v
                end
            end
            return nil
        end
        local function TweenToHighestPoint()
            local HighestPoint = getHighestPoint()
            if HighestPoint then
                Tween(HighestPoint.CFrame * CFrame.new(0, 211.88, 0))
            end
        end
        Tabs.Travel:Button({
            Title = 'Teleport To High Place (Mirage)',
            Callback = function()
                TweenToHighestPoint()
            end,
        })
        Tabs.Travel:Toggle({
            Title = 'Teleport To Advanced Fruit Dealer',
            Value = false,
            Callback = function(Value)
                _G.AutoTpAdvanced = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoTpAdvanced) then continue end
                if _G.AutoTpAdvanced then
                    pcall(function()
                        local advancedFruitDealer = game:GetService('ReplicatedStorage'):FindFirstChild('NPCs') and game.ReplicatedStorage.NPCs:FindFirstChild('Advanced Fruit Dealer')
                        if advancedFruitDealer and advancedFruitDealer:IsA('Model') and advancedFruitDealer.PrimaryPart then
                            Tween(CFrame.new(advancedFruitDealer.PrimaryPart.Position))
                        end
                    end)
                end
            end
        end)
        Tabs.Travel:Toggle({
            Title = 'Teleport To Gear (Mirage)',
            Value = false,
            Callback = function(Value)
                _G.TweenToGear = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.TweenToGear) then continue end
                if _G.TweenToGear then
                    pcall(function()
                        local MysticIsland = game:GetService('Workspace'):FindFirstChild('Map') and game.Workspace.Map:FindFirstChild('MysticIsland')
                        if MysticIsland then
                            for _, v in pairs(MysticIsland:GetChildren())do
                                if v:IsA('MeshPart') and v.Material == Enum.Material.Neon then
                                    Tween(v.CFrame)
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Tabs.Sea:Toggle({
            Title = 'Lock Moon And Use Race',
            Value = false,
            Callback = function(Value)
                _G.AutoLockMoon = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    if _G.AutoLockMoon then
                        local lighting = game:GetService('Lighting')
                        local currentCamera = workspace.CurrentCamera
                        if lighting and currentCamera then
                            local moonDir = lighting:GetMoonDirection()
                            if moonDir then
                                local lookAtPos = currentCamera.CFrame.Position + moonDir * 100
                                currentCamera.CFrame = CFrame.lookAt(currentCamera.CFrame.Position, lookAtPos)
                            end
                        end
                        local rs = game:GetService('ReplicatedStorage')
                        if rs and rs:FindFirstChild('Remotes') and rs.Remotes:FindFirstChild('CommE') then
                            rs.Remotes.CommE:FireServer('ActivateAbility')
                        end
                    end
                end)
            end
        end)
    end
    if Sea1 then
        Tabs.Inventory:Toggle({
            Title = 'Auto Saber',
            Value = false,
            Callback = function(Value)
                _G.Auto_Saber = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Saber and game.Players.LocalPlayer.Data.Level.Value >= 200) then continue end
                if _G.Auto_Saber and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                    pcall(function()
                        if game.Workspace.Map.Jungle.Final.Part.Transparency == 0 and game.Workspace.Map.Jungle.QuestPlates.Door.Transparency == 0 then
                            local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                            local targetPos = Vector3.new(-1612.55884, 36.9774132, 148.719543)
                            if (targetPos-playerPos).Magnitude <= 100 then
                                Tween(CFrame.new(targetPos))
                                task.wait(1)
                                for i = 1, 5 do
                                    local plate = game.Workspace.Map.Jungle.QuestPlates['Plate' .. i].Button
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plate.CFrame
                                    task.wait(1)
                                end
                            else
                                Tween(CFrame.new(targetPos))
                            end
                        elseif game.Workspace.Map.Desert.Burn.Part.Transparency == 0 then
                            if game.Players.LocalPlayer.Backpack:FindFirstChild('Torch') or game.Players.LocalPlayer.Character:FindFirstChild('Torch') then
                                Equip('Torch')
                                Tween(CFrame.new(1114.61475, 5.04679728, 4350.22803))
                            else
                                Tween(CFrame.new(-1610.00757, 11.5049858, 164.001587))
                            end
                        else
                            local progress = game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'SickMan')
                            if progress ~= 0 then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'GetCup')
                                task.wait(0.5)
                                Equip('Cup')
                                task.wait(0.5)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'FillCup', game.Players.LocalPlayer.Character.Cup)
                                task.wait()
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'SickMan')
                            else
                                local richSonProgress = game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon')
                                if richSonProgress == nil then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon')
                                elseif richSonProgress == 0 then
                                    if game.Workspace.Enemies:FindFirstChild('Mob Leader') or game.ReplicatedStorage:FindFirstChild('Mob Leader') then
                                        Tween(CFrame.new(-2967.59521,-4.91089821, 5328.70703))
                                        for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                                            if v.Name == 'Mob Leader' and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                                repeat
                                                    task.wait()
                                                    AutoHaki()
                                                    Equip(SelectWeapon)
                                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                                    Attack()
                                                until v.Humanoid.Health <= 0 or not _G.Auto_Saber
                                            end
                                        end
                                    end
                                elseif richSonProgress == 1 then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon')
                                    task.wait(0.5)
                                    Equip('Relic')
                                    task.wait(0.5)
                                    Tween(CFrame.new(-1404.91504, 29.9773273, 3.80598116))
                                end
                            end
                        end
                        if _G.Auto_Saber then
                            if game.Workspace.Enemies:FindFirstChild('Saber Expert') or game.ReplicatedStorage:FindFirstChild('Saber Expert') then
                                for _, v in pairs(game.Workspace.Enemies:GetChildren())do
                                    if v.Name == 'Saber Expert' and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            FarmPos = v.HumanoidRootPart.CFrame
                                            MonFarm = v.Name
                                            Attack()
                                        until v.Humanoid.Health <= 0 or not _G.Auto_Saber
                                        if v.Humanoid.Health <= 0 then
                                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ProQuestProgress', 'PlaceRelic')
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Pole V1',
            Value = false,
            Callback = function(Value)
                _G.Auto_PoleV1 = Value
            end,
        })
        local PolePos = CFrame.new(-7748.0185546875, 5606.80615234375,-2305.898681640625)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_PoleV1) then continue end
                if _G.Auto_PoleV1 then
                    pcall(function()
                        if game:GetService('Workspace').Enemies:FindFirstChild('Thunder God') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if v.Name == 'Thunder God' then
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            Attack()
                                        until not _G.Auto_PoleV1 or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-PolePos.Position).Magnitude < 1500 then
                                Tween(PolePos)
                            end
                        end
                        Tween(CFrame.new(-7748.0185546875, 5606.80615234375,-2305.898681640625))
                        if game:GetService('ReplicatedStorage'):FindFirstChild('Thunder God') then
                            Tween(game:GetService('ReplicatedStorage'):FindFirstChild('Thunder God').HumanoidRootPart.CFrame + Pos)
                        end
                    end)
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Shark Saw',
            Value = false,
            Callback = function(Value)
                _G.Auto_Saw = Value
            end,
        })
        local SawPos = CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Saw) then continue end
                if _G.Auto_Saw then
                    pcall(function()
                        if game:GetService('Workspace').Enemies:FindFirstChild('The Saw') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if v.Name == 'The Saw' then
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            Attack()
                                        until not _G.Auto_Saw or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-SawPos.Position).Magnitude < 1500 then
                                Tween(SawPos)
                            end
                        end
                        Tween(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
                        if game:GetService('ReplicatedStorage'):FindFirstChild('The Saw') then
                            Tween(game:GetService('ReplicatedStorage'):FindFirstChild('The Saw').HumanoidRootPart.CFrame + Pos)
                        end
                    end)
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Warden Sword',
            Value = false,
            Callback = function(Value)
                _G.Auto_Warden = Value
            end,
        })
        local WardenPos = CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976563)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Warden) then continue end
                if _G.Auto_Warden then
                    pcall(function()
                        if game:GetService('Workspace').Enemies:FindFirstChild('Chief Warden') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if v.Name == 'Chief Warden' then
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            Attack()
                                        until not _G.Auto_Warden or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-WardenPos.Position).Magnitude < 1500 then
                                Tween(WardenPos)
                            end
                        end
                        Tween(CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976563))
                        if game:GetService('ReplicatedStorage'):FindFirstChild('Chief Warden') then
                            Tween(game:GetService('ReplicatedStorage'):FindFirstChild('Chief Warden').HumanoidRootPart.CFrame + Pos)
                        end
                    end)
                end
            end
        end)
    end
    if Sea3 then
        Tabs.Inventory:Toggle({
            Title = 'Fully Hallow Scythe',
            Value = false,
            Callback = function(Value)
                _G.AutoHallowSycthe = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoHallowSycthe) then continue end
                if _G.AutoHallowSycthe then
                    pcall(function()
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer('Bones', 'Buy', 1, 1)
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoHallowSycthe) then continue end
                if _G.AutoHallowSycthe then
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local character = player.Character
                        local backpack = player.Backpack
                        local enemies = game.Workspace.Enemies
                        local hallowEssence = backpack:FindFirstChild('Hallow Essence') or (character and character:FindFirstChild('Hallow Essence'))
                        local soulReaper = enemies:FindFirstChild('Soul Reaper')
                        local BoneCFrame = CFrame.new(-9515.75, 174.85, 6079.4)
                        if soulReaper then
                            for _, v in pairs(enemies:GetChildren())do
                                if v.Name:find('Soul Reaper') then
                                    repeat
                                        task.wait()
                                        Attack()
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
                                    until v.Humanoid.Health <= 0 or not _G.AutoHallowSycthe
                                end
                            end
                        elseif hallowEssence then
                            repeat
                                Tween(CFrame.new(-8932.322, 146.832, 6062.551))
                                task.wait()
                            until (character.HumanoidRootPart.Position-Vector3.new(-8932.322, 146.832, 6062.551)).Magnitude <= 5
                            task.wait()
                            Equip('Hallow Essence')
                        else
                            local questGui = player.PlayerGui.Main.Quest
                            local questTitle = questGui.Container.QuestTitle.Title.Text
                            if not questTitle:find('Posessed Mummy') then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('AbandonQuest')
                            end
                            if not questGui.Visible then
                                Tween(BoneCFrame)
                                if (BoneCFrame.Position-character.HumanoidRootPart.Position).Magnitude <= 5 then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('StartQuest', 'HauntedQuest2', 2)
                                end
                            else
                                for _, v in pairs(enemies:GetChildren())do
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                        if table.find({
                                            'Reborn Skeleton',
                                            'Living Zombie',
                                            'Demonic Soul',
                                            'Posessed Mummy',
                                        }, v.Name) and questTitle:find('Posessed Mummy') then
                                            repeat
                                                task.wait()
                                                Attack()
                                                AutoHaki()
                                                Equip(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                                FarmPos = v.HumanoidRootPart.CFrame
                                                MonFarm = v.Name
                                            until not _G.AutoHallowSycthe or v.Humanoid.Health <= 0 or not v.Parent or not questGui.Visible
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end
    if Sea3 then
        Tabs.Inventory:Toggle({
            Title = 'Auto Yama',
            Value = false,
            Callback = function(Value)
                _G.AutoYama = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoYama) then continue end
                if _G.AutoYama then
                    if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter', 'Progress') >= 30 then
                        repeat
                            task.wait()
                            fireclickdetector(game:GetService('Workspace').Map.Waterfall.SealedKatana.Handle.ClickDetector)
                        until game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Yama') or not _G.AutoYama
                    end
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Tushita',
            Value = false,
            Callback = function(Value)
                _G.AutoTushita = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoTushita) then continue end
                if _G.AutoTushita then
                    local enemies = game:GetService('Workspace').Enemies
                    local longma = enemies:FindFirstChild('Longma')
                    if longma then
                        for i, v in pairs(enemies:GetChildren())do
                            if v.Name == 'Longma' and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    Attack()
                                    AutoHaki()
                                    if not game.Players.LocalPlayer.Character:FindFirstChild(SelectWeapon) then
                                        Equip(SelectWeapon)
                                    end
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                until not _G.AutoTushita or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    else
                        Tween(CFrame.new(-10238.875976563, 389.7912902832,-9549.7939453125))
                    end
                end
            end
        end)

        local function SolarixHasItem(Name)
            if game.Players.LocalPlayer.Backpack:FindFirstChild(Name) or (game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild(Name)) then
                return true
            end
            local Ok, Inventory = pcall(function()
                return game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory')
            end)
            if Ok and type(Inventory) == 'table' then
                for _, Item in pairs(Inventory) do
                    if type(Item) == 'table' and Item.Name == Name then
                        return true
                    end
                end
            end
            return false
        end
        local function SolarixItemData(Name)
            local Ok, Inventory = pcall(function()
                return game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory')
            end)
            if Ok and type(Inventory) == 'table' then
                for _, Item in pairs(Inventory) do
                    if type(Item) == 'table' and Item.Name == Name then
                        return Item
                    end
                end
            end
            return {}
        end
        local function SolarixMaterial(Name)
            local Item = SolarixItemData(Name)
            return tonumber(Item.Count or Item.count or Item.Quantity or Item.quantity) or 0
        end
        local function SolarixMastery(Name)
            local Item = SolarixItemData(Name)
            return tonumber(Item.Mastery or Item.mastery or Item.Level or Item.level) or 0
        end
        local function SolarixLoadSword(Name)
            pcall(function()
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LoadItem', Name)
            end)
        end
        local function SolarixCDKProgress(Type)
            local Ok, Result = pcall(function()
                return game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CDKQuest', 'Progress', Type)
            end)
            if Ok and type(Result) == 'table' then
                return tonumber(Result[Type == 'Good' and 'Good' or 'Evil']) or tonumber(Result.Value) or -9
            end
            return -9
        end
        local function SolarixStartCDK(Type)
            pcall(function()
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CDKQuest', 'Progress', Type)
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CDKQuest', 'StartTrial', Type)
            end)
        end
        local function SolarixNearestEnemy(Names)
            local Root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
            local Best, Distance = nil, math.huge
            if not Root then return nil end
            for _, Enemy in pairs(game:GetService('Workspace').Enemies:GetChildren()) do
                if table.find(Names, Enemy.Name) and Enemy:FindFirstChild('Humanoid') and Enemy:FindFirstChild('HumanoidRootPart') and Enemy.Humanoid.Health > 0 then
                    local Range = (Root.Position - Enemy.HumanoidRootPart.Position).Magnitude
                    if Range < Distance then
                        Distance = Range
                        Best = Enemy
                    end
                end
            end
            return Best
        end
        local function SolarixKillCDKEnemy(Enemy, Sword)
            if not Enemy or not Enemy:FindFirstChild('HumanoidRootPart') or not Enemy:FindFirstChild('Humanoid') or Enemy.Humanoid.Health <= 0 then return false end
            AutoHaki()
            SolarixLoadSword(Sword or 'Yama')
            FarmPos = Enemy.HumanoidRootPart.CFrame
            MonFarm = Enemy.Name
            Tween(Enemy.HumanoidRootPart.CFrame + Pos)
            Attack()
            return true
        end
        local function SolarixClickPrompt(Object)
            if Object and Object:FindFirstChild('ProximityPrompt') then
                pcall(function()
                    fireproximityprompt(Object.ProximityPrompt)
                end)
            end
        end
        local function SolarixRunYamaTrial(Step)
            if Step == 1 then
                local Enemy = SolarixNearestEnemy({'Mythological Pirate'})
                if Enemy then
                    SolarixStartCDK('Evil')
                    SolarixKillCDKEnemy(Enemy, 'Yama')
                else
                    Tween(CFrame.new(-13451.46484375, 543.712890625, -6961.0029296875))
                end
            elseif Step == 2 then
                local Target = nil
                if game.Players.LocalPlayer:FindFirstChild('QuestHaze') then
                    for _, Value in pairs(game.Players.LocalPlayer.QuestHaze:GetChildren()) do
                        if Value.Value > 0 then
                            Target = Value.Name
                            break
                        end
                    end
                end
                if Target then
                    local Enemy = SolarixNearestEnemy({Target})
                    if Enemy then
                        SolarixKillCDKEnemy(Enemy, 'Yama')
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild(Target) then
                        Tween(game:GetService('ReplicatedStorage')[Target].HumanoidRootPart.CFrame)
                    end
                end
            elseif Step == 3 then
                if game:GetService('Workspace').Map:FindFirstChild('HellDimension') then
                    local Enemy = SolarixNearestEnemy({'Cursed Skeleton', "Hell's Messenger"})
                    if Enemy then
                        SolarixKillCDKEnemy(Enemy, 'Yama')
                    else
                        for _, Name in ipairs({'Torch1', 'Torch2', 'Torch3'}) do
                            local Torch = game:GetService('Workspace').Map.HellDimension:FindFirstChild(Name)
                            if Torch and Torch:FindFirstChild('ProximityPrompt') and Torch.ProximityPrompt.Enabled then
                                Tween(Torch.CFrame)
                                SolarixClickPrompt(Torch)
                                break
                            end
                        end
                    end
                elseif game.Players.LocalPlayer.Backpack:FindFirstChild('Hallow Essence') or game.Players.LocalPlayer.Character:FindFirstChild('Hallow Essence') then
                    Tween(CFrame.new(-9500.35352, 142.104813, 5868.80713))
                else
                    local Reaper = SolarixNearestEnemy({'Soul Reaper'})
                    if Reaper then
                        Tween(Reaper.HumanoidRootPart.CFrame)
                    else
                        pcall(function()
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Bones', 'Buy', 1, 1)
                        end)
                        Tween(CFrame.new(-9500.35352, 142.104813, 5868.80713))
                    end
                end
            end
        end
        local function SolarixRunTushitaTrial(Step)
            if Step == 1 then
                pcall(function()
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CDKQuest', 'BoatQuest', workspace.NPCs:FindFirstChild('Luxury Boat Dealer'))
                end)
                for _, CF in ipairs({CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125), CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625), CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875)}) do
                    if not _G.AutoQuestCDK then break end
                    Tween(CF)
                    task.wait(0.35)
                end
            elseif Step == 2 then
                local Enemy = SolarixNearestEnemy({'Pirate Millionaire', 'Pistol Billionaire', 'Forest Pirate', 'Mythological Pirate'}) or SolarixNearestEnemy({'Beautiful Pirate', 'Hydra Leader'})
                if Enemy then
                    SolarixKillCDKEnemy(Enemy, 'Tushita')
                else
                    Tween(CFrame.new(-5569.12939, 320.95163, -3037.64575))
                end
            elseif Step == 3 then
                if game:GetService('Workspace').Map:FindFirstChild('HeavenlyDimension') then
                    local Enemy = SolarixNearestEnemy({'Cursed Skeleton', "Heaven's Guardian"})
                    if Enemy then
                        SolarixKillCDKEnemy(Enemy, 'Tushita')
                    else
                        for _, Name in ipairs({'Torch1', 'Torch2', 'Torch3'}) do
                            local Torch = game:GetService('Workspace').Map.HeavenlyDimension:FindFirstChild(Name)
                            if Torch and Torch:FindFirstChild('ProximityPrompt') and Torch.ProximityPrompt.Enabled then
                                Tween(Torch.CFrame)
                                SolarixClickPrompt(Torch)
                                break
                            end
                        end
                    end
                else
                    local Queen = SolarixNearestEnemy({'Cake Queen'})
                    if Queen then
                        SolarixKillCDKEnemy(Queen, 'Tushita')
                    else
                        Tween(CFrame.new(-821.4803466796875, 65.8453369140625, -10965.03125))
                    end
                end
            end
        end
        local function SolarixRunCDKBoss()
            local Boss = SolarixNearestEnemy({'Cursed Skeleton Boss'})
            if Boss then
                SolarixKillCDKEnemy(Boss, 'Tushita')
            else
                local Cursed = workspace.Map:FindFirstChild('Turtle') and workspace.Map.Turtle:FindFirstChild('Cursed')
                if Cursed then
                    for _, Name in ipairs({'Pedestal1', 'Pedestal2', 'Pedestal3'}) do
                        local Pedestal = Cursed:FindFirstChild(Name)
                        if Pedestal and Pedestal:FindFirstChild('ProximityPrompt') and Pedestal.ProximityPrompt.Enabled then
                            Tween(Pedestal.CFrame)
                            SolarixClickPrompt(Pedestal)
                            break
                        end
                    end
                end
            end
        end
        Tabs.Inventory:Toggle({
            Title = 'Auto Quest CDK',
            Value = false,
            Callback = function(Value)
                _G.AutoQuestCDK = Value
                if not Value then
                    _G.AutoBone = false
                end
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoQuestCDK) then continue end
                pcall(function()
                    if SolarixHasItem('Cursed Dual Katana') then
                        _G.AutoBone = false
                        return
                    end
                    if not SolarixHasItem('Yama') or not SolarixHasItem('Tushita') then
                        return
                    end
                    if SolarixMaterial('Alucard Fragment') < 6 then
                        if SolarixMastery('Yama') < 350 then
                            _G.AutoBone = true
                            SolarixLoadSword('Yama')
                            local Enemy = SolarixNearestEnemy({'Reborn Skeleton', 'Living Zombie', 'Demonic Soul', 'Posessed Mummy'})
                            if Enemy then
                                SolarixKillCDKEnemy(Enemy, 'Yama')
                            else
                                Tween(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
                            end
                            return
                        end
                        if SolarixMastery('Tushita') < 350 then
                            _G.AutoBone = true
                            SolarixLoadSword('Tushita')
                            local Enemy = SolarixNearestEnemy({'Reborn Skeleton', 'Living Zombie', 'Demonic Soul', 'Posessed Mummy'})
                            if Enemy then
                                SolarixKillCDKEnemy(Enemy, 'Tushita')
                            else
                                Tween(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
                            end
                            return
                        end
                        _G.AutoBone = false
                        local Evil = SolarixCDKProgress('Evil')
                        if Evil ~= -2 and Evil ~= 4 then
                            SolarixStartCDK('Evil')
                            SolarixRunYamaTrial(Evil == 1 and 2 or Evil == 2 and 3 or 1)
                            return
                        end
                        local Good = SolarixCDKProgress('Good')
                        if Good ~= -2 and Good ~= 3 then
                            SolarixStartCDK('Good')
                            SolarixRunTushitaTrial(Good == 1 and 2 or Good == 2 and 3 or 1)
                            return
                        end
                        return
                    end
                    pcall(function()
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CDKQuest', 'Progress', 'Good')
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CDKQuest', 'Progress', 'Evil')
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CDKQuest', 'SpawnBoss')
                    end)
                    SolarixRunCDKBoss()
                end)
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Holy Torch',
            Value = false,
            Callback = function(Value)
                _G.Auto_Holy_Torch = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Holy_Torch) then continue end
                if _G.Auto_Holy_Torch then
                    pcall(function()
                        local locations = {
                            CFrame.new(-10752, 417,-9366),
                            CFrame.new(-11672, 334,-9474),
                            CFrame.new(-12132, 521,-10655),
                            CFrame.new(-13336, 486,-6985),
                            CFrame.new(-13489, 332,-7925),
                        }
                        for _, location in ipairs(locations)do
                            repeat
                                Tween(location)
                                task.wait()
                            until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-location.Position).Magnitude <= 5
                        end
                    end)
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Canvander',
            Value = false,
            Callback = function(Value)
                _G.Auto_Canvander = Value
            end,
        })
        local CanvaPos = CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Canvander) then continue end
                if _G.Auto_Canvander then
                    pcall(function()
                        if game:GetService('Workspace').Enemies:FindFirstChild('Beautiful Pirate') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if v.Name == 'Beautiful Pirate' then
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            Attack()
                                        until not _G.Auto_Canvander or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-CanvaPos.Position).Magnitude < 1500 then
                                Tween(CanvaPos)
                            end
                        end
                        local beautifulPirate = game:GetService('ReplicatedStorage'):FindFirstChild('Beautiful Pirate')
                        if beautifulPirate and beautifulPirate:FindFirstChild('HumanoidRootPart') then
                            Tween(beautifulPirate.HumanoidRootPart.CFrame + Pos)
                        end
                    end)
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Buddy Sword',
            Value = false,
            Callback = function(Value)
                _G.Auto_Buddy = Value
            end,
        })
        local BuddyPos = CFrame.new(-731.2034301757813, 381.5658874511719,-11198.4951171875)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Buddy) then continue end
                if _G.Auto_Buddy then
                    pcall(function()
                        if game:GetService('Workspace').Enemies:FindFirstChild('Cake Queen') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if v.Name == 'Cake Queen' and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        Attack()
                                    until not _G.Auto_Buddy or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-BuddyPos.Position).Magnitude < 1500 then
                                Tween(BuddyPos)
                            end
                        end
                        if game:GetService('ReplicatedStorage'):FindFirstChild('Cake Queen') then
                            Tween(game:GetService('ReplicatedStorage').CakeQueen.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                        end
                    end)
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Musketeer Hat',
            Value = false,
            Callback = function(Value)
                _G.Auto_MusketeerHat = Value
            end,
        })
        task.spawn(function()
            pcall(function()
                while task.wait() do
                    if not SolarixStream(_G.Auto_MusketeerHat) then continue end
                    if _G.Auto_MusketeerHat then
                        local player = game:GetService('Players').LocalPlayer
                        local playerGui = player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                        local playerQuest = player.PlayerGui.Main.Quest.Visible
                        if player.Data.Level.Value >= 1800 then
                            if game:GetService('ReplicatedStorage').Remotes.CommF:InvokeServer('CitizenQuestProgress').KilledBandits == false then
                                if string.find(playerQuest, 'Forest Pirate') and string.find(playerQuest, '50') and playerGui == true then
                                    local enemy = game:GetService('Workspace').Enemies:FindFirstChild('Forest Pirate')
                                    if enemy then
                                        for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                            if v.Name == 'Forest Pirate' then
                                                repeat
                                                    task.wait()
                                                    pcall(function()
                                                        Equip(SelectWeapon)
                                                        AutoHaki()
                                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                                        FarmPos = v.HumanoidRootPart.CFrame
                                                        MonFarm = v.Name
                                                        Attack()
                                                    end)
                                                until _G.Auto_MusketeerHat == false or v.Humanoid.Health <= 0 or not v.Parent or player.PlayerGui.Main.Quest.Visible == false
                                            end
                                        end
                                    else
                                        Tween(CFrame.new(-13206.452148438, 425.89199829102,-7964.5537109375))
                                    end
                                end
                            end
                            if game:GetService('ReplicatedStorage').Remotes.CommF:InvokeServer('CitizenQuestProgress').KilledBoss == false then
                                if playerQuest and string.find(playerQuest, 'Captain Elephant') then
                                    local elephant = game:GetService('Workspace').Enemies:FindFirstChild('Captain Elephant')
                                    if elephant then
                                        for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                            if v.Name == 'Captain Elephant' then
                                                repeat
                                                    task.wait()
                                                    pcall(function()
                                                        Equip(SelectWeapon)
                                                        AutoHaki()
                                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                                        Attack()
                                                    end)
                                                until _G.Auto_MusketeerHat == false or v.Humanoid.Health <= 0 or not v.Parent or player.PlayerGui.Main.Quest.Visible == false
                                            end
                                        end
                                    else
                                        Tween(CFrame.new(-13374.889648438, 421.27752685547,-8225.208984375))
                                    end
                                end
                            end
                            if game:GetService('ReplicatedStorage').Remotes.CommF:InvokeServer('CitizenQuestProgress', 'Citizen') == 2 then
                                Tween(CFrame.new(-12512.138671875, 340.39279174805,-9872.8203125))
                            end
                        end
                    end
                end
            end)
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Skull Guitar',
            Value = false,
            Callback = function(Val)
                _G.Auto_SkullGuitar = Val
            end,
        })
        task.spawn(function()
            Plr = game.Players.LocalPlayer
            local CommF = game.ReplicatedStorage.Remotes.CommF_
            local Map = workspace.Map:WaitForChild('Haunted Castle')
            while task.wait() do
                if not SolarixStream(_G.Auto_SkullGuitar) then continue end
                if _G.Auto_SkullGuitar then
                    pcall(function()
                        local Root = Plr.Character.HumanoidRootPart
                        if game.ReplicatedStorage.Remotes.CommF_:InvokeServer('BuySoulGuitar', true) then
                            if GetInventory and GetInventory('Skull Guitar') then
                                _G.Auto_SkullGuitar = false
                                return
                            end
                        end
                        local Progress = CommF:InvokeServer('GuitarPuzzleProgress', 'Check')
                        if not Progress then
                            local Res = CommF:InvokeServer('gravestoneEvent', 2)
                            if Res == 'Nothing' then
                                Library:Notify({
                                    Title = 'Waiting for the Full Moon',
                                    Duration = 5,
                                })
                            elseif Res == 'Error' then
                                Tween(CFrame.new(-9707,-71, 6517))
                            else
                                CommF:InvokeServer('gravestoneEvent', 2, true)
                            end
                        else
                            if not Progress.Swamp then
                                local Enemy = workspace.Enemies:FindFirstChild('Living Zombie')
                                if Enemy and Enemy:FindFirstChild('Humanoid') and Enemy.Humanoid.Health > 0 then
                                    AutoHaki()
                                    Equip(SelectWeapon)
                                    if Enemy.HumanoidRootPart then
                                        Tween(Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                        FarmPos = Enemy.HumanoidRootPart.CFrame
                                        MonFarm = Enemy.Name
                                        Attack()
                                    end
                                else
                                    Tween(CFrame.new(-10161, 139, 5955))
                                end
                            elseif not Progress.Gravestones then
                                if (Vector3.new(-8762, 177, 6171)-Root.Position).Magnitude > 10 then
                                    Tween(CFrame.new(-8762, 177, 6171))
                                else
                                    local List = {
                                        Map.Placard7.Left,
                                        Map.Placard6.Left,
                                        Map.Placard5.Left,
                                        Map.Placard4.Right,
                                        Map.Placard3.Left,
                                        Map.Placard2.Right,
                                        Map.Placard1.Right,
                                    }
                                    for _, v in ipairs(List)do
                                        if v and v:FindFirstChild('ClickDetector') then
                                            fireclickdetector(v.ClickDetector)
                                            task.wait(0.1)
                                        end
                                    end
                                end
                            elseif not Progress.Ghost then
                                if (Vector3.new(-9514, 172, 6098)-Root.Position).Magnitude > 200 then
                                    Tween(CFrame.new(-9514, 145, 6098))
                                else
                                    CommF:InvokeServer('GuitarPuzzleProgress', 'Ghost')
                                end
                            elseif not Progress.Trophies then
                                if (Vector3.new(-9553, 66, 6042)-Root.Position).Magnitude > 10 then
                                    Tween(CFrame.new(-9553, 66, 6042))
                                else
                                    local Tablet = Map:FindFirstChild('Tablet')
                                    if Tablet then
                                        for i = 1, 10 do
                                            local Segment = Tablet:FindFirstChild('Segment' .. i)
                                            if Segment and Segment:FindFirstChild('ClickDetector') then
                                                fireclickdetector(Segment.ClickDetector)
                                            end
                                        end
                                    end
                                end
                            elseif not Progress.Pipes then
                                if (Vector3.new(-9553, 66, 6042)-Root.Position).Magnitude > 10 then
                                    Tween(CFrame.new(-9553, 66, 6042))
                                else
                                    local Floor = Map['Lab Puzzle'].ColorFloor.Model
                                    if Floor and Floor.Part1:FindFirstChild('ClickDetector') then
                                        local function ClickPipe(Part, Times)
                                            if Part and Part:FindFirstChild('ClickDetector') then
                                                for i = 1, (Times or 1)do
                                                    fireclickdetector(Part.ClickDetector)
                                                    task.wait(0.1)
                                                end
                                            end
                                        end
                                        ClickPipe(Floor.Part3, 1)
                                        ClickPipe(Floor.Part4, 3)
                                        ClickPipe(Floor.Part6, 2)
                                        ClickPipe(Floor.Part8, 1)
                                        ClickPipe(Floor.Part10, 3)
                                    end
                                end
                            else
                                CommF:InvokeServer('soulGuitarBuy', true)
                            end
                        end
                    end)
                end
            end
        end)
    end
    if Sea3 then
        Tabs.Player:Toggle({
            Title = 'Auto Observation V2',
            Value = false,
            Callback = function(Value)
                _G.Auto_ObservationV2 = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    if _G.Auto_ObservationV2 then
                        if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CitizenQuestProgress', 'Citizen') == 3 then
                            _G.Auto_MusketeerHat = false
                            if game.Players.LocalPlayer.Backpack:FindFirstChild('Banana') and game.Players.LocalPlayer.Backpack:FindFirstChild('Apple') and game.Players.LocalPlayer.Backpack:FindFirstChild('Pineapple') then
                                repeat
                                    Tween(CFrame.new(-12444.78515625, 332.40396118164,-7673.1806640625))
                                    task.wait()
                                until not _G.Auto_ObservationV2 or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-12444.78515625, 332.40396118164,-7673.1806640625)).Magnitude <= 5
                                task.wait(0.5)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('CitizenQuestProgress', 'Citizen')
                            elseif game.Players.LocalPlayer.Backpack:FindFirstChild('Fruit Bowl') or game.Players.LocalPlayer.Character:FindFirstChild('Fruit Bowl') then
                                repeat
                                    Tween(CFrame.new(-10920.125, 624.20275878906,-10266.995117188))
                                    task.wait()
                                until not _G.Auto_ObservationV2 or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-10920.125, 624.20275878906,-10266.995117188)).Magnitude <= 5
                                task.wait(0.5)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('KenTalk2', 'Start')
                                task.wait(1)
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('KenTalk2', 'Buy')
                            else
                                for _, Folder in pairs({workspace, workspace:FindFirstChild('_WorldOrigin')}) do
                                    if Folder then
                                        for _, v in pairs(Folder:GetChildren())do
                                            if (v.Name == 'Apple' or v.Name == 'Banana' or v.Name == 'Pineapple') and v:FindFirstChild('Handle') then
                                                v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
                                                task.wait()
                                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
                                                task.wait()
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            _G.Auto_MusketeerHat = true
                        end
                    end
                end)
            end
        end)
    end
    Tabs.Player:Toggle({
        Title = 'Auto Farm Observation',
        Value = false,
        Callback = function(Value)
            _G.AutoFarmKen = Value
        end,
    })
    local ws = game:GetService('Workspace')
    local rs = game:GetService('ReplicatedStorage')
    local plrs = game:GetService('Players')
    local lp = plrs.LocalPlayer
    local DodgeActive = false
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            pcall(function()
                if _G.AutoFarmKen then
                    rs.Remotes.CommE:FireServer('Ken', true)
                    local current = lp:GetAttribute('KenDodgesLeft')
                    if current == 0 then
                        DodgeActive = false
                    elseif current > 0 then
                        rs.Remotes.CommE:FireServer('Ken', true)
                        DodgeActive = true
                    end
                end
            end)
        end
    end)
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            pcall(function()
                if _G.AutoFarmKen then
                    if Sea1 then
                        local Mob = ws.Enemies:FindFirstChild('Galley Captain')
                        if Mob and Mob:FindFirstChild('HumanoidRootPart') then
                            if DodgeActive then
                                Tween(Mob.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))
                            else
                                DodgeActive = false
                            end
                        else
                            Tween(CFrame.new(5533.29785, 88.1079102, 4852.3916))
                        end
                    elseif Sea2 then
                        local Mob = ws.Enemies:FindFirstChild('Lava Pirate')
                        if Mob and Mob:FindFirstChild('HumanoidRootPart') then
                            if DodgeActive then
                                Tween(Mob.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))
                            else
                                DodgeActive = false
                            end
                        else
                            Tween(CFrame.new(-5478.39209, 15.9775667,-5246.9126))
                        end
                    elseif Sea3 then
                        local Mob = ws.Enemies:FindFirstChild('Venomous Assailant')
                        if Mob and Mob:FindFirstChild('HumanoidRootPart') then
                            if DodgeActive then
                                Tween(Mob.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))
                            else
                                DodgeActive = false
                            end
                        else
                            Tween(CFrame.new(4530.3540039063, 656.75695800781,-131.60952758789))
                        end
                    end
                end
            end)
        end
    end)
    if Sea3 then
        Tabs.Player:Toggle({
            Title = 'Auto Rainbow Haki',
            Value = false,
            Callback = function(Value)
                _G.Auto_RainbowHaki = Value
            end,
        })
        task.spawn(function()
            pcall(function()
                while task.wait() do
                    if not SolarixStream(_G.Auto_RainbowHaki) then continue end
                    if _G.Auto_RainbowHaki then
                        local QuestUI = game.Players.LocalPlayer.PlayerGui.Main.Quest
                        if not QuestUI.Visible then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer('HornedMan', 'Bet')
                        else
                            local QuestTitle = QuestUI.Container.QuestTitle.Title.Text
                            if string.find(QuestTitle, 'Stone') then
                                if workspace.Enemies:FindFirstChild('Stone') then
                                    for _, v in pairs(workspace.Enemies:GetChildren())do
                                        if v.Name == 'Stone' then
                                            repeat
                                                task.wait()
                                                Equip(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                                Attack()
                                            until not _G.Auto_RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not QuestUI.Visible
                                        end
                                    end
                                else
                                    Tween(CFrame.new(-1086.1162, 38.84259, 6768.7144))
                                end
                            elseif string.find(QuestTitle, 'Hydra Leader') then
                                if workspace.Enemies:FindFirstChild('Hydra Leader') then
                                    for _, v in pairs(workspace.Enemies:GetChildren())do
                                        if v.Name == 'Hydra Leader' then
                                            repeat
                                                task.wait()
                                                Equip(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                                Attack()
                                            until not _G.Auto_RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not QuestUI.Visible
                                        end
                                    end
                                else
                                    Tween(CFrame.new(5713.98877, 601.92297, 202.75125))
                                end
                            elseif string.find(QuestTitle, 'Kilo Admiral') then
                                if workspace.Enemies:FindFirstChild('Kilo Admiral') then
                                    for _, v in pairs(workspace.Enemies:GetChildren())do
                                        if v.Name == 'Kilo Admiral' then
                                            repeat
                                                task.wait()
                                                Equip(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                                Attack()
                                            until not _G.Auto_RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not QuestUI.Visible
                                        end
                                    end
                                else
                                    Tween(CFrame.new(2877.61743, 423.558685,-7207.31006))
                                end
                            elseif string.find(QuestTitle, 'Captain Elephant') then
                                if workspace.Enemies:FindFirstChild('Captain Elephant') then
                                    for _, v in pairs(workspace.Enemies:GetChildren())do
                                        if v.Name == 'Captain Elephant' then
                                            repeat
                                                task.wait()
                                                Equip(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                                Attack()
                                            until not _G.Auto_RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not QuestUI.Visible
                                        end
                                    end
                                else
                                    Tween(CFrame.new(-13485.0283, 331.709259,-8012.4873))
                                end
                            elseif string.find(QuestTitle, 'Beautiful Pirate') then
                                if workspace.Enemies:FindFirstChild('Beautiful Pirate') then
                                    for _, v in pairs(workspace.Enemies:GetChildren())do
                                        if v.Name == 'Beautiful Pirate' then
                                            repeat
                                                task.wait()
                                                Equip(SelectWeapon)
                                                Tween(v.HumanoidRootPart.CFrame + Pos)
                                                Attack()
                                            until not _G.Auto_RainbowHaki or v.Humanoid.Health <= 0 or not v.Parent or not QuestUI.Visible
                                        end
                                    end
                                else
                                    Tween(CFrame.new(5312.3598632813, 20.141201019287,-10.158538818359))
                                end
                            else
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('HornedMan', 'Bet')
                            end
                        end
                    end
                end
            end)
        end)
    end
    if Sea2 then
        Tabs.Inventory:Toggle({
            Title = 'Auto Factory',
            Value = false,
            Callback = function(Value)
                _G.Factory = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Factory) then continue end
                if _G.Factory then
                    if game.Workspace.Enemies:FindFirstChild('Core') then
                        for i, v in pairs(game.Workspace.Enemies:GetChildren())do
                            if v.Name == 'Core' and v.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    Attack()
                                    repeat
                                        Tween(CFrame.new(448.46756, 199.356781,-441.389252))
                                        task.wait()
                                    until not _G.Factory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(448.46756, 199.356781,-441.389252)).Magnitude <= 10
                                    Equip(SelectWeapon)
                                    AutoHaki()
                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                until not v.Parent or v.Humanoid.Health <= 0 or _G.Factory == false
                            end
                        end
                    elseif game.ReplicatedStorage:FindFirstChild('Core') then
                        repeat
                            Tween(CFrame.new(448.46756, 199.356781,-441.389252))
                            task.wait()
                        until not _G.Factory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(448.46756, 199.356781,-441.389252)).Magnitude <= 10
                    end
                end
            end
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Farm Swan',
            Value = false,
            Callback = function(Value)
                _G.AutoFarmSwan = Value
            end,
        })
        task.spawn(function()
            pcall(function()
                while task.wait() do
                    if not SolarixStream(_G.AutoFarmSwan) then continue end
                    if _G.AutoFarmSwan then
                        if game:GetService('Workspace').Enemies:FindFirstChild('Don Swan') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if v.Name == 'Don Swan' and v.Humanoid.Health > 0 and v:IsA('Model') and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') then
                                    repeat
                                        task.wait()
                                        pcall(function()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            Attack()
                                        end)
                                    until not _G.AutoFarmSwan or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            repeat
                                task.wait()
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(2284.912109375, 15.537666320801, 905.48291015625))
                            until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(2284.912109375, 15.537666320801, 905.48291015625)).Magnitude <= 5 or not _G.AutoFarmSwan
                        end
                    end
                end
            end)
        end)
        Tabs.Inventory:Toggle({
            Title = 'Auto Rengoku',
            Value = false,
            Callback = function(Value)
                _G.Auto_Regoku = Value
            end,
        })
        task.spawn(function()
            pcall(function()
                while task.wait() do
                    if not SolarixStream(_G.Auto_Regoku) then continue end
                    if _G.Auto_Regoku then
                        if game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Hidden Key') or game:GetService('Players').LocalPlayer.Character:FindFirstChild('Hidden Key') then
                            Equip('Hidden Key')
                            Tween(CFrame.new(6571.1201171875, 299.23028564453,-6967.841796875))
                        elseif game:GetService('Workspace').Enemies:FindFirstChild('Snow Lurker') or game:GetService('Workspace').Enemies:FindFirstChild('Arctic Warrior') then
                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                if (v.Name == 'Snow Lurker' or v.Name == 'Arctic Warrior') and v.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        Equip(SelectWeapon)
                                        AutoHaki()
                                        FarmPos = v.HumanoidRootPart.CFrame
                                        MonFarm = v.Name
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        Attack()
                                    until game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Hidden Key') or _G.Auto_Regoku == false or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            Tween(CFrame.new(5439.716796875, 84.420944213867,-6715.1635742188))
                        end
                    end
                end
            end)
        end)
    end
    if Sea2 or Sea3 then
        Tabs.Shop:Button({
            Title = 'Buy Color Haki',
            Callback = function()
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '2')
            end,
        })
    end
    if Sea2 then
        Tabs.Shop:Button({
            Title = 'Buy Legendary Sword',
            Callback = function()
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LegendarySwordDealer', '2')
            end,
        })
        Tabs.Race:Toggle({
            Title = 'Evo Race V2',
            Value = false,
            Callback = function(Value)
                _G.AutoEvoRace = Value
            end,
        })
        task.spawn(function()
            pcall(function()
                while task.wait() do
                    if not SolarixStream(_G.AutoEvoRace) then continue end
                    if _G.AutoEvoRace then
                        if not game:GetService('Players').LocalPlayer.Data.Race:FindFirstChild('Evolved') then
                            local comm = game:GetService('ReplicatedStorage').Remotes.CommF_
                            local status = comm:InvokeServer('Alchemist', '1')
                            if status == 0 then
                                Tween(CFrame.new(-2779.83521, 72.9661407,-3574.02002,-0.730484903, 6.39014104e-8,-0.68292886, 3.5996322399999996e-8, 1, 5.50667032e-8, 0.68292886, 1.56424669e-8,-0.730484903))
                                if (Vector3.new(-2779.83521, 72.9661407,-3574.02002)-game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                                    task.wait(1)
                                    comm:InvokeServer('Alchemist', '2')
                                end
                            elseif status == 1 then
                                pcall(function()
                                    local clockTime = game:GetService('Lighting').ClockTime
                                    local plr = game:GetService('Players').LocalPlayer
                                    local bp = plr.Backpack
                                    local char = plr.Character
                                    if (clockTime < 6 or clockTime >= 18) and not bp:FindFirstChild('Flower 1') and not char:FindFirstChild('Flower 1') then
                                        Tween(game:GetService('Workspace').Flower1.CFrame)
                                    elseif not bp:FindFirstChild('Flower 2') and not char:FindFirstChild('Flower 2') then
                                        Tween(game:GetService('Workspace').Flower2.CFrame)
                                    elseif not bp:FindFirstChild('Flower 3') and not char:FindFirstChild('Flower 3') then
                                        if game:GetService('Workspace').Enemies:FindFirstChild('Zombie') then
                                            for i, v in pairs(game:GetService('Workspace').Enemies:GetChildren())do
                                                if v.Name == 'Zombie' then
                                                    repeat
                                                        task.wait()
                                                        AutoHaki()
                                                        Equip(SelectWeapon)
                                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                                        Attack()
                                                        FarmPos = v.HumanoidRootPart.CFrame
                                                        MonFarm = v.Name
                                                    until bp:FindFirstChild('Flower 3') or not v.Parent or v.Humanoid.Health <= 0 or _G.AutoEvoRace == false
                                                end
                                            end
                                        else
                                            Tween(CFrame.new(-5685.9233398438, 48.480125427246,-853.23724365234))
                                        end
                                    elseif (bp:FindFirstChild('Flower 3') or char:FindFirstChild('Flower 3')) and not bp:FindFirstChild('Flower 1') and not char:FindFirstChild('Flower 1') then
                                        Tween(CFrame.new(-5685.9233398438, 48.480125427246,-853.23724365234))
                                    end
                                end)
                            elseif status == 2 then
                                comm:InvokeServer('Alchemist', '3')
                            end
                        end
                    end
                end
            end)
        end)
    end
    if Sea2 or Sea3 then
        Tabs.Settings:Toggle({
            Title = 'Auto Turn On Race V3',
            Value = false,
            Callback = function(Value)
                _G.AutoT = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    if _G.AutoT then
                        local CommE = game:GetService('ReplicatedStorage').Remotes:FindFirstChild('CommE')
                        if CommE then
                            CommE:FireServer('ActivateAbility')
                        end
                    end
                end)
            end
        end)
        if Sea3 then
            Tabs.Settings:Toggle({
                Title = 'Auto Turn On Race V4',
                Value = false,
                Callback = function(Value)
                    _G.AutoTurnV4 = Value
                end,
            })
        end
    end
    Players = game:GetService('Players')
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    Workspace = game:GetService('Workspace')
    LocalPlayer = Players.LocalPlayer
    local Remote = ReplicatedStorage.Remotes:FindFirstChild('CommE')
    local Config = {
        Radius = 120,
        Anims = {
            'LionsSong',
            'LionsSongCharge',
            'HighWavesCharge',
            'TremorPunchWindUpLoop',
            'EruptChargeLoop',
            'BlackHoleChargeLoop',
            'YoruZCharge',
            'LeopardCharge',
            'ExecutionCharge',
            'StabCharge',
            'GumChargeLoop',
            'ElectroClawCHold',
            'BirdCharge',
            'SpringSnipe',
            'SnapHold',
            'RubberBazookaStart',
            'RubberAxeHold',
            'RubberRocketHold',
            'LeopardDashPoseTransformed',
            'MammothChargeJump',
            'Meteor',
            'Shower',
            'Punch',
            'Kick',
            'Slash',
            'GroundImpact',
            'Pound',
            'Superhuman',
            'Godhuman',
            'Dragon',
            'SeaBeast',
            'Roar',
            'Beam',
        },
    }
    local activeAttacks = 0
    local function checkAnim(id)
        local s = tostring(id):lower()
        for _, v in ipairs(Config.Anims)do
            if s:find(v:lower()) then
                return true
            end
        end
        return false
    end
    local function updateKenState()
        if activeAttacks > 0 then
            Remote:FireServer('Ken', true)
        else
            Remote:FireServer('Ken', false)
        end
    end
    local function monitor(m)
        local h = m:WaitForChild('Humanoid', 5)
        local r = m:WaitForChild('HumanoidRootPart', 5)
        if h and r then
            local a = h:FindFirstChildOfClass('Animator') or h:WaitForChild('Animator', 5)
            if not a then
                return
            end
            a.AnimationPlayed:Connect(function(tr)
                local c = LocalPlayer.Character
                if not c or not c:FindFirstChild('HumanoidRootPart') then
                    return
                end
                if (c.HumanoidRootPart.Position-r.Position).Magnitude <= Config.Radius then
                    if checkAnim(tr.Animation.Name) or checkAnim(tr.Animation.AnimationId) or tr.Priority == Enum.AnimationPriority.Action then
                        activeAttacks = activeAttacks + 1
                        updateKenState()
                        tr.Stopped:Connect(function()
                            activeAttacks = activeAttacks-1
                            if activeAttacks < 0 then
                                activeAttacks = 0
                            end
                            updateKenState()
                        end)
                    end
                end
            end)
        end
    end
    local function scanFolder(folderName)
        local folder = Workspace:FindFirstChild(folderName)
        if folder then
            for _, v in ipairs(folder:GetChildren())do
                if v ~= LocalPlayer.Character then
                    task.spawn(monitor, v)
                end
            end
            folder.ChildAdded:Connect(function(v)
                if v ~= LocalPlayer.Character then
                    task.spawn(monitor, v)
                end
            end)
        end
    end
    scanFolder('Enemies')
    scanFolder('Characters')
    scanFolder('SeaBeasts')
    Workspace.ChildAdded:Connect(function(child)
        if child.Name == 'SeaBeasts' or child.Name == 'Enemies' or child.Name == 'Characters' then
            scanFolder(child.Name)
        end
    end)
    local BringMobOffset = Vector3.new(0, 0, 0)
    local function GetMobRoot(Mob)
        if not Mob then
            return nil
        end
        return Mob:FindFirstChild('HumanoidRootPart') or Mob.PrimaryPart
    end
    local function IsMobAlive(Mob)
        local Humanoid = Mob and Mob:FindFirstChild('Humanoid')
        local Root = GetMobRoot(Mob)
        return Humanoid and Root and Humanoid.Health > 0
    end
    local function GetTargetPosition()
        if typeof(FarmPos) == 'CFrame' then
            return FarmPos.Position
        elseif typeof(FarmPos) == 'Vector3' then
            return FarmPos
        elseif typeof(FarmPos) == 'Instance' and FarmPos:IsA('BasePart') then
            return FarmPos.Position
        end
        return nil
    end
    local function GetTargetMobName(TargetMob)
        if TargetMob and TargetMob.Name then
            return TargetMob.Name
        end
        if MonFarm and MonFarm ~= '' then
            return MonFarm
        end
        return nil
    end
    local function ApplyBringMob(Enemy, TargetPosition)
        local Humanoid = Enemy:FindFirstChild('Humanoid')
        local Root = GetMobRoot(Enemy)
        if not Humanoid or not Root then
            return
        end
        Root.CFrame = CFrame.new(TargetPosition + BringMobOffset)
        Root.CanCollide = false
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
        Humanoid.WalkSpeed = 0
        Humanoid.JumpPower = 0
        Humanoid:ChangeState(11)
    end
    function BringMob(TargetMob)
        local TargetPosition = GetTargetPosition()
        local TargetName = GetTargetMobName(TargetMob)
        if TargetMob and IsMobAlive(TargetMob) then
            local Root = GetMobRoot(TargetMob)
            if Root then
                TargetPosition = Root.Position
            end
        end
        if not TargetPosition or not TargetName then
            return
        end
        pcall(function()
            sethiddenproperty(LocalPlayer, 'SimulationRadius', math.huge)
        end)
        local Enemies = Workspace:FindFirstChild('Enemies')
        if not Enemies then
            return
        end
        for _, Enemy in pairs(Enemies:GetChildren())do
            if Enemy.Name == TargetName and IsMobAlive(Enemy) then
                ApplyBringMob(Enemy, TargetPosition)
            end
        end
    end
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(FarmPos and MonFarm) then continue end
            if FarmPos and MonFarm then
                pcall(function()
                    BringMob()
                end)
                SolarixStreamDelay(0.15)
            end
        end
    end)
    Tabs.Misc:Toggle({
        Title = 'White Screen',
        Value = false,
        Callback = function(Value)
            _G.WhiteScreen = Value
            RunService:Set3dRenderingEnabled(not Value)
        end,
    })
    local AddPointAmount = 1
    Tabs.Stats:Slider({
        Title = 'Add Point Amount',
        Value = {
            Min = 1,
            Max = 100,
            Default = 1,
        },
        Step = 1,
        Callback = function(Value)
            AddPointAmount = math.max(1, math.floor(tonumber(Value) or 1))
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Melee',
        Value = false,
        Callback = function(Value)
            _G.Auto_Stats_Melee = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Defense',
        Value = false,
        Callback = function(Value)
            _G.Auto_Stats_Defense = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Sword',
        Value = false,
        Callback = function(Value)
            _G.Auto_Stats_Sword = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Gun',
        Value = false,
        Callback = function(Value)
            _G.Auto_Stats_Gun = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Fruit',
        Value = false,
        Callback = function(Value)
            _G.Auto_Stats_Devil_Fruit = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Auto_Stats_Devil_Fruit) then continue end
            if _G.Auto_Stats_Devil_Fruit then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AddPoint', 'Demon Fruit', AddPointAmount)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Auto_Stats_Gun) then continue end
            if _G.Auto_Stats_Gun then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AddPoint', 'Gun', AddPointAmount)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Auto_Stats_Sword) then continue end
            if _G.Auto_Stats_Sword then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AddPoint', 'Sword', AddPointAmount)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Auto_Stats_Defense) then continue end
            if _G.Auto_Stats_Defense then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AddPoint', 'Defense', AddPointAmount)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Auto_Stats_Melee) then continue end
            if _G.Auto_Stats_Melee then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AddPoint', 'Melee', AddPointAmount)
            end
        end
    end)
    local Playerslist = {}
    for i, v in pairs(game:GetService('Players'):GetChildren())do
        table.insert(Playerslist, v.Name)
    end
    _G.SelectPly = _G.SelectPly or Playerslist[1] or ''
    local function SetSpectateTarget()
        local Camera = workspace.CurrentCamera
        if not Camera then
            return
        end
        if _G.SpectatePlayer and _G.SelectPly and _G.SelectPly ~= '' then
            local TargetPlayer = Players:FindFirstChild(_G.SelectPly)
            local TargetHumanoid = TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChildOfClass('Humanoid')
            if TargetHumanoid then
                Camera.CameraSubject = TargetHumanoid
                return
            end
        end
        local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if Humanoid then
            Camera.CameraSubject = Humanoid
        end
    end
    local SelectedPlyDropdown = Tabs.Player:Dropdown({
        Title = 'Select Player',
        Values = Playerslist,
        Multi = false,
        Value = Playerslist[1] or '',
        Callback = function(Value)
            _G.SelectPly = Value
            SetSpectateTarget()
        end,
    })
    Tabs.Player:Button({
        Title = 'Refresh Player List',
        Callback = function()
            table.clear(Playerslist)
            for i, v in pairs(game:GetService('Players'):GetChildren())do
                table.insert(Playerslist, v.Name)
            end
            if not table.find(Playerslist, _G.SelectPly) then
                _G.SelectPly = Playerslist[1] or ''
            end
            SelectedPlyDropdown:Refresh(Playerslist)
            SetSpectateTarget()
        end,
    })
    Tabs.Player:Toggle({
        Title = 'Teleport To Player',
        Value = false,
        Callback = function(Value)
            _G.TeleportPly = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.TeleportPly) then continue end
            if _G.TeleportPly then
                pcall(function()
                    Tween(game.Players[_G.SelectPly].Character.HumanoidRootPart.CFrame)
                end)
            end
        end
    end)
    Tabs.Player:Toggle({
        Title = 'Spectate Player',
        Value = false,
        Callback = function(Value)
            _G.SpectatePlayer = Value
            SetSpectateTarget()
        end,
    })
    local function ConnectSpectateCharacter(Player)
        if not Player then
            return
        end
        Player.CharacterAdded:Connect(function()
            if _G.SpectatePlayer and Player.Name == _G.SelectPly then
                task.defer(SetSpectateTarget)
            end
        end)
    end
    for _, Player in ipairs(Players:GetPlayers()) do
        ConnectSpectateCharacter(Player)
    end
    Players.PlayerAdded:Connect(ConnectSpectateCharacter)
    Players.PlayerRemoving:Connect(function(Player)
        if Player.Name == _G.SelectPly then
            _G.SelectPly = ''
            SetSpectateTarget()
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function()
        task.defer(SetSpectateTarget)
    end)
    Players = game:GetService('Players')
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    local GetWaterHeight = require(ReplicatedStorage.Util.GetWaterHeightAtLocation)
    LocalPlayer = Players.LocalPlayer
    local WaterPart = Instance.new('Part')
    WaterPart.Name = 'WalkOnWater_Part'
    WaterPart.Size = Vector3.new(200, 1, 200)
    WaterPart.Transparency = 1
    WaterPart.Anchored = true
    WaterPart.CanCollide = true
    WaterPart.CanQuery = false
    WaterPart.Parent = workspace
    local LastWaterLevel =-4
    Tabs.Player:Toggle({
        Title = 'Walk On Water',
        Value = true,
        Callback = function(Value)
            _G.WalkonWater = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.WalkonWater and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')) then continue end
            if _G.WalkonWater and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
                local RootPart = LocalPlayer.Character.HumanoidRootPart
                local RootPos = RootPart.Position
                local Success, Height = pcall(function()
                    return GetWaterHeight(RootPos)
                end)
                if Success and type(Height) == 'number' then
                    LastWaterLevel = Height
                end
                if RootPos.Y >= (LastWaterLevel-5) then
                    WaterPart.CFrame = CFrame.new(RootPos.X, LastWaterLevel-0.5, RootPos.Z)
                else
                    WaterPart.CFrame = CFrame.new(RootPos.X, LastWaterLevel-2, RootPos.Z)
                end
            else
                WaterPart.CFrame = CFrame.new(0,-1E4, 0)
            end
        end
    end)
    Players = game:GetService('Players')
    LocalPlayer = Players.LocalPlayer
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            local MaxDistance = math.huge
            local Nearest = nil
            pcall(function()
                for _, v in pairs(Players:GetPlayers())do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild('HumanoidRootPart') and v.Character.Humanoid.Health > 0 then
                        local Distance = (v.Character.HumanoidRootPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if Distance < MaxDistance then
                            MaxDistance = Distance
                            Nearest = v
                        end
                    end
                end
            end)
            _G.TargetPlayer = Nearest
        end
    end)
    Tabs.Player:Toggle({
        Title = 'Aimbot Camera',
        Value = false,
        Callback = function(Value)
            _G.Aimbot_Camera = Value
        end,
    })
    Tabs.Player:Toggle({
        Title = 'Silent Aim',
        Value = false,
        Callback = function(Value)
            _G.Silent_Aim = Value
        end,
    })
    Tabs.Player:Toggle({
        Title = 'Aimbot Gun',
        Value = false,
        Callback = function(Value)
            _G.Aimbot_Gun = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Aimbot_Camera and _G.TargetPlayer and _G.TargetPlayer.Character and _G.TargetPlayer.Character:FindFirstChild('HumanoidRootPart')) then continue end
            if _G.Aimbot_Camera and _G.TargetPlayer and _G.TargetPlayer.Character and _G.TargetPlayer.Character:FindFirstChild('HumanoidRootPart') then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, _G.TargetPlayer.Character.HumanoidRootPart.Position)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Silent_Aim and _G.TargetPlayer and _G.TargetPlayer.Character and _G.TargetPlayer.Character:FindFirstChild('HumanoidRootPart')) then continue end
            if _G.Silent_Aim and _G.TargetPlayer and _G.TargetPlayer.Character and _G.TargetPlayer.Character:FindFirstChild('HumanoidRootPart') then
                pcall(function()
                    local Character = LocalPlayer.Character
                    local Tool = Character:FindFirstChildOfClass('Tool')
                    if Tool then
                        if Tool:FindFirstChild('RemoteEvent') and Tool:FindFirstChild('MousePos') then
                            local args = {
                                [1] = _G.TargetPlayer.Character.HumanoidRootPart.Position,
                            }
                            Tool.RemoteEvent:FireServer(unpack(args))
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Aimbot_Gun and _G.TargetPlayer and _G.TargetPlayer.Character and _G.TargetPlayer.Character:FindFirstChild('HumanoidRootPart')) then continue end
            if _G.Aimbot_Gun and _G.TargetPlayer and _G.TargetPlayer.Character and _G.TargetPlayer.Character:FindFirstChild('HumanoidRootPart') then
                pcall(function()
                    local Character = LocalPlayer.Character
                    local Tool = Character:FindFirstChildOfClass('Tool')
                    if Tool and Tool:FindFirstChild('RemoteFunctionShoot') then
                        if Tool:FindFirstChild('Cooldown') then
                            Tool.Cooldown.Value = 0
                        end
                        local args = {
                            [1] = _G.TargetPlayer.Character.HumanoidRootPart.Position,
                            [2] = _G.TargetPlayer.Character.HumanoidRootPart,
                        }
                        Tool.RemoteFunctionShoot:InvokeServer(unpack(args))
                    end
                end)
            end
        end
    end)
    Tabs.Player:Toggle({
        Title = 'ESP Player',
        Value = false,
        Callback = function(Value)
            _G.EspPlayer = Value
        end,
    })
    Players = game:GetService('Players')
    LocalPlayer = Players.LocalPlayer
    local function CreateEsp(character)
        local head = character:WaitForChild('Head', 5)
        if not head or head:FindFirstChild('ESP') then
            return
        end
        local BillboardGui = Instance.new('BillboardGui')
        BillboardGui.Name = 'ESP'
        BillboardGui.Adornee = head
        BillboardGui.Size = UDim2.new(0, 110, 0, 35)
        BillboardGui.ExtentsOffset = Vector3.new(0, 2.5, 0)
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Parent = head
        local MainFrame = Instance.new('Frame')
        MainFrame.Name = 'MainFrame'
        MainFrame.Parent = BillboardGui
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        MainFrame.BackgroundTransparency = 0.25
        MainFrame.Size = UDim2.new(1, 0, 1, 0)
        MainFrame.BorderSizePixel = 0
        local UICorner = Instance.new('UICorner')
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = MainFrame
        local UIStroke = Instance.new('UIStroke')
        UIStroke.Parent = MainFrame
        UIStroke.Thickness = 1.2
        UIStroke.Transparency = 0.1
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        local UIGradient = Instance.new('UIGradient')
        UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255)),
        }
        UIGradient.Rotation = 45
        UIGradient.Parent = UIStroke
        local NameLabel = Instance.new('TextLabel')
        NameLabel.Parent = MainFrame
        NameLabel.BackgroundTransparency = 1
        NameLabel.Position = UDim2.new(0, 8, 0, 2)
        NameLabel.Size = UDim2.new(1,-16, 0.5, 0)
        NameLabel.Text = character.Name
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextSize = 11
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        local InfoLabel = Instance.new('TextLabel')
        InfoLabel.Name = 'InfoLabel'
        InfoLabel.Parent = MainFrame
        InfoLabel.BackgroundTransparency = 1
        InfoLabel.Position = UDim2.new(0, 8, 0.5,-1)
        InfoLabel.Size = UDim2.new(1,-16, 0.5, 0)
        InfoLabel.Text = 'HP: 100% | 0m'
        InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        InfoLabel.TextSize = 9
        InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
        local HealthBarBg = Instance.new('Frame')
        HealthBarBg.Parent = MainFrame
        HealthBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        HealthBarBg.BorderSizePixel = 0
        HealthBarBg.Position = UDim2.new(0, 8, 0.9,-1)
        HealthBarBg.Size = UDim2.new(1,-16, 0, 2)
        local HealthBar = Instance.new('Frame')
        HealthBar.Name = 'HealthBar'
        HealthBar.Parent = HealthBarBg
        HealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        HealthBar.BorderSizePixel = 0
        HealthBar.Size = UDim2.new(1, 0, 1, 0)
        task.spawn(function()
            local rotation = 0
            while BillboardGui.Parent do
                rotation = rotation + 2
                UIGradient.Rotation = rotation
                task.wait(0.05)
            end
        end)
    end
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.EspPlayer) then continue end
            if _G.EspPlayer then
                for _, player in pairs(Players:GetPlayers())do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild('Head') and player.Character:FindFirstChild('Humanoid') then
                        local head = player.Character.Head
                        if not head:FindFirstChild('ESP') then
                            CreateEsp(player.Character)
                        else
                            local esp = head:FindFirstChild('ESP')
                            esp.Enabled = true
                            local mainFrame = esp:FindFirstChild('MainFrame')
                            if mainFrame then
                                local hum = player.Character.Humanoid
                                local root = player.Character:FindFirstChild('HumanoidRootPart')
                                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
                                if hum and root and myRoot then
                                    local rawDist = (root.Position-myRoot.Position).Magnitude
                                    local dist = math.floor(rawDist / 12)
                                    local health = math.floor(hum.Health)
                                    local maxHealth = hum.MaxHealth
                                    local infoLabel = mainFrame:FindFirstChild('InfoLabel')
                                    if infoLabel then
                                        infoLabel.Text = string.format('HP: %d%% | %dm', (health / maxHealth) * 100, dist)
                                    end
                                    local healthBarBg = mainFrame:FindFirstChild('Frame')
                                    local healthBar = healthBarBg and healthBarBg:FindFirstChild('HealthBar')
                                    if healthBar then
                                        local healthColor = Color3.fromRGB(0, 255, 100)
                                        if health < maxHealth * 0.5 then
                                            healthColor = Color3.fromRGB(255, 150, 0)
                                        end
                                        if health < maxHealth * 0.2 then
                                            healthColor = Color3.fromRGB(255, 50, 50)
                                        end
                                        healthBar.BackgroundColor3 = healthColor
                                        healthBar.Size = UDim2.new(math.clamp(health / maxHealth, 0, 1), 0, 1, 0)
                                    end
                                end
                            end
                        end
                    end
                end
            else
                for _, player in pairs(Players:GetPlayers())do
                    if player.Character and player.Character:FindFirstChild('Head') then
                        local esp = player.Character.Head:FindFirstChild('ESP')
                        if esp then
                            esp.Enabled = false
                        end
                    end
                end
            end
        end
    end)
    if Sea2 then
        Tabs.Travel:Toggle({
            Title = 'Quest Sea3',
            Value = false,
            Callback = function(Value)
                _G.Auto_Sea3 = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Sea3) then continue end
                if _G.Auto_Sea3 then
                    pcall(function()
                        local player = game.Players.LocalPlayer
                        local rootPart = player.Character.HumanoidRootPart
                        local enemies = workspace.Enemies
                        if player.Data.Level.Value >= 1500 and Sea2 then
                            local questPos = CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016)
                            Tween(questPos)
                            repeat
                                task.wait()
                            until (rootPart.Position-questPos.Position).Magnitude <= 10
                            task.wait(1)
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ZQuestProgress', 'Begin')
                        end
                        task.wait(1)
                        if enemies:FindFirstChild('rip_indra') then
                            for _, v in pairs(enemies:GetChildren())do
                                if v.Name == 'rip_indra' then
                                    repeat
                                        task.wait()
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                        Attack()
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelZou')
                                    until not _G.Auto_Sea3 or v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        elseif not enemies:FindFirstChild('rip_indra') and (CFrame.new(-26880.933, 22.848, 473.189)-rootPart.Position).Magnitude <= 1000 then
                            Tween(CFrame.new(-26880.933, 22.848, 473.189))
                        end
                    end)
                end
            end
        end)
    end
    Tabs.Travel:Button({
        Title = 'Teleport To Sea 1',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelMain')
        end,
    })
    Tabs.Travel:Button({
        Title = 'Teleport To Sea 2',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelDressrosa')
        end,
    })
    Tabs.Travel:Button({
        Title = 'Teleport To Sea 3',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelZou')
        end,
    })
    Tabs.Travel:Button({
        Title = 'Teleport To Dungeon',
        Callback = function()
            game:GetService('ReplicatedStorage').Modules.Net['RF/DungeonNPCNetworkFunction']:InvokeServer('TeleportToDungeonHub')
        end,
    })
    local IslandList = {}
    if Sea1 then
        IslandList = {
            'Colosseum',
            'Pirate Village',
            'Underwater',
            'Jungle',
            'Desert',
            'Starter Marine',
            'Middle Town',
            'Upper Sky',
            'Volcano',
            'Sky',
            'Starter Island',
            'Fountain',
            'Prison',
            'Marine Fortress',
            'Snow',
        }
    elseif Sea2 then
        IslandList = {
            'Haunted Ship',
            'Dark Arena',
            'Docks 2',
            'Skull',
            'Doghouse',
            'Lava',
            'Raid',
            'Snow',
            'Colosseum',
            'Graveyard',
            'Lab',
            'Mansion',
            'Cafe',
            'Remote',
            'Docks 1',
            'Docks 4',
            'Winter Castle',
            'Docks 3',
        }
    elseif Sea3 then
        IslandList = {
            'Cake Land',
            'Turtle Mountain',
            'Ice Cream Land',
            'Tiki Outpost',
            'Turtle Mansion',
            'Great Tree',
            'Hydra Town',
            'Haunted Castle',
            'Port',
            'Peanut Land',
            'Turtle Entrance',
            'Hydra Arena',
            'Chocolate Land',
            'Sea Castle',
            'Turtle Center',
        }
    end
    Tabs.Travel:Dropdown({
        Title = 'Island Type',
        Values = IslandList,
        Multi = false,
        Value = IslandList[1],
        Callback = function(Value)
            _G.SelectIsland = Value
        end,
    })
    Tabs.Travel:Button({
        Title = 'Teleport To Island',
        Callback = function()
            local islandMap = {}
            if Sea1 then
                islandMap = {
                    ['Middle Town'] = CFrame.new(-700.3, 12.2, 1578.8),
                    ['Upper Sky'] = CFrame.new(-7962.9, 5814,-1961.5),
                    Snow = CFrame.new(1384.7, 37.4,-1334),
                    Jungle = CFrame.new(-1325.8, 11.9,-85.2),
                    ['Pirate Village'] = CFrame.new(-795, 26.4, 4125.4),
                    ['Starter Island'] = CFrame.new(1010.1, 16.5, 1292),
                    Sky = CFrame.new(-4806.5, 719.7,-2668),
                    Desert = CFrame.new(1312.5, 68, 4477.1),
                    ['Starter Marine'] = CFrame.new(-3112.3, 223.6, 2076.9),
                    Prison = CFrame.new(5268.7, 161.8, 830.4),
                    ['Marine Fortress'] = CFrame.new(-5179.7, 279.7, 4369.1),
                    Volcano = CFrame.new(-5570.2, 46.8, 8528),
                    Fountain = CFrame.new(5427.6, 429.4, 4382.2),
                    Colosseum = CFrame.new(-2122.2, 33.9,-3033),
                }
            elseif Sea2 then
                islandMap = {
                    ['Dark Arena'] = CFrame.new(3954.7, 13.4,-3477.4),
                    Colosseum = CFrame.new(-1823.9, 44.3, 1636),
                    Graveyard = CFrame.new(-5707.6, 126.1,-768.2),
                    Lab = CFrame.new(-5524.4, 224.2,-5880.4),
                    Snow = CFrame.new(1215.8, 429.5,-4667.1),
                    ['Docks 1'] = CFrame.new(-925.9, 8.2, 1815.6),
                    ['Docks 4'] = CFrame.new(-5798, 6.6,-5035.7),
                    Lava = CFrame.new(-5220.6, 174.4,-5565.9),
                    Raid = CFrame.new(-6498.5, 198.6,-4470.5),
                    Mansion = CFrame.new(-483.1, 331.9, 608.5),
                    ['Winter Castle'] = CFrame.new(5544.9, 28.4,-6381.9),
                    ['Docks 3'] = CFrame.new(-1947, 6.5,-2582.2),
                    Skull = CFrame.new(-2939.9, 115.9,-9989.6),
                    Doghouse = CFrame.new(-1988.2, 125.5,-78.6),
                    ['Docks 2'] = CFrame.new(-20.5, 39.3, 2708.2),
                    Remote = CFrame.new(4766.6, 8.5, 2909.9),
                }
            elseif Sea3 then
                islandMap = {
                    ['Great Tree'] = CFrame.new(4353.8, 565.8,-6181.2),
                    Port = CFrame.new(-336.1, 20.6, 5561),
                    ['Haunted Castle'] = CFrame.new(-9523.8, 142.1, 5548.5),
                    ['Turtle Entrance'] = CFrame.new(-10180.7, 331.8,-8306.2),
                    ['Cake Land'] = CFrame.new(-2078.1, 70,-12128.4),
                    ['Chocolate Land'] = CFrame.new(367.3, 125.6,-12708.6),
                    ['Ice Cream Land'] = CFrame.new(-921.63, 58.71,-10875.46),
                    ['Peanut Land'] = CFrame.new(-2020.6, 9.7,-9941.1),
                    ['Tiki Outpost'] = CFrame.new(-16451.8, 527.8, 422.7),
                    ['Turtle Mountain'] = CFrame.new(-12836.6, 844.4,-10717.4),
                    ['Hydra Arena'] = CFrame.new(5012.1, 173.6,-2002.7),
                    ['Turtle Center'] = CFrame.new(-11990.2, 331.8,-9180.3),
                }
            end
            local special = {
                Underwater = Vector3.new(61163.9, 11.7, 1819.8),
                Cafe = Vector3.new(-391.4, 73.1, 342.7),
                ['Haunted Ship'] = Vector3.new(923.4, 125.1, 32885.9),
                ['Sea Castle'] = Vector3.new(-5054.6, 314.6,-3177.6),
                ['Hydra Town'] = Vector3.new(5661.5, 1013.1,-335),
                ['Turtle Mansion'] = Vector3.new(-12468.5, 375,-7554.6),
            }
            if islandMap[_G.SelectIsland] then
                Tween(islandMap[_G.SelectIsland])
            elseif special[_G.SelectIsland] then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', special[_G.SelectIsland])
            end
        end,
    })
    Tabs.Fruit:Toggle({
        Title = 'Store Fruit',
        Value = false,
        Callback = function(Value)
            _G.AutoStoreFruit = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.AutoStoreFruit) then continue end
            if _G.AutoStoreFruit then
                pcall(function()
                    for _, container in ipairs({
                        game:GetService('Players').LocalPlayer.Backpack,
                        game:GetService('Players').LocalPlayer.Character,
                    })do
                        for _, item in ipairs(container:GetChildren())do
                            local eatRemote = item:FindFirstChild('EatRemote', true)
                            if eatRemote then
                                local originalName = item:GetAttribute('OriginalName')
                                if originalName then
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StoreFruit', originalName, item)
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
    Tabs.Fruit:Toggle({
        Title = 'Random Fruit (Money)',
        Value = false,
        Callback = function(Value)
            _G.Random_Auto = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Random_Auto) then continue end
            if _G.Random_Auto then
                pcall(function()
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Cousin', 'Buy')
                end)
            end
        end
    end)
    Tabs.Fruit:Toggle({
        Title = 'Teleport To Fruit',
        Value = false,
        Callback = function(Value)
            _G.Tweenfruit = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.Tweenfruit) then continue end
            if _G.Tweenfruit then
                pcall(function()
                    for i, v in pairs(game.Workspace:GetChildren())do
                        if string.find(v.Name, 'Fruit') and v:FindFirstChild('Handle') then
                            Tween(v.Handle.CFrame)
                        end
                    end
                end)
            end
        end
    end)
    if Sea2 or Sea3 then
        local Chips = {
            'Flame',
            'Ice',
            'Quake',
            'Light',
            'Dark',
            'Spider',
            'Rumble',
            'Magma',
            'Buddha',
            'Sand',
            'Phoenix',
            'Dough',
        }
        local SelectChip = nil
        Tabs.Dungeon:Dropdown({
            Title = 'Chip Type',
            Values = Chips,
            Multi = false,
            Callback = function(Value)
                SelectChip = Value
            end,
        })
        Tabs.Dungeon:Toggle({
            Title = 'Buy Chip',
            Value = false,
            Callback = function(Value)
                _G.Auto_Buy_Chips_Dungeon = Value
            end,
        })
        Tabs.Dungeon:Toggle({
            Title = 'Start Raid',
            Value = false,
            Callback = function(Value)
                _G.Auto_StartRaid = Value
            end,
        })
        Tabs.Dungeon:Toggle({
            Title = 'Auto Awaken',
            Value = false,
            Callback = function(Value)
                AutoAwakenAbilities = Value
            end,
        })
        Tabs.Dungeon:Toggle({
            Title = 'Get Low Fruits 1M',
            Value = false,
            Callback = function(Value)
                _G.Autofruit = Value
            end,
        })
        if Sea2 then
            Tabs.Dungeon:Toggle({
                Title = 'Buy Chip & Kill Law',
                Value = false,
                Callback = function(Value)
                    _G.Auto_Law = Value
                end,
            })
        end
        Tabs.Dungeon:Button({
            Title = 'Teleport To Area Raid',
            Callback = function()
                if Sea2 then
                    Tween(CFrame.new(-6498.5, 198.6,-4470.5))
                elseif Sea3 then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-5075.509, 314.5155,-3150.022))
                    Tween(CFrame.new(-5017.409, 314.844,-2823.013))
                end
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Buy_Chips_Dungeon) then continue end
                if _G.Auto_Buy_Chips_Dungeon then
                    pcall(function()
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('RaidsNpc', 'Select', SelectChip)
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_StartRaid and (Sea2 or Sea3)) then continue end
                if _G.Auto_StartRaid and (Sea2 or Sea3) then
                    pcall(function()
                        local Player = game:GetService('Players').LocalPlayer
                        local Gui = Player.PlayerGui.Main.TopHUDList.RaidTimer
                        local Character = Player.Character
                        local Backpack = Player.Backpack
                        Workspace = game:GetService('Workspace')
                        if Gui.Visible == true then
                            local IsIsland5 = Workspace._WorldOrigin.Locations:FindFirstChild('Island 5')
                            local IsIsland4 = Workspace._WorldOrigin.Locations:FindFirstChild('Island 4')
                            if IsIsland5 or IsIsland4 then
                                sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
                                for _, v in pairs(Workspace.Enemies:GetChildren())do
                                    if v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                                        v.Humanoid.Health = 0
                                        v.HumanoidRootPart.CanCollide = false
                                    end
                                end
                                local TargetIsland = IsIsland5 or IsIsland4
                                Tween(TargetIsland.CFrame + Pos)
                            else
                                for _, v in pairs(Workspace.Enemies:GetChildren())do
                                    if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                        if (v.HumanoidRootPart.Position-Character.HumanoidRootPart.Position).Magnitude <= 500 then
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            FarmPos = v.HumanoidRootPart.CFrame
                                            MonFarm = v.Name
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            Attack()
                                            return
                                        end
                                    end
                                end
                                for i = 5, 1,-1 do
                                    local island = Workspace._WorldOrigin.Locations:FindFirstChild('Island ' .. i)
                                    if island then
                                        Tween(island.CFrame + Pos)
                                        return
                                    end
                                end
                            end
                        else
                            if not Workspace.Map.RaidMap:FindFirstChild('RaidIsland1') and (Backpack:FindFirstChild('Special Microchip') or Character:FindFirstChild('Special Microchip')) then
                                if Sea2 then
                                    fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                                elseif Sea3 then
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-5083.26, 314.606,-3175.673))
                                    fireclickdetector(Workspace.Map['Boat Castle'].RaidSummon2.Button.Main.ClickDetector)
                                end
                            end
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(AutoAwakenAbilities) then continue end
                if AutoAwakenAbilities then
                    pcall(function()
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Awakener', 'Awaken')
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Autofruit) then continue end
                if _G.Autofruit then
                    pcall(function()
                        local Fruits = {
                            'Rocket-Rocket',
                            'Spin-Spin',
                            'Blade-Blade',
                            'Spring-Spring',
                            'Bomb-Bomb',
                            'Smoke-Smoke',
                            'Spike-Spike',
                            'Flame-Flame',
                            'Ice-Ice',
                            'Sand-Sand',
                            'Dark-Dark',
                            'Ghost-Ghost',
                            'Diamond-Diamond',
                            'Light-Light',
                            'Rubber-Rubber',
                            'Eagle-Eagle',
                        }
                        for _, fruit in ipairs(Fruits)do
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LoadFruit', fruit)
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Law) then continue end
                if _G.Auto_Law then
                    pcall(function()
                        local plr = game.Players.LocalPlayer
                        local enemies = workspace.Enemies
                        local orderBoss = enemies:FindFirstChild('Order')
                        local hasChip = plr.Backpack:FindFirstChild('Microchip') or plr.Character:FindFirstChild('Microchip')
                        local raidStart = game.ReplicatedStorage:FindFirstChild('Order')
                        if not hasChip and not orderBoss and not raidStart then
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer('BlackbeardReward', 'Microchip', '1')
                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer('BlackbeardReward', 'Microchip', '2')
                        elseif hasChip and not orderBoss then
                            fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                        elseif orderBoss then
                            for _, v in pairs(enemies:GetChildren())do
                                if v.Name == 'Order' and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 then
                                    repeat
                                        task.wait()
                                        Attack()
                                        AutoHaki()
                                        Equip(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame + Pos)
                                    until not v.Parent or v.Humanoid.Health <= 0 or not _G.Auto_Law
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end
    if Dungeon then
        Players = game:GetService('Players')
        ReplicatedStorage = game:GetService('ReplicatedStorage')
        local VirtualInputManager = game:GetService('VirtualInputManager')
        local GuiService = game:GetService('GuiService')
        Workspace = game:GetService('Workspace')
        LocalPlayer = Players.LocalPlayer
        local BuffNames = {
            'HYPER!', 'Lifesteal', 'Defense', 'Melee', 'Sword', 'Fruit',
            'Fruit Meter', 'Fortress', 'Overflow', 'Skyjumps', 'Armor', 'Race Meter'
        }
        local DropdownOptions = {'All'}
        for _, v in ipairs(BuffNames) do
            table.insert(DropdownOptions, v)
        end
        _G.SelectedBuffs = BuffNames
        Tabs.Dungeon:Dropdown({
            Title = 'Difficulty',
            Values = {'Normal', 'Hard', 'Challenge'},
            Value = 'Normal',
            Multi = false,
            Callback = function(Value)
                pcall(function()
                    local Character = LocalPlayer.Character
                    local Root = Character and Character:FindFirstChild('HumanoidRootPart')
                    if not Root then return end
                    local Hub = Workspace.Map:FindFirstChild('Simulation Hub')
                    if Hub and Hub:FindFirstChild('Pads') then
                        local ClosestPad, MinDist = nil, math.huge
                        for i = 1, 3 do
                            local Pad = Hub.Pads:FindFirstChild('DUNGEON_TELEPORTER' .. i)
                            if Pad then
                                local Dist = (Root.Position - Pad:GetPivot().Position).Magnitude
                                if Dist < MinDist then
                                    MinDist = Dist
                                    ClosestPad = Pad
                                end
                            end
                        end
                        if ClosestPad and MinDist <= 50 then
                            ClosestPad.DungeonSettingsChanged:FireServer('Difficulty', Value)
                        end
                    end
                end)
            end,
        })
        Tabs.Dungeon:Dropdown({
            Title = 'Select Buff',
            Values = DropdownOptions,
            Value = {'All'},
            Multi = true,
            Callback = function(Value)
                if table.find(Value, 'All') then
                    _G.SelectedBuffs = BuffNames
                else
                    _G.SelectedBuffs = Value
                end
            end,
        })
        Tabs.Dungeon:Toggle({
            Title = 'Auto Random Trinket',
            Value = false,
            Callback = function(V)
                _G.Auto_RandomTrinket = V
            end,
        })
        Tabs.Dungeon:Button({
            Title = 'Open Scrap UI',
            Callback = function()
                game.Players.LocalPlayer.PlayerGui.AccessoryTrasher.Open:Fire()
            end,
        })
        Tabs.Dungeon:Toggle({
            Title = 'Auto Start',
            Value = false,
            Callback = function(V)
                _G.Auto_Start = V
            end,
        })
        Tabs.Dungeon:Toggle({
            Title = 'Auto Dungeon',
            Value = false,
            Callback = function(V)
                _G.Auto_Dungeon = V
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_RandomTrinket) then continue end
                if _G.Auto_RandomTrinket then
                    pcall(function()
                        ReplicatedStorage.Remotes.AccessoryInteract:InvokeServer('d')
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Start) then continue end
                if _G.Auto_Start then
                    pcall(function()
                        if Workspace.Map:FindFirstChild('Dungeon') then return end
                        local Hub = Workspace.Map:FindFirstChild('Simulation Hub')
                        if not Hub or not Hub:FindFirstChild('Pads') then return end
                        local Character = LocalPlayer.Character
                        local Root = Character and Character:FindFirstChild('HumanoidRootPart')
                        if not Root then return end
                        local MyCurrentPad, TargetPad = nil, nil
                        local BestCount = -1
                        for i = 1, 3 do
                            local P = Hub.Pads:FindFirstChild('DUNGEON_TELEPORTER' .. i)
                            if P and (Root.Position - P:GetPivot().Position).Magnitude < 15 then
                                MyCurrentPad = P
                                break
                            end
                        end
                        for i = 1, 3 do
                            local P = Hub.Pads:FindFirstChild('DUNGEON_TELEPORTER' .. i)
                            if P then
                                local PadPart = P:FindFirstChild('Pad')
                                if PadPart and PadPart:FindFirstChild('TeleporterBillboard') then
                                    local StatusText = PadPart.TeleporterBillboard.Status.ContentText
                                    local Count = 0
                                    if string.find(StatusText, "/4") then
                                        local CountStr = string.match(StatusText, '(%d+)/4')
                                        Count = tonumber(CountStr) or 0
                                    elseif StatusText ~= "" and StatusText ~= "Loading..." then
                                        Count = 5
                                    end
                                    if Count > BestCount then
                                        BestCount = Count
                                        TargetPad = P
                                    elseif Count == BestCount and MyCurrentPad and P == MyCurrentPad then
                                        TargetPad = P
                                    end
                                end
                            end
                        end
                        if not TargetPad then
                            TargetPad = MyCurrentPad or Hub.Pads:FindFirstChild('DUNGEON_TELEPORTER1')
                        end
                        if TargetPad then
                            if (Root.Position - TargetPad:GetPivot().Position).Magnitude > 5 then
                                Tween(TargetPad:GetPivot())
                            elseif TargetPad == MyCurrentPad then
                                TargetPad.DungeonSettingsChanged:FireServer('Start')
                            end
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Dungeon and _G.SelectedBuffs and #_G.SelectedBuffs > 0) then continue end
                if _G.Auto_Dungeon and _G.SelectedBuffs and #_G.SelectedBuffs > 0 then
                    pcall(function()
                        local PlayerGui = LocalPlayer.PlayerGui
                        local FoundAndClicked = false
                        for _, PriorityKeyword in ipairs(_G.SelectedBuffs) do
                            if FoundAndClicked then break end
                            for _, ChildGui in pairs(PlayerGui:GetChildren()) do
                                if ChildGui:FindFirstChild('1') and ChildGui['1']:FindFirstChild('2') then
                                    local CardContainer = ChildGui['1']['2']
                                    local DisplayNameLabel = CardContainer:FindFirstChild('DisplayName')
                                    if DisplayNameLabel then
                                        local Content = DisplayNameLabel.ContentText or DisplayNameLabel.Text
                                        if string.lower(Content) == string.lower(PriorityKeyword) then
                                            local Inset = GuiService:GetGuiInset()
                                            local X = CardContainer.AbsolutePosition.X + (CardContainer.AbsoluteSize.X / 2) + Inset.X
                                            local Y = CardContainer.AbsolutePosition.Y + (CardContainer.AbsoluteSize.Y / 2) + Inset.Y
                                            VirtualInputManager:SendMouseButtonEvent(X, Y, 0, true, game, 1)
                                            task.wait(0.05)
                                            VirtualInputManager:SendMouseButtonEvent(X, Y, 0, false, game, 1)
                                            FoundAndClicked = true
                                            task.wait(0.3)
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.Auto_Dungeon) then continue end
                if _G.Auto_Dungeon then
                    pcall(function()
                        local ReturnRemote = ReplicatedStorage.DungeonShared:FindFirstChild('ReturnToHub')
                        if ReturnRemote and ReturnRemote:GetAttribute('Timer') then
                            ReturnRemote:FireServer()
                        end
                        local Character = LocalPlayer.Character
                        local Root = Character and Character:FindFirstChild('HumanoidRootPart')
                        if not Root then return end
                        local MapDungeon = Workspace.Map:FindFirstChild('Dungeon')
                        local TargetShrine, ShrineDist = nil, math.huge
                        if MapDungeon and MapDungeon:FindFirstChild('10') and MapDungeon['10']:FindFirstChild('Props') then
                            for _, v in pairs(MapDungeon['10'].Props:GetChildren()) do
                                local NeonPart = v:FindFirstChild('NeonShrinePart')
                                if NeonPart and NeonPart.Color == Color3.fromRGB(0, 255, 238) then
                                    local Dist = (Root.Position - NeonPart.Position).Magnitude
                                    if Dist < ShrineDist then
                                        ShrineDist = Dist
                                        TargetShrine = NeonPart
                                    end
                                end
                            end
                        end
                        if TargetShrine then
                            Tween(TargetShrine.CFrame)
                            CallSkills()
                        else
                            local Enemies = Workspace.Enemies
                            local realEnemy, closestDist = nil, math.huge
                            for _, v in pairs(Enemies:GetChildren()) do
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                    local Name = string.lower(v.Name)
                                    local DispName = v.Humanoid.DisplayName and string.lower(v.Humanoid.DisplayName) or ''
                                    if not (Name:find('shadow') or Name:find('friendo') or DispName:find('shadow') or DispName:find('friendo')) then
                                        local Dist = (Root.Position - v.HumanoidRootPart.Position).Magnitude
                                        if Dist < closestDist then
                                            closestDist = Dist
                                            realEnemy = v
                                        end
                                    end
                                end
                            end
                            if realEnemy then
                                local PlayerZone, EnemyZone = nil, nil
                                local MinDistPlayer, MinDistEnemy = math.huge, math.huge
                                if MapDungeon then
                                    for _, zone in pairs(MapDungeon:GetChildren()) do
                                        local refPoint = zone:FindFirstChild('ExitTeleporter') or zone:FindFirstChild('EntranceTeleporter')
                                        if refPoint then
                                            local pDist = (Root.Position - refPoint:GetPivot().Position).Magnitude
                                            if pDist < MinDistPlayer then
                                                MinDistPlayer = pDist
                                                PlayerZone = zone
                                            end
                                            local eDist = (realEnemy.HumanoidRootPart.Position - refPoint:GetPivot().Position).Magnitude
                                            if eDist < MinDistEnemy then
                                                MinDistEnemy = eDist
                                                EnemyZone = zone
                                            end
                                        end
                                    end
                                end
                                if PlayerZone and EnemyZone and PlayerZone ~= EnemyZone then
                                    local Exit = PlayerZone:FindFirstChild('ExitTeleporter')
                                    if Exit then
                                        BKP(Exit:GetPivot())
                                    else
                                        MonFarm = realEnemy.Name
                                        FarmPos = realEnemy.HumanoidRootPart.CFrame
                                        Tween(realEnemy.HumanoidRootPart.CFrame + Pos)
                                        Equip(SelectWeapon)
                                        AutoHaki()
                                        Attack()
                                        AutoRaceV3()
                                    end
                                else
                                    MonFarm = realEnemy.Name
                                    FarmPos = realEnemy.HumanoidRootPart.CFrame
                                    Tween(realEnemy.HumanoidRootPart.CFrame + Pos)
                                    Equip(SelectWeapon)
                                    AutoHaki()
                                    Attack()
                                    AutoRaceV3()
                                end
                            elseif MapDungeon then
                                local nearestExit, minExitDist = nil, math.huge
                                for _, zone in pairs(MapDungeon:GetChildren()) do
                                    local exit = zone:FindFirstChild('ExitTeleporter')
                                    if exit then
                                        local dist = (Root.Position - exit:GetPivot().Position).Magnitude
                                        if dist < minExitDist then
                                            minExitDist = dist
                                            nearestExit = exit
                                        end
                                    end
                                end
                                if nearestExit then
                                    BKP(nearestExit:GetPivot())
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end
    if Sea3 then
        Tabs.Race:Button({
            Title = 'Pull Lever',
            Callback = function()
                if game.ReplicatedStorage:FindFirstChild('MapStash') then
                    local mapStash = game.ReplicatedStorage.MapStash
                    local temple = mapStash:FindFirstChild('Temple of Time')
                    if temple then
                        if not workspace:FindFirstChild('Map') then
                            Instance.new('Folder', workspace).Name = 'Map'
                        end
                        temple.Parent = workspace.Map
                    end
                end
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(28286.355, 14895.301, 102.625))
                local temple = workspace:FindFirstChild('Map') and workspace.Map:FindFirstChild('Temple of Time')
                if not temple then
                    return
                end
                for _, obj in ipairs(temple:GetDescendants())do
                    if obj:IsA('ProximityPrompt') and obj.ActionText == 'Interact' then
                        local part = obj.Parent
                        if part and part:IsA('BasePart') and (not obj.ObjectText or obj.ObjectText == '') then
                            Tween(CFrame.new(part.Position))
                            repeat
                                task.wait()
                            until (game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-part.Position).Magnitude <= 5)
                            fireproximityprompt(obj, 0)
                            break
                        end
                    end
                end
            end,
        })
        Tabs.Race:Button({
            Title = 'Temple Of Time',
            Callback = function()
                if game.ReplicatedStorage:FindFirstChild('MapStash') then
                    if game.ReplicatedStorage.MapStash:FindFirstChild('Temple of Time') then
                        if not game.Workspace:FindFirstChild('Map') then
                            Instance.new('Folder', game.Workspace).Name = 'Map'
                        end
                        game.ReplicatedStorage.MapStash['Temple of Time'].Parent = game.Workspace.Map
                    end
                end
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(28286.355, 14895.301, 102.625))
            end,
        })
        Tabs.Race:Button({
            Title = 'Ancient Clock',
            Callback = function()
                if game.ReplicatedStorage:FindFirstChild('MapStash') then
                    if game.ReplicatedStorage.MapStash:FindFirstChild('Temple of Time') then
                        if not game.Workspace:FindFirstChild('Map') then
                            Instance.new('Folder', game.Workspace).Name = 'Map'
                        end
                        game.ReplicatedStorage.MapStash['Temple of Time'].Parent = game.Workspace.Map
                    end
                end
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(28286.355, 14895.301, 102.625))
                Tween(CFrame.new(29549, 15069,-88))
            end,
        })
        Tabs.Race:Button({
            Title = 'Teleport To Area Buy Gear',
            Callback = function()
                local race = game.Players.LocalPlayer.Data.Race.Value
                if race == 'Draco' then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(5661.532, 1013.091,-334.965))
                    Tween(CFrame.new(5666.294, 958.345, 940.345))
                else
                    if game.ReplicatedStorage:FindFirstChild('MapStash') then
                        if game.ReplicatedStorage.MapStash:FindFirstChild('Temple of Time') then
                            if not game.Workspace:FindFirstChild('Map') then
                                Instance.new('Folder', game.Workspace).Name = 'Map'
                            end
                            game.ReplicatedStorage.MapStash['Temple of Time'].Parent = game.Workspace.Map
                        end
                    end
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(28286.355, 14895.301, 102.625))
                    Tween(CFrame.new(28981.553, 14888.427,-120.246))
                end
            end,
        })
        Tabs.Race:Button({
            Title = 'Teleport To Door Your Race',
            Callback = function()
                local race = game.Players.LocalPlayer.Data.Race.Value
                local racePositions = {
                    Cyborg = CFrame.new(28492.3809, 14896.038,-421.044),
                    Mink = CFrame.new(29020.627, 14890.661,-379.481),
                    Human = CFrame.new(29237.238, 14890.658,-206.638),
                    Skypiea = CFrame.new(28968.041, 14919.309, 233.463),
                    Ghoul = CFrame.new(28671.729, 14890.716, 454.153),
                    Fishman = CFrame.new(28223.846, 14890.658,-210.973),
                }
                if race == 'Draco' then
                    local prehistoricIsland = workspace:FindFirstChild('Map') and workspace.Map:FindFirstChild('PrehistoricIsland')
                    if prehistoricIsland then
                        local trialTeleport = prehistoricIsland:FindFirstChild('TrialTeleport')
                        if trialTeleport and trialTeleport:IsA('Part') then
                            Tween(CFrame.new(trialTeleport.Position))
                        end
                    end
                elseif racePositions[race] then
                    local function ensureTempleOfTimeLoaded()
                        if game.ReplicatedStorage:FindFirstChild('MapStash') then
                            if game.ReplicatedStorage.MapStash:FindFirstChild('Temple of Time') then
                                if not workspace:FindFirstChild('Map') then
                                    Instance.new('Folder', workspace).Name = 'Map'
                                end
                                game.ReplicatedStorage.MapStash['Temple of Time'].Parent = workspace.Map
                            end
                        end
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(28286.355, 14895.301, 102.625))
                    end
                    ensureTempleOfTimeLoaded()
                    Tween(racePositions[race])
                end
            end,
        })
        Tabs.Race:Toggle({
            Title = 'Complete Trial',
            Value = false,
            Callback = function(Value)
                _G.AutoQuestRace = Value
            end,
        })
        Tabs.Race:Toggle({
            Title = 'Killed Player Later Trial',
            Value = false,
            Callback = function(Value)
                _G.AutoKillTrial = Value
            end,
        })
        local selectedGearColor = nil
        Tabs.Race:Dropdown({
            Title = 'Select Gear Color',
            Values = {
                'Red',
                'Blue',
            },
            Multi = false,
            Callback = function(Value)
                selectedGearColor = Value
            end,
        })
        Tabs.Race:Button({
            Title = 'Change Gear',
            Callback = function()
                if not selectedGearColor or (selectedGearColor ~= 'Red' and selectedGearColor ~= 'Blue') then
                    return
                end
                local gearType = selectedGearColor == 'Red' and 'Alpha' or 'Omega'
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TempleClock', 'SpendPoint', 'Gear3', gearType)
                Library:Notify({
                    Title = 'Solarix',
                    Content = 'Successfully changed gear to ' .. selectedGearColor,
                    Duration = 5,
                })
            end,
        })
        Tabs.Race:Toggle({
            Title = 'Auto Train',
            Value = false,
            Callback = function(Value)
                _G.AutoFarmRace = Value
            end,
        })
        Tabs.Race:Toggle({
            Title = 'Buy Gear',
            Value = false,
            Callback = function(Value)
                _G.AutoUpgrade = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoUpgrade) then continue end
                if _G.AutoUpgrade then
                    local player = game.Players.LocalPlayer
                    local race = player:FindFirstChild('Data') and player.Data:FindFirstChild('Race')
                    if race and race.Value == 'Draco' then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('UpgradeRace', 'Buy', 2)
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('UpgradeRace', 'Buy')
                    end
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    if _G.AutoQuestRace then
                        local player = game.Players.LocalPlayer
                        local race = player.Data.Race.Value
                        local char = player.Character
                        local hrp = char and char:FindFirstChild('HumanoidRootPart')
                        if race == 'Human' or race == 'Ghoul' then
                            for _, v in pairs(workspace.Enemies:GetChildren())do
                                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                    if hrp then
                                        local distance = (hrp.Position-v.HumanoidRootPart.Position).Magnitude
                                        if distance <= 150 then
                                            v.Humanoid.Health = 0
                                            v.HumanoidRootPart.CanCollide = false
                                            sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
                                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                        end
                                    end
                                end
                            end
                        elseif race == 'Fishman' and hrp then
                            local seaBeast = workspace.SeaBeasts:FindFirstChild('SeaBeast1')
                            if seaBeast and seaBeast:FindFirstChild('HumanoidRootPart') then
                                local distance = (hrp.Position-seaBeast.HumanoidRootPart.Position).Magnitude
                                if distance <= 300 then
                                    repeat
                                        task.wait()
                                        AutoRaceV3()
                                        Tween(seaBeast.HumanoidRootPart.CFrame * CFrame.new(0, 500, 0))
                                        CallSkills()
                                    until not _G.AutoQuestRace or not seaBeast.Parent or seaBeast.Humanoid.Health <= 0
                                end
                            end
                        elseif race == 'Skypiea' then
                            for _, v in pairs(workspace.Map.SkyTrial.Model:GetDescendants())do
                                if v.Name == 'snowisland_Cylinder.081' and v:IsA('BasePart') then
                                    BKP(v.CFrame)
                                end
                            end
                        elseif race == 'Cyborg' and hrp then
                            if game.ReplicatedStorage:FindFirstChild('MapStash') and game.ReplicatedStorage.MapStash:FindFirstChild('Temple of Time') then
                                if not workspace:FindFirstChild('Map') then
                                    Instance.new('Folder', workspace).Name = 'Map'
                                end
                                game.ReplicatedStorage.MapStash['Temple of Time'].Parent = workspace.Map
                            end
                            local temple = workspace:FindFirstChild('Map') and workspace.Map:FindFirstChild('Temple of Time')
                            local shouldRequestEntrance = true
                            if temple and temple:IsA('Model') then
                                local cf, size = temple:GetBoundingBox()
                                local relativePos = cf:PointToObjectSpace(hrp.Position)
                                if math.abs(relativePos.X) <= size.X / 2 and math.abs(relativePos.Y) <= size.Y / 2 and math.abs(relativePos.Z) <= size.Z / 2 then
                                    shouldRequestEntrance = false
                                end
                            end
                            if shouldRequestEntrance then
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(28286.355, 14895.301, 102.625))
                            end
                        elseif race == 'Mink' then
                            local startPoint = workspace:FindFirstChild('StartPoint')
                            if startPoint and startPoint:IsA('BasePart') then
                                BKP(startPoint.CFrame)
                            end
                        elseif race == 'Draco' and hrp then
                            game.ReplicatedStorage.Remotes.DracoTrial:InvokeServer()
                            local draco = workspace:FindFirstChild('Map') and workspace.Map:FindFirstChild('DracoTrial')
                            if draco then
                                local cf, size = draco:GetBoundingBox()
                                local relativePos = cf:PointToObjectSpace(hrp.Position)
                                local inside = math.abs(relativePos.X) <= size.X / 2 and math.abs(relativePos.Y) <= size.Y / 2 and math.abs(relativePos.Z) <= size.Z / 2
                                if inside then
                                    local function getPrompt(name)
                                        local model = draco:FindFirstChild(name, true)
                                        if model then
                                            for _, v in pairs(model:GetDescendants())do
                                                if v:IsA('ProximityPrompt') and v.ActionText == 'Interact' and v.Enabled then
                                                    return v.Parent, v
                                                end
                                            end
                                        end
                                        return nil, nil
                                    end
                                    for i = 1, 3 do
                                        local rPart, rPrompt = getPrompt('Relic' .. i)
                                        local ePart, ePrompt = getPrompt('EndRelic' .. i)
                                        if rPart and rPrompt then
                                            Tween(rPart.CFrame)
                                            repeat
                                                task.wait()
                                            until (hrp.Position-rPart.Position).Magnitude <= 5
                                            fireproximityprompt(rPrompt, 0)
                                            local finalEPart, finalEPrompt = getPrompt('EndRelic' .. i)
                                            if finalEPart and finalEPrompt then
                                                Tween(finalEPart.CFrame)
                                                repeat
                                                    task.wait()
                                                until (hrp.Position-finalEPart.Position).Magnitude <= 5
                                                fireproximityprompt(finalEPrompt, 0)
                                            end
                                            return
                                        elseif ePart and ePrompt then
                                            Tween(ePart.CFrame)
                                            repeat
                                                task.wait()
                                            until (hrp.Position-ePart.Position).Magnitude <= 5
                                            fireproximityprompt(ePrompt, 0)
                                            return
                                        end
                                    end
                                    local door = draco:FindFirstChild('TrialDoor')
                                    local touch = door and door:FindFirstChild('DoorTouch')
                                    if touch then
                                        Tween(touch.CFrame)
                                    end
                                end
                            end
                        end
                    end
                    local Vim = game:GetService('VirtualInputManager')
                    local Lp = game:GetService('Players').LocalPlayer
                    local Last = {
                        Z = 0,
                        X = 0,
                        C = 0,
                    }
                    local Keys = {
                        Z = Enum.KeyCode.Z,
                        X = Enum.KeyCode.X,
                        C = Enum.KeyCode.C,
                    }
                    if _G.AutoKillTrial then
                        for _, v in pairs(workspace.Characters:GetChildren())do
                            if v:IsA('Model') and v:FindFirstChild('HumanoidRootPart') and v:FindFirstChild('Humanoid') and v.Name ~= Lp.Name and v.Humanoid.Health > 0 then
                                local HRP = Lp.Character and Lp.Character:FindFirstChild('HumanoidRootPart')
                                if HRP and (v.HumanoidRootPart.Position-HRP.Position).Magnitude <= 150 then
                                    local Gui = Lp:FindFirstChild('PlayerGui')
                                    local RT = Gui and Gui:FindFirstChild('Main') and Gui.Main:FindFirstChild('TopHUDList') and Gui.Main.TopHUDList:FindFirstChild('RaidTimer')
                                    if RT and RT.Visible then
                                        repeat
                                            task.wait()
                                            AutoHaki()
                                            Equip(SelectWeapon)
                                            AutoRaceV3()
                                            NameTarget = v.Name
                                            Tween(v.HumanoidRootPart.CFrame + Pos)
                                            local Tool = Lp.Character:FindFirstChild(SelectWeapon) or Lp.Character:FindFirstChildOfClass('Tool')
                                            local DidSkill = false
                                            if Tool and Tool:FindFirstChild('Data') then
                                                local ok, Info = pcall(require, Tool.Data)
                                                if ok and Info and Info.Cooldown then
                                                    local Now = os.clock()
                                                    for _, k in ipairs({
                                                        'Z',
                                                        'X',
                                                        'C',
                                                    })do
                                                        if (Now-Last[k]) >= Info.Cooldown[k] then
                                                            if Tool:FindFirstChild('RemoteEvent') then
                                                                Tool.RemoteEvent:FireServer(v.HumanoidRootPart.Position)
                                                            end
                                                            Vim:SendKeyEvent(true, Keys[k], false, game)
                                                            task.wait(0.05)
                                                            Vim:SendKeyEvent(false, Keys[k], false, game)
                                                            Last[k] = Now
                                                            DidSkill = true
                                                            break
                                                        end
                                                    end
                                                end
                                            end
                                            if not DidSkill then
                                                Attack()
                                            end
                                        until not _G.AutoKillTrial or not v.Parent or v.Humanoid.Health <= 0 or not RT.Visible
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    Players = game:GetService('Players')
    LocalPlayer = Players.LocalPlayer
    local CommF_ = ReplicatedStorage:WaitForChild('Remotes'):WaitForChild('CommF_')
    local Net = ReplicatedStorage:WaitForChild('Modules'):FindFirstChild('Net')
    if Sea1 then
        Tabs.Shop:Button({
            Title = 'Buy Cutlass',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Cutlass')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Geppo',
            Callback = function()
                CommF_:InvokeServer('BuyHaki', 'Geppo')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Buso',
            Callback = function()
                CommF_:InvokeServer('BuyHaki', 'Buso')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Soru',
            Callback = function()
                CommF_:InvokeServer('BuyHaki', 'Soru')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Ken',
            Callback = function()
                CommF_:InvokeServer('KenTalk', 'Buy')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Katana',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Katana')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Iron Mace',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Iron Mace')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Dual Katana',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Duel Katana')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Triple Katana',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Triple Katana')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Pipe',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Pipe')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Dual-Headed Blade',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Dual-Headed Blade')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Bisento',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Bisento')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Soul Cane',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Soul Cane')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Black Cape',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Black Cape')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Swordsman Hat',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Swordsman Hat')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Tomoe Ring',
            Callback = function()
                CommF_:InvokeServer('BuyItem', 'Tomoe Ring')
            end,
        })
    end
    if Sea1 or Sea2 or Sea3 then
        if not Sea1 then
            Tabs.Shop:Button({
                Title = 'Buy Geppo',
                Callback = function()
                    CommF_:InvokeServer('BuyHaki', 'Geppo')
                end,
            })
            Tabs.Shop:Button({
                Title = 'Buy Buso',
                Callback = function()
                    CommF_:InvokeServer('BuyHaki', 'Buso')
                end,
            })
            Tabs.Shop:Button({
                Title = 'Buy Soru',
                Callback = function()
                    CommF_:InvokeServer('BuyHaki', 'Soru')
                end,
            })
            Tabs.Shop:Button({
                Title = 'Buy Ken',
                Callback = function()
                    CommF_:InvokeServer('KenTalk', 'Buy')
                end,
            })
        end
        Tabs.Shop:Button({
            Title = 'Buy Black Leg',
            Callback = function()
                CommF_:InvokeServer('BuyBlackLeg')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Electro',
            Callback = function()
                CommF_:InvokeServer('BuyElectro')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Fishman Karate',
            Callback = function()
                CommF_:InvokeServer('BuyFishmanKarate')
            end,
        })
        Tabs.Stats:Button({
            Title = 'Reset Stats',
            Callback = function()
                CommF_:InvokeServer('BlackbeardReward', 'Refund', '1')
                CommF_:InvokeServer('BlackbeardReward', 'Refund', '2')
            end,
        })
    end
    if Sea2 or Sea3 then
        Tabs.Shop:Button({
            Title = 'Buy Pole V2',
            Callback = function()
                CommF_:InvokeServer('ThunderGodTalk')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Dragon Claw',
            Callback = function()
                CommF_:InvokeServer('BlackbeardReward', 'DragonClaw', '1')
                CommF_:InvokeServer('BlackbeardReward', 'DragonClaw', '2')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Superhuman',
            Callback = function()
                CommF_:InvokeServer('BuySuperhuman')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Death Step',
            Callback = function()
                CommF_:InvokeServer('BuyDeathStep')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Sharkman Karate',
            Callback = function()
                CommF_:InvokeServer('BuySharkmanKarate', true)
                CommF_:InvokeServer('BuySharkmanKarate')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Change Race Normal',
            Callback = function()
                pcall(function()
                    CommF_:InvokeServer('BlackbeardReward', 'Reroll', '1')
                    CommF_:InvokeServer('BlackbeardReward', 'Reroll', '2')
                end)
            end,
        })
        Tabs.Shop:Button({
            Title = 'Change Race Ghoul',
            Callback = function()
                pcall(function()
                    CommF_:InvokeServer('Ectoplasm', 'Change', 4)
                end)
            end,
        })
        Tabs.Shop:Button({
            Title = 'Change Race Cyborg',
            Callback = function()
                pcall(function()
                    CommF_:InvokeServer('CyborgTrainer', 'Buy')
                end)
            end,
        })
    end
    if Sea2 then
        Tabs.Shop:Button({
            Title = 'Buy Kabucha',
            Callback = function()
                CommF_:InvokeServer('BlackbeardReward', 'Slingshot', '2')
            end,
        })
    end
    if Sea3 then
        Tabs.Shop:Button({
            Title = 'Buy Electric Claw',
            Callback = function()
                CommF_:InvokeServer('BuyElectricClaw')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Dragon Talon',
            Callback = function()
                CommF_:InvokeServer('BuyDragonTalon')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Godhuman',
            Callback = function()
                CommF_:InvokeServer('BuyGodhuman')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Buy Sanguine Art',
            Callback = function()
                CommF_:InvokeServer('BuySanguineArt')
            end,
        })
        Tabs.Shop:Button({
            Title = 'Change Race Draco',
            Callback = function()
                pcall(function()
                    CommF_:InvokeServer('requestEntrance', Vector3.new(5661.532, 1013.09,-334.965))
                    Tween(CFrame.new(5814.427, 1208.327, 884.579))
                    local targetPosition = Vector3.new(5814.427, 1208.327, 884.579)
                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    repeat
                        task.wait()
                    until (character:WaitForChild('HumanoidRootPart').Position-targetPosition).Magnitude < 5
                    Net:FindFirstChild('RF/InteractDragonQuest'):InvokeServer({
                        NPC = 'Dragon Wizard',
                        Command = 'DragonRace',
                    })
                end)
            end,
        })
    end
    local ServerBrowser = ReplicatedStorage:WaitForChild('__ServerBrowser', 10)
    local JobInputValue = ''
    local ServerHistoryPath = 'Solarix Hub/assets/Servers.json'
    local ServerHistory = {}
    pcall(function()
        if isfile and isfile(ServerHistoryPath) then
            local Data = readfile(ServerHistoryPath)
            if Data and Data ~= '' then
                ServerHistory = HttpService:JSONDecode(Data)
            end
        end
    end)
    local function SaveServerId(ServerId)
        ServerId = tostring(ServerId or '')
        if ServerId == '' then
            return
        end
        for _, Id in ipairs(ServerHistory) do
            if tostring(Id) == ServerId then
                return
            end
        end
        table.insert(ServerHistory, ServerId)
        pcall(function()
            if makefolder and not isfolder('Solarix Hub') then
                makefolder('Solarix Hub')
            end
            if makefolder and not isfolder('Solarix Hub/assets') then
                makefolder('Solarix Hub/assets')
            end
            if writefile then
                writefile(ServerHistoryPath, HttpService:JSONEncode(ServerHistory))
            end
        end)
    end
    local function JoinedServer(ServerId)
        ServerId = tostring(ServerId or '')
        for _, Id in ipairs(ServerHistory) do
            if tostring(Id) == ServerId then
                return true
            end
        end
        return false
    end
    local function GetServerBrowser()
        if ServerBrowser and ServerBrowser.Parent then
            return ServerBrowser
        end
        ServerBrowser = ReplicatedStorage:FindFirstChild('__ServerBrowser')
        return ServerBrowser
    end
    local BrowserBusy = false
    local function BrowserTeleport(ServerId)
        if BrowserBusy then
            return
        end
        local Browser = GetServerBrowser()
        if not Browser then
            return
        end
        BrowserBusy = true
        task.spawn(function()
            local TargetId = tostring(ServerId or '')
            if TargetId == '' then
                local Success, CurrentJob = pcall(function()
                    return Browser:InvokeServer('getjob')
                end)
                if Success and CurrentJob then
                    TargetId = tostring(CurrentJob)
                end
            end
            if TargetId ~= '' then
                pcall(function()
                    Browser:InvokeServer('teleport', TargetId)
                end)
            end
            task.wait(2)
            BrowserBusy = false
        end)
    end
    local function BrowserKickHop()
        if BrowserBusy then
            return
        end
        BrowserTeleport()
    end
    local AutoRejoinHooked = false
    local function HookAutoRejoinKick()
        if AutoRejoinHooked then
            return
        end
        AutoRejoinHooked = true
        if hookmetamethod then
            local OldNamecall
            OldNamecall = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
                local Method = getnamecallmethod()
                if _G.AutoRejoin and tostring(Method):lower() == 'kick' then
                    BrowserKickHop()
                    return
                end
                return OldNamecall(self, ...)
            end))
            return
        end
        if getrawmetatable and setreadonly then
            local Metatable = getrawmetatable(game)
            local OldNamecall = Metatable.__namecall
            setreadonly(Metatable, false)
            Metatable.__namecall = newcclosure(function(self, ...)
                local Method = getnamecallmethod()
                if _G.AutoRejoin and tostring(Method):lower() == 'kick' then
                    BrowserKickHop()
                    return
                end
                return OldNamecall(self, ...)
            end)
            setreadonly(Metatable, true)
        end
    end
    HookAutoRejoinKick()
    local function HopServer(LowServer)
        task.spawn(function()
            local Cursor = ''
            while task.wait() do
                local Url = 'https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=100'
                if Cursor ~= '' then
                    Url = Url .. '&cursor=' .. Cursor
                end
                local Success, Result = pcall(function()
                    return HttpService:JSONDecode(game:HttpGet(Url))
                end)
                if not Success or not Result or not Result.data then
                    return
                end
                local Target = nil
                if LowServer then
                    for i = #Result.data, 1, -1 do
                        local Server = Result.data[i]
                        local Playing = tonumber(Server.playing)
                        local MaxPlayers = tonumber(Server.maxPlayers)
                        local Id = tostring(Server.id)
                        if Playing and MaxPlayers and Playing <= 2 and Playing < MaxPlayers and not JoinedServer(Id) then
                            Target = Server
                            break
                        end
                    end
                else
                    for _, Server in ipairs(Result.data) do
                        local Playing = tonumber(Server.playing)
                        local MaxPlayers = tonumber(Server.maxPlayers)
                        local Id = tostring(Server.id)
                        if Playing and MaxPlayers and Playing < MaxPlayers and not JoinedServer(Id) then
                            Target = Server
                            break
                        end
                    end
                end
                if Target then
                    SaveServerId(Target.id)
                    BrowserTeleport(Target.id)
                    return
                end
                Cursor = Result.nextPageCursor or ''
                if Cursor == '' then
                    return
                end
            end
        end)
    end
    Tabs.Misc:Button({
        Title = 'Rejoin',
        Callback = function()
            BrowserTeleport()
        end,
    })
    Tabs.Misc:Button({
        Title = 'Copy Job ID',
        Callback = function()
            SetClip(tostring(game.JobId))
        end,
    })
    Tabs.Misc:Input({
        Title = 'Join Job ID',
        Value = '',
        Placeholder = 'Paste Job ID here...',
        Callback = function(Value)
            JobInputValue = tostring(Value or '')
        end,
    })
    Tabs.Misc:Button({
        Title = 'Join Server',
        Callback = function()
            BrowserTeleport(JobInputValue)
        end,
    })
    Tabs.Misc:Button({
        Title = 'Hop Server',
        Callback = function()
            HopServer(false)
        end,
    })
    Tabs.Misc:Button({
        Title = 'Hop Low Server',
        Callback = function()
            HopServer(true)
        end,
    })
    Tabs.Misc:Toggle({
        Title = 'Auto Rejoin',
        Value = false,
        Callback = function(Value)
            _G.AutoRejoin = Value
        end,
    })
    local PromptGui = CoreGui:FindFirstChild('RobloxPromptGui')
    local PromptOverlay = PromptGui and PromptGui:FindFirstChild('promptOverlay')
    if PromptOverlay then
        PromptOverlay.ChildAdded:Connect(function(Child)
            if _G.AutoRejoin and Child.Name == 'ErrorPrompt' then
                BrowserKickHop()
            end
        end)
    end
    Tabs.Misc:Button({
        Title = 'Pirate',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetTeam', 'Pirates')
        end,
    })
    Tabs.Misc:Button({
        Title = 'Marine',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetTeam', 'Marines')
        end,
    })
    Tabs.Misc:Button({
        Title = 'Redeem Codes',
        Callback = function()
            local RedeemRemote = ReplicatedStorage.Remotes:FindFirstChild('Redeem')
            if not RedeemRemote then
                return
            end
            task.spawn(function()
                local Success, Result = pcall(function()
                    return game:HttpGet('https://github.com/SolarixHubAcademy/SolarixHub/raw/refs/heads/main/Code.json')
                end)
                if Success and Result then
                    local DecodeSuccess, Codes = pcall(function()
                        return HttpService:JSONDecode(Result)
                    end)
                    if DecodeSuccess and Codes then
                        for _, Code in ipairs(Codes) do
                            task.spawn(function()
                                pcall(function()
                                    RedeemRemote:InvokeServer(Code)
                                end)
                            end)
                        end
                    end
                end
            end)
        end,
    })
    Tabs.Misc:Dropdown({
        Title = 'Select Dealer Type',
        Values = {
            'Advanced Fruit Dealer',
            'Blox Fruit Dealer',
        },
        Multi = false,
        Callback = function(Value)
            selectedDealerType = Value
        end,
    })
    Tabs.Misc:Button({
        Title = 'Open Dealer UI',
        Callback = function()
            if selectedDealerType == 'Blox Fruit Dealer' then
                require(game:GetService('ReplicatedStorage').Controllers.UI.FruitShop):Open('FruitDealer')
            elseif selectedDealerType == 'Advanced Fruit Dealer' then
                require(game:GetService('ReplicatedStorage').Controllers.UI.FruitShop):Open('AdvancedFruitDealer')
            end
        end,
    })
    if Sea2 or Sea3 then
        Tabs.Misc:Button({
            Title = 'Title',
            Callback = function()
                local TitlesMenu = game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('TitlesMenu')
                TitlesMenu.Open:Fire()
            end,
        })
        Tabs.Misc:Button({
            Title = 'Awaken',
            Callback = function()
                local playerGui = game:GetService('Players').LocalPlayer:FindFirstChild('PlayerGui')
                if playerGui then
                    local mainGui = playerGui:FindFirstChild('Main')
                    if mainGui then
                        local awakeningToggler = mainGui:FindFirstChild('AwakeningToggler')
                        if awakeningToggler then
                            awakeningToggler.Visible = true
                        end
                    end
                end
            end,
        })
    end
    Lighting = game:GetService('Lighting')
    Workspace = game:GetService('Workspace')
    local Terrain = Workspace:WaitForChild('Terrain')
    local lightingLayers = Lighting:FindFirstChild('LightingLayers')
    if lightingLayers then
        lightingLayers:ClearAllChildren()
    end
    local effectsToRemove = {
        'BaseAtmosphere',
        'SeaTerrorCC',
        'SeaKitsuneCC',
    }
    for _, name in ipairs(effectsToRemove)do
        local effect = Lighting:FindFirstChild(name)
        if effect then
            effect:Destroy()
        end
    end
    if Terrain:GetAttribute('SeaTheme') then
        Terrain:SetAttribute('SeaTheme', 'Default')
    end
    if Workspace.Gravity ~= 196.2 then
        Workspace.Gravity = 196.2
    end
    Tabs.Misc:Toggle({
        Title = 'Remove Notify',
        Value = false,
        Callback = function(Value)
            _G.RemoveNotify = Value
        end,
    })
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            pcall(function()
                if _G.RemoveNotify then
                    game:GetService('Players').LocalPlayer.PlayerGui.Notifications.Enabled = false
                else
                    game:GetService('Players').LocalPlayer.PlayerGui.Notifications.Enabled = true
                end
            end)
        end
    end)
    if Sea3 then
        Tabs.Shop:Button({
            Title = 'Buy Chip Leviathan',
            Callback = function()
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('InfoLeviathan', '2')
            end,
        })
        Tabs.Travel:Toggle({
            Title = 'Teleport To Frozen Dimension',
            Value = false,
            Callback = function(Value)
                _G.TweenToFrozenDimension = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.TweenToFrozenDimension) then continue end
                if _G.TweenToFrozenDimension then
                    local frozenWatcher = game:GetService('ReplicatedStorage').NPCs:FindFirstChild('Frozen Watcher')
                    if frozenWatcher and frozenWatcher:IsA('Model') and frozenWatcher.PrimaryPart then
                        Tween(CFrame.new(frozenWatcher.PrimaryPart.Position))
                    end
                end
            end
        end)
    end
    ReplicatedStorage = game:GetService('ReplicatedStorage')
    Workspace = game:GetService('Workspace')
    Lighting = game:GetService('Lighting')
    local Remotes = ReplicatedStorage.Remotes
    local Event = Remotes.CommF_
    local PhaseMap = {
        ['http://www.roblox.com/asset/?id=9709149680'] = {
            name = '15%',
            order = 1,
        },
        ['http://www.roblox.com/asset/?id=9709150401'] = {
            name = '25%',
            order = 2,
        },
        ['http://www.roblox.com/asset/?id=9709143733'] = {
            name = '50%',
            order = 3,
        },
        ['http://www.roblox.com/asset/?id=9709149052'] = {
            name = '75%',
            order = 4,
        },
        ['http://www.roblox.com/asset/?id=9709149431'] = {
            name = '100%',
            order = 5,
        },
    }
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            pcall(function()
                local moonTextureId = ''
                local fantasySky = Lighting:FindFirstChild('FantasySky')
                local normalSky = Lighting:FindFirstChild('Sky')
                if fantasySky then
                    moonTextureId = fantasySky.MoonTextureId
                elseif normalSky then
                    moonTextureId = normalSky.MoonTextureId
                end
                local phase = PhaseMap[moonTextureId]
                if phase then
                    Status:Set('Moon Phase: ' .. phase.name)
                else
                    Status:Set('Moon Phase: 0%')
                end
                local kenResult = Event:InvokeServer('KenTalk', 'Status')
                if kenResult then
                    local kenExp = string.match(tostring(kenResult), '%d+')
                    if kenExp then
                        Status:Set('Observation: ' .. kenExp)
                    else
                        Status:Set('Observation: ' .. tostring(kenResult))
                    end
                end
                if Sea3 then
                    if Workspace._WorldOrigin.Locations:FindFirstChild('Kitsune Island') then
                        Status:Set('Kitsune Island: Spawned')
                    else
                        Status:Set('Kitsune Island: Not Found')
                    end
                    if Workspace.Map:FindFirstChild('MysticIsland') then
                        Status:Set('Mirage Island: Spawned')
                    else
                        Status:Set('Mirage Island: Not Found')
                    end
                    local Map = Workspace:FindFirstChild('Map')
                    if Map and Map:FindFirstChild('LeviathanGate') then
                        Status:Set('Frozen Dimension: Spawned')
                    else
                        Status:Set('Frozen Dimension: Not Found')
                    end
                end
            end)
        end
    end)
    if Sea2 or Sea3 then
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    local colorName, rarityIndex = Event:InvokeServer('ColorsDealer', '1')
                    if type(colorName) == 'string' then
                        Status:Set('Haki Dealer: ' .. colorName)
                    else
                        Status:Set('Haki Dealer: Not Found')
                    end
                end)
            end
        end)
    end
    if Sea2 then
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    local swordResult = Event:InvokeServer('LegendarySwordDealer', '1')
                    if type(swordResult) == 'string' then
                        Status:Set('Sword Dealer: ' .. swordResult)
                    else
                        Status:Set('Sword Dealer: Not Found')
                    end
                end)
            end
        end)
    end
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            pcall(function()
                local res = game:GetService('ReplicatedStorage').Modules.Net['RF/DungeonNPCNetworkFunction']:InvokeServer('GetDungeonEnergy')
                local txt = res.Text[1]
                Status:Set('Energy: ' .. (txt:match('(%d+) energy') or '0') .. ' | Time Full: ' .. (txt:match('(%d+:%d+:%d+)') or 'Full'))
            end)
        end
    end)
    task.spawn(function()
        while task.wait() do
            SolarixStreamDelay(0.35)
            pcall(function()
                local bushes = game:GetService('CollectionService'):GetTagged('BerryBush')
                local counts = {}
                local hasBerry = false
                if #bushes > 0 then
                    for _, bush in pairs(bushes)do
                        for _, berryName in pairs(bush:GetAttributes())do
                            if type(berryName) == 'string' then
                                counts[berryName] = (counts[berryName] or 0) + 1
                                hasBerry = true
                            end
                        end
                    end
                end
                if hasBerry then
                    local displayList = {}
                    for name, count in pairs(counts)do
                        if count > 1 then
                            table.insert(displayList, name .. ' (x' .. count .. ')')
                        else
                            table.insert(displayList, name)
                        end
                    end
                    table.sort(displayList)
                    Status:Set('Berry Status: ' .. table.concat(displayList, ', '))
                else
                    Status:Set('Berry Status: Not Found')
                end
            end)
        end
    end)
    if Sea3 then
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    local Enemies = Workspace:FindFirstChild('Enemies')
                    local hasEliteBoss = ReplicatedStorage:FindFirstChild('Diablo') or ReplicatedStorage:FindFirstChild('Deandre') or ReplicatedStorage:FindFirstChild('Urban') or (Enemies and (Enemies:FindFirstChild('Diablo') or Enemies:FindFirstChild('Deandre') or Enemies:FindFirstChild('Urban')))
                    local progress = Event:InvokeServer('EliteHunter', 'Progress')
                    if hasEliteBoss then
                        Status:Set('Elite Hunter: Spawned | Killed: ' .. progress)
                    else
                        Status:Set('Elite Hunter: Not Found | Killed: ' .. progress)
                    end
                    local bribeStatus = Event:InvokeServer('InfoLeviathan', '1')
                    if bribeStatus == 5 then
                        Status:Set('Leviathan: Out There')
                    elseif bribeStatus <= 0 then
                        Status:Set("Leviathan: I don't know")
                    else
                        Status:Set('Leviathan: Need Bribe')
                    end
                end)
            end
        end)
        Tabs.Sea:Toggle({
            Title = 'Auto Blaze Ember',
            Value = false,
            Callback = function(toggleValue)
                _G.AutoFarmBlazeEmber = toggleValue
            end,
        })
        function getBlazeEmberQuest()
            local res = game:GetService('ReplicatedStorage').Modules.Net['RF/DragonHunter']:InvokeServer({
                Context = 'Check',
            })
            if res then
                for k, v in pairs(res)do
                    if k == 'Text' then
                        return v
                    end
                end
            end
        end
        function getRequestQuest()
            return game:GetService('ReplicatedStorage').Modules.Net['RF/DragonHunter']:InvokeServer({
                Context = 'RequestQuest',
            })
        end
        function getIsOnQuest()
            local res = game:GetService('ReplicatedStorage').Modules.Net['RF/DragonHunter']:InvokeServer({
                Context = 'Check',
            })
            if res then
                for k, v in pairs(res)do
                    if k == 'Text' and (string.find(v, 'Venomous Assailant') or string.find(v, 'Hydra Enforcer') or string.find(v, 'Destroy 10 trees')) then
                        return true
                    end
                end
            end
            return false
        end
        function SaveBlazeEmberQuest()
            local quest = getBlazeEmberQuest()
            if string.find(quest, 'Venomous Assailant') then
                _G.BlazeEmberQuest = 'Venomous Assailant'
            elseif string.find(quest, 'Hydra Enforcer') then
                _G.BlazeEmberQuest = 'Hydra Enforcer'
            elseif string.find(quest, 'Destroy 10 trees') then
                _G.BlazeEmberQuest = 'Destroy 10 trees'
            end
        end
        function isQuestCompleated()
            for _, v in pairs(game:GetService('Players').LocalPlayer.PlayerGui.Notifications:GetChildren())do
                for _, notif in pairs(v:GetChildren())do
                    if string.find(notif.Text, 'Task completed!') or string.find(notif.Text, 'Head back to the Dojo') then
                        return true
                    end
                end
            end
            return false
        end
        function CollectBlazeEmber()
            game:GetService('ReplicatedStorage').Modules.Net['RE/DragonDojoEmber']:FireServer()
        end
        function autoKillVenemousAssailant()
            local enemies = game:GetService('Workspace').Enemies
            if not enemies:FindFirstChild('Venomous Assailant') then
                Tween(CFrame.new(4789.29639, 1078.59082, 962.764099))
            else
                for _, v in pairs(enemies:GetChildren())do
                    if v.Name == 'Venomous Assailant' and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            Attack()
                            AutoHaki()
                            Equip(SelectWeapon)
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                        until not v.Parent or v.Humanoid.Health <= 0 or not _G.AutoFarmBlazeEmber or not _G.OnBlzeQuest
                    end
                end
            end
        end
        function autoKillHydraEnforcer()
            local enemies = game:GetService('Workspace').Enemies
            if not enemies:FindFirstChild('Hydra Enforcer') then
                Tween(CFrame.new(4789.29639, 1078.59082, 962.764099))
            else
                for _, v in pairs(enemies:GetChildren())do
                    if v.Name == 'Hydra Enforcer' and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            Attack()
                            AutoHaki()
                            Equip(SelectWeapon)
                            Tween(v.HumanoidRootPart.CFrame + Pos)
                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                        until not v.Parent or v.Humanoid.Health <= 0 or not _G.AutoFarmBlazeEmber or not _G.OnBlzeQuest
                    end
                end
            end
        end
        function autoDestroyHydraTrees()
            local posList = {
                CFrame.new(5260.28223, 1004.24329, 347.062622),
                CFrame.new(5237.94775, 1004.24329, 429.596344),
                CFrame.new(5320.87793, 1004.24329, 439.152954),
                CFrame.new(5346.70752, 1004.24329, 359.389008),
            }
            local myPos = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame.Position
            for _, pos in ipairs(posList)do
                if (myPos-pos.Position).Magnitude <= 10 then
                    CallSkills()
                else
                    Tween(pos)
                end
            end
        end
        _G.OnBlzeQuest = false
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFarmBlazeEmber) then continue end
                if _G.AutoFarmBlazeEmber then
                    pcall(function()
                        if not _G.OnBlzeQuest and not getIsOnQuest() then
                            Tween(CFrame.new(5864.86377, 1209.55066, 812.775024))
                            getRequestQuest()
                        end
                        SaveBlazeEmberQuest()
                        _G.OnBlzeQuest = true
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(isQuestCompleated()) then continue end
                if isQuestCompleated() then
                    _G.OnBlzeQuest = false
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFarmBlazeEmber) then continue end
                if _G.AutoFarmBlazeEmber then
                    pcall(function()
                        if _G.BlazeEmberQuest == 'Venomous Assailant' and _G.OnBlzeQuest then
                            autoKillVenemousAssailant()
                        elseif _G.BlazeEmberQuest == 'Hydra Enforcer' and _G.OnBlzeQuest then
                            autoKillHydraEnforcer()
                        elseif _G.BlazeEmberQuest == 'Destroy 10 trees' and _G.OnBlzeQuest then
                            autoDestroyHydraTrees()
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFarmBlazeEmber) then continue end
                if _G.AutoFarmBlazeEmber then
                    pcall(function()
                        CollectBlazeEmber()
                    end)
                end
            end
        end)
        local CraftItems = {
            ['Volcanic Magnet'] = 'Volcanic Magnet',
            ['Dino Hood'] = 'DinoHood',
            ['T-Rex Skull'] = 'TRexSkull',
            ['Common Scroll'] = 'CommonScroll',
            ['Monster Magnet'] = 'MonsterMagnet',
            ['Terror Jaw'] = 'TerrorJaw',
            ['Tooth Necklace'] = 'ToothNecklace',
            ['Beast Hunter'] = 'BeastHunter',
            ['Leviathan Shield'] = 'LeviathanShield',
            ['Leviathan Crown'] = 'LeviathanCrown',
            ['Mythical Scroll'] = 'MythicalScroll',
            ['Legendary Scroll'] = 'LegendaryScroll',
            ['Rare Scroll'] = 'RareScroll',
        }
        local SelectedCraftItem = nil
        local CraftItemNames = {}
        for itemName, _ in pairs(CraftItems)do
            table.insert(CraftItemNames, itemName)
        end
        Tabs.Sea:Dropdown({
            Title = 'Select Item to Craft',
            Values = CraftItemNames,
            Multi = false,
            Callback = function(Value)
                SelectedCraftItem = CraftItems[Value]
            end,
        })
        Tabs.Sea:Button({
            Title = 'Craft Item',
            Callback = function()
                if SelectedCraftItem then
                    game:GetService('ReplicatedStorage').Modules.Net:FindFirstChild('RF/Craft'):InvokeServer('Craft', SelectedCraftItem)
                end
            end,
        })
        local npcPosition = Vector3.new(-16665.191, 104.596, 1579.694)
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    if workspace:FindFirstChild('Map') and workspace.Map:FindFirstChild('PrehistoricIsland') then
                        Status:Set('Prehistoric: Spawned')
                    else
                        Status:Set('Prehistoric: Not Found')
                    end
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild('HumanoidRootPart') then
                        local distToNpc = (char.HumanoidRootPart.Position-npcPosition).Magnitude
                        local scaledDist = math.floor(distToNpc / 10)
                        Status:Set('Tiki Distance: ' .. scaledDist .. ' m')
                    else
                        Status:Set('Tiki Distance: N/A')
                    end
                    local tyrant = workspace:FindFirstChild('Enemies') and workspace.Enemies:FindFirstChild('Tyrant of the Skies')
                    if tyrant then
                        Status:Set('Tyrant Skies: Spawned')
                    else
                        local map = workspace:FindFirstChild('Map')
                        local count = 0
                        if map then
                            local tikiOutpost = map:FindFirstChild('TikiOutpost')
                            if tikiOutpost then
                                local islandModel = tikiOutpost:FindFirstChild('IslandModel')
                                local islandChunks = islandModel and islandModel:FindFirstChild('IslandChunks') and islandModel.IslandChunks:FindFirstChild('E')
                                if islandModel then
                                    for i = 1, 2 do
                                        local eye = islandModel:FindFirstChild('Eye' .. i)
                                        if eye and eye:IsA('BasePart') and eye.Transparency == 0 then
                                            count = count + 1
                                        end
                                    end
                                end
                                if islandChunks then
                                    for i = 3, 4 do
                                        local eye = islandChunks:FindFirstChild('Eye' .. i)
                                        if eye and eye:IsA('BasePart') and eye.Transparency == 0 then
                                            count = count + 1
                                        end
                                    end
                                end
                                Status:Set('Tyrant Skies: ' .. count .. '/4')
                            else
                                Status:Set('Tyrant Skies: 0/4')
                            end
                        else
                            Status:Set('Tyrant Skies: 0/4')
                        end
                    end
                end)
            end
        end)
        Tabs.Travel:Toggle({
            Title = 'Teleport To Prehistoric Island',
            Value = false,
            Callback = function(Value)
                _G.TweenToPrehistoric = Value
            end,
        })
        task.spawn(function()
            local island = game:GetService('Workspace').Map:WaitForChild('PrehistoricIsland')
            while task.wait() do
                if not SolarixStream(_G.TweenToPrehistoric) then continue end
                if _G.TweenToPrehistoric then
                    local prehistoricIslandCore = game:GetService('Workspace').Map:FindFirstChild('PrehistoricIsland')
                    if prehistoricIslandCore then
                        local relic = prehistoricIslandCore:FindFirstChild('Core') and prehistoricIslandCore.Core:FindFirstChild('PrehistoricRelic')
                        local skull = relic and relic:FindFirstChild('Skull')
                        if skull then
                            Tween(CFrame.new(skull.Position))
                        end
                    end
                end
            end
        end)
        Tabs.Sea:Toggle({
            Title = 'Patch Volcano',
            Value = false,
            Callback = function(v)
                _G.AutoVolcanic = v
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoVolcanic) then continue end
                if _G.AutoVolcanic then
                    local map = workspace.Map:FindFirstChild('PrehistoricIsland')
                    local core = map and map:FindFirstChild('Core')
                    local lp = game.Players.LocalPlayer
                    local root = lp.Character and lp.Character:FindFirstChild('HumanoidRootPart')
                    if core and root then
                        local activeRock = nil
                        if core:FindFirstChild('VolcanoRocks') then
                            for _, r in pairs(core.VolcanoRocks:GetChildren())do
                                local t = r:FindFirstChild('volcanorock') or r:FindFirstChild('VFXLayer')
                                if t and (t.Color == Color3.fromRGB(185, 53, 56) or t.Color == Color3.fromRGB(185, 53, 57)) then
                                    activeRock = t
                                    break
                                end
                            end
                        end
                        local prompt = nil
                        if not activeRock and core:FindFirstChild('ActivationPrompt') then
                            prompt = core.ActivationPrompt:FindFirstChild('ProximityPrompt')
                        end
                        if activeRock then
                            Tween(activeRock.CFrame)
                            CallSkills()
                        elseif prompt and prompt.Parent then
                            Tween(CFrame.new(prompt.Parent.Position))
                            if (prompt.Parent.Position-root.Position).Magnitude < 10 then
                                fireproximityprompt(prompt, 0)
                            end
                        else
                            local skull = core:FindFirstChild('PrehistoricRelic') and core.PrehistoricRelic:FindFirstChild('Skull')
                            if skull then
                                Tween(CFrame.new(skull.Position))
                            end
                        end
                    end
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoVolcanic) then continue end
                if _G.AutoVolcanic then
                    pcall(function()
                        local map = workspace.Map:FindFirstChild('PrehistoricIsland')
                        local core = map and map:FindFirstChild('Core')
                        if core and core:FindFirstChild('InteriorLava') then
                            core.InteriorLava:Destroy()
                        end
                        if map then
                            for _, v in pairs(map:GetDescendants())do
                                if v:IsA('BasePart') and v.Name:lower():find('lava') then
                                    v:Destroy()
                                end
                            end
                        end
                        for _, v in pairs(workspace.Enemies:GetChildren())do
                            if v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                                sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
                                v.Humanoid.Health = 0
                                v.HumanoidRootPart.CanCollide = false
                            end
                        end
                    end)
                end
            end
        end)
        Tabs.Sea:Toggle({
            Title = 'Attack Leviathan',
            Value = false,
            Callback = function(v)
                _G.AttackLeviathan = v
                if _G.AttackLeviathan then
                    ReplicatedStorage = game:GetService('ReplicatedStorage')
                    local EffectContainer = ReplicatedStorage:WaitForChild('Effect'):WaitForChild('Container'):WaitForChild('Leviathan')
                    local Targets = {
                        'Tornado',
                        'Splash',
                        'IceWave2',
                        'IceWave',
                        'IceBlock',
                        'FreezeBlast',
                    }
                    for _, ModuleName in ipairs(Targets)do
                        local Module = EffectContainer:WaitForChild(ModuleName)
                        hookfunction(require(Module), function() end)
                    end
                    local TargetModule = game:GetService('Players').LocalPlayer.PlayerScripts.LeviathanCinematicc.Intro
                    local old_require
                    old_require = hookfunction(require, function(module)
                        if module == TargetModule then
                            error()
                        end
                        return old_require(module)
                    end)
                    pcall(function()
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer('OpenLeviathanGate')
                    end)
                end
                task.spawn(function()
                    while task.wait() do
                        if not SolarixStream(_G.AttackLeviathan) then continue end
                        if _G.AttackLeviathan then
                            local player = game.Players.LocalPlayer
                            local character = player.Character
                            local hrp = character and character:FindFirstChild('HumanoidRootPart')
                            local hum = character and character:FindFirstChild('Humanoid')
                            if hrp and hum and hum.Health > 0 then
                                local seaBeasts = workspace:FindFirstChild('SeaBeasts')
                                local targetPart = nil
                                local minDist = math.huge
                                if seaBeasts then
                                    for _, obj in pairs(seaBeasts:GetChildren())do
                                        if obj.Name == 'Leviathan Segment' and obj:FindFirstChild('HumanoidRootPart') and obj:FindFirstChild('Humanoid') and obj.Humanoid.Health > 0 then
                                            local dist = (obj.HumanoidRootPart.Position-hrp.Position).Magnitude
                                            if dist < minDist then
                                                minDist = dist
                                                targetPart = obj.HumanoidRootPart
                                            end
                                        end
                                    end
                                    if not targetPart then
                                        local tail = seaBeasts:FindFirstChild('Leviathan Tail')
                                        if tail and tail:FindFirstChild('HumanoidRootPart') and tail:FindFirstChild('Humanoid') and tail.Humanoid.Health > 0 then
                                            targetPart = tail.HumanoidRootPart
                                        end
                                    end
                                    if not targetPart then
                                        local boss = seaBeasts:FindFirstChild('Leviathan')
                                        if boss and boss:FindFirstChild('HumanoidRootPart') and boss:FindFirstChild('Humanoid') and boss.Humanoid.Health > 0 then
                                            targetPart = boss.HumanoidRootPart
                                        end
                                    end
                                end
                                if targetPart then
                                    if hum.Health < 7000 then
                                        Tween(CFrame.new(targetPart.Position + Vector3.new(0, 500, 0)))
                                    else
                                        Tween(CFrame.new(targetPart.Position + Vector3.new(0, 50, 0)))
                                        CallSkills()
                                        AutoRaceV3()
                                        AutoHaki()
                                    end
                                end
                            end
                        end
                    end
                end)
            end,
        })
        Players = game:GetService('Players')
        TweenService = game:GetService('TweenService')
        Workspace = game:GetService('Workspace')
        ReplicatedStorage = game:GetService('ReplicatedStorage')
        RunService = game:GetService('RunService')
        Plr = Players.LocalPlayer
        local Speed = 350
        local function GetMyBoat()
            for _, v in pairs(Workspace.Boats:GetChildren())do
                if v:FindFirstChild('Owner') and v.Owner.Value == Plr then
                    return v
                end
            end
        end
        Tabs.Sea:Toggle({
            Title = 'Auto Shoot Heart',
            Value = false,
            Callback = function(v)
                _G.AutoShootHeart = v
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoShootHeart) then continue end
                if _G.AutoShootHeart then
                    local b = GetMyBoat()
                    if b then
                        StartBoatNoclip(b)
                    end
                    SolarixStreamDelay(0.25)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoShootHeart) then continue end
                if _G.AutoShootHeart then
                    pcall(function()
                        local Heart = Workspace.Map:FindFirstChild('FrozenHeart')
                        local Boat = GetMyBoat()
                        if Heart and Boat and Boat.Name == 'Beast Hunter' then
                            local VSeat = Boat:FindFirstChild('VehicleSeat')
                            local Harpoon = Boat:FindFirstChild('Harpoon')
                            local HSeat = Harpoon and Harpoon:FindFirstChild('Seat')
                            local HTip = Harpoon and Harpoon:FindFirstChild('Part')
                            local Char = Plr.Character
                            local Hum = Char and Char:FindFirstChild('Humanoid')
                            if VSeat and HSeat and Hum and Char.PrimaryPart then
                                if (VSeat.Position-Heart.Position).Magnitude > 150 then
                                    if Hum.SeatPart == VSeat then
                                        local Dir = (Heart.Position-VSeat.Position).Unit
                                        VSeat.AssemblyLinearVelocity = Dir * Speed
                                        VSeat.AssemblyAngularVelocity = Vector3.zero
                                        local Next = VSeat.Position + (Dir * Speed * 0.05)
                                        VSeat.CFrame = CFrame.new(Vector3.new(Next.X, 190, Next.Z), Heart.Position) * CFrame.Angles(0, math.rad(-35), 0)
                                    else
                                        Hum.Sit = false
                                        task.wait(0.1)
                                        Tween(VSeat.CFrame * CFrame.new(0, 5, 0))
                                        task.wait(0.5)
                                        VSeat:Sit(Hum)
                                    end
                                else
                                    VSeat.AssemblyLinearVelocity = Vector3.zero
                                    VSeat.AssemblyAngularVelocity = Vector3.zero
                                    local TargetY = VSeat.Position.Y > 30 and 25 or VSeat.Position.Y
                                    VSeat.CFrame = CFrame.new(Vector3.new(VSeat.Position.X, TargetY, VSeat.Position.Z), Vector3.new(Heart.Position.X, TargetY, Heart.Position.Z))
                                    if VSeat.Position.Y <= 30 then
                                        if Hum.SeatPart == VSeat then
                                            Hum.Sit = false
                                            task.wait(0.1)
                                        elseif Hum.SeatPart ~= HSeat then
                                            Tween(HSeat.CFrame * CFrame.new(0, 2, 0))
                                            task.wait(0.5)
                                            HSeat:Sit(Hum)
                                        elseif Hum.SeatPart == HSeat then
                                            local SPos = HTip and HTip.Position or HSeat.Position
                                            local Vec = HSeat.CFrame:PointToObjectSpace(SPos + (Heart.Position-SPos).Unit)
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer('FireHarpoon', Vec.X * 100, Vec.Y * 100, Harpoon, Workspace:GetServerTimeNow())
                                            task.wait(0.1)
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Players = game:GetService('Players')
        Workspace = game:GetService('Workspace')
        ReplicatedStorage = game:GetService('ReplicatedStorage')
        Plr = Players.LocalPlayer
        local function GetMyBoat()
            for _, v in pairs(Workspace.Boats:GetChildren())do
                if v:FindFirstChild('Owner') and v.Owner.Value == Plr then
                    return v
                end
            end
        end
        Tabs.Sea:Toggle({
            Title = 'Auto Repair Ship',
            Value = false,
            Callback = function(v)
                _G.AutoRepairShip = v
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoRepairShip) then continue end
                if _G.AutoRepairShip then
                    pcall(function()
                        local Boat = GetMyBoat()
                        if Boat and Boat:FindFirstChild('ShipHealthBBG') then
                            local Split = string.split(Boat.ShipHealthBBG.ShipHealthBar.TextLabel.ContentText, '/')
                            if tonumber(Split[1]) < tonumber(Split[2]) then
                                local Char = Plr.Character
                                local Hum = Char and Char:FindFirstChild('Humanoid')
                                local VSeat = Boat:FindFirstChild('VehicleSeat')
                                if Char and Hum and VSeat then
                                    if Hum.Sit then
                                        Hum.Sit = false
                                        task.wait(0.1)
                                    end
                                    local Hammer = Char:FindFirstChild('_RepairHammer') or Plr.Backpack:FindFirstChild('_RepairHammer')
                                    if not Hammer then
                                        ReplicatedStorage.Remotes.SubclassNetwork.UseSubclass:InvokeServer({
                                            Action = 'RequestHammer',
                                        })
                                    else
                                        if Hammer.Parent == Plr.Backpack then
                                            Hum:EquipTool(Hammer)
                                        end
                                        local Marker = Workspace._WorldOrigin:FindFirstChild('MiniGameMarker')
                                        if Marker then
                                            local TopPos = Marker.Size.Y / 2 + 3
                                            if Tween then
                                                Tween(Marker.CFrame * CFrame.new(0, TopPos, 0))
                                            elseif Char.HumanoidRootPart then
                                                Char.HumanoidRootPart.CFrame = Marker.CFrame * CFrame.new(0, TopPos, 0)
                                            end
                                            local EquippedHammer = Char:FindFirstChild('_RepairHammer')
                                            if EquippedHammer and EquippedHammer:FindFirstChild('M1Down') then
                                                EquippedHammer.M1Down:FireServer('Minigame')
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end)
        Players = game:GetService('Players')
        Workspace = game:GetService('Workspace')
        Plr = Players.LocalPlayer
        local CurrentTarget = nil
        Tabs.Sea:Toggle({
            Title = 'Auto Wooden Plank',
            Value = false,
            Callback = function(v)
                _G.AutoWoodenPlank = v
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoWoodenPlank) then continue end
                if _G.AutoWoodenPlank then
                    pcall(function()
                        local Root = Plr.Character and Plr.Character:FindFirstChild('HumanoidRootPart')
                        if Root then
                            local Folder = Workspace.Map.Port.IslandModel
                            local Found = nil
                            local ShortestDist = math.huge
                            for _, tree in ipairs(Folder:GetChildren())do
                                local group = tree:FindFirstChild('Group')
                                if group then
                                    for _, wood in ipairs(group:GetChildren())do
                                        local Pos = nil
                                        if wood:IsA('BasePart') then
                                            Pos = wood.Position
                                        elseif wood:IsA('Model') then
                                            Pos = wood:GetPivot().Position
                                        end
                                        if Pos then
                                            local Dist = (Root.Position-Pos).Magnitude
                                            if Dist < ShortestDist then
                                                ShortestDist = Dist
                                                Found = wood
                                            end
                                        end
                                    end
                                end
                            end
                            CurrentTarget = Found
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoWoodenPlank and CurrentTarget) then continue end
                if _G.AutoWoodenPlank and CurrentTarget then
                    pcall(function()
                        local Root = Plr.Character and Plr.Character:FindFirstChild('HumanoidRootPart')
                        if Root then
                            local TargetCF = CurrentTarget:IsA('Model') and CurrentTarget:GetPivot() or CurrentTarget.CFrame
                            local Dist = (Root.Position-TargetCF.Position).Magnitude
                            if Dist > 5 then
                                Tween(TargetCF)
                            else
                                CallSkills()
                            end
                        end
                    end)
                end
            end
        end)
        Workspace = game:GetService('Workspace')
        Tabs.Sea:Toggle({
            Title = 'Auto Ignite Lanterns',
            Value = false,
            Callback = function(v)
                _G.AutoIgnite = v
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoIgnite) then continue end
                if _G.AutoIgnite then
                    pcall(function()
                        local Client = Workspace:FindFirstChild('HydraIslandClient')
                        local Remote = Client and Client:FindFirstChild('RemoteFunction')
                        local Dojo = Workspace.Map:FindFirstChild('Waterfall') and Workspace.Map.Waterfall:FindFirstChild('IslandModel') and Workspace.Map.Waterfall.IslandModel:FindFirstChild('DojoAddition')
                        if Dojo and Remote then
                            for _, name in ipairs({
                                'Red',
                                'Green',
                                'Yellow',
                            })do
                                local Lantern = Dojo:FindFirstChild(name)
                                if Lantern and not Lantern:GetAttribute('Lit') then
                                    Remote:InvokeServer('Ignite', Lantern)
                                end
                            end
                        end
                    end)
                end
            end
        end)
        local CollectValues = {
            'Dino Bones',
            'Eggs',
        }
        _G.SelectedCollect = {}
        _G.AutoCollectToggle = false
        Tabs.Sea:Dropdown({
            Title = 'Collect Type',
            Values = CollectValues,
            Multi = true,
            Callback = function(Value)
                _G.SelectedCollect = Value
            end,
        })
        Tabs.Sea:Toggle({
            Title = 'Auto Collect',
            Value = false,
            Callback = function(Value)
                _G.AutoCollectToggle = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoCollectToggle) then continue end
                if _G.AutoCollectToggle then
                    local p = game.Players.LocalPlayer
                    local char = p.Character
                    local wantBones = false
                    local wantEggs = false
                    if _G.SelectedCollect then
                        for _, v in pairs(_G.SelectedCollect)do
                            if v == 'Dino Bones' then
                                wantBones = true
                            end
                            if v == 'Eggs' then
                                wantEggs = true
                            end
                        end
                    end
                    local foundPriority = false
                    if wantBones then
                        for _, obj in pairs(workspace:GetChildren())do
                            if obj:IsA('BasePart') and obj.Name == 'DinoBone' then
                                foundPriority = true
                                repeat
                                    if not _G.AutoCollectToggle then
                                        break
                                    end
                                    if obj and obj.Parent then
                                        Tween(CFrame.new(obj.Position))
                                    end
                                    task.wait()
                                until not obj or not obj.Parent
                                break
                            end
                        end
                    end
                    if not foundPriority and wantEggs then
                        local path = workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs
                        local dragonEggs = path:GetChildren()
                        if #dragonEggs > 0 then
                            local randomEgg = dragonEggs[math.random(1, #dragonEggs)]
                            if randomEgg:IsA('Model') and randomEgg.PrimaryPart then
                                local prompt = nil
                                for _, Child in ipairs(randomEgg:GetChildren())do
                                    if Child:IsA('ProximityPrompt') and Child.ActionText == 'Collect' and Child.ObjectText == 'Dragon Egg' then
                                        prompt = Child
                                        break
                                    end
                                    for _, SubChild in ipairs(Child:GetChildren())do
                                        if SubChild:IsA('ProximityPrompt') and SubChild.ActionText == 'Collect' and SubChild.ObjectText == 'Dragon Egg' then
                                            prompt = SubChild
                                            break
                                        end
                                    end
                                    if prompt then
                                        break
                                    end
                                end
                                if prompt then
                                    repeat
                                        if not _G.AutoCollectToggle then
                                            break
                                        end
                                        if randomEgg.PrimaryPart then
                                            Tween(randomEgg.PrimaryPart.CFrame)
                                        end
                                        if char and char:FindFirstChild('HumanoidRootPart') and randomEgg.PrimaryPart then
                                            if (char.HumanoidRootPart.Position-randomEgg.PrimaryPart.Position).Magnitude <= 5 then
                                                fireproximityprompt(prompt, 0)
                                            end
                                        end
                                        task.wait()
                                    until not randomEgg or not randomEgg.Parent or not prompt or not prompt.Parent
                                end
                            end
                        end
                    end
                end
            end
        end)
        function checkEagleEye()
            local islandModel = game:GetService('Workspace').Map.TikiOutpost.IslandModel
            local islandChunks = islandModel.IslandChunks and islandModel.IslandChunks.E
            local targetEyes = {
                Eye1 = false,
                Eye2 = false,
                Eye3 = false,
                Eye4 = false,
            }
            for _, v in ipairs(islandModel:GetChildren())do
                if string.match(v.Name, '^Eye%d$') and targetEyes[v.Name] ~= nil then
                    if tonumber(v.Transparency) == 0 then
                        targetEyes[v.Name] = true
                    end
                end
            end
            if islandChunks then
                for _, v in ipairs(islandChunks:GetChildren())do
                    if string.match(v.Name, '^Eye%d$') and targetEyes[v.Name] ~= nil then
                        if tonumber(v.Transparency) == 0 then
                            targetEyes[v.Name] = true
                        end
                    end
                end
            end
            for _, found in pairs(targetEyes)do
                if not found then
                    return false
                end
            end
            return true
        end
        function DestroyTyrantSkies()
            local islandModel = game:GetService('Workspace').Map.TikiOutpost.IslandModel
            local islandChunks = islandModel and islandModel.IslandChunks and islandModel.IslandChunks.D
            local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            if islandChunks and islandChunks:FindFirstChild('EagleBossArena') then
                for _, v in pairs(islandChunks.EagleBossArena:GetChildren())do
                    if v.Name == 'Tree' then
                        local treePosition = v.WorldPivot.Position
                        local distance = (playerPosition-treePosition).Magnitude
                        Tween(CFrame.new(treePosition))
                        if distance <= 5 then
                            CallSkills()
                        end
                    end
                end
            end
        end
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoTyrant) then continue end
                if _G.AutoTyrant then
                    pcall(function()
                        local enemies = game:GetService('Workspace').Enemies
                        local tyrant = enemies:FindFirstChild('Tyrant of the Skies')
                        if tyrant and tyrant:FindFirstChild('Humanoid') and tyrant.Humanoid.Health > 0 and tyrant:FindFirstChild('HumanoidRootPart') then
                            AutoHaki()
                            Equip(SelectWeapon)
                            Tween(tyrant.HumanoidRootPart.CFrame + Pos)
                            Attack()
                            return
                        elseif not checkEagleEye() then
                            for _, v in pairs(enemies:GetChildren())do
                                if table.find({
                                    'Serpent Hunter',
                                    'Skull Slayer',
                                    'Isle Champion',
                                    'Sun-kissed Warrior',
                                }, v.Name) and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
                                    AutoHaki()
                                    Equip(SelectWeapon)
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                    Tween(v.HumanoidRootPart.CFrame + Pos)
                                    Attack()
                                    return
                                end
                            end
                            Tween(CFrame.new(-16654.3671875, 416.16455078125, 1363.68359375))
                        else
                            DestroyTyrantSkies()
                        end
                    end)
                end
            end
        end)
    end
    if Sea1 or Sea2 or Sea3 then
        Players = game:GetService('Players')
        ReplicatedStorage = game:GetService('ReplicatedStorage')
        Workspace = game:GetService('Workspace')
        LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
        local Modules = ReplicatedStorage:WaitForChild('Modules')
        local Net = Modules:WaitForChild('Net')
        local FishReplicated = ReplicatedStorage:WaitForChild('FishReplicated')
        local FishingRequest = FishReplicated:FindFirstChild('FishingRequest')
        local Config = require(FishReplicated.FishingClient.Config)
        local Util = ReplicatedStorage:WaitForChild('Util')
        local GetWaterHeightAtLocation = require(Util:WaitForChild('GetWaterHeightAtLocation'))
        local JobsRF = Net:FindFirstChild('RF/JobsRemoteFunction')
        local CraftRF = Net:FindFirstChild('RF/Craft')
        local function EquipRod()
            local currentRod = _G.SelectedRod or 'Fishing Rod'
            local Humanoid = Character:FindFirstChildOfClass('Humanoid')
            if not Character:FindFirstChild(currentRod) then
                local Tool = LocalPlayer.Backpack:FindFirstChild(currentRod)
                if Tool then
                    Humanoid:EquipTool(Tool)
                end
            end
        end
        local function GetCastPos()
            local waterY = GetWaterHeightAtLocation(HumanoidRootPart.Position)
            local castDist = 50
            if Config and Config.Rod and Config.Rod.MaxLaunchDistance then
                castDist = Config.Rod.MaxLaunchDistance
            end
            local dir = HumanoidRootPart.CFrame.LookVector * castDist
            local targetPos = HumanoidRootPart.Position + dir
            local _, ground = Workspace:FindPartOnRayWithIgnoreList(Ray.new(targetPos + Vector3.new(0, 50, 0), Vector3.new(0,-100, 0)), {
                Character,
                Workspace.Characters,
                Workspace.Enemies,
            })
            if ground then
                return Vector3.new(targetPos.X, math.max(ground.Y, waterY), targetPos.Z)
            else
                return Vector3.new(targetPos.X, waterY, targetPos.Z)
            end
        end
        local function Cast()
            task.spawn(function()
                pcall(function()
                    FishingRequest:InvokeServer('StartCasting')
                    FishingRequest:InvokeServer('CastLineAtLocation', GetCastPos(), 100, true)
                end)
            end)
        end
        local function Catch()
            task.spawn(function()
                pcall(function()
                    FishingRequest:InvokeServer('Catching', 1)
                    FishingRequest:InvokeServer('Catch', 1)
                end)
            end)
        end
        local Jobs = require(game:GetService('ReplicatedStorage').JobsReplicated)
        task.spawn(function()
            while task.wait() do
                SolarixStreamDelay(0.35)
                pcall(function()
                    local data = Jobs.GetJobData('Fishing')
                    if data and data.LevelData then
                        Status:Set('Fishing Level: ' .. tostring(data.LevelData.level))
                    else
                        Status:Set('Fishing Level: N/A')
                    end
                end)
            end
        end)
        Tabs.Fishing:Button({
            Title = 'Get Free Rod',
            Callback = function()
                task.spawn(function()
                    pcall(function()
                        JobsRF:InvokeServer('FishingNPC', 'FirstTimeFreeRod')
                    end)
                end)
            end,
        })
        local RodList = {
            ['Fishing Rod'] = 'Fishing Rod',
            ['Gold Rod'] = 'Gold Rod',
            ['Shark Rod'] = 'Shark Rod',
            ['Shell Rod'] = 'Shell Rod',
            ['Treasure Rod'] = 'Treasure Rod',
        }
        local RodNames = {}
        for name, _ in pairs(RodList)do
            table.insert(RodNames, name)
        end
        Tabs.Fishing:Dropdown({
            Title = 'Select Rod',
            Values = RodNames,
            Multi = false,
            Value = 'Fishing Rod',
            Callback = function(Value)
                _G.SelectedRod = RodList[Value]
            end,
        })
        local BaitList = {
            ['Basic Bait'] = 'Basic Bait',
            ['Kelp Bait'] = 'Kelp Bait',
            ['Good Bait'] = 'Good Bait',
            ['Abyssal Bait'] = 'Abyssal Bait',
            ['Frozen Bait'] = 'Frozen Bait',
            ['Epic Bait'] = 'Epic Bait',
            ['Carnivore Bait'] = 'Carnivore Bait',
        }
        local BaitNames = {}
        for name, _ in pairs(BaitList)do
            table.insert(BaitNames, name)
        end
        Tabs.Fishing:Dropdown({
            Title = 'Select Bait',
            Values = BaitNames,
            Multi = false,
            Value = 'Basic Bait',
            Callback = function(Value)
                _G.SelectedBait = BaitList[Value]
            end,
        })
        Tabs.Fishing:Toggle({
            Title = 'Auto Craft Bait',
            Value = false,
            Callback = function(Value)
                _G.AutoCraftBait = Value
            end,
        })
        Tabs.Fishing:Button({
            Title = 'Open Fish Index',
            Callback = function()
                local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
                PlayerGui:SetAttribute('FishIndexVisible', true)
            end,
        })
        Tabs.Fishing:Toggle({
            Title = 'Auto Sell Fish',
            Value = false,
            Callback = function(Value)
                _G.AutoSellFish = Value
            end,
        })
        Tabs.Fishing:Toggle({
            Title = 'Accept Quest',
            Value = false,
            Callback = function(Value)
                _G.AutoAcceptQuest = Value
            end,
        })
        Tabs.Fishing:Toggle({
            Title = 'Auto Fishing',
            Value = false,
            Callback = function(Value)
                _G.AutoFishing = Value
            end,
        })
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoCraftBait) then continue end
                if _G.AutoCraftBait then
                    pcall(function()
                        CraftRF:InvokeServer('Craft', _G.SelectedBait or 'Basic Bait')
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoSellFish) then continue end
                if _G.AutoSellFish then
                    pcall(function()
                        JobsRF:InvokeServer('FishingNPC', 'SellFish')
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoAcceptQuest) then continue end
                if _G.AutoAcceptQuest then
                    pcall(function()
                        local PlayerGui = LocalPlayer:FindFirstChild('PlayerGui')
                        local FishGui = PlayerGui and PlayerGui:FindFirstChild('Main') and PlayerGui.Main:FindFirstChild('Quest')
                        if not FishGui or not FishGui.Visible then
                            JobsRF:InvokeServer('FishingNPC', 'Angler', 'AskQuest')
                        else
                            JobsRF:InvokeServer('FishingNPC', 'Angler', 'CheckQuest')
                        end
                    end)
                end
            end
        end)
        task.spawn(function()
            while task.wait() do
                if not SolarixStream(_G.AutoFishing) then continue end
                if _G.AutoFishing then
                    pcall(function()
                        Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')
                        EquipRod()
                        local currentRod = _G.SelectedRod or 'Fishing Rod'
                        local Rod = Character:FindFirstChild(currentRod)
                        if Rod then
                            local State = Rod:GetAttribute('ServerState') or Rod:GetAttribute('State')
                            if State == 'Biting' then
                                Catch()
                            elseif State == 'ReeledIn' or State == 'Idle' or not State then
                                Cast()
                            end
                        end
                    end)
                end
            end
        end)
    end
    for _, Callback in ipairs(InitialToggleCallbacks) do
        task.defer(Callback)
    end
    if Tabs.Info and Tabs.Info.Select then
        Tabs.Info:Select()
    end
    task.defer(function()
        Library:Notify({
            Title = 'Solarix Hub',
            Content = 'Script loaded successfully.',
            Icon = 'solar:check-circle-bold',
        })
    end)
end
local function SolarixDoor()
    local WindUI = loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/latest/download/main.lua'))()
    local Library = WindUI
    pcall(function()
        Library:SetFont('rbxasset://fonts/families/FredokaOne.json')
    end)
    Library:AddTheme({
        Name = 'SolarixDoorFlare',
        Accent = Color3.fromHex('#FF8A3D'),
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#160807'), Transparency = 0.03},
            ['45'] = {Color = Color3.fromHex('#34100A'), Transparency = 0.05},
            ['100'] = {Color = Color3.fromHex('#6D2112'), Transparency = 0.08},
        }, {
            Rotation = 28,
        }),
        Outline = Color3.fromHex('#FFC68A'),
        Text = Color3.fromHex('#FFF8EF'),
        Placeholder = Color3.fromHex('#D6A383'),
        Button = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#30100A'), Transparency = 0.02},
            ['52'] = {Color = Color3.fromHex('#6E2112'), Transparency = 0.04},
            ['100'] = {Color = Color3.fromHex('#FF7A22'), Transparency = 0.08},
        }, {
            Rotation = 22,
        }),
        Icon = Color3.fromHex('#FFD2A1'),
    })
    Library:SetTheme('SolarixDoorFlare')
    local Window = Library:CreateWindow({
        Title = 'Solarix Hub',
        Icon = 'lucide:flame',
        Folder = 'Solarix Hub',
        Size = UDim2.fromOffset(580, 460),
        MinSize = Vector2.new(560, 350),
        MaxSize = Vector2.new(580, 460),
        ToggleKey = Enum.KeyCode.G,
        Transparent = true,
        Theme = 'SolarixDoorFlare',
        Acrylic = false,
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#160807'), Transparency = 0.08},
            ['38'] = {Color = Color3.fromHex('#42130B'), Transparency = 0.03},
            ['67'] = {Color = Color3.fromHex('#D94C1A'), Transparency = 0.16},
            ['100'] = {Color = Color3.fromHex('#160807'), Transparency = 0.06},
        }, {
            Rotation = 35,
        }),
        Resizable = false,
        SideBarWidth = 190,
        HideSearchBar = false,
        ScrollBarEnabled = false,
        User = {
            Enabled = false,
        },
        OpenButton = {
            Title = 'Solarix Hub',
            Icon = 'lucide:flame',
            Enabled = true,
            Draggable = true,
            CornerRadius = UDim.new(0, 14),
            StrokeThickness = 1.5,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex('#24100B')),
                ColorSequenceKeypoint.new(0.45, Color3.fromHex('#FF6B1A')),
                ColorSequenceKeypoint.new(0.7, Color3.fromHex('#FFE0B5')),
                ColorSequenceKeypoint.new(1, Color3.fromHex('#5A1A0E')),
            }),
        },
    })
    local Colors = {
        Info = Color3.fromHex('#FFD1A1'),
        Green = Color3.fromHex('#FF8A3D'),
    }
    local function TabOptions(Title, Icon, IconColor)
        return {
            Title = Title,
            Icon = Icon,
            IconColor = IconColor,
            IconShape = 'Square',
            Border = true,
        }
    end
    local Tabs = {
        Info = Window:Tab(TabOptions('Info', 'solar:info-circle-bold', Colors.Info)),
        General = Window:Tab(TabOptions('General', 'solar:play-circle-bold', Colors.Green)),
    }
    Tabs.Info:Paragraph({
        Title = 'Info',
        Desc = "Press 'G' to toggle UI.",
        Color = 'Orange',
    })
    Tabs.Info:Paragraph({
        Title = 'Support Game',
        Desc = '[+] Blox Fruits\n[+] Doors\n[+] Sailor Piece\n[+] Survive Zombie Arena',
        Color = 'Orange',
    })
    local Lighting = game:GetService('Lighting')
    local CollectionService = game:GetService('CollectionService')
    local EspParent = gethui and gethui() or game:GetService('CoreGui')
    local EspFolder = EspParent:FindFirstChild('SolarixDoorEspFolder')
    if EspFolder then
        EspFolder:Destroy()
    end
    EspFolder = Instance.new('Folder')
    EspFolder.Name = 'SolarixDoorEspFolder'
    EspFolder.Parent = EspParent
    local EspId = 0
    local EspMark = 0
    local DoorWalkSpeed = 16
    local SolarixDoorRenderDistance = 420
    local DoorColor = Color3.fromRGB(95, 255, 140)
    local HidingColor = Color3.fromRGB(110, 205, 255)
    local GoldColor = Color3.fromRGB(255, 190, 55)
    local ItemColor = Color3.fromRGB(255, 160, 220)
    local EntityColor = Color3.fromRGB(255, 80, 80)
    local PlayerColor = Color3.fromRGB(150, 245, 255)
    local function GetObjectId(Object)
        if not Object then
            return '0'
        end
        local Id = Object:GetAttribute('SolarixDoorEspId')
        if Id then
            return tostring(Id)
        end
        EspId = EspId + 1
        Id = tostring(EspId)
        pcall(function()
            Object:SetAttribute('SolarixDoorEspId', Id)
        end)
        return Id
    end
    local function NextMark()
        EspMark = EspMark + 1
        return EspMark
    end
    local function GetLocalRoot()
        local Character = LocalPlayer.Character
        return Character and Character:FindFirstChild('HumanoidRootPart')
    end
    local function GetVisualPartScore(Part, ObjectName)
        if not Part or not Part:IsA('BasePart') then
            return -100
        end
        local Score = 0
        local Name = Part.Name:lower()
        local ObjectText = tostring(ObjectName or ''):lower():gsub('[^%w]', '')
        local PartText = tostring(Part.Name or ''):lower():gsub('[^%w]', '')
        if Part.Transparency < 0.95 then
            Score = Score + 4
        else
            Score = Score - 8
        end
        if Part:IsA('MeshPart') or Part:IsA('UnionOperation') then
            Score = Score + 10
        end
        if Part:FindFirstChildOfClass('SpecialMesh') or Part:FindFirstChildOfClass('SurfaceAppearance') or Part:FindFirstChildOfClass('Texture') or Part:FindFirstChildOfClass('Decal') then
            Score = Score + 8
        end
        if ObjectText ~= '' and PartText ~= '' and (PartText == ObjectText or ObjectText:find(PartText, 1, true) or PartText:find(ObjectText, 1, true)) then
            Score = Score + 6
        end
        if Name:find('hitbox') or Name:find('collision') or Name:find('trigger') or Name:find('root') or Name:find('prompt') or Name:find('bounds') then
            Score = Score - 12
        end
        if Part.Size.Magnitude <= 0.35 then
            Score = Score - 4
        end
        return Score
    end
    local function AddVisualPart(List, Part)
        if Part and Part:IsA('BasePart') and not table.find(List, Part) then
            List[#List + 1] = Part
        end
    end
    local function GetVisualParts(Object)
        local Parts = {}
        if not Object then
            return Parts
        end
        if Object:IsA('BasePart') then
            AddVisualPart(Parts, Object)
            return Parts
        end
        local BestPart = nil
        local BestScore = -100
        for _, Child in pairs(Object:GetChildren()) do
            if Child:IsA('BasePart') then
                local Score = GetVisualPartScore(Child, Object.Name)
                if Score > BestScore then
                    BestScore = Score
                    BestPart = Child
                end
                if Score >= 4 then
                    AddVisualPart(Parts, Child)
                end
            end
        end
        for _, Child in pairs(Object:GetChildren()) do
            for _, SubChild in pairs(Child:GetChildren()) do
                if SubChild:IsA('BasePart') then
                    local Score = GetVisualPartScore(SubChild, Object.Name)
                    if Score > BestScore then
                        BestScore = Score
                        BestPart = SubChild
                    end
                    if Score >= 4 then
                        AddVisualPart(Parts, SubChild)
                    end
                end
            end
        end
        if #Parts == 0 then
            AddVisualPart(Parts, BestPart)
        end
        return Parts
    end
    local function GetEspPart(Object)
        local Parts = GetVisualParts(Object)
        if Parts[1] then
            return Parts[1]
        end
        if Object and Object:IsA('Model') then
            local Root = Object:FindFirstChild('HumanoidRootPart') or Object:FindFirstChild('Head') or Object.PrimaryPart
            if Root and Root:IsA('BasePart') then
                return Root
            end
        end
        return nil
    end
    local function FormatEspText(Text)
        Text = tostring(Text or '')
        Text = Text:gsub('[_%-]+', ' ')
        Text = Text:gsub('(%u)(%u%l)', '%1 %2')
        Text = Text:gsub('(%l)(%u)', '%1 %2')
        Text = Text:gsub('(%a)(%d)', '%1 %2')
        Text = Text:gsub('(%d)(%a)', '%1 %2')
        Text = Text:gsub('%s+', ' ')
        Text = Text:gsub('^%s+', ''):gsub('%s+$', '')
        Text = Text:gsub('(%S+)', function(Word)
            if Word:upper() == Word then
                return Word
            end
            return Word:sub(1, 1):upper() .. Word:sub(2)
        end)
        return Text
    end
    local function FormatEspDistance(Text, Part)
        local Name = FormatEspText(Text)
        local Root = GetLocalRoot()
        if Root and Part then
            local Distance = (Root.Position - Part.Position).Magnitude
            return Name .. ' [' .. tostring(math.floor(Distance + 0.5)) .. 'm]'
        end
        return Name
    end
    local function GetEspOffset(Group)
        if Group == 'Door' then
            return Vector3.new(0, 3.8, 0)
        elseif Group == 'Hiding' then
            return Vector3.new(0, 3.05, 0)
        elseif Group == 'Gold' then
            return Vector3.new(0, 2.3, 0)
        elseif Group == 'Item' then
            return Vector3.new(0, 1.65, 0)
        elseif Group == 'Entity' then
            return Vector3.new(0, 4.45, 0)
        elseif Group == 'Player' then
            return Vector3.new(0, 5, 0)
        end
        return Vector3.new(0, 2.8, 0)
    end
    local function CreateEspGui(Name, Color, Group)
        local Gui = Instance.new('BillboardGui')
        Gui.Name = Name
        Gui.AlwaysOnTop = true
        Gui.Enabled = true
        Gui.Size = UDim2.new(0, 195, 0, 34)
        Gui.StudsOffset = GetEspOffset(Group)
        Gui.MaxDistance = SolarixDoorRenderDistance
        Gui:SetAttribute('Group', Group)
        Gui.Parent = EspFolder
        local Label = Instance.new('TextLabel')
        Label.Name = 'Text'
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.FontFace = Font.new('rbxasset://fonts/families/FredokaOne.json')
        Label.Text = ''
        Label.TextSize = 18
        Label.TextColor3 = Color
        Label.TextStrokeTransparency = 0.35
        Label.TextStrokeColor3 = Color3.fromRGB(8, 22, 16)
        Label.Parent = Gui
        return Gui
    end
    local function GetAuraTarget(Object)
        if not Object then
            return nil
        end
        if Object:IsA('BasePart') or Object:IsA('Model') or Object:IsA('Tool') then
            return Object
        end
        for _, Child in pairs(Object:GetChildren()) do
            if Child:IsA('Model') or Child:IsA('Tool') then
                return Child
            end
        end
        local Parts = GetVisualParts(Object)
        if Parts[1] then
            return Parts[1]
        end
        return Object
    end
    local function EnsureEspAura(Group, Id, Object, Color, Mark)
        local AuraTarget = GetAuraTarget(Object)
        if not AuraTarget then
            return
        end
        local AuraName = 'SolarixDoorAura_' .. Group .. '_' .. Id
        local Aura = EspFolder:FindFirstChild(AuraName)
        if not Aura then
            Aura = Instance.new('Highlight')
            Aura.Name = AuraName
            Aura.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Aura.FillTransparency = 0.72
            Aura.OutlineTransparency = 0.08
            Aura:SetAttribute('Group', Group)
            Aura.Parent = EspFolder
        end
        Aura:SetAttribute('Mark', Mark)
        Aura.Adornee = AuraTarget
        Aura.FillColor = Color
        Aura.OutlineColor = Color
        Aura.Enabled = true
    end
    local function EnsureEsp(Group, Object, Text, Color, Mark)
        local Part = GetEspPart(Object)
        if not Part then
            return
        end
        local Root = GetLocalRoot()
        if Root and (Root.Position - Part.Position).Magnitude > SolarixDoorRenderDistance then
            return
        end
        local Id = GetObjectId(Object)
        local GuiName = 'SolarixDoorEsp_' .. Group .. '_' .. Id
        local Gui = EspFolder:FindFirstChild(GuiName)
        if not Gui then
            Gui = CreateEspGui(GuiName, Color, Group)
        end
        Gui:SetAttribute('Mark', Mark)
        Gui.Adornee = Part
        Gui.StudsOffset = GetEspOffset(Group)
        Gui.Enabled = true
        local Label = Gui:FindFirstChild('Text')
        if Label then
            Label.Text = FormatEspDistance(Text, Part)
            Label.TextColor3 = Color
        end
        EnsureEspAura(Group, Id, Object, Color, Mark)
    end
    local function ClearEspGroup(Group)
        for _, Object in pairs(EspFolder:GetChildren()) do
            if Object:GetAttribute('Group') == Group then
                Object:Destroy()
            end
        end
    end
    local function CleanEspGroup(Group, Mark)
        for _, Object in pairs(EspFolder:GetChildren()) do
            if Object:GetAttribute('Group') == Group and Object:GetAttribute('Mark') ~= Mark then
                Object:Destroy()
            end
        end
    end
    local function HasTag(Object, TagName)
        if not Object then
            return false
        end
        local Ok, Result = pcall(function()
            return CollectionService:HasTag(Object, TagName)
        end)
        if Ok and Result then
            return true
        end
        return Object:GetAttribute('TAG') == TagName or Object:GetAttribute('Tag') == TagName or Object:GetAttribute('tag') == TagName
    end
    local function GetLastRoomNumber()
        local CurrentRooms = workspace:FindFirstChild('CurrentRooms')
        if not CurrentRooms then
            return nil
        end
        local LastNumber = nil
        for _, Room in pairs(CurrentRooms:GetChildren()) do
            local Number = tonumber(Room.Name)
            if Number and (not LastNumber or Number > LastNumber) then
                LastNumber = Number
            end
        end
        return LastNumber
    end
    local function ForRecentRooms(Callback)
        local CurrentRooms = workspace:FindFirstChild('CurrentRooms')
        local LastNumber = GetLastRoomNumber()
        if not CurrentRooms or not LastNumber then
            return
        end
        local FirstNumber = math.max(0, LastNumber - 2)
        for Number = FirstNumber, LastNumber do
            local Room = CurrentRooms:FindFirstChild(tostring(Number))
            if Room then
                Callback(Room, Number)
            end
        end
    end
    local function ForRecentAssets(Callback)
        ForRecentRooms(function(Room, Number)
            local Assets = Room:FindFirstChild('Assets')
            if Assets then
                Callback(Assets, Room, Number)
            end
        end)
    end
    local function ForAssetObjects(Callback)
        ForRecentAssets(function(Assets, Room, Number)
            for _, Object in pairs(Assets:GetChildren()) do
                Callback(Object, Room, Number)
                for _, Child in pairs(Object:GetChildren()) do
                    Callback(Child, Room, Number)
                    for _, SubChild in pairs(Child:GetChildren()) do
                        Callback(SubChild, Room, Number)
                    end
                end
            end
        end)
    end
    local function AddDoorEsp()
        local Mark = NextMark()
        ForRecentRooms(function(Room, Number)
            local Door = Room:FindFirstChild('Door')
            if Door then
                EnsureEsp('Door', Door, 'Door ' .. tostring(Number + 1), DoorColor, Mark)
            end
        end)
        CleanEspGroup('Door', Mark)
    end
    local function AddHidingEsp()
        local Mark = NextMark()
        ForAssetObjects(function(Object)
            if HasTag(Object, 'HidingSpot') then
                EnsureEsp('Hiding', Object, Object.Name, HidingColor, Mark)
            end
        end)
        CleanEspGroup('Hiding', Mark)
    end
    local function AddGoldEsp()
        local Mark = NextMark()
        ForAssetObjects(function(Object)
            if Object.Name == 'GoldPile' then
                EnsureEsp('Gold', Object, Object.Name, GoldColor, Mark)
            end
        end)
        CleanEspGroup('Gold', Mark)
    end
    local function AddItemEsp()
        local Mark = NextMark()
        ForAssetObjects(function(Object)
            if HasTag(Object, 'ItemDrop') or HasTag(Object, 'RBS') then
                EnsureEsp('Item', Object, Object.Name, ItemColor, Mark)
            end
        end)
        CleanEspGroup('Item', Mark)
    end
    local function AddPlayerEsp()
        local Mark = NextMark()
        for _, OtherPlayer in pairs(Players:GetPlayers()) do
            if OtherPlayer ~= LocalPlayer then
                local Character = OtherPlayer.Character
                local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
                local RootPart = Character and Character:FindFirstChild('HumanoidRootPart')
                if Character and Humanoid and RootPart and Humanoid.Health > 0 then
                    local PlayerName = OtherPlayer.Name
                    if OtherPlayer.DisplayName and OtherPlayer.DisplayName ~= OtherPlayer.Name then
                        PlayerName = OtherPlayer.DisplayName .. ' (' .. OtherPlayer.Name .. ')'
                    end
                    EnsureEsp('Player', Character, PlayerName, PlayerColor, Mark)
                end
            end
        end
        CleanEspGroup('Player', Mark)
    end
    local function AddEntityNotify(Object)
        if not Object or Object:GetAttribute('SolarixEntitySeen') then
            return
        end
        pcall(function()
            Library:Notify({
                Title = 'Solarix Hub',
                Content = FormatEspText(Object.Name),
                Icon = 'solar:danger-triangle-bold',
            })
        end)
        pcall(function()
            Object:SetAttribute('SolarixEntitySeen', true)
        end)
    end
    local function AddEntityEsp()
        local Mark = NextMark()
        for _, Object in pairs(CollectionService:GetTagged('EntityKillable')) do
            if Object and Object.Parent then
                AddEntityNotify(Object)
                EnsureEsp('Entity', Object, Object.Name, EntityColor, Mark)
            end
        end
        for _, Object in pairs(workspace:GetChildren()) do
            if HasTag(Object, 'EntityKillable') then
                AddEntityNotify(Object)
                EnsureEsp('Entity', Object, Object.Name, EntityColor, Mark)
            end
        end
        CleanEspGroup('Entity', Mark)
    end
    local function SetBright()
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(165, 170, 165)
        Lighting.OutdoorAmbient = Color3.fromRGB(150, 155, 150)
        Lighting.ExposureCompensation = 0.35
        pcall(function()
            Lighting.EnvironmentDiffuseScale = 1
            Lighting.EnvironmentSpecularScale = 0.35
            Lighting.ShadowSoftness = 0
        end)
    end
    local function SetWalkSpeed()
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
        if Humanoid and Humanoid.Health > 0 and Humanoid.WalkSpeed ~= DoorWalkSpeed then
            Humanoid.WalkSpeed = DoorWalkSpeed
        end
    end
    Tabs.General:Toggle({
        Title = 'Door ESP',
        Value = false,
        Callback = function(Value)
            _G.SolarixDoorEspDoor = Value
            if not Value then
                ClearEspGroup('Door')
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Hiding Spot ESP',
        Value = false,
        Callback = function(Value)
            _G.SolarixDoorEspHiding = Value
            if not Value then
                ClearEspGroup('Hiding')
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Gold ESP',
        Value = false,
        Callback = function(Value)
            _G.SolarixDoorEspGold = Value
            if not Value then
                ClearEspGroup('Gold')
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Item ESP',
        Value = false,
        Callback = function(Value)
            _G.SolarixDoorEspItem = Value
            if not Value then
                ClearEspGroup('Item')
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Player ESP',
        Value = false,
        Callback = function(Value)
            _G.SolarixDoorEspPlayer = Value
            if not Value then
                ClearEspGroup('Player')
            end
        end,
    })
    Tabs.General:Slider({
        Title = 'Walk Speed',
        Value = {
            Min = 0,
            Max = 18,
            Default = 16,
        },
        Step = 1,
        Callback = function(Value)
            DoorWalkSpeed = math.clamp(math.floor(tonumber(Value) or 16), 0, 18)
            _G.SolarixDoorWalkSpeed = DoorWalkSpeed
            SetWalkSpeed()
        end,
    })
    Tabs.General:Button({
        Title = 'Remove Darkness',
        Callback = function()
            SetBright()
        end,
    })
    task.spawn(function()
        while task.wait() do
            local AnyEsp = _G.SolarixDoorEspDoor or _G.SolarixDoorEspHiding or _G.SolarixDoorEspGold or _G.SolarixDoorEspItem or _G.SolarixDoorEspPlayer
            if not SolarixStream(AnyEsp) then
                continue
            end
            pcall(function()
                if _G.SolarixDoorEspDoor then
                    AddDoorEsp()
                end
                if _G.SolarixDoorEspHiding then
                    AddHidingEsp()
                end
                if _G.SolarixDoorEspGold then
                    AddGoldEsp()
                end
                if _G.SolarixDoorEspItem then
                    AddItemEsp()
                end
                if _G.SolarixDoorEspPlayer then
                    AddPlayerEsp()
                end
                AddEntityEsp()
            end)
            SolarixStreamDelay(1.25)
        end
    end)
    task.spawn(function()
        while task.wait() do
            pcall(function()
                SetWalkSpeed()
            end)
            SolarixStreamDelay(0.8)
        end
    end)
    if Tabs.Info and Tabs.Info.Select then
        Tabs.Info:Select()
    end
    task.defer(function()
        Library:Notify({
            Title = 'Solarix Hub',
            Content = 'Script loaded successfully.',
            Icon = 'solar:check-circle-bold',
        })
    end)
end


local function SolarixSailorPiece()
    local Players = game:GetService('Players')
    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local Workspace = game:GetService('Workspace')
    local TweenService = game:GetService('TweenService')
    local Lighting = game:GetService('Lighting')
    local VirtualInputManager = game:GetService('VirtualInputManager')
    local VirtualUser = game:GetService('VirtualUser')
    local TeleportService = game:GetService('TeleportService')
    local GuiService = game:GetService('GuiService')
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
    local TweenSpeed = 150
    local TargetDistance = 45
    local CurrentTween = nil
    local CurrentTweenTarget = nil
    local CurrentTweenConnection = nil
    local CurrentTweenCompleted = nil
    local TweenProxy = nil
    local NoclipParts = {}
    local SelectedWeaponType = 'Melee'
    local FarmDistance = 20
    local SelectedMob = ''
    local SelectedBoss = ''
    local SelectedSummon = ''
    local SelectedOtherSummon = ''
    local SelectedDungeon = 'CidDungeon'
    local SelectedStats = {Melee = true, Sword = false, Defense = true, Power = false}
    local SelectedMerchantItems = {}
    local SelectedCraftItems = {}
    local SelectedSkills = {Z = true, X = true, C = true, V = true, F = true}
    local SelectedCodes = {'Release', 'Update', 'Sorry', 'Shutdown', 'Thanks'}
    local LastM1 = 0
    local LastSkill = 0
    local LastQuest = 0
    local LastInventory = 0
    local LastMerchant = 0
    local LastDungeon = 0
    local LastTargetName = ''
    local LastIsland = ''
    local CachedMobs = {}
    local CachedBosses = {}
    local CachedNPCs = {}
    local CachedWeapons = {Melee = {}, Sword = {}, Power = {}}
    local CachedItems = {}
    local CachedCrystals = {}
    local Tables = {
        Weapon = {'Melee', 'Sword', 'Power'},
        Dungeon = {'Cid Dungeon', 'Rune Dungeon', 'Double Dungeon', 'Boss Rush', 'Infinite Tower'},
        Stats = {'Melee', 'Sword', 'Defense', 'Power'},
        CraftItem = {'SlimeKey', 'DivineGrail'},
        MerchantItem = {},
        Mob = {},
        Boss = {},
        NPC = {},
        Summon = {'StrongestHistory', 'StrongestToday', 'Rimuru', 'Anos', 'TrueAizen', 'Atomic', 'AbyssalEmpress'},
        Island = {'Starter', 'Jungle', 'Desert', 'Snow', 'Sailor', 'Shibuya', 'HuecoMundo', 'Boss', 'Dungeon', 'Shinjuku', 'Valentine', 'Slime', 'Academy', 'Judgement', 'SoulSociety', 'Tower'},
        ManualWeaponClass = {Combat = 'Melee', Invisible = 'Power', Bomb = 'Power', Quake = 'Power'},
    }
    for _, Flag in ipairs({'SolarixSailorLevelFarm', 'SolarixSailorMobFarm', 'SolarixSailorAllMobFarm', 'SolarixSailorBossesFarm', 'SolarixSailorAllBossesFarm', 'SolarixSailorSummonBossFarm', 'SolarixSailorAutoDungeon', 'SolarixSailorAutoInfiniteTower', 'SolarixSailorDungeonAutofarm', 'SolarixSailorAutoStats', 'SolarixSailorAutoAscend', 'SolarixSailorAutoTrait', 'SolarixSailorAutoRace', 'SolarixSailorAutoClan', 'SolarixSailorAutoCraftItem', 'SolarixSailorArtifactMilestone', 'SolarixSailorArtifactUpgrade', 'SolarixSailorArtifactEquip', 'SolarixSailorAutoMerchant', 'SolarixSailorAutoDungeonMerchant', 'SolarixSailorAutoValentineMerchant', 'SolarixSailorAutoTowerMerchant', 'SolarixSailorAutoSummon', 'SolarixSailorAutoSkill'}) do
        _G[Flag] = false
    end
    _G.SolarixSailorAutoSkill = true
    _G.SolarixSailorAutoReconnect = true
    local SolarixSailorReconnectConnection = nil
    local function SolarixSailorReconnect()
        if SolarixSailorReconnectConnection then
            SolarixSailorReconnectConnection:Disconnect()
            SolarixSailorReconnectConnection = nil
        end
        SolarixSailorReconnectConnection = GuiService.ErrorMessageChanged:Connect(function()
            if not _G.SolarixSailorAutoReconnect then
                return
            end
            pcall(function()
                local PromptGui = game:GetService('CoreGui'):FindFirstChild('RobloxPromptGui')
                local Overlay = PromptGui and PromptGui:FindFirstChild('promptOverlay')
                local ErrorPrompt = Overlay and Overlay:FindFirstChild('ErrorPrompt')
                if ErrorPrompt and ErrorPrompt.Visible then
                    if _G.SolarixSailorAutoReconnect then
                        TeleportService:Teleport(game.PlaceId, LocalPlayer)
                    end
                end
            end)
        end)
    end
    SolarixSailorReconnect()
    local function GetRemote(Parent, PathText)
        local Current = Parent
        for _, Name in ipairs(tostring(PathText):split('.')) do
            if not Current then
                return nil
            end
            Current = Current:FindFirstChild(Name)
        end
        return Current
    end
    local Remotes = {
        SettingsToggle = GetRemote(ReplicatedStorage, 'RemoteEvents.SettingsToggle'),
        UseCode = GetRemote(ReplicatedStorage, 'RemoteEvents.CodeRedeem'),
        M1 = GetRemote(ReplicatedStorage, 'CombatSystem.Remotes.RequestHit'),
        EquipWeapon = GetRemote(ReplicatedStorage, 'Remotes.EquipWeapon'),
        UseSkill = GetRemote(ReplicatedStorage, 'AbilitySystem.Remotes.RequestAbility'),
        UseFruit = GetRemote(ReplicatedStorage, 'RemoteEvents.FruitPowerRemote'),
        QuestAccept = GetRemote(ReplicatedStorage, 'RemoteEvents.QuestAccept'),
        QuestAbandon = GetRemote(ReplicatedStorage, 'RemoteEvents.QuestAbandon'),
        UseItem = GetRemote(ReplicatedStorage, 'Remotes.UseItem'),
        SlimeCraft = GetRemote(ReplicatedStorage, 'Remotes.RequestSlimeCraft'),
        GrailCraft = GetRemote(ReplicatedStorage, 'Remotes.RequestGrailCraft'),
        AddStat = GetRemote(ReplicatedStorage, 'RemoteEvents.AllocateStat'),
        TPPortal = GetRemote(ReplicatedStorage, 'Remotes.TeleportToPortal'),
        OpenDungeon = GetRemote(ReplicatedStorage, 'Remotes.RequestDungeonPortal'),
        DungeonWaveVote = GetRemote(ReplicatedStorage, 'Remotes.DungeonWaveVote'),
        OpenMerchant = GetRemote(ReplicatedStorage, 'Remotes.MerchantRemotes.OpenMerchantUI'),
        MerchantBuy = GetRemote(ReplicatedStorage, 'Remotes.MerchantRemotes.PurchaseMerchantItem'),
        ValentineBuy = GetRemote(ReplicatedStorage, 'Remotes.ValentineMerchantRemotes.PurchaseValentineMerchantItem'),
        SummonBoss = GetRemote(ReplicatedStorage, 'Remotes.RequestSummonBoss'),
        JJKSummonBoss = GetRemote(ReplicatedStorage, 'Remotes.RequestSpawnStrongestBoss'),
        RimuruBoss = GetRemote(ReplicatedStorage, 'RemoteEvents.RequestSpawnRimuru'),
        AnosBoss = GetRemote(ReplicatedStorage, 'Remotes.RequestSpawnAnosBoss'),
        TrueAizenBoss = GetRemote(ReplicatedStorage, 'RemoteEvents.RequestSpawnTrueAizen'),
        AtomicBoss = GetRemote(ReplicatedStorage, 'RemoteEvents.RequestSpawnAtomic'),
        ReqInventory = GetRemote(ReplicatedStorage, 'Remotes.RequestInventory'),
        Ascend = GetRemote(ReplicatedStorage, 'RemoteEvents.RequestAscend'),
        CloseAscend = GetRemote(ReplicatedStorage, 'RemoteEvents.CloseAscendUI'),
        SkillTreeUpgrade = GetRemote(ReplicatedStorage, 'RemoteEvents.SkillTreeUpgrade'),
        RollTrait = GetRemote(ReplicatedStorage, 'RemoteEvents.TraitReroll'),
        TraitConfirm = GetRemote(ReplicatedStorage, 'RemoteEvents.TraitConfirm'),
        RaceReroll = GetRemote(ReplicatedStorage, 'Remotes.UseItem'),
        ClanReroll = GetRemote(ReplicatedStorage, 'Remotes.UseItem'),
        ArtifactClaim = GetRemote(ReplicatedStorage, 'RemoteEvents.ArtifactMilestoneClaimReward'),
        ArtifactMassDelete = GetRemote(ReplicatedStorage, 'RemoteEvents.ArtifactMassDeleteByUUIDs'),
        ArtifactMassUpgrade = GetRemote(ReplicatedStorage, 'RemoteEvents.ArtifactMassUpgrade'),
        ArtifactLock = GetRemote(ReplicatedStorage, 'RemoteEvents.ArtifactLock'),
        ArtifactEquip = GetRemote(ReplicatedStorage, 'RemoteEvents.ArtifactEquip'),
        LoadoutLoad = GetRemote(ReplicatedStorage, 'RemoteEvents.LoadoutLoad'),
        EquipTitle = GetRemote(ReplicatedStorage, 'RemoteEvents.TitleEquip'),
        EquipRune = GetRemote(ReplicatedStorage, 'Remotes.EquipRune'),
    }
    local function GetSafeModule(Parent, Name)
        local Object = Parent and Parent:FindFirstChild(Name)
        if Object and Object:IsA('ModuleScript') then
            local Ok, Result = pcall(require, Object)
            if Ok then
                return Result
            end
        end
        return nil
    end
    local Modules = {
        Quests = GetSafeModule(ReplicatedStorage:FindFirstChild('Modules'), 'QuestConfig') or {RepeatableQuests = {}, Questlines = {}},
        WeaponClass = GetSafeModule(ReplicatedStorage:FindFirstChild('Modules'), 'WeaponClassification') or {Tools = {}},
    }
    local PATH = {
        Mobs = Workspace:FindFirstChild('NPCs') or Workspace:WaitForChild('NPCs', 10),
        InteractNPCs = Workspace:FindFirstChild('ServiceNPCs') or Workspace:WaitForChild('ServiceNPCs', 10),
    }
    local function SafeFire(Remote, ...)
        if Remote and Remote.FireServer then
            task.defer(pcall, Remote.FireServer, Remote, ...)
        end
    end
    local function SafeInvoke(Remote, ...)
        if Remote and Remote.InvokeServer then
            local Args = {...}
            local Result
            local Done = false
            task.spawn(function()
                local Ok, Res = pcall(function()
                    return Remote:InvokeServer(unpack(Args))
                end)
                if Ok then
                    Result = Res
                end
                Done = true
            end)
            local Started = tick()
            repeat task.wait() until Done or tick() - Started > 2
            return Result
        end
    end
    local function GetCharacter()
        local Character = LocalPlayer.Character
        if Character and Character:FindFirstChild('HumanoidRootPart') and Character:FindFirstChildOfClass('Humanoid') then
            return Character
        end
        return nil
    end
    local function GetRoot()
        local Character = GetCharacter()
        return Character and Character:FindFirstChild('HumanoidRootPart')
    end
    local function GetHumanoid()
        local Character = GetCharacter()
        return Character and Character:FindFirstChildOfClass('Humanoid')
    end
    local function Alive(Model)
        local Humanoid = Model and Model:FindFirstChildOfClass('Humanoid')
        return Humanoid and Humanoid.Health > 0
    end
    local function Pivot(Object)
        if not Object then
            return nil
        end
        if typeof(Object) == 'CFrame' then
            return Object
        end
        if typeof(Object) == 'Vector3' then
            return CFrame.new(Object)
        end
        if typeof(Object) == 'Instance' then
            if Object:IsA('BasePart') then
                return Object.CFrame
            end
            if Object:IsA('Model') then
                return Object:GetPivot()
            end
        end
        return nil
    end
    local function CleanName(Name)
        return tostring(Name or ''):gsub('%d+$', ''):gsub('_', ' '):gsub('(%l)(%u)', '%1 %2'):gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', '')
    end
    local function DungeonKey(Name)
        return ({['Cid Dungeon'] = 'CidDungeon', ['Rune Dungeon'] = 'RuneDungeon', ['Double Dungeon'] = 'DoubleDungeon', ['Boss Rush'] = 'BossRush', ['Infinite Tower'] = 'InfiniteTower'})[Name] or Name or 'CidDungeon'
    end
    local function SaveNoclipPart(Part)
        if Part and Part:IsA('BasePart') and NoclipParts[Part] == nil then
            NoclipParts[Part] = Part.CanCollide
            Part.CanCollide = false
        elseif Part and Part:IsA('BasePart') then
            Part.CanCollide = false
        end
    end
    local function ApplyNoclip()
        local Character = GetCharacter()
        if not Character then
            return
        end
        for _, Object in ipairs(Character:GetChildren()) do
            SaveNoclipPart(Object)
            for _, Child in ipairs(Object:GetChildren()) do
                SaveNoclipPart(Child)
            end
        end
    end
    local function RestoreNoclip()
        for Part, Value in pairs(NoclipParts) do
            if Part and Part.Parent then
                Part.CanCollide = Value
            end
            NoclipParts[Part] = nil
        end
    end
    local function GetTweenProxy(Root)
        if TweenProxy and TweenProxy.Parent then
            return TweenProxy
        end
        TweenProxy = Instance.new('Part')
        TweenProxy.Name = 'SolarixSailorTweenProxy'
        TweenProxy.Anchored = true
        TweenProxy.CanCollide = false
        TweenProxy.CanTouch = false
        TweenProxy.CanQuery = false
        TweenProxy.Transparency = 1
        TweenProxy.Size = Vector3.new(1, 1, 1)
        TweenProxy.CFrame = Root.CFrame
        TweenProxy.Parent = Workspace
        return TweenProxy
    end
    function StopTween()
        if CurrentTween then
            CurrentTween:Cancel()
            CurrentTween = nil
        end
        if CurrentTweenConnection then
            CurrentTweenConnection:Disconnect()
            CurrentTweenConnection = nil
        end
        if CurrentTweenCompleted then
            CurrentTweenCompleted:Disconnect()
            CurrentTweenCompleted = nil
        end
        CurrentTweenTarget = nil
        RestoreNoclip()
        local Root = GetRoot()
        local Humanoid = GetHumanoid()
        if Root then
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            local BodyClip = Root:FindFirstChild('SolarixSailorBodyClip')
            if BodyClip then
                BodyClip:Destroy()
            end
        end
        if Humanoid then
            Humanoid.PlatformStand = false
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
    local function Tween(Target)
        local TargetCF = Pivot(Target)
        if not TargetCF then
            return
        end
        local Character = GetCharacter()
        local Root = Character and Character:FindFirstChild('HumanoidRootPart')
        local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
        if not Character or not Root or not Humanoid or Humanoid.Health <= 0 then
            return
        end
        local Distance = (Root.Position - TargetCF.Position).Magnitude
        if Distance <= TargetDistance then
            if CurrentTween then
                CurrentTween:Cancel()
                CurrentTween = nil
            end
            if CurrentTweenConnection then
                CurrentTweenConnection:Disconnect()
                CurrentTweenConnection = nil
            end
            if CurrentTweenCompleted then
                CurrentTweenCompleted:Disconnect()
                CurrentTweenCompleted = nil
            end
            CurrentTweenTarget = TargetCF
            ApplyNoclip()
            local BodyClip = Root:FindFirstChild('SolarixSailorBodyClip')
            if not BodyClip then
                BodyClip = Instance.new('BodyVelocity')
                BodyClip.Name = 'SolarixSailorBodyClip'
                BodyClip.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                BodyClip.Velocity = Vector3.zero
                BodyClip.Parent = Root
            end
            if (Root.Position - TargetCF.Position).Magnitude > 1.25 then
                Root.CFrame = TargetCF
            end
            Root.AssemblyLinearVelocity = Vector3.zero
            Root.AssemblyAngularVelocity = Vector3.zero
            Humanoid.PlatformStand = true
            Humanoid.Sit = false
            Humanoid:ChangeState(11)
            return
        end
        if CurrentTweenTarget and (CurrentTweenTarget.Position - TargetCF.Position).Magnitude <= 5 and CurrentTween and CurrentTween.PlaybackState == Enum.PlaybackState.Playing then
            return
        end
        if CurrentTween then
            CurrentTween:Cancel()
            CurrentTween = nil
        end
        if CurrentTweenCompleted then
            CurrentTweenCompleted:Disconnect()
            CurrentTweenCompleted = nil
        end
        CurrentTweenTarget = TargetCF
        ApplyNoclip()
        local BodyClip = Root:FindFirstChild('SolarixSailorBodyClip')
        if not BodyClip then
            BodyClip = Instance.new('BodyVelocity')
            BodyClip.Name = 'SolarixSailorBodyClip'
            BodyClip.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            BodyClip.Velocity = Vector3.zero
            BodyClip.Parent = Root
        end
        local Proxy = GetTweenProxy(Root)
        Proxy.CFrame = Root.CFrame
        if not CurrentTweenConnection then
            CurrentTweenConnection = RunService.Heartbeat:Connect(function()
                if not CurrentTween then
                    return
                end
                local Char = GetCharacter()
                local Hrp = Char and Char:FindFirstChild('HumanoidRootPart')
                local Hum = Char and Char:FindFirstChildOfClass('Humanoid')
                if Hrp and Hum and Hum.Health > 0 then
                    Hrp.CFrame = Proxy.CFrame
                    Hrp.AssemblyLinearVelocity = Vector3.zero
                    Hrp.AssemblyAngularVelocity = Vector3.zero
                    Hum.PlatformStand = true
                    if Hum.Sit then
                        Hum.Sit = false
                    end
                    Hum:ChangeState(11)
                end
            end)
        end
        CurrentTween = TweenService:Create(Proxy, TweenInfo.new(math.max(Distance / TweenSpeed, 0.05), Enum.EasingStyle.Linear), {CFrame = TargetCF})
        CurrentTweenCompleted = CurrentTween.Completed:Connect(function(State)
            if State == Enum.PlaybackState.Completed then
                local Char = GetCharacter()
                local Hrp = Char and Char:FindFirstChild('HumanoidRootPart')
                if Hrp then
                    Hrp.CFrame = TargetCF
                    Hrp.AssemblyLinearVelocity = Vector3.zero
                    Hrp.AssemblyAngularVelocity = Vector3.zero
                end
            end
            StopTween()
        end)
        CurrentTween:Play()
    end
    local function CreateStopTweenButton()
        local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
        if PlayerGui:FindFirstChild('StopTweenGui') then
            PlayerGui.StopTweenGui:Destroy()
        end
        local Gui = Instance.new('ScreenGui')
        Gui.Name = 'StopTweenGui'
        Gui.Parent = PlayerGui
        Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        Gui.DisplayOrder = 1
        Gui.ResetOnSpawn = false
        local Frame = Instance.new('Frame')
        Frame.Parent = Gui
        Frame.AnchorPoint = Vector2.new(1, 0.5)
        Frame.BackgroundColor3 = Color3.fromRGB(26, 12, 8)
        Frame.BackgroundTransparency = 0.18
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.new(0, 108, 0, 36)
        Frame.Position = UDim2.new(1, -10, 0.5, 0)
        Frame.Active = true
        Frame.ClipsDescendants = true
        local Corner = Instance.new('UICorner')
        Corner.Parent = Frame
        Corner.CornerRadius = UDim.new(0, 14)
        local Gradient = Instance.new('UIGradient')
        Gradient.Parent = Frame
        Gradient.Rotation = 45
        Gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(44, 15, 8)),
            ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 105, 26)),
            ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 221, 170)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(95, 27, 12)),
        })
        local Button = Instance.new('TextButton')
        Button.Parent = Frame
        Button.BackgroundTransparency = 1
        Button.Size = UDim2.new(1, -8, 1, 0)
        Button.Position = UDim2.new(0, 4, 0, 0)
        Button.Font = Enum.Font.FredokaOne
        Button.Text = 'Stop Tween'
        Button.TextColor3 = Color3.fromRGB(246, 255, 250)
        Button.TextStrokeTransparency = 1
        Button.TextSize = 14
        Button.TextScaled = true
        Button.TextWrapped = false
        Button.MouseButton1Click:Connect(StopTween)
    end
    CreateStopTweenButton()
    LocalPlayer.CharacterAdded:Connect(function(Character)
        StopTween()
        local Humanoid = Character:WaitForChild('Humanoid', 10)
        if Humanoid then
            Humanoid.Died:Connect(StopTween)
        end
    end)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
        LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Died:Connect(StopTween)
    end
    local function UpdateIslandCrystals()
        local Map = {
            Starter = {'StarterIsland', 'SpawnPointCrystal_Starter'},
            Jungle = {'JungleIsland', 'SpawnPointCrystal_Jungle'},
            Desert = {'DesertIsland', 'SpawnPointCrystal_Desert'},
            Snow = {'SnowIsland', 'SpawnPointCrystal_Snow'},
            Sailor = {'SailorIsland', 'SpawnPointCrystal_Sailor'},
            Shibuya = {'ShibuyaStation', 'SpawnPointCrystal_Shibuya'},
            HuecoMundo = {'HuecoMundo', 'SpawnPointCrystal_HuecoMundo'},
            Boss = {'BossIsland', 'SpawnPointCrystal_Boss'},
            Dungeon = {'Main Temple', 'SpawnPointCrystal_Dungeon'},
            Shinjuku = {'ShinjukuIsland', 'SpawnPointCrystal_Shinjuku'},
            Valentine = {'ValentineIsland', 'SpawnPointCrystal_Valentine'},
            Slime = {'SlimeIsland', 'SpawnPointCrystal_Slime'},
            Academy = {'AcademyIsland', 'SpawnPointCrystal_Academy'},
            Judgement = {'JudgementIsland', 'SpawnPointCrystal_Judgement'},
            SoulSociety = {'SoulSociety', 'SpawnPointCrystal_SoulSociety'},
            Tower = {'TowerIsland', 'SpawnPointCrystal_Tower'},
        }
        for Name, Data in pairs(Map) do
            local Island = Workspace:FindFirstChild(Data[1])
            CachedCrystals[Name] = Island and Island:FindFirstChild(Data[2])
        end
    end
    local function UpdateNPCLists()
        table.clear(CachedMobs)
        table.clear(CachedBosses)
        table.clear(CachedNPCs)
        table.clear(Tables.Mob)
        table.clear(Tables.Boss)
        table.clear(Tables.NPC)
        local UniqueMob = {}
        local UniqueBoss = {}
        if PATH.Mobs then
            for _, Npc in ipairs(PATH.Mobs:GetChildren()) do
                if Npc:IsA('Model') then
                    local Name = CleanName(Npc.Name)
                    if Name ~= '' then
                        if Name:lower():find('boss') or Name:lower():find('mini') then
                            if not UniqueBoss[Name] then
                                UniqueBoss[Name] = true
                                table.insert(Tables.Boss, Name)
                            end
                            CachedBosses[#CachedBosses + 1] = Npc
                        else
                            if not UniqueMob[Name] then
                                UniqueMob[Name] = true
                                table.insert(Tables.Mob, Name)
                            end
                            CachedMobs[#CachedMobs + 1] = Npc
                        end
                    end
                end
            end
        end
        if PATH.InteractNPCs then
            for _, Npc in ipairs(PATH.InteractNPCs:GetChildren()) do
                if Npc:IsA('Model') or Npc:IsA('Folder') then
                    table.insert(Tables.NPC, Npc.Name)
                    CachedNPCs[#CachedNPCs + 1] = Npc
                end
            end
        end
        table.sort(Tables.Mob)
        table.sort(Tables.Boss)
        table.sort(Tables.NPC)
    end
    local function CleanText(Text)
        return tostring(Text or ''):gsub('%s+', ''):lower()
    end
    local function GetToolTypeFromModule(ToolName)
        local Target = CleanText(ToolName)
        for ManualName, ToolType in pairs(Tables.ManualWeaponClass) do
            if CleanText(ManualName) == Target then
                return ToolType
            end
        end
        if Modules.WeaponClass and Modules.WeaponClass.Tools then
            for ModuleName, ToolData in pairs(Modules.WeaponClass.Tools) do
                if CleanText(ModuleName) == Target then
                    if type(ToolData) == 'string' then
                        return ToolData
                    elseif type(ToolData) == 'table' then
                        return ToolData.Type or ToolData.Class or ToolData.WeaponType or ToolData.Category
                    end
                end
            end
        end
        local Name = tostring(ToolName or ''):lower()
        if Name == 'combat' or Name:find('combat') then
            return 'Melee'
        elseif Name:find('sword') or Name:find('katana') or Name:find('blade') then
            return 'Sword'
        elseif Name:find('fruit') or Name == 'invisible' or Name == 'bomb' or Name == 'quake' then
            return 'Power'
        end
        return nil
    end
    local function UpdateWeapons()
        table.clear(CachedWeapons.Melee)
        table.clear(CachedWeapons.Sword)
        table.clear(CachedWeapons.Power)
        local Added = {}
        local function Scan(Container)
            if not Container then
                return
            end
            for _, Tool in ipairs(Container:GetChildren()) do
                if Tool:IsA('Tool') and not Added[Tool.Name] then
                    local ToolType = GetToolTypeFromModule(Tool.Name)
                    if CachedWeapons[ToolType] then
                        CachedWeapons[ToolType][#CachedWeapons[ToolType] + 1] = Tool.Name
                        Added[Tool.Name] = true
                    end
                end
            end
        end
        Scan(LocalPlayer.Backpack)
        Scan(LocalPlayer.Character)
    end
    local function UpdateInventory()
        if tick() - LastInventory < 4 then
            return
        end
        LastInventory = tick()
        local Inventory = SafeInvoke(Remotes.ReqInventory)
        if type(Inventory) == 'table' then
            table.clear(CachedItems)
            table.clear(Tables.MerchantItem)
            for _, Item in pairs(Inventory) do
                if type(Item) == 'table' and Item.name then
                    CachedItems[Item.name] = Item.quantity or 1
                    if not table.find(Tables.MerchantItem, Item.name) then
                        table.insert(Tables.MerchantItem, Item.name)
                    end
                elseif type(Item) == 'table' and Item.Name then
                    CachedItems[Item.Name] = Item.Count or Item.Quantity or 1
                    if not table.find(Tables.MerchantItem, Item.Name) then
                        table.insert(Tables.MerchantItem, Item.Name)
                    end
                end
            end
            table.sort(Tables.MerchantItem)
        end
    end
    local function GetNearestIsland(Position, Name)
        local BestName = 'Starter'
        local BestDistance = math.huge
        for IslandName, Crystal in pairs(CachedCrystals) do
            local CF = Pivot(Crystal)
            if CF then
                local Distance = (Position - CF.Position).Magnitude
                if Distance < BestDistance then
                    BestDistance = Distance
                    BestName = IslandName
                end
            end
        end
        if tostring(Name or ''):lower():find('boss') then
            return BestName == 'Starter' and 'Boss' or BestName
        end
        return BestName
    end
    local function GetToolByName(Name)
        local Character = GetCharacter()
        local Backpack = LocalPlayer:FindFirstChild('Backpack')
        return (Character and Character:FindFirstChild(Name)) or (Backpack and Backpack:FindFirstChild(Name))
    end
    local GetEquippedTool
    local LastEquipName = ''
    local LastEquipTick = 0
    local function EquipWeapon()
        UpdateWeapons()
        local List = CachedWeapons[SelectedWeaponType] or CachedWeapons.Melee
        local Weapon = List and List[1]
        local Character = GetCharacter()
        local Backpack = LocalPlayer:FindFirstChild('Backpack')
        local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
        if not Weapon and SelectedWeaponType == 'Melee' then
            local CombatTool = GetToolByName('Combat')
            if CombatTool then
                Weapon = 'Combat'
            end
        end
        if not Weapon or not Character or not Humanoid or Humanoid.Health <= 0 then
            return GetEquippedTool()
        end
        local Current = GetEquippedTool()
        if Current and Current.Name == Weapon then
            return Current
        end
        local Tool = GetToolByName(Weapon)
        if Tool and Tool.Parent == Character then
            return Tool
        end
        if Tool and Tool.Parent == Backpack then
            pcall(function()
                Humanoid:EquipTool(Tool)
            end)
            LastEquipName = Weapon
            LastEquipTick = tick()
            return GetEquippedTool()
        end
        return GetEquippedTool()
    end
    GetEquippedTool = function()
        local Character = GetCharacter()
        return Character and Character:FindFirstChildOfClass('Tool')
    end
    local function UseSelectedSkills()
        if not _G.SolarixSailorAutoSkill then
            return
        end
        local Now = tick()
        if Now - LastSkill < 0.22 then
            return
        end
        local Character = GetCharacter()
        local Tool = Character and Character:FindFirstChildOfClass('Tool')
        if not Tool then
            Tool = EquipWeapon()
        end
        if not Tool then
            return
        end
        local ToolType = GetToolTypeFromModule(Tool.Name)
        for _, Key in ipairs({'Z', 'X', 'C', 'V', 'F'}) do
            if SelectedSkills[Key] then
                if ToolType == 'Power' then
                    SafeFire(Remotes.UseFruit, 'UseAbility', {
                        FruitPower = Tool.Name:gsub(' Fruit', ''),
                        KeyCode = Enum.KeyCode[Key],
                    })
                else
                    SafeFire(Remotes.UseSkill, ({Z = 1, X = 2, C = 3, V = 4, F = 5})[Key])
                end
                task.wait(0.25)
            end
        end
        LastSkill = tick()
    end
    local function Attack()
        local Root = GetRoot()
        if not Root then return end
        EquipWeapon()
        
        local HitCount = 0
        if PATH.Mobs then
            for _, Npc in ipairs(PATH.Mobs:GetChildren()) do
                if Npc:IsA('Model') and Alive(Npc) then
                    local CF = Pivot(Npc)
                    if CF and (Root.Position - CF.Position).Magnitude <= 115 then
                        task.spawn(SafeFire, Remotes.M1, CF.Position)
                        HitCount += 1
                        if HitCount >= 15 then break end
                    end
                end
            end
        end
        
        if HitCount > 0 then task.spawn(UseSelectedSkills) end
        task.spawn(SafeFire, Remotes.M1)
    end
    local function TargetPosition(Target)
        local TargetCF = Pivot(Target)
        if not TargetCF then
            return nil
        end
        local BehindPosition = TargetCF.Position - TargetCF.LookVector * FarmDistance
        return CFrame.new(BehindPosition, TargetCF.Position)
    end
    local function IsTargetName(Target, Name)
        if not Target or not Name or Name == '' then
            return false
        end
        return CleanName(Target.Name) == CleanName(Name)
    end
    local function IsSmartMatch(NpcName, TargetMobType)
        return CleanName(NpcName):lower() == CleanName(TargetMobType):lower()
    end
    local function IsValidTarget(Npc)
        if not Npc or not Npc.Parent then
            return false
        end
        local Humanoid = Npc:FindFirstChildOfClass('Humanoid')
        if not Humanoid then
            return false
        end
        if Npc:FindFirstChild('IK_Active') then
            return true
        end
        return Humanoid.Health > 0
    end
    local function GetBestMobCluster(MobNames)
        if type(MobNames) ~= 'table' or not PATH.Mobs then
            return nil
        end
        local Root = GetRoot()
        local Mobs = {}
        for _, Npc in ipairs(PATH.Mobs:GetChildren()) do
            if Npc:IsA('Model') and IsValidTarget(Npc) and MobNames[CleanName(Npc.Name):lower()] then
                Mobs[#Mobs + 1] = Npc
            end
        end
        if #Mobs == 0 then
            return nil
        end
        local Best = Mobs[1]
        local BestScore = -math.huge
        for _, A in ipairs(Mobs) do
            local ACF = Pivot(A)
            if ACF then
                local Score = 0
                for _, B in ipairs(Mobs) do
                    local BCF = Pivot(B)
                    if BCF and (ACF.Position - BCF.Position).Magnitude <= 45 then
                        Score += 1
                    end
                end
                if Root then
                    Score -= (Root.Position - ACF.Position).Magnitude / 5000
                end
                if Score > BestScore then
                    Best = A
                    BestScore = Score
                end
            end
        end
        return Best
    end
    local function GetPlayerLevel()
        local Level = 1
        pcall(function()
            if LocalPlayer:FindFirstChild('Data') and LocalPlayer.Data:FindFirstChild('Level') then
                Level = tonumber(LocalPlayer.Data.Level.Value) or Level
            elseif LocalPlayer:FindFirstChild('leaderstats') and LocalPlayer.leaderstats:FindFirstChild('Level') then
                Level = tonumber(LocalPlayer.leaderstats.Level.Value) or Level
            elseif LocalPlayer:FindFirstChild('PlayerStats') and LocalPlayer.PlayerStats:FindFirstChild('lvl') then
                Level = tonumber(LocalPlayer.PlayerStats.lvl.Value) or Level
            end
        end)
        return Level
    end
    local function NumberValue(Value)
        return tonumber(Value) or tonumber(tostring(Value or ''):match('%d+')) or 0
    end
    local function QuestLevel(QuestData)
        return NumberValue(QuestData.recommendedLevel) > 0 and NumberValue(QuestData.recommendedLevel) or NumberValue(QuestData.LevelReq) > 0 and NumberValue(QuestData.LevelReq) or NumberValue(QuestData.levelReq) > 0 and NumberValue(QuestData.levelReq) or NumberValue(QuestData.Level) > 0 and NumberValue(QuestData.Level) or NumberValue(QuestData.level) > 0 and NumberValue(QuestData.level) or NumberValue(QuestData.requiredLevel)
    end
    local function EnsureQuestSettings()
        local SettingsUI = PlayerGui:FindFirstChild('SettingsUI')
        local Frame = SettingsUI and SettingsUI:FindFirstChild('MainFrame')
        local Content = Frame and Frame:FindFirstChild('Frame') and Frame.Frame:FindFirstChild('Content')
        local SettingsTab = Content and Content:FindFirstChild('SettingsTabFrame')
        if SettingsTab then
            local EnableQuestRepeat = SettingsTab:FindFirstChild('Toggle_EnableQuestRepeat', true)
            if EnableQuestRepeat and EnableQuestRepeat:FindFirstChild('SettingsHolder') and EnableQuestRepeat.SettingsHolder:FindFirstChild('Off') and EnableQuestRepeat.SettingsHolder.Off.Visible then
                SafeFire(Remotes.SettingsToggle, 'EnableQuestRepeat', true)
                task.wait(0.3)
            end
            local AutoQuestRepeat = SettingsTab:FindFirstChild('Toggle_AutoQuestRepeat', true)
            if AutoQuestRepeat and AutoQuestRepeat:FindFirstChild('SettingsHolder') and AutoQuestRepeat.SettingsHolder:FindFirstChild('Off') and AutoQuestRepeat.SettingsHolder.Off.Visible then
                SafeFire(Remotes.SettingsToggle, 'AutoQuestRepeat', true)
            end
            return
        end
        SafeFire(Remotes.SettingsToggle, 'EnableQuestRepeat', true)
        SafeFire(Remotes.SettingsToggle, 'AutoQuestRepeat', true)
    end
    local function GetLevelQuestNPC()
        local Level = GetPlayerLevel()
        local TargetNPC = nil
        local TargetLevel = -1
        local LowestNPC = nil
        local LowestLevel = math.huge
        local Repeatable = Modules.Quests and Modules.Quests.RepeatableQuests or {}
        for NpcId, QuestData in pairs(Repeatable) do
            local Required = QuestLevel(QuestData or {})
            local HasMob = QuestData and QuestData.requirements and QuestData.requirements[1] and QuestData.requirements[1].npcType
            if HasMob and Required > 0 then
                if Required < LowestLevel then
                    LowestNPC = NpcId
                    LowestLevel = Required
                end
                if Level >= Required and Required > TargetLevel then
                    TargetNPC = NpcId
                    TargetLevel = Required
                end
            end
        end
        return TargetNPC or LowestNPC or 'QuestNPC1'
    end
    local function UpdateQuest()
        if not _G.SolarixSailorLevelFarm then
            return nil
        end
        EnsureQuestSettings()
        local TargetNPC = GetLevelQuestNPC()
        local QuestUI = PlayerGui:FindFirstChild('QuestUI') and PlayerGui.QuestUI:FindFirstChild('Quest')
        if not QuestUI then
            SafeFire(Remotes.QuestAccept, TargetNPC)
            LastTargetName = TargetNPC
            return TargetNPC
        end
        if LastTargetName ~= TargetNPC or not QuestUI.Visible then
            SafeFire(Remotes.QuestAbandon, 'repeatable')
            local AbandonTick = 0
            while _G.SolarixSailorLevelFarm and QuestUI.Visible and AbandonTick < 15 do
                task.wait(0.2)
                AbandonTick += 1
            end
            if not _G.SolarixSailorLevelFarm then
                return nil
            end
            SafeFire(Remotes.QuestAccept, TargetNPC)
            local AcceptTick = 0
            while _G.SolarixSailorLevelFarm and not QuestUI.Visible and AcceptTick < 20 do
                task.wait(0.2)
                AcceptTick += 1
                if AcceptTick % 5 == 0 then
                    SafeFire(Remotes.QuestAccept, TargetNPC)
                end
            end
            if QuestUI.Visible and _G.SolarixSailorLevelFarm then
                LastTargetName = TargetNPC
            end
        end
        return _G.SolarixSailorLevelFarm and TargetNPC or nil
    end
    local function FindNearestByName(Name, BossOnly)
        local Root = GetRoot()
        local Best
        local BestDistance = math.huge
        if not Root or not PATH.Mobs then
            return nil
        end
        for _, Npc in ipairs(PATH.Mobs:GetChildren()) do
            if Npc:IsA('Model') and IsValidTarget(Npc) then
                local Clean = CleanName(Npc.Name)
                local IsBoss = Clean:lower():find('boss') or Clean:lower():find('mini')
                if (not Name or Name == '' or Clean == CleanName(Name)) and ((BossOnly and IsBoss) or (not BossOnly and not IsBoss)) then
                    local CF = Pivot(Npc)
                    if CF then
                        local Distance = (Root.Position - CF.Position).Magnitude
                        if Distance < BestDistance then
                            BestDistance = Distance
                            Best = Npc
                        end
                    end
                end
            end
        end
        return Best
    end
    local function GetQuestMobName(QuestNPC)
        local QuestData = Modules.Quests and Modules.Quests.RepeatableQuests and Modules.Quests.RepeatableQuests[QuestNPC]
        if not QuestData or not QuestData.requirements or not QuestData.requirements[1] then
            return nil
        end
        return QuestData.requirements[1].npcType and CleanName(QuestData.requirements[1].npcType):lower() or nil
    end
    local function FindLevelMob()
        if not _G.SolarixSailorLevelFarm then
            return nil
        end
        local QuestNPC = UpdateQuest()
        if not QuestNPC then
            return nil
        end
        local TargetMobType = GetQuestMobName(QuestNPC)
        if not TargetMobType or not PATH.Mobs then
            return nil
        end
        local Root = GetRoot()
        local Target = nil
        local Distance = math.huge
        for _, Npc in ipairs(PATH.Mobs:GetChildren()) do
            if Npc:IsA('Model') and IsValidTarget(Npc) then
                local NpcCleanName = CleanName(Npc.Name):lower()
                if NpcCleanName == TargetMobType or NpcCleanName:find(TargetMobType, 1, true) or TargetMobType:find(NpcCleanName, 1, true) then
                    local CF = Pivot(Npc)
                    if CF then
                        local NewDistance = Root and (Root.Position - CF.Position).Magnitude or 0
                        if NewDistance < Distance then
                            Target = Npc
                            Distance = NewDistance
                        end
                    end
                end
            end
        end
        return Target
    end    
    local function AcceptQuestForTarget(Target)
        if _G.SolarixSailorLevelFarm then
            UpdateQuest()
        end
    end
    local function SailorFarmActive()
        return _G.SolarixSailorLevelFarm or _G.SolarixSailorMobFarm or _G.SolarixSailorAllMobFarm or _G.SolarixSailorBossesFarm or _G.SolarixSailorAllBossesFarm or _G.SolarixSailorSummonBossFarm or _G.SolarixSailorDungeonAutofarm
    end
    local function StopSailorFarmMotion()
        StopTween()
        LastTargetName = ''
    end
    local function MoveAndKill(Target, UseQuest)
        if not SailorFarmActive() or not Target or not Alive(Target) then
            if not SailorFarmActive() then
                StopSailorFarmMotion()
            end
            return
        end
        if UseQuest then
            AcceptQuestForTarget(Target)
            if not _G.SolarixSailorLevelFarm then
                StopSailorFarmMotion()
                return
            end
        end
        local MoveCF = TargetPosition(Target)
        if MoveCF and SailorFarmActive() then
            Tween(MoveCF)
        end
        if SailorFarmActive() then
            Attack()
        end
    end
    local function TeleportIsland(Name)
        if Name and Name ~= '' then
            SafeFire(Remotes.TPPortal, Name)
            LastIsland = Name
        end
    end
    local function Summon(Name)
        if Name == 'StrongestHistory' or Name == 'StrongestToday' then
            SafeFire(Remotes.JJKSummonBoss, Name)
        elseif Name == 'Rimuru' then
            SafeFire(Remotes.RimuruBoss)
        elseif Name == 'Anos' then
            SafeFire(Remotes.AnosBoss)
        elseif Name == 'TrueAizen' then
            SafeFire(Remotes.TrueAizenBoss)
        elseif Name == 'Atomic' then
            SafeFire(Remotes.AtomicBoss)
        elseif Name and Name ~= '' then
            SafeFire(Remotes.SummonBoss, Name)
        end
    end
    local WindUI = loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/latest/download/main.lua'))()
    local Library = WindUI
    pcall(function()
        Library:SetFont('rbxasset://fonts/families/FredokaOne.json')
    end)
    Library:AddTheme({
        Name = 'SolarixFlare',
        Accent = Color3.fromHex('#FF8A3D'),
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#1A0B08'), Transparency = 0.03},
            ['46'] = {Color = Color3.fromHex('#3A120B'), Transparency = 0.05},
            ['100'] = {Color = Color3.fromHex('#7A2413'), Transparency = 0.08},
        }, {Rotation = 28}),
        Outline = Color3.fromHex('#FFC68A'),
        Text = Color3.fromHex('#FFF8EF'),
        Placeholder = Color3.fromHex('#D6A383'),
        Button = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#30100A'), Transparency = 0.02},
            ['52'] = {Color = Color3.fromHex('#6E2112'), Transparency = 0.04},
            ['100'] = {Color = Color3.fromHex('#FF7A22'), Transparency = 0.08},
        }, {Rotation = 22}),
        Icon = Color3.fromHex('#FFD2A1'),
    })
    Library:SetTheme('SolarixFlare')
    local Window = Library:CreateWindow({
        Title = 'Solarix Hub',
        Icon = 'lucide:flame',
        Folder = 'Solarix Hub',
        Size = UDim2.fromOffset(580, 460),
        MinSize = Vector2.new(560, 350),
        MaxSize = Vector2.new(580, 460),
        ToggleKey = Enum.KeyCode.G,
        Transparent = true,
        Theme = 'SolarixFlare',
        Acrylic = false,
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#160807'), Transparency = 0.08},
            ['38'] = {Color = Color3.fromHex('#42130B'), Transparency = 0.03},
            ['67'] = {Color = Color3.fromHex('#D94C1A'), Transparency = 0.16},
            ['100'] = {Color = Color3.fromHex('#160807'), Transparency = 0.06},
        }, {
            Rotation = 35,
        }),
        Resizable = false,
        SideBarWidth = 190,
        HideSearchBar = false,
        ScrollBarEnabled = false,
        User = {Enabled = false},
        OpenButton = {
            Title = 'Solarix Hub',
            Icon = 'lucide:flame',
            Enabled = true,
            Draggable = true,
            CornerRadius = UDim.new(0, 14),
            StrokeThickness = 1.5,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex('#24100B')),
                ColorSequenceKeypoint.new(0.45, Color3.fromHex('#FF6B1A')),
                ColorSequenceKeypoint.new(0.7, Color3.fromHex('#FFE0B5')),
                ColorSequenceKeypoint.new(1, Color3.fromHex('#5A1A0E')),
            }),
        },
    })
    local Colors = {
        Info = Color3.fromHex('#FFD1A1'),
        Green = Color3.fromHex('#FF8A3D'),
        Yellow = Color3.fromHex('#FFD166'),
        Purple = Color3.fromHex('#E0A3FF'),
        Cyan = Color3.fromHex('#FFB26B'),
        Orange = Color3.fromHex('#FF9E4A'),
        Red = Color3.fromHex('#FF5A3D'),
        Blue = Color3.fromHex('#F08B5F'),
        Grey = Color3.fromHex('#B98C75'),
    }
    local function TabOptions(Title, Icon, IconColor)
        return {Title = Title, Icon = Icon, IconColor = IconColor, IconShape = 'Square', Border = true}
    end
    local Tabs = {
        Info = Window:Tab(TabOptions('Info', 'solar:info-circle-bold', Colors.Info)),
        General = Window:Tab(TabOptions('General', 'solar:play-circle-bold', Colors.Green)),
        Boss = Window:Tab(TabOptions('Boss', 'solar:crown-star-bold', Colors.Red)),
        Dungeon = Window:Tab(TabOptions('Dungeon', 'solar:ghost-bold', Colors.Purple)),
        Stats = Window:Tab(TabOptions('Stats', 'solar:graph-up-bold', Colors.Yellow)),
        Inventory = Window:Tab(TabOptions('Inventory', 'solar:backpack-bold', Colors.Orange)),
        Shop = Window:Tab(TabOptions('Shop', 'solar:cart-large-minimalistic-bold', Colors.Green)),
    }
    Tabs.Info:Paragraph({
        Title = 'Solarix Hub',
        Desc = "Press 'G' to toggle UI.",
        Color = 'Orange',
    })
    Tabs.Info:Paragraph({
        Title = 'Support Game',
        Desc = '[+] Blox Fruits\n[+] Doors\n[+] Sailor Piece\n[+] Survive Zombie Arena',
        Color = 'Orange',
    })
    UpdateIslandCrystals()
    UpdateNPCLists()
    UpdateWeapons()
    Tabs.General:Dropdown({
        Title = 'Weapon',
        Values = Tables.Weapon,
        Value = 'Melee',
        Multi = false,
        Callback = function(Value)
            SelectedWeaponType = Value or 'Melee'
        end,
    })
    Tabs.General:Slider({
        Title = 'Distance',
        Value = {Min = 3, Max = 40, Default = FarmDistance},
        Callback = function(Value)
            FarmDistance = tonumber(Value) or FarmDistance
        end,
    })
    Tabs.General:Dropdown({
        Title = 'Select Skills',
        Values = {'Z', 'X', 'C', 'V', 'F'},
        Multi = true,
        Value = {'Z', 'X', 'C', 'V', 'F'},
        Callback = function(Value)
            table.clear(SelectedSkills)
            if type(Value) == 'table' then
                for Key, Enabled in pairs(Value) do
                    if type(Key) == 'number' then
                        SelectedSkills[Enabled] = true
                    elseif Enabled then
                        SelectedSkills[Key] = true
                    end
                end
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Auto Skill',
        Value = true,
        Callback = function(Value)
            _G.SolarixSailorAutoSkill = Value
        end,
    })
    Tabs.General:Toggle({
        Title = 'Auto Reconnect',
        Value = true,
        Callback = function(Value)
            _G.SolarixSailorAutoReconnect = Value
            if Value then
                SolarixSailorReconnect()
            elseif SolarixSailorReconnectConnection then
                SolarixSailorReconnectConnection:Disconnect()
                SolarixSailorReconnectConnection = nil
            end
        end,
    })
    local MobDropdown = Tabs.General:Dropdown({
        Title = 'Select Mob',
        Values = Tables.Mob,
        Value = '',
        Multi = false,
        Callback = function(Value)
            SelectedMob = Value or ''
        end,
    })
    Tabs.General:Button({
        Title = 'Refresh Mobs',
        Callback = function()
            UpdateNPCLists()
            if MobDropdown and MobDropdown.Refresh then
                MobDropdown:Refresh(Tables.Mob)
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Level Farm',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorLevelFarm = Value
            if not Value then
                LastTargetName = ''
                StopSailorFarmMotion()
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Mob Farm',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorMobFarm = Value
            if not Value then
                StopSailorFarmMotion()
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'All Mob Farm',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAllMobFarm = Value
            if not Value then
                StopSailorFarmMotion()
            end
        end,
    })
    local BossDropdown = Tabs.Boss:Dropdown({
        Title = 'Select Boss',
        Values = Tables.Boss,
        Value = '',
        Multi = false,
        Callback = function(Value)
            SelectedBoss = Value or ''
        end,
    })
    Tabs.Boss:Button({
        Title = 'Refresh Bosses',
        Callback = function()
            UpdateNPCLists()
            if BossDropdown and BossDropdown.Refresh then
                BossDropdown:Refresh(Tables.Boss)
            end
        end,
    })
    Tabs.Boss:Toggle({
        Title = 'Bosses Farm',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorBossesFarm = Value
            if not Value then
                StopSailorFarmMotion()
            end
        end,
    })
    Tabs.Boss:Toggle({
        Title = 'All Bosses Farm',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAllBossesFarm = Value
            if not Value then
                StopSailorFarmMotion()
            end
        end,
    })
    Tabs.Boss:Dropdown({
        Title = 'Select Summon',
        Values = Tables.Summon,
        Value = '',
        Multi = false,
        Callback = function(Value)
            SelectedSummon = Value or ''
        end,
    })
    Tabs.Boss:Toggle({
        Title = 'Auto Summon',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoSummon = Value
        end,
    })
    Tabs.Boss:Toggle({
        Title = 'Summon Boss Farm',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorSummonBossFarm = Value
        end,
    })
    Tabs.Dungeon:Dropdown({
        Title = 'Select Dungeon',
        Values = Tables.Dungeon,
        Value = 'Cid Dungeon',
        Multi = false,
        Callback = function(Value)
            SelectedDungeon = DungeonKey(Value)
        end,
    })
    Tabs.Dungeon:Toggle({
        Title = 'Auto Dungeon',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoDungeon = Value
        end,
    })
    Tabs.Dungeon:Toggle({
        Title = 'Auto Infinite Tower',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoInfiniteTower = Value
        end,
    })
    Tabs.Dungeon:Toggle({
        Title = 'Dungeon Autofarm',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorDungeonAutofarm = Value
        end,
    })
    Tabs.Stats:Dropdown({
        Title = 'Select Stats',
        Values = Tables.Stats,
        Value = {'Melee', 'Defense'},
        Multi = true,
        Callback = function(Value)
            table.clear(SelectedStats)
            if type(Value) == 'table' then
                for Key, Enabled in pairs(Value) do
                    if Enabled == true then
                        SelectedStats[Key] = true
                    elseif type(Key) == 'number' then
                        SelectedStats[Enabled] = true
                    end
                end
            end
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Stats',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoStats = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Ascend',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoAscend = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Trait',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoTrait = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Race',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoRace = Value
        end,
    })
    Tabs.Stats:Toggle({
        Title = 'Auto Clan',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoClan = Value
        end,
    })
    Tabs.Inventory:Dropdown({
        Title = 'Craft Item',
        Values = Tables.CraftItem,
        Value = {},
        Multi = true,
        Callback = function(Value)
            SelectedCraftItems = Value or {}
        end,
    })
    Tabs.Inventory:Toggle({
        Title = 'Auto Craft Item',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoCraftItem = Value
        end,
    })
    Tabs.Inventory:Toggle({
        Title = 'Artifact Milestone',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorArtifactMilestone = Value
        end,
    })
    Tabs.Inventory:Toggle({
        Title = 'Artifact Upgrade',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorArtifactUpgrade = Value
        end,
    })
    Tabs.Inventory:Toggle({
        Title = 'Artifact Equip',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorArtifactEquip = Value
        end,
    })
    Tabs.Inventory:Button({
        Title = 'Redeem Codes',
        Callback = function()
            for _, Code in ipairs(SelectedCodes) do
                SafeFire(Remotes.UseCode, Code)
            end
        end,
    })
    Tabs.Shop:Dropdown({
        Title = 'Merchant Items',
        Values = Tables.MerchantItem,
        Value = {},
        Multi = true,
        Callback = function(Value)
            SelectedMerchantItems = Value or {}
        end,
    })
    Tabs.Shop:Button({
        Title = 'Refresh Inventory',
        Callback = function()
            LastInventory = 0
            UpdateInventory()
        end,
    })
    Tabs.Shop:Toggle({
        Title = 'Auto Merchant',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoMerchant = Value
        end,
    })
    Tabs.Shop:Toggle({
        Title = 'Auto Dungeon Merchant',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoDungeonMerchant = Value
        end,
    })
    Tabs.Shop:Toggle({
        Title = 'Auto Valentine Merchant',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoValentineMerchant = Value
        end,
    })
    Tabs.Shop:Toggle({
        Title = 'Auto Tower Merchant',
        Value = false,
        Callback = function(Value)
            _G.SolarixSailorAutoTowerMerchant = Value
        end,
    })
    LocalPlayer.Idled:Connect(function()
        pcall(function()
            VirtualUser:Button2Down(Vector2.new(), Workspace.CurrentCamera.CFrame)
            task.wait()
            VirtualUser:Button2Up(Vector2.new(), Workspace.CurrentCamera.CFrame)
        end)
    end)
    GuiService.ErrorMessageChanged:Connect(function()
        task.delay(2, function()
            pcall(function()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end)
        end)
    end)
    task.spawn(function()
        while task.wait() do
            local Enabled = _G.SolarixSailorLevelFarm or _G.SolarixSailorMobFarm or _G.SolarixSailorAllMobFarm
            if not SolarixStream(Enabled) then continue end
            if not Enabled then
                StopSailorFarmMotion()
                continue
            end
            local Target
            if _G.SolarixSailorLevelFarm then
                Target = FindLevelMob()
                if _G.SolarixSailorLevelFarm then
                    MoveAndKill(Target, true)
                end
            elseif _G.SolarixSailorMobFarm then
                Target = FindNearestByName(SelectedMob, false)
                if _G.SolarixSailorMobFarm then
                    MoveAndKill(Target, false)
                end
            elseif _G.SolarixSailorAllMobFarm then
                UpdateNPCLists()
                for _, Name in ipairs(Tables.Mob) do
                    if not _G.SolarixSailorAllMobFarm then
                        StopSailorFarmMotion()
                        break
                    end
                    Target = FindNearestByName(Name, false)
                    if Target then
                        MoveAndKill(Target, false)
                        break
                    end
                end
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            local Enabled = _G.SolarixSailorBossesFarm or _G.SolarixSailorAllBossesFarm or _G.SolarixSailorSummonBossFarm
            if not SolarixStream(Enabled) then continue end
            local Target
            if _G.SolarixSailorBossesFarm then
                Target = FindNearestByName(SelectedBoss, true)
            elseif _G.SolarixSailorAllBossesFarm or _G.SolarixSailorSummonBossFarm then
                UpdateNPCLists()
                for _, Name in ipairs(Tables.Boss) do
                    Target = FindNearestByName(Name, true)
                    if Target then
                        break
                    end
                end
            end
            if not Target and (_G.SolarixSailorAutoSummon or _G.SolarixSailorSummonBossFarm) then
                Summon(SelectedSummon)
                SolarixStreamDelay(2)
            elseif Target then
                MoveAndKill(Target, false)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixSailorAutoStats) then continue end
            local Points = 0
            pcall(function()
                Points = LocalPlayer.Data.StatPoints.Value
            end)
            if Points > 0 then
                local Active = {}
                for Stat, Enabled in pairs(SelectedStats) do
                    if Enabled then
                        Active[#Active + 1] = Stat
                    end
                end
                local Amount = math.max(1, math.floor(Points / math.max(#Active, 1)))
                for _, Stat in ipairs(Active) do
                    SafeFire(Remotes.AddStat, Stat, Amount)
                end
            end
            SolarixStreamDelay(1)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixSailorAutoAscend or _G.SolarixSailorAutoTrait or _G.SolarixSailorAutoRace or _G.SolarixSailorAutoClan) then continue end
            if _G.SolarixSailorAutoAscend then
                SafeFire(Remotes.Ascend)
                SafeFire(Remotes.CloseAscend)
            end
            if _G.SolarixSailorAutoTrait then
                SafeFire(Remotes.TraitConfirm, true)
                SafeFire(Remotes.RollTrait)
            end
            if _G.SolarixSailorAutoRace then
                SafeFire(Remotes.UseItem, 'Use', 'Race Reroll', 1)
            end
            if _G.SolarixSailorAutoClan then
                SafeFire(Remotes.UseItem, 'Use', 'Clan Reroll', 1)
            end
            SolarixStreamDelay(0.6)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixSailorAutoDungeon or _G.SolarixSailorAutoInfiniteTower or _G.SolarixSailorDungeonAutofarm) then continue end
            if tick() - LastDungeon > 12 then
                if _G.SolarixSailorAutoInfiniteTower then
                    SafeFire(Remotes.OpenDungeon, 'InfiniteTower')
                else
                    SafeFire(Remotes.OpenDungeon, SelectedDungeon)
                end
                LastDungeon = tick()
            end
            local Portal = Workspace:FindFirstChild('ActiveDungeonPortal')
            if Portal then
                Tween(Portal.CFrame)
                local Prompt = Portal:FindFirstChildWhichIsA('ProximityPrompt', true)
                if Prompt and fireproximityprompt then
                    fireproximityprompt(Prompt)
                end
            end
            SafeFire(Remotes.DungeonWaveVote, true)
            if _G.SolarixSailorDungeonAutofarm then
                local Target
                if PATH.Mobs then
                    for _, Npc in ipairs(PATH.Mobs:GetChildren()) do
                        if Npc:IsA('Model') and Alive(Npc) then
                            Target = Npc
                            break
                        end
                    end
                end
                MoveAndKill(Target, false)
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixSailorAutoMerchant or _G.SolarixSailorAutoDungeonMerchant or _G.SolarixSailorAutoValentineMerchant or _G.SolarixSailorAutoTowerMerchant) then continue end
            if tick() - LastMerchant < 1 then
                continue
            end
            LastMerchant = tick()
            for Item, Enabled in pairs(SelectedMerchantItems) do
                local Name = Enabled == true and Item or Enabled
                if type(Name) == 'string' and Name ~= '' then
                    if _G.SolarixSailorAutoValentineMerchant then
                        SafeFire(Remotes.ValentineBuy, Name)
                    else
                        SafeFire(Remotes.MerchantBuy, Name)
                    end
                end
            end
            SolarixStreamDelay(0.7)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixSailorAutoCraftItem or _G.SolarixSailorArtifactMilestone or _G.SolarixSailorArtifactUpgrade or _G.SolarixSailorArtifactEquip) then continue end
            if _G.SolarixSailorAutoCraftItem then
                for Item, Enabled in pairs(SelectedCraftItems) do
                    local Name = Enabled == true and Item or Enabled
                    if Name == 'SlimeKey' then
                        SafeFire(Remotes.SlimeCraft)
                    elseif Name == 'DivineGrail' then
                        SafeFire(Remotes.GrailCraft)
                    end
                end
            end
            if _G.SolarixSailorArtifactMilestone then
                for I = 1, 40 do
                    SafeFire(Remotes.ArtifactClaim, I)
                end
            end
            if _G.SolarixSailorArtifactUpgrade then
                SafeFire(Remotes.ArtifactMassUpgrade)
            end
            if _G.SolarixSailorArtifactEquip then
                SafeFire(Remotes.ArtifactEquip)
            end
            SolarixStreamDelay(1)
        end
    end)
    task.spawn(function()
        while task.wait(5) do
            UpdateIslandCrystals()
            UpdateNPCLists()
            UpdateWeapons()
        end
    end)
    if Tabs.Info and Tabs.Info.Select then
        Tabs.Info:Select()
    end
    task.defer(function()
        Library:Notify({
            Title = 'Solarix Hub',
            Content = 'Script loaded successfully.',
            Icon = 'solar:check-circle-bold',
        })
    end)
end


local function SolarixSurviveZombie()
    local Players = game:GetService('Players')
    local RunService = game:GetService('RunService')
    local ReplicatedStorage = game:GetService('ReplicatedStorage')
    local Workspace = game:GetService('Workspace')
    local LocalPlayer = Players.LocalPlayer
    local WindUI = loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/latest/download/main.lua'))()
    local Library = WindUI
    pcall(function()
        Library:SetFont('rbxasset://fonts/families/FredokaOne.json')
    end)
    Library:AddTheme({
        Name = 'SolarixFlare',
        Accent = Color3.fromHex('#FF8A3D'),
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#1A0B08'), Transparency = 0.03},
            ['46'] = {Color = Color3.fromHex('#3A120B'), Transparency = 0.05},
            ['100'] = {Color = Color3.fromHex('#7A2413'), Transparency = 0.08},
        }, {
            Rotation = 28,
        }),
        Outline = Color3.fromHex('#FFC68A'),
        Text = Color3.fromHex('#FFF8EF'),
        Placeholder = Color3.fromHex('#D6A383'),
        Button = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#30100A'), Transparency = 0.02},
            ['52'] = {Color = Color3.fromHex('#6E2112'), Transparency = 0.04},
            ['100'] = {Color = Color3.fromHex('#FF7A22'), Transparency = 0.08},
        }, {
            Rotation = 22,
        }),
        Icon = Color3.fromHex('#FFD2A1'),
    })
    Library:SetTheme('SolarixFlare')
    local Window = Library:CreateWindow({
        Title = 'Solarix Hub',
        Icon = 'lucide:flame',
        Folder = 'Solarix Hub',
        Size = UDim2.fromOffset(580, 460),
        MinSize = Vector2.new(560, 350),
        MaxSize = Vector2.new(580, 460),
        ToggleKey = Enum.KeyCode.G,
        Transparent = true,
        Theme = 'SolarixFlare',
        Acrylic = false,
        Background = Library:Gradient({
            ['0'] = {Color = Color3.fromHex('#160807'), Transparency = 0.08},
            ['38'] = {Color = Color3.fromHex('#42130B'), Transparency = 0.03},
            ['67'] = {Color = Color3.fromHex('#D94C1A'), Transparency = 0.16},
            ['100'] = {Color = Color3.fromHex('#160807'), Transparency = 0.06},
        }, {
            Rotation = 35,
        }),
        Resizable = false,
        SideBarWidth = 190,
        HideSearchBar = false,
        ScrollBarEnabled = false,
        User = {
            Enabled = false,
        },
        OpenButton = {
            Title = 'Solarix Hub',
            Icon = 'lucide:flame',
            Enabled = true,
            Draggable = true,
            CornerRadius = UDim.new(0, 14),
            StrokeThickness = 1.5,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex('#24100B')),
                ColorSequenceKeypoint.new(0.45, Color3.fromHex('#FF6B1A')),
                ColorSequenceKeypoint.new(0.7, Color3.fromHex('#FFE0B5')),
                ColorSequenceKeypoint.new(1, Color3.fromHex('#5A1A0E')),
            }),
        },
    })
    local Colors = {
        Info = Color3.fromHex('#FFD1A1'),
        Green = Color3.fromHex('#FF8A3D'),
    }
    local function TabOptions(Title, Icon, IconColor)
        return {
            Title = Title,
            Icon = Icon,
            IconColor = IconColor,
            IconShape = 'Square',
            Border = true,
        }
    end
    local Tabs = {
        Info = Window:Tab(TabOptions('Info', 'solar:info-circle-bold', Colors.Info)),
        General = Window:Tab(TabOptions('General', 'solar:play-circle-bold', Colors.Green)),
    }
    local InitialToggleCallbacks = {}
    local function EnableInitialToggleCallback(Tab)
        local OriginalToggle = Tab.Toggle
        if type(OriginalToggle) ~= 'function' then
            return
        end
        Tab.Toggle = function(Self, Config)
            local Element = OriginalToggle(Self, Config)
            if type(Config) == 'table' and type(Config.Callback) == 'function' and Config.Value ~= nil then
                InitialToggleCallbacks[#InitialToggleCallbacks + 1] = function()
                    Config.Callback(Config.Value)
                end
            end
            return Element
        end
    end
    for _, Tab in pairs(Tabs) do
        EnableInitialToggleCallback(Tab)
    end
    Tabs.Info:Paragraph({
        Title = 'Solarix Hub',
        Desc = "Press 'G' to toggle UI.",
        Color = 'Orange',
    })
    Tabs.Info:Paragraph({
        Title = 'Support Game',
        Desc = '[+] Blox Fruits\n[+] Doors\n[+] Sailor Piece\n[+] Survive Zombie Arena',
        Color = 'Orange',
    })
    local ZombieClient = nil
    local GunClient = nil
    local GunRemotes = nil
    local CachedZombies = {}
    local LastScan = 0
    local ScanDelay = 0
    local KillAuraRange = math.huge
    local KillAuraTargets = math.huge
    local function GetPosition(Value)
        if typeof(Value) == 'Vector3' then
            return Value
        end
        if typeof(Value) == 'CFrame' then
            return Value.Position
        end
        return nil
    end
    local function GetModelPosition(Model)
        if not Model then
            return nil
        end
        local Root = Model:FindFirstChild('HumanoidRootPart') or Model:FindFirstChild('Head') or Model:FindFirstChildWhichIsA('BasePart')
        return Root and Root.Position or nil
    end
    local function IsAlive(Model, Data)
        if Data and Data.IsDying then
            return false
        end
        local Humanoid = Model and Model:FindFirstChildOfClass('Humanoid')
        if Humanoid and Humanoid.Health <= 0 then
            return false
        end
        return Model and Model.Parent ~= nil
    end
    local function FindGameClients()
        if _G.ZombieClient and typeof(_G.ZombieClient) == 'table' and _G.ZombieClient.Zombies then
            ZombieClient = _G.ZombieClient
        end
        if _G.GunClient and typeof(_G.GunClient) == 'table' and _G.GunClient.TryFire then
            GunClient = _G.GunClient
        end
        local PlayerScripts = LocalPlayer:FindFirstChild('PlayerScripts')
        if PlayerScripts and (not ZombieClient or not GunClient) then
            local function Scan(Parent, Depth)
                if Depth > 4 or (ZombieClient and GunClient) then
                    return
                end
                for _, Object in ipairs(Parent:GetChildren()) do
                    if Object:IsA('ModuleScript') then
                        local Ok, Result = pcall(require, Object)
                        if Ok and typeof(Result) == 'table' then
                            if not ZombieClient and Result.Zombies and (Result.GetNearbyZombieIds or Result.GetZombieById) then
                                ZombieClient = Result
                            end
                            if not GunClient and Result.TryFire then
                                GunClient = Result
                            end
                        end
                    elseif Object:IsA('Folder') or Object:IsA('ScreenGui') then
                        Scan(Object, Depth + 1)
                    end
                end
            end
            pcall(Scan, PlayerScripts, 0)
        end
        local Folder = ReplicatedStorage:FindFirstChild('GunRemotes')
        if Folder then
            GunRemotes = {
                Fire = Folder:FindFirstChild('GunFire'),
                Hit = Folder:FindFirstChild('GunHit'),
            }
        end
    end
    local function IsGunTool(Tool)
        if not Tool or not Tool:IsA('Tool') then
            return false
        end
        local Name = string.lower(tostring(Tool.Name or ''))
        local ToolTip = string.lower(tostring(Tool.ToolTip or ''))
        if ToolTip:find('gun') or ToolTip:find('weapon') then
            return true
        end
        if Name:find('gun') or Name:find('pistol') or Name:find('rifle') or Name:find('smg') or Name:find('shotgun') or Name:find('ak') or Name:find('uzi') then
            return true
        end
        if Tool:FindFirstChild('GunScript') or Tool:FindFirstChild('GunClient') or Tool:FindFirstChild('Fire') then
            return true
        end
        return false
    end
    local function FindGunTool()
        local Character = LocalPlayer.Character
        local Backpack = LocalPlayer:FindFirstChild('Backpack')
        if Character then
            for _, Tool in ipairs(Character:GetChildren()) do
                if IsGunTool(Tool) then
                    return Tool
                end
            end
        end
        if Backpack then
            for _, Tool in ipairs(Backpack:GetChildren()) do
                if IsGunTool(Tool) then
                    return Tool
                end
            end
        end
        if Character then
            local Tool = Character:FindFirstChildOfClass('Tool')
            if Tool then
                return Tool
            end
        end
        if Backpack then
            return Backpack:FindFirstChildOfClass('Tool')
        end
        return nil
    end
    local function EquipGun()
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
        local Tool = FindGunTool()
        if Tool and Humanoid and Tool.Parent ~= Character then
            pcall(function()
                Humanoid:EquipTool(Tool)
            end)
            task.wait()
        end
        return Tool
    end
    local function GetEquippedGun()
        return EquipGun()
    end
    local function ScanZombies()
        local Now = tick()
        if Now - LastScan < ScanDelay then
            return CachedZombies
        end
        LastScan = Now
        local Zombies = {}
        if ZombieClient and ZombieClient.Zombies then
            for Id, Data in pairs(ZombieClient.Zombies) do
                local Model = Data and Data.Model
                local Position = Data and (GetPosition(Data.CurrentPosition) or GetPosition(Data.TargetPosition) or GetModelPosition(Model))
                if Position and IsAlive(Model, Data) then
                    Zombies[#Zombies + 1] = {
                        Id = Id,
                        Model = Model,
                        Position = Position,
                        Distance = math.huge,
                    }
                end
            end
        else
            local Folder = Workspace:FindFirstChild('Zombies_Local')
            if Folder then
                for _, Model in ipairs(Folder:GetChildren()) do
                    if Model:IsA('Model') then
                        local Position = GetModelPosition(Model)
                        if Position and IsAlive(Model) then
                            Zombies[#Zombies + 1] = {
                                Id = Model:GetAttribute('Id') or tonumber(Model.Name:match('%d+')) or Model.Name,
                                Model = Model,
                                Position = Position,
                                Distance = math.huge,
                            }
                        end
                    end
                end
            end
        end
        CachedZombies = Zombies
        return Zombies
    end
    local function GetTargets()
        local Character = LocalPlayer.Character
        local Root = Character and Character:FindFirstChild('HumanoidRootPart')
        if not Root then
            return {}
        end
        local MyPosition = Root.Position
        local Targets = {}
        local Zombies = ScanZombies()
        for i = 1, #Zombies do
            local Zombie = Zombies[i]
            local Distance = (Zombie.Position - MyPosition).Magnitude
            if Distance <= KillAuraRange then
                Zombie.Distance = Distance
                Targets[#Targets + 1] = Zombie
            end
        end
        table.sort(Targets, function(A, B)
            return A.Distance < B.Distance
        end)
        while #Targets > KillAuraTargets do
            table.remove(Targets)
        end
        return Targets
    end
    local Shoot = function(Targets)
        if #Targets <= 0 then
            return
        end
        local Gun = GetEquippedGun()
        local Character = LocalPlayer.Character
        local Root = Character and Character:FindFirstChild('HumanoidRootPart')
        if not Gun or not Root then
            return
        end
        local Origin = Root.Position + Vector3.new(0, 2, 0)
        local FirstPosition = Targets[1].Position
        local Aim = FirstPosition - Origin
        local Direction = Aim.Magnitude > 0 and Aim.Unit or Vector3.zero
        if GunClient and GunClient.TryFire then
            local OldAim = GunClient.GetAimDirection
            local OldFiring = GunClient.IsFiring
            if OldAim then
                GunClient.GetAimDirection = function()
                    return Direction
                end
            end
            GunClient.IsFiring = true
            pcall(function()
                GunClient:TryFire()
            end)
            if OldAim then
                GunClient.GetAimDirection = OldAim
            end
            GunClient.IsFiring = OldFiring
        end
        if GunRemotes then
            if GunRemotes.Fire then
                task.defer(function()
                    pcall(function()
                        GunRemotes.Fire:FireServer(Gun.Name, Origin, Direction)
                    end)
                end)
            end
            if GunRemotes.Hit then
                for i = 1, math.min(#Targets, KillAuraTargets) do
                    local Target = Targets[i]
                    if Target and Target.Id and Target.Position then
                        task.defer(function()
                            pcall(function()
                                GunRemotes.Hit:FireServer(Gun.Name, Target.Id, Target.Position)
                            end)
                        end)
                    end
                end
            end
        end
    end
    Tabs.General:Toggle({
        Title = 'Auto Shoot',
        Value = false,
        Callback = function(Value)
            _G.SolarixZombieAutoShoot = Value
            if Value then
                FindGameClients()
                task.defer(EquipGun)
            end
        end,
    })
    Tabs.General:Toggle({
        Title = 'Auto Gun Upgrade',
        Value = false,
        Callback = function(Value)
            _G.SolarixZombieAutoGunUpgrade = Value
        end,
    })
    Tabs.General:Toggle({
        Title = 'Auto Health Upgrade',
        Value = false,
        Callback = function(Value)
            _G.SolarixZombieAutoHealthUpgrade = Value
        end,
    })
    Tabs.General:Toggle({
        Title = 'Auto Landmine',
        Value = false,
        Callback = function(Value)
            _G.SolarixZombieAutoLandmine = Value
        end,
    })
    task.spawn(function()
        FindGameClients()
        while task.wait() do
            if not SolarixStream(_G.SolarixZombieAutoShoot) then continue end
            pcall(function()
                local Targets = GetTargets()
                if #Targets > 0 then
                    Shoot(Targets)
                end
            end)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixZombieAutoGunUpgrade) then continue end
            pcall(function()
                local UpgradeRemotes = ReplicatedStorage:FindFirstChild('UpgradeRemotes')
                local PurchaseWeaponUpgrade = UpgradeRemotes and UpgradeRemotes:FindFirstChild('PurchaseWeaponUpgrade')
                if PurchaseWeaponUpgrade then
                    PurchaseWeaponUpgrade:FireServer()
                end
            end)
            SolarixStreamDelay(0.45)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixZombieAutoHealthUpgrade) then continue end
            pcall(function()
                local UpgradeRemotes = ReplicatedStorage:FindFirstChild('UpgradeRemotes')
                local PurchaseHealthUpgrade = UpgradeRemotes and UpgradeRemotes:FindFirstChild('PurchaseHealthUpgrade')
                if PurchaseHealthUpgrade then
                    PurchaseHealthUpgrade:FireServer()
                end
            end)
            SolarixStreamDelay(0.45)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if not SolarixStream(_G.SolarixZombieAutoLandmine) then continue end
            pcall(function()
                ReplicatedStorage.GearRemotes.GearPurchase:FireServer('Landmine')
            end)
            SolarixStreamDelay(0.45)
        end
    end)
    for _, Callback in ipairs(InitialToggleCallbacks) do
        task.defer(Callback)
    end
    if Tabs.Info and Tabs.Info.Select then
        Tabs.Info:Select()
    end
    task.defer(function()
        Library:Notify({
            Title = 'Solarix Hub',
            Content = 'Script loaded successfully.',
            Icon = 'solar:check-circle-bold',
        })
    end)
end

local function LoadSolarix()
    local CurrentMap = workspace:GetAttribute('MAP')
    if CurrentMap == 'Sea1' or CurrentMap == 'Sea2' or CurrentMap == 'Sea3' or CurrentMap == 'Dungeons' then
        SolarixBF()
    elseif game.PlaceId == 6839171747 then
        SolarixDoor()
    elseif game.PlaceId == 77747658251236 then
        SolarixSailorPiece()
    elseif game.PlaceId == 98927955463992 then
        SolarixSurviveZombie()
    end
end
local function New(Class, Props)
    local Object = Instance.new(Class)
    for Key, Value in pairs(Props or {}) do
        Object[Key] = Value
    end
    return Object
end
local function Tween(Object, Info, Props)
    local TweenObject = Twen:Create(Object, Info, Props)
    TweenObject:Play()
    return TweenObject
end
local function AddCorner(Object, Radius)
    return New('UICorner', {
        CornerRadius = Radius or UDim.new(0, 18),
        Parent = Object,
    })
end
local function AddStroke(Object, Color, Thickness)
    return New('UIStroke', {
        Color = Color,
        Thickness = Thickness or 2,
        Transparency = 0.08,
        Parent = Object,
    })
end
local function AddGradient(Object, Colors, Rotation, Transparency)
    return New('UIGradient', {
        Color = ColorSequence.new(Colors),
        Rotation = Rotation or 0,
        Transparency = Transparency or NumberSequence.new(0),
        Parent = Object,
    })
end
local function AddGloss(Object)
    local Gloss = New('Frame', {
        Name = 'Gloss',
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0.45, 0),
        Parent = Object,
    })
    AddCorner(Gloss, UDim.new(0.35, 0))
    AddGradient(Gloss, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 210, 170)),
    }, 90, NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.55),
        NumberSequenceKeypoint.new(1, 1),
    }))
    return Gloss
end
local function GetGuiParent()
    local Success, GuiParent = pcall(function()
        return gethui and gethui() or game:GetService('CoreGui')
    end)
    if Success and GuiParent then
        return GuiParent
    end
    return LocalPlayer:WaitForChild('PlayerGui')
end
local function MakeText(Parent, Text, Position, Size)
    return New('TextLabel', {
        Text = Text,
        FontFace = Font.new('rbxasset://fonts/families/FredokaOne.json'),
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = Position,
        Size = Size,
        Parent = Parent,
    })
end
local function MakeRow(Parent)
    local Frame = New('Frame', {
        BackgroundColor3 = Color3.fromRGB(32, 12, 8),
        BackgroundTransparency = 0.22,
        Size = UDim2.new(1, 0, 0.28, 0),
        ClipsDescendants = true,
        Parent = Parent,
    })
    AddCorner(Frame, UDim.new(0.35, 0))
    local Stroke = AddStroke(Frame, Color3.fromRGB(255, 115, 35), 2)
    AddGradient(Frame, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 145, 45)),
        ColorSequenceKeypoint.new(0.48, Color3.fromRGB(32, 12, 8)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 20)),
    }, 18, NumberSequence.new(0.18))
    AddGloss(Frame)
    New('UIPadding', {
        PaddingLeft = UDim.new(0.06, 0),
        Parent = Frame,
    })
    local Icon = New('ImageLabel', {
        Image = 'rbxassetid://81111209361717',
        ImageColor3 = Color3.fromRGB(255, 115, 35),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0.09, 0, 0.7, 0),
        ScaleType = Enum.ScaleType.Fit,
        Parent = Frame,
    })
    local Label = New('TextLabel', {
        Text = '',
        FontFace = Font.new('rbxasset://fonts/families/FredokaOne.json'),
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0.15, 0, 0.5, 0),
        Size = UDim2.new(0.8, 0, 0.5, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Frame,
    })
    return {
        Frame = Frame,
        Stroke = Stroke,
        Icon = Icon,
        Label = Label,
        Spin = nil,
    }
end
local function SetRow(Row, Text, Done)
    Row.Label.Text = Text
    Row.Icon.Image = Done and 'rbxassetid://13858820419' or 'rbxassetid://81111209361717'
    if Row.Spin then
        Row.Spin:Cancel()
        Row.Spin = nil
    end
    if Done then
        Tween(Row.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Rotation = 0,
        })
    else
        Row.Icon.Rotation = 0
        Row.Spin = Tween(Row.Icon, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
            Rotation = 360,
        })
    end
    local Success = Done and (Text:find('Whitelisted') or Text:find('Connected'))
    local Fail = not Done and Text:find('Not')
    local MainColor = Success and Color3.fromRGB(120, 42, 18) or Color3.fromRGB(32, 12, 8)
    local AccentColor = Success and Color3.fromRGB(255, 190, 90) or Fail and Color3.fromRGB(255, 90, 90) or Color3.fromRGB(255, 115, 35)
    Tween(Row.Frame, TweenInfo.new(0.3), {
        BackgroundColor3 = MainColor,
    })
    Tween(Row.Icon, TweenInfo.new(0.3), {
        ImageColor3 = AccentColor,
    })
    Tween(Row.Stroke, TweenInfo.new(0.3), {
        Color = AccentColor,
    })
end
local function MakeButton(Parent, Text, MainColor, AccentColor)
    local Button = New('TextButton', {
        Text = '',
        BackgroundColor3 = MainColor,
        BackgroundTransparency = 0.18,
        Size = UDim2.new(0.475, 0, 1, 0),
        AutoButtonColor = false,
        ClipsDescendants = true,
        Parent = Parent,
    })
    AddCorner(Button, UDim.new(0.4, 0))
    local Stroke = AddStroke(Button, AccentColor, 2.5)
    AddGradient(Button, {
        ColorSequenceKeypoint.new(0, AccentColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 210, 120)),
    }, 12)
    AddGloss(Button)
    local Label = MakeText(Button, Text, UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.85, 0, 0.5, 0))
    return Button, Label, Stroke
end
local function MakeKeyGui()
    local GuiParent = GetGuiParent()
    local OldGui = GuiParent:FindFirstChild('SolarixGui')
    if OldGui then
        OldGui:Destroy()
    end
    local PlayerGui = LocalPlayer:FindFirstChild('PlayerGui')
    if PlayerGui and PlayerGui:FindFirstChild('SolarixGui') then
        PlayerGui.SolarixGui:Destroy()
    end
    local Gui = New('ScreenGui', {
        Name = 'SolarixGui',
        IgnoreGuiInset = true,
        DisplayOrder = 999999,
        ResetOnSpawn = false,
        Parent = GuiParent,
    })
    local Bg = New('ImageLabel', {
        Name = 'Canvas',
        Image = 'rbxassetid://129585420055699',
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Crop,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Parent = Gui,
    })
    New('Frame', {
        BackgroundColor3 = Color3.fromRGB(16, 6, 5),
        BackgroundTransparency = 0.42,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = Bg,
    })
    local Main = New('Frame', {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.6, 0),
        Size = UDim2.new(0.35, 0, 0.45, 0),
        Parent = Bg,
    })
    local Title = MakeText(Main, 'Solarix Hub', UDim2.new(0.5, 0, -0.28, 0), UDim2.new(1, 0, 0.45, 0))
    AddGradient(Title, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 210, 120)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 115, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 20)),
    })
    local List = New('Frame', {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.new(1, 0, 0.65, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Parent = Main,
    })
    New('UIListLayout', {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.08, 0),
        Parent = List,
    })
    local Buttons = New('Frame', {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, 0),
        Size = UDim2.new(1, 0, 0.22, 0),
        Parent = Main,
    })
    New('UIListLayout', {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0.05, 0),
        Parent = Buttons,
    })
    local Copy, CopyLabel, CopyStroke = MakeButton(Buttons, 'Get Link', Color3.fromRGB(32, 12, 8), Color3.fromRGB(255, 70, 20))
    local Check, CheckLabel, CheckStroke = MakeButton(Buttons, 'Check', Color3.fromRGB(255, 115, 35), Color3.fromRGB(255, 210, 120))
    New('UIAspectRatioConstraint', {
        AspectRatio = 1.72,
        Parent = Gui,
    })
    return {
        Gui = Gui,
        Bg = Bg,
        List = List,
        Copy = Copy,
        CopyLabel = CopyLabel,
        CopyStroke = CopyStroke,
        Check = Check,
        CheckLabel = CheckLabel,
        CheckStroke = CheckStroke,
    }
end
local function StartKeyGui()
    local Ui = MakeKeyGui()
    local ConnectingRow = MakeRow(Ui.List)
    local CheckRow = MakeRow(Ui.List)
    SetRow(ConnectingRow, 'Connecting...', false)
    SetRow(ConnectingRow, 'Connected!', true)
    SetRow(CheckRow, 'Retrying in 15s...', false)
    Ui.Copy.Activated:Connect(function()
        SetClip('https://solarixhub.vercel.app/getkey?hwid=' .. Uid)
        Ui.CopyLabel.Text = 'Copied!'
        task.delay(1, function()
            Ui.CopyLabel.Text = 'Get Link'
        end)
    end)
    local Checking = false
    local Active = true
    local LastCheck = tick()
    local function OpenHub()
        Tween(Ui.Bg, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1,
            Position = UDim2.new(0.5, 0, 1.5, 0),
        })
        Active = false
        task.delay(0.5, function()
            if Ui.Gui then
                Ui.Gui:Destroy()
            end
            LoadSolarix()
        end)
    end
    local function RunCheck()
        if Checking then
            return
        end
        Checking = true
        SetRow(CheckRow, 'Checking...', false)
        if Get('https://solarixhub.vercel.app/check?id=' .. Uid) then
            SetRow(CheckRow, 'Whitelisted!', true)
            OpenHub()
            return
        end
        SetRow(CheckRow, 'Not Whitelisted.', false)
        task.delay(1.5, function()
            LastCheck = tick()
            Checking = false
        end)
    end
    Ui.Check.Activated:Connect(function()
        if Checking then
            return
        end
        LastCheck = tick() - 15
        RunCheck()
    end)
    task.spawn(function()
        local Retrying = false
        while task.wait() do
            if not Active then
                break
            end
            if not Checking then
                local Left = math.ceil(15 - (tick() - LastCheck))
                if Left > 0 then
                    CheckRow.Label.Text = 'Retrying in ' .. Left .. 's...'
                    if not Retrying then
                        Retrying = true
                        SetRow(CheckRow, CheckRow.Label.Text, false)
                    end
                else
                    Retrying = false
                    RunCheck()
                end
            else
                Retrying = false
            end
        end
    end)
end
if Get('https://github.com/LeafHubAcademy/SolarixHub/raw/refs/heads/main/keyless.json') or Get('https://solarixhub.vercel.app/check?id=' .. Uid) then
    LoadSolarix()
else
    StartKeyGui()
end
