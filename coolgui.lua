-- c00lkidd GUI Reborn & Fixed Edition 
-- Đã sửa lỗi: Thu nhỏ nút tròn + Fix lỗi ID ảnh lỗi/xóa + Bấm hiện Menu

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- 1. KHỞI TẠO SCREEN GUI CHÍNH
local coolGui = Instance.new("ScreenGui")
coolGui.Name = "coolGui"
coolGui.Parent = playerGui
coolGui.ResetOnSpawn = false
coolGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 2. TẠO KHUNG MENU CHÍNH (MAINFRAME)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = coolGui
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Viền đỏ đặc trưng c00lkidd
mainFrame.Visible = false -- Ban đầu ẩn đi, bấm nút tròn mới hiện

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Tiêu đề Menu
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.Text = "c00lkidd's GUI - Fixed Edition"
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleLabel

-- Container chứa các nút tính năng bên trong Menu
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
contentFrame.ScrollBarThickness = 6

local layout = Instance.new("UIGridLayout")
layout.Parent = contentFrame
layout.CellSize = UDim2.new(0, 130, 0, 35)
layout.CellPadding = UDim2.new(0, 10, 0, 10)

-- Hàm mẫu tạo nhanh nút bấm tính năng
local function createFeatureButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Parent = contentFrame
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSans
    btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Danh sách các tính năng mẫu của c00lkidd GUI (Bạn có thể viết thêm code tính năng vào đây)
createFeatureButton("Fly / Bay", function()
    print("Kích hoạt tính năng Bay!")
end)

createFeatureButton("Inf Jump", function()
    print("Kích hoạt Nhảy vô hạn!")
end)

createFeatureButton("Speed 50", function()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

createFeatureButton("Btools", function()
    Instance.new("HopperBin", localPlayer.Backpack).BinType = Enum.HopperBinType.Clone
    Instance.new("HopperBin", localPlayer.Backpack).BinType = Enum.HopperBinType.GameTool
    Instance.new("HopperBin", localPlayer.Backpack).BinType = Enum.HopperBinType.Grab
end)

-- 3. TẠO NÚT BẤM HÌNH TRÒN LOGO COOLKID (ĐÃ FIX KÍCH THƯỚC VÀ LỖI CLICK)
local logoButton = Instance.new("ImageButton")
logoButton.Name = "LogoButton"
logoButton.Parent = coolGui
logoButton.AnchorPoint = Vector2.new(0.5, 0.5)
-- Sửa kích thước: Luôn luôn cố định là 60x60 pixel, nhỏ gọn không bị to quá khổ
logoButton.Size = UDim2.new(0, 60, 0, 60)
logoButton.Position = UDim2.new(0, 50, 0, 80) -- Vị trí chuẩn góc trái màn hình
logoButton.BackgroundTransparency = 1
-- Đổi ID ảnh c00lkidd mới hoạt động tốt, loại bỏ hoàn toàn lỗi hiển thị vòng đen xì
logoButton.Image = "rbxassetid://10613271180" 
logoButton.ZIndex = 100 -- Đẩy lên trên cùng tránh bị các bảng khác che khuất

-- Tạo viền hào quang màu đỏ bo tròn tuyệt đối cho nút bấm hình tròn
local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0) -- Bo tròn 100% thành hình tròn
logoCorner.Parent = logoButton

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(255, 0, 0)
logoStroke.Thickness = 2
logoStroke.Parent = logoButton

-- 4. XỬ LÝ SỰ KIỆN ẤN NÚT TRÒN ĐỂ HIỆN/ẨN MENU
local isMenuOpen = false
logoButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    mainFrame.Visible = isMenuOpen
end)

-- 5. BỔ SUNG TÍNH NĂNG KÉO THẢ (DRAGGABLE) CHO CẢ NÚT TRÒN VÀ KHUNG MENU
local function makeDraggable(frame, dragAnchor)
    local dragging, dragInput, dragStart, startPos
    dragAnchor = dragAnchor or frame

    dragAnchor.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragAnchor.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Kích hoạt kéo thả cho nút tròn và khung chính để bạn có thể dời đi bất cứ đâu trên màn hình
makeDraggable(logoButton)
makeDraggable(mainFrame, titleLabel)

print("c00lkidd GUI đã được sửa lỗi kích thước và nút bấm thành công!")
