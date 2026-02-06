local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local runService = game:GetService("RunService")

if coreGui:FindFirstChild("BrairotFinal") then coreGui.BrairotFinal:Destroy() end

local sg = Instance.new("ScreenGui", coreGui)
sg.Name = "BrairotFinal"

local autoUpAtivo = false

-- LÓGICA AUTO UP (5 STUDS)
runService.Heartbeat:Connect(function()
    if autoUpAtivo then
        pcall(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            for _, obj in pairs(workspace:GetDescendants()) do
                if (obj.Name == "Upgrade" or obj.Name == "Wave Machine") and obj:IsA("BasePart") then
                    if (root.Position - obj.Position).Magnitude <= 5 then
                        local cd = obj:FindFirstChildOfClass("ClickDetector")
                        if cd then fireclickdetector(cd) end
                        local gui = obj:FindFirstChild("UpgradeGui")
                        local btn = gui and gui:FindFirstChild("Button")
                        if btn then
                            for _, conn in pairs(getconnections(btn.Activated)) do conn:Fire() end
                            for _, conn in pairs(getconnections(btn.MouseButton1Click)) do conn:Fire() end
                        end
                    end
                end
            end
        end)
    end
end)

-- FRAME PRINCIPAL (HORIZONTAL)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 360, 0, 180)
main.Position = UDim2.new(0, 10, 0, 50)
main.BackgroundTransparency = 1

-- BOTÃO MOSTRAR/OCULTAR (FIXO NO TOPO)
local hideBtn = Instance.new("TextButton", sg)
hideBtn.Size = UDim2.new(0, 80, 0, 30)
hideBtn.Position = UDim2.new(0, 10, 0, 10)
hideBtn.Text = "OCULTAR"
hideBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hideBtn.Font = Enum.Font.SourceSansBold
hideBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    hideBtn.Text = main.Visible and "OCULTAR" or "MOSTRAR"
end)

-- COLUNA 1: CONTROLES
local col1 = Instance.new("Frame", main)
col1.Size = UDim2.new(0, 110, 1, 0)
col1.Position = UDim2.new(0, 0, 0, 0)
col1.BackgroundTransparency = 1

local btnUp = Instance.new("TextButton", col1)
btnUp.Size = UDim2.new(1, 0, 0, 40)
btnUp.Text = "AUTO: OFF"
btnUp.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
btnUp.TextColor3 = Color3.fromRGB(255, 255, 255)
btnUp.Font = Enum.Font.SourceSansBold
btnUp.MouseButton1Click:Connect(function()
    autoUpAtivo = not autoUpAtivo
    btnUp.Text = autoUpAtivo and "AUTO: ON" or "AUTO: OFF"
    btnUp.BackgroundColor3 = autoUpAtivo and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

local btnDel = Instance.new("TextButton", col1)
btnDel.Size = UDim2.new(1, 0, 0, 40)
btnDel.Position = UDim2.new(0, 0, 0, 45)
btnDel.Text = "DEL VIP"
btnDel.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
btnDel.TextColor3 = Color3.fromRGB(255, 255, 255)
btnDel.Font = Enum.Font.SourceSansBold
btnDel.MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("vip") then v:Destroy() end
    end
end)

-- COLUNA 2: GAPS 1-6
local col2 = Instance.new("Frame", main)
col2.Size = UDim2.new(0, 110, 1, 0)
col2.Position = UDim2.new(0, 120, 0, 0)
col2.BackgroundTransparency = 1

-- COLUNA 3: GAPS 7-11
local col3 = Instance.new("Frame", main)
col3.Size = UDim2.new(0, 110, 1, 0)
col3.Position = UDim2.new(0, 240, 0, 0)
col3.BackgroundTransparency = 1

local gaps = {{136, 3, -60}, {198, -2, -68}, {281, -2, -77}, {404, -2, -6}, {540, -2, -11}, {755, -2, -5}, {1084, -2, -4}, {1561, -2, -45}, {2248, -2, -12}, {2596, -2, -18}, {2603, -2, -56}}

for i, c in ipairs(gaps) do
    local targetCol = (i <= 6) and col2 or col3
    local posIndex = (i <= 6) and (i - 1) or (i - 7)
    
    local b = Instance.new("TextButton", targetCol)
    b.Size = UDim2.new(1, 0, 0, 25)
    b.Position = UDim2.new(0, 0, 0, posIndex * 28)
    b.Text = (i == 11) and "BURACO" or "GAP " .. i
    b.BackgroundColor3 = (i == 11) and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(20, 20, 20)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 12
    b.MouseButton1Click:Connect(function()
        player.Character.HumanoidRootPart.CFrame = CFrame.new(c[1], c[2], c[3])
    end)
end
