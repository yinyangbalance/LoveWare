--[[ REMADE AND SCRIPTED BY COFFEE SOLARA. PERMMISION TO COPY IS NOT ALLOWED. ONLY LUCID, OTHER PEOPLE IN THE ILOVEEXPLOITING COMMUNITY CAN ACCESS THIS. TO GET PERMMISION CONTACT ME VIA EMAIL: hanachi.032014@gmail.com ]]--
--[[
Visit our Discord!
https://discord.gg/D9B4BNsx6S
]]
local Author = "@Author CoffeeSolara"
local name = "@Name VapeLibrary/LoveWare"
local Dependencies = "@Dependencies Luau 5.1 Level 3-8 Executer"
local Permmisions = "@LevelPermmmisions RobloxScript GuiEditing GetHUI Custom_Lua_Enviorment"
-- Loadstring to include the LoveWare library
local LoveWare = {}

-- Helper function to create UI corner
local function createUICorner(instance)
    local corner = Instance.new("UICorner")
    corner.Parent = instance
end

-- Function to make the window draggable
local function makeDraggable(frame)
    local userInputService = game:GetService("UserInputService")
    local dragging, dragInput, startPos, startSize

    local function update(input)
        local delta = input.Position - dragInput
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragInput = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    userInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
end

function LoveWare:CreateWindow(params)
    local gui = Instance.new("ScreenGui")
    gui.Name = params.Title or "LoveWare"
    gui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = params.Size or UDim2.new(0, 300, 0, 400)
    frame.Position = params.Position or UDim2.new(0.5, -150, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    frame.BorderSizePixel = 0
    createUICorner(frame)  -- Add UI corner
    frame.Parent = gui

    makeDraggable(frame)  -- Make the window draggable

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    title.BorderSizePixel = 0
    title.Text = params.Title or "LoveWare"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.Parent = frame

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    contentFrame.BorderSizePixel = 0
    createUICorner(contentFrame)  -- Add UI corner
    contentFrame.Parent = frame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = contentFrame

    local window = {
        Gui = gui,
        Frame = frame,
        ContentFrame = contentFrame,
        Tabs = {}
    }

    return window
end

function LoveWare:CreateTab(window, tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 30)
    tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.SourceSansBold
    tabButton.TextSize = 18
    createUICorner(tabButton)  -- Add UI corner
    tabButton.Parent = window.ContentFrame

    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, -30)
    tabContent.Position = UDim2.new(0, 0, 0, 30)
    tabContent.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    tabContent.BorderSizePixel = 0
    tabContent.Visible = false
    createUICorner(tabContent)  -- Add UI corner
    tabContent.Parent = window.ContentFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = tabContent

    tabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(window.Tabs) do
            tab.Content.Visible = false
        end
        tabContent.Visible = true
    end)

    local tab = {
        Button = tabButton,
        Content = tabContent
    }

    table.insert(window.Tabs, tab)
    return tab
end

function LoveWare:CreateButton(tab, buttonText, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    button.BorderSizePixel = 0
    button.Text = buttonText
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    createUICorner(button)  -- Add UI corner
    button.Parent = tab.Content

    button.MouseButton1Click:Connect(function()
        callback()
    end)
end

function LoveWare:CreateDropdown(tab, dropdownText, options, callback)
    local dropdown = Instance.new("Frame")
    dropdown.Size = UDim2.new(1, 0, 0, 30)
    dropdown.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    dropdown.BorderSizePixel = 0
    createUICorner(dropdown)  -- Add UI corner
    dropdown.Parent = tab.Content

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    button.BorderSizePixel = 0
    button.Text = dropdownText
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    createUICorner(button)  -- Add UI corner
    button.Parent = dropdown

    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(1, 0, 0, #options * 30)
    optionsFrame.Position = UDim2.new(0, 0, 1, 0)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    createUICorner(optionsFrame)  -- Add UI corner
    optionsFrame.Parent = dropdown

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = optionsFrame

    button.MouseButton1Click:Connect(function()
        optionsFrame.Visible = not optionsFrame.Visible
    end)

    for _, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Size = UDim2.new(1, 0, 0, 30)
        optionButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        optionButton.BorderSizePixel = 0
        optionButton.Text = option
        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.Font = Enum.Font.SourceSans
        optionButton.TextSize = 18
        createUICorner(optionButton)  -- Add UI corner
        optionButton.Parent = optionsFrame

        optionButton.MouseButton1Click:Connect(function()
            callback(option)
            button.Text = option
            optionsFrame.Visible = false
        end)
    end
end

function LoveWare:CreateSlider(tab, sliderText, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    sliderFrame.BorderSizePixel = 0
    createUICorner(sliderFrame)  -- Add UI corner
    sliderFrame.Parent = tab.Content

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    label.BorderSizePixel = 0
    label.Text = sliderText .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    createUICorner(label)  -- Add UI corner
    label.Parent = sliderFrame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 10)
    slider.Position = UDim2.new(0, 0, 0, 30)
    slider.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    slider.BorderSizePixel = 0
    createUICorner(slider)  -- Add UI corner
    slider.Parent = sliderFrame

    local handle = Instance.new("Frame")
    handle.Size = UDim2.new(0, 10, 1, 0)
    handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    handle.BorderSizePixel = 0
    createUICorner(handle)  -- Add UI corner
    handle.Parent = slider

    local function updateHandle(position)
        local clampedPos = math.clamp(position, 0, slider.AbsoluteSize.X)
        handle.Position = UDim2.new(0, clampedPos, 0, 0)
        local value = math.floor(((clampedPos / slider.AbsoluteSize.X) * (max - min)) + min)
        label.Text = sliderText .. ": " .. value
        callback(value)
    end

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateHandle(input.Position.X - slider.AbsolutePosition.X)
            local connection
            connection = userInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateHandle(input.Position.X - slider.AbsolutePosition.X)
                end
            end)
            userInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    connection:Disconnect()
                end
            end)
        end
    end)

    updateHandle((default - min) / (max - min) * slider.AbsoluteSize.X)
end

return LoveWare
