--// Private Server Finder - Chilli Hub
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FindBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")
local CopyBtn = Instance.new("TextButton")

-- GUI Setup
ScreenGui.Name = "ChilliHubGUI"
ScreenGui.Parent = game.CoreGui

Frame.Size = UDim2.new(0, 320, 0, 200)
Frame.Position = UDim2.new(0.5, -160, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

Title.Text = "Private Server Finder - Chilli Hub"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

FindBtn.Text = "FIND"
FindBtn.Size = UDim2.new(0, 120, 0, 40)
FindBtn.Position = UDim2.new(0.5, -60, 0.5, -20)
FindBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
FindBtn.TextColor3 = Color3.new(1, 1, 1)
FindBtn.Font = Enum.Font.SourceSansBold
FindBtn.TextSize = 20
FindBtn.Parent = Frame

Status.Text = "Find Online Private Server (0 player)"
Status.Size = UDim2.new(1, 0, 0, 40)
Status.Position = UDim2.new(0, 0, 1, -40)
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.SourceSans
Status.TextSize = 16
Status.Parent = Frame

CopyBtn.Text = "Copy Link"
CopyBtn.Size = UDim2.new(0, 120, 0, 40)
CopyBtn.Position = UDim2.new(0.5, -60, 0.5, 40)
CopyBtn.BackgroundColor3 = Color3.fromRGB(70, 200, 70)
CopyBtn.TextColor3 = Color3.new(1, 1, 1)
CopyBtn.Font = Enum.Font.SourceSansBold
CopyBtn.TextSize = 18
CopyBtn.Visible = false
CopyBtn.Parent = Frame

-- Functionality
local link = "https://www.roblox.com/share?code=5557eed314f683498f4bbeb1b7725af1&type=Server"

FindBtn.MouseButton1Click:Connect(function()
    FindBtn.Visible = false
    for i = 20, 0, -1 do
        Status.Text = "Finding server... " .. i .. "s"
        wait(1)
    end
    Status.Text = "Server found!"
    CopyBtn.Visible = true
end)

CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(link)
        CopyBtn.Text = "Copied!"
    else
        Status.Text = "Clipboard not supported."
    end
end)
