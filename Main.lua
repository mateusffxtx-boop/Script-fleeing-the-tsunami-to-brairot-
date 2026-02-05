local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if coreGui:FindFirstChild("BrairotFinal") then coreGui.BrairotFinal:Destroy() end

local sg = Instance.new("ScreenGui", coreGui)
sg.Name = "BrairotFinal"

-- Coordenadas Gaps
local gaps = {
    {136.0, 3.4, -60.0}, {198.5, -2.6, -68.0}, {281.5, -2.6, -77.0},
    {404.0, -2.6, -6.0}, {540.0, -2.6, -11.0}, {755.0, -2.6, -5.0},
    {1084.0, -2.6, -4.0}, {1561.0, -2.6, -45.6}, {2248.5, -2.6, -12.0},
    {2596.5, -2.6, -18.0}, {2603.5, -2.6, -56.7}
}

local function superTween(targetPos)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local info = TweenInfo.new((root.Position - Vector3.new(targetPos[1], targetPos[2], targetPos[3])).Magnitude/750, Enum.EasingStyle.Linear)
        TweenService:Create(root, info, {CFrame = CFrame.new(targetPos[1], targetPos[2], targetPos[3])}):Play()
        root.AssemblyLinearVelocity = Vector3.new(0,0,0)
    end
end

-- FUNÇÃO DELETE VIP WALLS (Busca por Padrão de Nome)
local function deletarVipWalls()
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        -- Procura qualquer coisa que tenha "Vip" e "Wall" no nome (independente de maiúsculas)
        local nome = obj.Name:lower()
        if nome:find("vip") and (nome:find("wall") or nome:find("barr")) then
            pcall(function()
                -- Se for uma peça única
                if obj:IsA("BasePart") then
                    obj.CanCollide = false
                    obj.Transparency = 1
                    obj.Parent = nil
                end
                -- Se for uma pasta ou modelo, limpa tudo dentro
                for _, child in pairs(obj:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CanCollide = false
                        child.Transparency = 1
                        child.Parent = nil
                    end
                end
                obj.Parent = nil
            end)
        end
    end
end

-- INTERFACE
local buttons = {}
local toggleMain = Instance.new("TextButton", sg)
toggleMain.Size = UDim2.new(0, 80, 0, 30)
toggleMain.Position = UDim2.new(0, 5, 0.02, 0)
toggleMain.Text = "OCULTAR"
toggleMain.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
toggleMain.Font = Enum.Font.SourceSansBold

local btnDel = Instance.new("TextButton", sg)
btnDel.Size = UDim2.new(0, 130, 0, 30)
btnDel.Position = UDim2.new(0, 90, 0.02, 0)
btnDel.Text = "DELETE VIP WALLS"
btnDel.BackgroundColor3 = Color3.fromRGB(0, 150, 150)
btnDel.TextColor3 = Color3.fromRGB(255, 255, 255)
btnDel.Font = Enum.Font.SourceSansBold
btnDel.MouseButton1Click:Connect(deletarVipWalls)

for i, c in ipairs(gaps) do
    local b = Instance.new("TextButton", sg)
    b.Size = UDim2.new(0, 100, 0, 30)
    local col = (i > 6) and 110 or 5
    local row = (i > 6) and (i-7) * 35 or (i-1) * 35
    b.Position = UDim2.new(0, col, 0.08, row)
    b.Text = (i == 11) and "BURACO" or "GAP " .. i
    b.BackgroundColor3 = (i == 11) and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(0, 0, 0)
    b.BackgroundTransparency = 0.4
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.MouseButton1Click:Connect(function() superTween(c) end)
    table.insert(buttons, b)
end
