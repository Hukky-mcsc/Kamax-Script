-- script.lua
-- LocalScript: Join a shared private server when button pressed
-- Put this in StarterPlayerScripts hoặc load qua executor

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ⚙️ Thay link share ở đây bằng link của bạn
local SHARE_LINK = "https://www.roblox.com/share?code=a1071115f1ea6a4595278c1a4ce7ec4e&type=Server"

-- Parse 'code' param từ link share
local function parseShareCode(url)
	if not url then return nil end
	return url:match("[?&]code=([%w%-_]+)")
end

-- 🧱 Tạo GUI
local function createGui()
	if playerGui:FindFirstChild("FindPrivateServerGui") then
		playerGui.FindPrivateServerGui:Destroy()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "FindPrivateServerGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	local frame = Instance.new("Frame")
	frame.Name = "BlackBox"
	frame.Size = UDim2.new(0, 320, 0, 160)
	frame.Position = UDim2.new(0.5, -160, 0.35, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	frame.BorderSizePixel = 0
	frame.Parent = screenGui

	-- 🧭 Tiêu đề
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -40, 0, 28)
	title.Position = UDim2.new(0, 10, 0, 8)
	title.BackgroundTransparency = 1
	title.Text = "Private Server"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextScaled = true
	title.Font = Enum.Font.SourceSansBold
	title.Parent = frame

	-- ❌ Nút đóng GUI
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 24, 0, 24)
	closeBtn.Position = UDim2.new(1, -28, 0, 8)
	closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.new(1, 1, 1)
	closeBtn.Font = Enum.Font.SourceSansBold
	closeBtn.TextScaled = true
	closeBtn.Parent = frame
	closeBtn.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	local info = Instance.new("TextLabel")
	info.Size = UDim2.new(1, -20, 0, 44)
	info.Position = UDim2.new(0, 10, 0, 38)
	info.BackgroundTransparency = 1
	info.Text = "Join the shared private server."
	info.TextWrapped = true
	info.TextColor3 = Color3.new(1, 1, 1)
	info.TextSize = 14
	info.Parent = frame

	local btn = Instance.new("TextButton")
	btn.Name = "FindButton"
	btn.Size = UDim2.new(0, 220, 0, 40)
	btn.Position = UDim2.new(0.5, -110, 1, -48)
	btn.AnchorPoint = Vector2.new(0.5, 0)
	btn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
	btn.Text = "Find Private Server"
	btn.TextColor3 = Color3.fromRGB(20, 20, 20)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextScaled = true
	btn.Parent = frame

	return screenGui, btn
end

-- 🧭 Teleport + hiển thị debug
local function teleportToShare(link, button)
	local code = parseShareCode(link)
	if not code then
		warn("❌ Không tìm thấy code trong link:", link)
		if button then button.Text = "Invalid Link" end
		return
	end

	local placeId = game.PlaceId -- thay nếu muốn teleport qua place khác

	if button then
		button.Text = "Teleporting..."
		button.Active = false
	end

	-- Debug info
	print("🔍 Teleporting: placeId =", placeId, " | code =", code)

	local ok, err = pcall(function()
		TeleportService:TeleportToPlaceInstance(placeId, code, player)
	end)

	if not ok then
		warn("⚠️ Teleport thất bại:", err)
		if button then
			button.Text = "Failed — Try Again"
			button.Active = true
		end

		-- Hiển thị thông báo lỗi trên màn hình
		StarterGui:SetCore("SendNotification", {
			Title = "Teleport Failed",
			Text = tostring(err),
			Duration = 6
		})
	end
end

-- 🟩 Khởi chạy GUI
local gui, button = createGui()
button.MouseButton1Click:Connect(function()
	teleportToShare(SHARE_LINK, button)
end)
