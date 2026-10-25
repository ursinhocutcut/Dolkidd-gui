-- dolkidd GUI • made by dolkidd • VERSÃO CORRIGIDA
-- ==============================================
-- SERVIÇOS
-- ==============================================
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then return end
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
if not PlayerGui then return end

-- ✅ IDs
local SUA_IMAGEM_ID = "rbxassetid://116172277658508"
local JUMPSCARE_IMAGEM_ID = "rbxassetid://75404084774813"
local JUMPSCARE_SOM_ID = "rbxassetid://6129291390"

-- ==============================================
-- TELA PRINCIPAL
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "dolkiddGUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Janela Arrastável
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(244, 41, 6)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.05, 0, 0.15, 0)
Frame.Size = UDim2.new(0, 310, 0, 520)
Frame.Active = true
Frame.Draggable = true

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Title.BorderColor3 = Color3.fromRGB(244, 41, 6)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBlack
Title.Text = "dolkidd GUI"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 22

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Parent = Frame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 50)
Subtitle.Size = UDim2.new(1, 0, 0, 25)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "made by dolkidd • FIXED"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.TextSize = 12

-- ==============================================
-- ✅ DECAL SPAM
-- ==============================================
local function AplicarDecal(parte)
	if not parte:IsA("BasePart") then return end
	for _, d in ipairs(parte:GetChildren()) do
		if d:IsA("Decal") then d:Destroy() end
	end
	parte.Transparency = 0
	parte.Material = Enum.Material.Plastic
	local faces = {"Front", "Back", "Top", "Bottom", "Left", "Right"}
	for _, nomeFace in ipairs(faces) do
		local decal = Instance.new("Decal")
		decal.Name = "dolkidd_" .. nomeFace
		decal.Face = Enum.NormalId[nomeFace]
		decal.Texture = SUA_IMAGEM_ID
		decal.Transparency = 0
		decal.Parent = parte
	end
end

local function DecalSpam()
	local contador = 0
	for _, obj in ipairs(Workspace:GetDescendants()) do
		task.spawn(function()
			if obj:IsA("BasePart") then
				AplicarDecal(obj)
				contador = contador + 1
			end
		end)
	end
	task.wait(0.5)
	print("✅ Decal Spam: " .. contador .. " partes alteradas")
end

-- ==============================================
-- ✅ SKYBOX
-- ==============================================
local function SkyboxSuaImagem()
	local oldSky = Lighting:FindFirstChildWhichIsA("Sky")
	if oldSky then oldSky:Destroy() end
	local sky = Instance.new("Sky")
	sky.Name = "dolkiddSky"
	sky.Parent = Lighting
	sky.SkyboxBk = SUA_IMAGEM_ID
	sky.SkyboxDn = SUA_IMAGEM_ID
	sky.SkyboxFt = SUA_IMAGEM_ID
	sky.SkyboxLf = SUA_IMAGEM_ID
	sky.SkyboxRt = SUA_IMAGEM_ID
	sky.SkyboxUp = SUA_IMAGEM_ID
	print("✅ Skybox ativada!")
end

-- ==============================================
-- ✅ PARTÍCULAS
-- ==============================================
local function ParticulasSuaImagem()
	task.spawn(function()
		while ScreenGui.Parent and task.wait(0.5) do
			for _, p in ipairs(Players:GetPlayers()) do
				task.spawn(function()
					local char = p.Character
					if not char then return end
					local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
					if not torso then return end
					for _, f in ipairs(torso:GetChildren()) do
						if f:IsA("ParticleEmitter") then f:Destroy() end
					end
					local pe = Instance.new("ParticleEmitter")
					pe.Name = "dolkiddParticula"
					pe.Texture = SUA_IMAGEM_ID
					pe.Lifetime = NumberRange.new(1, 3)
					pe.Rate = 5
					pe.Speed = NumberRange.new(2, 6)
					pe.Size = NumberSequence.new(0.2, 1)
					pe.Transparency = NumberSequence.new(0, 0.5)
					pe.Parent = torso
					Debris:AddItem(pe, 3)
				end)
			end
		end
	end)
	print("✅ Partículas ativadas!")
end

-- ==============================================
-- ✅ JUMPSCARE
-- ==============================================
local function Jumpscare()
	local jumpscareFrame = Instance.new("Frame")
	jumpscareFrame.Name = "JumpscareTela"
	jumpscareFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	jumpscareFrame.Size = UDim2.new(1, 0, 1, 0)
	jumpscareFrame.Position = UDim2.new(0, 0, 0, 0)
	jumpscareFrame.ZIndex = 999
	jumpscareFrame.Parent = ScreenGui

	local imagem = Instance.new("ImageLabel")
	imagem.Name = "ImagemJumpscare"
	imagem.BackgroundTransparency = 1
	imagem.Image = JUMPSCARE_IMAGEM_ID
	imagem.Size = UDim2.new(1, 0, 1, 0)
	imagem.Position = UDim2.new(0, 0, 0, 0)
	imagem.Parent = jumpscareFrame

	local som = Instance.new("Sound")
	som.Name = "SomJumpscare"
	som.SoundId = JUMPSCARE_SOM_ID
	som.Volume = 2
	som.Looped = false
	som.Parent = SoundService
	som:Play()

	print("⚠️ JUMPSCARE ATIVADO!")

	task.spawn(function()
		while som and som.IsPlaying and task.wait(0.1) do end
		if jumpscareFrame then jumpscareFrame:Destroy() end
		if som then som:Destroy() end
	end)
end

-- ==============================================
-- ✅ SHUTDOWN 267
-- ==============================================
local function Shutdown267()
	print("🚫 Desconectando — Banido pelo dolkidd! | Error Code: 267")
	if LocalPlayer then
		LocalPlayer:Kick("Você foi banido pelo dolkidd!\nError Code: 267")
	end
end

-- ==============================================
-- DEMAIS FUNÇÕES
-- ==============================================
local function Efeito666()
	Lighting.TimeOfDay = "00:00:00"
	Lighting.Brightness = 0
	Lighting.Ambient = Color3.fromRGB(180, 0, 0)
	Lighting.FogColor = Color3.fromRGB(0, 0, 0)
	Lighting.FogEnd = 150
	for _, obj in ipairs(Workspace:GetDescendants()) do
		task.spawn(function()
			if obj:IsA("BasePart") then
				obj.BrickColor = BrickColor.new("Really black")
				if not obj:FindFirstChild("Fire") then
					local fogo = Instance.new("Fire")
					fogo.Size = 8
					fogo.Heat = 10
					fogo.Parent = obj
				end
				if not obj:FindFirstChild("PointLight") then
					local luz = Instance.new("PointLight")
					luz.Color = Color3.fromRGB(255, 0, 0)
					luz.Brightness = 4
					luz.Range = 12
					luz.Parent = obj
				end
			end
		end)
	end
	print("✅ Efeito 666 ativado!")
end

local function FloodVisual()
	local regiao = Region3.new(Vector3.new(-500, 0, -500), Vector3.new(500, 20, 500))
	Workspace.Terrain:FillRegion(regiao:ExpandToGrid(4), 4, Enum.Material.Water)
	print("✅ Inundação ativada!")
end

local function DiscoFog()
	task.spawn(function()
		while ScreenGui.Parent and task.wait(0.2) do
			Lighting.Ambient = Color3.fromRGB(math.random(100,255), math.random(0,50), math.random(0,50))
			Lighting.ShadowColor = Color3.fromRGB(math.random(100,255), math.random(0,50), math.random(0,50))
		end
	end)()
	print("✅ Disco ativado!")
end

local function MensagemDolkidd()
	task.spawn(function()
		while ScreenGui.Parent and task.wait(4) do
			local aviso = Instance.new("Hint")
			aviso.Parent = ScreenGui
			aviso.Text = "dolkidd hacked this game!"
			task.wait(3.5)
			aviso:Destroy()
		end
	end)()
	print("✅ Mensagem ativada!")
end

-- ==============================================
-- BOTÕES
-- ==============================================
local botoes = {
	{texto = "666", funcao = Efeito666, x=10, y=85, l=90, a=50},
	{texto = "Decal Spam", funcao = DecalSpam, x=110, y=85, l=180, a=50},
	{texto = "Skybox", funcao = SkyboxSuaImagem, x=10, y=155, l=280, a=50},
	{texto = "Disco", funcao = DiscoFog, x=10, y=225, l=130, a=50},
	{texto = "Inundação", funcao = FloodVisual, x=150, y=225, l=140, a=50},
	{texto = "Mensagem", funcao = MensagemDolkidd, x=10, y=295, l=130, a=50},
	{texto = "Partículas", funcao = ParticulasSuaImagem, x=150, y=295, l=140, a=50},
	{texto = "⚠️ JUMPSCARE", funcao = Jumpscare, x=10, y=365, l=280, a=50},
	{texto = "🚫 SHUTDOWN", funcao = Shutdown267, x=10, y=435, l=280, a=50},
}

for _, btn in ipairs(botoes) do
	local botao = Instance.new("TextButton")
	botao.Parent = Frame
	botao.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	botao.BorderColor3 = Color3.fromRGB(244, 41, 6)
	botao.Position = UDim2.new(0, btn.x, 0, btn.y)
	botao.Size = UDim2.new(0, btn.l, 0, btn.a)
	botao.Font = Enum.Font.GothamBold
	botao.Text = btn.texto
	botao.TextColor3 = Color3.fromRGB(255, 60, 60)
	botao.TextSize = 16
	botao.AutoLocalize = false
	botao.MouseButton1Click:Connect(btn.funcao)
end

print("🎮 dolkidd GUI carregada com sucesso!")
