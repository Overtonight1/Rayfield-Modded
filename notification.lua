local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Gui = Instance.new("ScreenGui")
Gui.Name = "NebulaNotifications"
Gui.ResetOnSpawn = false
Gui.Parent = CoreGui

local Holder = Instance.new("Frame")
Holder.AnchorPoint = Vector2.new(1,1)
Holder.Position = UDim2.new(1,-24,1,-24)
Holder.Size = UDim2.new(0,360,1,-48)
Holder.BackgroundTransparency = 1
Holder.Parent = Gui

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
Layout.Parent = Holder

local function Notify(title,text,duration)
	duration = duration or 5
	local imageId = "109901840979974"

	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1,0,0,74)
	Frame.BackgroundColor3 = Color3.fromRGB(22,22,28)
	Frame.BorderSizePixel = 0
	Frame.BackgroundTransparency = 1
	Frame.Parent = Holder

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,12)
	Corner.Parent = Frame

	local Accent = Instance.new("Frame")
	Accent.Size = UDim2.new(0,3,1,0)
	Accent.BackgroundColor3 = Color3.fromRGB(145,110,255)
	Accent.BorderSizePixel = 0
	Accent.Parent = Frame

	local IconHolder = Instance.new("Frame")
	IconHolder.Size = UDim2.new(0,42,0,42)
	IconHolder.Position = UDim2.new(0,16,0.5,-21)
	IconHolder.BackgroundColor3 = Color3.fromRGB(32,32,40)
	IconHolder.BorderSizePixel = 0
	IconHolder.Parent = Frame

	local IconCorner = Instance.new("UICorner")
	IconCorner.CornerRadius = UDim.new(0,10)
	IconCorner.Parent = IconHolder

	local Icon = Instance.new("ImageLabel")
	Icon.Size = UDim2.new(0.7,0,0.7,0)
	Icon.Position = UDim2.new(0.15,0,0.15,0)
	Icon.BackgroundTransparency = 1
	Icon.Image = "rbxassetid://"..imageId
	Icon.ScaleType = Enum.ScaleType.Fit
	Icon.Parent = IconHolder

	local Close = Instance.new("TextButton")
	Close.Size = UDim2.new(0,18,0,18)
	Close.Position = UDim2.new(1,-24,0,10)
	Close.Text = "✕"
	Close.TextSize = 13
	Close.Font = Enum.Font.GothamBold
	Close.TextColor3 = Color3.fromRGB(180,180,190)
	Close.BackgroundTransparency = 1
	Close.Parent = Frame

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1,-120,0,20)
	Title.Position = UDim2.new(0,74,0,14)
	Title.BackgroundTransparency = 1
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255,255,255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 14
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Frame

	local Body = Instance.new("TextLabel")
	Body.Size = UDim2.new(1,-120,0,18)
	Body.Position = UDim2.new(0,74,0,34)
	Body.BackgroundTransparency = 1
	Body.TextWrapped = true
	Body.Text = text
	Body.TextColor3 = Color3.fromRGB(170,170,180)
	Body.Font = Enum.Font.Gotham
	Body.TextSize = 13
	Body.TextXAlignment = Enum.TextXAlignment.Left
	Body.TextYAlignment = Enum.TextYAlignment.Top
	Body.Parent = Frame

	local Bar = Instance.new("Frame")
	Bar.Size = UDim2.new(1,0,0,2)
	Bar.Position = UDim2.new(0,0,1,-2)
	Bar.BackgroundColor3 = Color3.fromRGB(145,110,255)
	Bar.BorderSizePixel = 0
	Bar.Parent = Frame

	Frame.Position = UDim2.new(1,80,0,0)

	TweenService:Create(Frame,TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
		BackgroundTransparency = 0,
		Position = UDim2.new(0,0,0,0)
	}):Play()

	local remaining = duration
	local running = true

	local function CloseNotification()
		running = false
		local tween = TweenService:Create(Frame,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{
			BackgroundTransparency = 1,
			Position = UDim2.new(1,80,0,0)
		})
		tween:Play()
		tween.Completed:Wait()
		Frame:Destroy()
	end

	Close.MouseButton1Click:Connect(CloseNotification)

	Frame.MouseEnter:Connect(function()
		running = false
	end)

	Frame.MouseLeave:Connect(function()
		running = true
	end)

	task.spawn(function()
		while remaining > 0 and Frame.Parent do
			if running then
				remaining -= 0.05
				Bar.Size = UDim2.new(remaining/duration,0,0,2)
			end
			task.wait(0.05)
		end
		if Frame.Parent then
			CloseNotification()
		end
	end)
end

getgenv().Notify = Notify

Notify("Nebula","hi.",6)
