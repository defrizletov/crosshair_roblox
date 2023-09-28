local screenSizes = {};
for size in tostring(workspace.CurrentCamera.ViewportSize):gmatch("([^, ]+)") do table.insert(screenSizes, size); end;

crossHair = Drawing.new("Square");
crossHair.Size = Vector2.new(4, 4);
crossHair.Position = Vector2.new((screenSizes[1] / 2) - 2, (screenSizes[2] / 2) - 2);
crossHair.ZIndex = 1;
crossHair.Transparency = 1;
crossHair.Thickness = 1;
crossHair.Color = Color3.fromRGB(255, 255, 255);
crossHair.Filled = true;
crossHair.Visible = true;

-- gui
local guiLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/defrizletov/orion_gui_lib/main/orion.lua')))();
local guiWindow = guiLib:MakeWindow({ Name = "Crosshair GUI", IntroEnabled = false, CloseCallback = function () guiLib:Destroy(); crossHair.Visible = false; end });
local guiTab = guiWindow:MakeTab({ Name = "Main" });

guiTab:AddToggle({
	Name = "Visible",
	Default = true,
	Callback = function (v) crossHair.Visible = v; end    
});

guiTab:AddToggle({
	Name = "Filled",
	Default = true,
	Callback = function (v) crossHair.Filled = v; end    
});

guiTab:AddTextbox({
	Name = "Size",
	Default = 4,
	TextDisappear = false,
	Callback = function (v)
        local crossHairSize = tonumber(v);
        if(type(crossHairSize) ~= "number") then guiLib:MakeNotification({ Name = "Invalid number!", Content = "You have entered a invalid number.", Time = 3 }); else
            crossHair.Size = Vector2.new(crossHairSize, crossHairSize);
            crossHair.Position = Vector2.new((screenSizes[1] / 2) - (crossHairSize / 2), (screenSizes[2] / 2) - (crossHairSize / 2));
        end;
	end	  
});

guiTab:AddTextbox({
	Name = "Thickness",
	Default = 1,
	TextDisappear = false,
	Callback = function (v)
        local crossHairThickness = tonumber(v);
        if(type(crossHairThickness) ~= "number") then guiLib:MakeNotification({ Name = "Invalid number!", Content = "You have entered a invalid number.", Time = 3 }); else crossHair.Thickness = crossHairThickness; end;
	end	  
});

guiTab:AddSlider({
	Name = "Transparency",
	Default = 10,
    Min = 0,
    Max = 10,
    Increment = 1,
    Color = Color3.fromRGB(255, 255, 255),
	Callback = function (transparency) crossHair.Transparency = transparency / 10; end 
});

guiTab:AddColorpicker({
	Name = "Color",
	Default = Color3.fromRGB(255, 255, 255),
	Callback = function (color) crossHair.Color = color; end	  
});

guiLib:Init();
