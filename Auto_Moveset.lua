-- if ur actually gonna do something with this ur a jew, no effort might break when trying to init the movestyle for new accounts

if not game:IsLoaded() then game.Loaded:Wait() end

repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("FULLY_LOADED_CHAR")

local player = game.Players.LocalPlayer

player.Character.Humanoid.Health = 0
player.CharacterAdded:Wait()
player.Character:WaitForChild("HumanoidRootPart")

local buttonMaxSet = workspace.Ignored.Shop["Boxing Moveset (Require: Max Box Stat) - $0"]
local buttonDefaultSet = workspace.Ignored.Shop["[Default Moveset] - $0"]

local function attack()
    local combat = player.Backpack:FindFirstChild("Combat") or player.Character:FindFirstChild("Combat")
    if combat then
        combat.Parent = player.Character
        combat:Activate()
        combat:Deactivate()
    end
end

------------------------------------// need to do this for new accounts that never hit the bag
if not player.DataFolder.Information:FindFirstChild("BoxingValue") then
    repeat task.wait()
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-280, 23, -1141)
        attack()
    until player.DataFolder.Information:FindFirstChild("BoxingValue")
end
if not player.DataFolder.Information:FindFirstChild("FightingStyle") then
    repeat task.wait()
        if player.Character:FindFirstChildWhichIsA("Tool") then player.Character.Humanoid:UnequipTools() end
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-228, 22, -1141)
        fireclickdetector(buttonDefaultSet.ClickDetector)
    until player.DataFolder.Information:FindFirstChild("FightingStyle")
end
------------------------------------//

local boxingPath = player.DataFolder.Information.BoxingValue
local fightingStylePath = player.DataFolder.Information.FightingStyle
local startTick = os.time()

if tonumber(boxingPath.Value) == 2500 and fightingStylePath.Value == "Boxing" then 
    return print("Already using Moveset")
end

_G.BoxConn = game:GetService("RunService").Heartbeat:Connect(function()
    if player.Character and player.Character.Humanoid.Health > 0 then
        if tonumber(boxingPath.Value) == 2500 then
            if fightingStylePath.Value ~= "Boxing" then
                pcall(function()
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(-237, 22, -1142)
                    fireclickdetector(buttonMaxSet.ClickDetector)
                end)
            else
                _G.BoxConn:Disconnect()
                _G.BoxConn = nil
                player:Kick("\n\nFinished: " .. string.format("%02i:%02i:%02i", (os.time() - startTick) / 60^2, (os.time() - startTick) / 60 % 60, (os.time() - startTick) % 60) .. "\n\n")
            end
        elseif tonumber(boxingPath.Value) ~= 2500 then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(-280, 23, -1141)
            attack()
        end
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
    end
end)
