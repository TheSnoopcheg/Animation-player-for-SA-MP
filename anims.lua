script_name("Animations")
script_author("Snoopcheg")
script_version("0.7.8")

local key = require ('vkeys')
local imgui = require ('mimgui')
local ffi = require ('ffi')
local sampev = require ('lib.samp.events')
local inicfg = require ('inicfg')
local encoding = require ('encoding')
encoding.default = 'CP1251'
u8 = encoding.UTF8
local gw, gh =  getScreenResolution()

local mainIni = inicfg.load({
	location = {
		xmain = 155,
		ymain = 120,
		xsecond = 167,
		ysecond = 510
	},
	main = {
		activation = false
	}
}, "..\\config\\anims\\animation.ini")

local animationlibs = {"SEX", "DANCING", "Attractors", "BEACH", "SnM", "SWEET", "INT_OFFICE", "INT_SHOP", "INT_HOUSE", "FOOD", "STRIP", "HEIST9", "WUZI", "CRACK",
"LOWRIDER", "SUNBATHE", "STRIP", "TRAIN", "SWAT", "SMOKING", "SHOP", "RIOT", "RAPPING", "POLICE", "PLAYIDLES", "PAULNMAC", "PARK", "MEDIC", "OTB", "ON_LOOKERS",
"MISC", "KNIFE", "GRAVEYARD", "GANGS", "FAT", "COP_AMBIENT", "CAR", "BOMBER", "BAR", "BD_FIRE"}

function loadAnims()
  repeat
      wait(0)
    until sampIsLocalPlayerSpawned()
		
  	local checkArray = {}; local loadCounter = 0
  	for _, v in pairs(animationlibs) do
  		requestAnimation(v); table.insert(checkArray, hasAnimationLoaded(v));
  	end

  	for k, _ in pairs(checkArray) do
  		if checkArray[k] then
  			loadCounter = loadCounter + 1
  		end
  	end

  	if loadCounter == #checkArray then
  		return true
	end
end

function playAnim(name, nameLib, speed, loop, lockX, lockY, lockF)
  if not isCharInAnyCar(PLAYER_PED) then
    animStatus = true
    taskPlayAnim(PLAYER_PED, name, nameLib, speed, loop, lockX, lockY, lockF, -1)
  else
     sampAddChatMessage('������� �� ������������� �������� ��� ����, ����� ������������ ��������.', -1)
  end
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
	apply_custom_style()
	local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
	local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
	mainfont = imgui.GetIO().Fonts:AddFontFromFileTTF(getWorkingDirectory() .. '\\resourse\\fonts\\nautiluspompilius.ttf', 16.5, nil, glyph_ranges)
end)

local antiflood = false
local act = 0
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local mainWindow = {
	active = new.bool(),
	x = new.int(mainIni.location.xmain),
	y = new.int(mainIni.location.ymain)
}
local secondWindow = {
	active = new.bool(),
	x = new.int(mainIni.location.xsecond),
	y = new.int(mainIni.location.ysecond)
}
local actkey = new.bool(mainIni.main.activation)
local dragmainw = new.bool()
local dragsecw = new.bool()

local mainFrame = imgui.OnFrame(
	function() return mainWindow.active[0] end,
    function(self)
		imgui.SetNextWindowPos(imgui.ImVec2(mainWindow.x[0] + 125, mainWindow.y[0]+113), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(250, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Anim menu', mainWindow.active, imgui.WindowFlags.NoResize + (dragmainw[0] and 0 or imgui.WindowFlags.NoMove))
		local btn_size = imgui.ImVec2(-0.1, 21)
			if act == 0 then
			if imgui.Button(u8'�����', btn_size) then act = 1 end
			if imgui.Button(u8'����������', btn_size) then act = 2 end
			if imgui.Button(u8'�����/����', btn_size) then act = 3 end		
			if imgui.Button(u8'����', btn_size) then act = 4 end
			if imgui.Button(u8'����', btn_size) then act = 5 end
			if imgui.Button(u8'������', btn_size) then act = 6 end
			if imgui.Button(u8'���������� ��������', btn_size) and animStatus and not isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() then
				taskPlayAnim(PLAYER_PED, "abseil", "PED", 4.0, false, false, true, false, -1)
				animStatus = false
			end
			if imgui.Button(u8'����������&���������', btn_size) then act = 7 end
		elseif act == 1 then
			if imgui.Button(u8'<< �����', btn_size) then act = 0 end
			imgui.Text(u8'�� Fortnite:')
			if imgui.Button('Orange Justice', btn_size) then playAnim("DNCE_M_A", "DANCING", 4.0, true, false, false, false) end
			if imgui.Button('True heart', btn_size) then playAnim("DNCE_M_B", "DANCING", 4.0, true, false, false, false) end
			if imgui.Button('Electro Shuffle', btn_size) then playAnim("DNCE_M_D", "DANCING", 4.0, true, false, false, false) end
			if imgui.Button('Dab', btn_size) then playAnim("DNCE_M_E", "DANCING", 4.0, false, false, false, false) end
			if imgui.Button('Dance Moves', btn_size) then playAnim("BD_PANIC_LOOP", "BD_FIRE", 4.0, true, false, false, false) end
			if imgui.Button('Fresh', btn_size) then playAnim("WASH_UP", "BD_FIRE", 4.0, true, false, false, false) end
			if imgui.Button('Eagle', btn_size) then playAnim("DNCE_M_C", "DANCING", 4.0, true, false, false, false) end
			imgui.Text(u8'������:')
			if imgui.Button(u8'�����(1)', btn_size) then playAnim("DAN_DOWN_A", "DANCING", 4.0, true, false, false, false) end
			if imgui.Button(u8'�����(2)', btn_size) then playAnim("DAN_LOOP_A", "DANCING", 4.0, true, false, false, false) end
			if imgui.Button(u8'�����(3)', btn_size) then playAnim("DAN_Left_A", "DANCING", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(1)', btn_size) then playAnim("strip_B", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(2)', btn_size) then playAnim("strip_E", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(3)', btn_size) then playAnim("strip_G", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(4)', btn_size) then playAnim("STR_A2B", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(5)', btn_size) then playAnim("STR_B2C", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(6)', btn_size) then playAnim("STR_C1", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(7)', btn_size) then playAnim("STR_C2", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(8)', btn_size) then playAnim("STR_Loop_A", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(9)', btn_size) then playAnim("STR_Loop_B", "STRIP", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������(10)', btn_size) then playAnim("STR_Loop_C", "STRIP", 4.0, true, false, false, false) end
		elseif act == 2 then
			if imgui.Button(u8'<< �����', btn_size) then act = 0 end
			if imgui.Button(u8'������(1)', btn_size) then playAnim("F_smklean_loop", "SMOKING", 4.0, true, false, false, false) end
			if imgui.Button(u8'������(2)', btn_size) then playAnim("M_smklean_loop", "SMOKING", 4.0, true, false, false, false) end
			if imgui.Button(u8'������(3)', btn_size) then playAnim("M_smkstnd_loop", "SMOKING", 4.0, true, false, false, false) end
			if imgui.Button(u8'���������', btn_size) then playAnim("M_smk_in", "SMOKING", 4.0, false, false, false, false) end
			if imgui.Button(u8'��������� ������', btn_size) then playAnim("ROB_Loop_Threat", "SHOP", 4.0, true, false, false, false) end
			if imgui.Button(u8'������� ����', btn_size) then playAnim("SHP_HandsUp_Scr", "SHOP", 4.0, false, false, false, true) end
			if imgui.Button(u8'������(1)', btn_size) then playAnim("RIOT_CHANT", "RIOT", 4.0, true, false, false, false) end
			if imgui.Button(u8'������(2)', btn_size) then playAnim("RIOT_PUNCHES", "RIOT", 4.0, true, false, false, false) end
			if imgui.Button(u8'�������', btn_size) then playAnim("RIOT_FUKU", "RIOT", 4.0, false, false, false, false) end
			if imgui.Button(u8'�������', btn_size) then playAnim("RIOT_shout", "RIOT", 4.0, false, false, false, false) end
			if imgui.Button(u8'��������', btn_size) then playAnim("CopTraf_Away", "POLICE", 4.0, false, false, false, false) end
			if imgui.Button(u8'�� ���', btn_size) then playAnim("CopTraf_Come", "POLICE", 4.0, false, false, false, false) end
			if imgui.Button(u8'����', btn_size) then playAnim("CopTraf_Stop", "POLICE", 4.0, false, false, false, false) end
			if imgui.Button(u8'�����(M)', btn_size) then playAnim("Piss_in", "PAULNMAC", 4.0, false, false, false, true) end
			if imgui.Button(u8'����', btn_size) then playAnim("Tai_Chi_Loop", "PARK", 4.0, true, false, false, false) end
			if imgui.Button(u8'������ ������', btn_size) then playAnim("CPR", "MEDIC", 4.0, false, false, false, false) end
			if imgui.Button(u8'������� ����(1)', btn_size) then playAnim("wtchrace_in", "OTB", 4.0, false, false, false, true) end
			if imgui.Button(u8'������� ����(2)', btn_size) then playAnim("prst_loopa", "GRAVEYARD", 4.0, false, false, false, true) end
			if imgui.Button(u8'���������(1<-)', btn_size) then playAnim("wtchrace_lose", "OTB", 4.0, false, false, false, true) end
			if imgui.Button(u8'��������(1<-)', btn_size) then playAnim("wtchrace_win", "OTB", 4.0, false, false, false, true) end
			if imgui.Button(u8'���������� �� ����(1<-)', btn_size) then playAnim("Coplook_watch", "COP_AMBIENT", 4.0, false, false, false, true) end
			if imgui.Button(u8'����������(1<-)', btn_size) then playAnim("Coplook_think", "COP_AMBIENT", 4.0, false, false, false, true) end
			if imgui.Button(u8'�������� ���', btn_size) then playAnim("Scratchballs_01", "MISC", 4.0, false, false, false, false) end
			if imgui.Button(u8'�������� ������', btn_size) then playAnim("shop_pay", "INT_SHOP", 4.0, false, false, false, false) end
			if imgui.Button(u8'�������(1)', btn_size) then playAnim("mrnF_loop", "GRAVEYARD", 4.0, true, false, false, false) end
			if imgui.Button(u8'�������(2)', btn_size) then playAnim("mrnM_loop", "GRAVEYARD", 4.0, true, false, false, false) end
			if imgui.Button(u8'�������� �� ��� �����', btn_size) then playAnim("Barserve_bottle", "BAR", 4.0, false, false, false, false) end
			if imgui.Button(u8'������� �����(1)', btn_size) then playAnim("Laugh_01", "RAPPING", 4.0, false, false, false, false) end
			if imgui.Button(u8'������� �����(2)', btn_size) then playAnim("wave_loop", "ON_LOOKERS", 4.0, true, false, false, false) end
			if imgui.Button(u8'������� �����(3)', btn_size) then playAnim("BD_GF_Wave", "BD_FIRE", 4.0, false, false, false, false) end	
		elseif act == 3 then
			if imgui.Button(u8'<< �����', btn_size) then act = 0 end
			imgui.Text(u8'�����:')
			if imgui.Button(u8'�����(1)', btn_size) then playAnim("Stepsit_in", "Attractors", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(2)', btn_size) then playAnim("ParkSit_M_loop", "BEACH", 4.0, true, false, false, false) end
			if imgui.Button(u8'�����(3)', btn_size) then playAnim("LOU_In", "INT_HOUSE", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(4)', btn_size) then playAnim("ParkSit_W_loop", "BEACH", 4.0, true, false, false, false) end
			if imgui.Button(u8'�����(5)', btn_size) then playAnim("ParkSit_M_in", "SUNBATHE", 4.0, false, false, false, true) end
			if imgui.Button(u8'�������� ���(5<-)', btn_size) then playAnim("ParkSit_M_IdleB", "SUNBATHE", 4.0, false, false, false, true) end
			if imgui.Button(u8'�������� ���(5<-)', btn_size) then playAnim("ParkSit_M_IdleC", "SUNBATHE", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(6)', btn_size) then playAnim("ParkSit_W_in", "SUNBATHE", 4.0, false, false, false, true) end
			if imgui.Button(u8'�������� ����(6<-)', btn_size) then playAnim("ParkSit_W_idleC", "SUNBATHE", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(���� �����)', btn_size) then playAnim("FF_Sit_In_L", "FOOD", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(���� ������)', btn_size) then playAnim("FF_Sit_In_R", "FOOD", 4.0, false, false, false, true) end
			imgui.Text(u8'����:')
			if imgui.Button(u8'����(1)', btn_size) then playAnim("bather", "BEACH", 4.0, true, false, false, false) end
			if imgui.Button(u8'����(2)', btn_size) then playAnim("Lay_Bac_Loop", "BEACH", 4.0, true, false, false, false) end
			if imgui.Button(u8'����(3)', btn_size) then playAnim("SitnWait_loop_W", "BEACH", 4.0, true, false, false, false) end
			if imgui.Button(u8'����(4)', btn_size) then playAnim("batherdown", "SUNBATHE", 4.0, false, false, false, true) end	
			if imgui.Button(u8'����(���� �����)', btn_size) then playAnim("BED_In_L", "INT_HOUSE", 4.0, false, false, false, true) end
			if imgui.Button(u8'����(���� ������)', btn_size) then playAnim("BED_In_R", "INT_HOUSE", 4.0, false, false, false, true) end
			imgui.Text(u8'������:')
			if imgui.Button(u8'�����(1)', btn_size) then playAnim("crckidle1", "CRACK", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(2)', btn_size) then playAnim("crckidle2", "CRACK", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(3)', btn_size) then playAnim("crckidle3", "CRACK", 4.0, false, false, false, true) end
			if imgui.Button(u8'�����(4)', btn_size) then playAnim("crckidle4", "CRACK", 4.0, false, false, false, true) end
		elseif act == 4 then
			if imgui.Button(u8'<< �����', btn_size) then act = 0 end
			if imgui.Button(u8'�����(���� ������ �����)', btn_size) then playAnim("OFF_Sit_In", "INT_OFFICE", 4.0, false, true, false, true) end	
			if imgui.Button(u8'�������� �� �����', btn_size) then playAnim("OFF_Sit_Crash", "INT_OFFICE", 4.0, false, false, false, true) end
			if imgui.Button(u8'������(�� ������)', btn_size) then playAnim("OFF_Sit_Drink", "INT_OFFICE", 4.0, false, false, false, true) end
			if imgui.Button(u8'��������', btn_size) then playAnim("OFF_Sit_Type_Loop", "INT_OFFICE", 4.0, true, false, false, false) end
			if imgui.Button(u8'���������� �� ����(�� ������)', btn_size) then playAnim("OFF_Sit_Watch", "INT_OFFICE", 4.0, false, false, false, true) end
			if imgui.Button(u8'������ ��-�� �����', btn_size) then playAnim("OFF_Sit_2Idle_180", "INT_OFFICE", 4.0, false, true, true, false) end
		elseif act == 5 then
			if imgui.Button(u8'<< �����', btn_size) then act = 0 end
			if imgui.Button(u8'������ �����(1)', btn_size) then playAnim("SnM_Caned_Idle_P", "SnM", 4.0, true, false, false, false) end
			if imgui.Button(u8'������ �����(2)', btn_size) then playAnim("Spanking_IdleW", "SnM", 4.0, true, false, false, false) end
			if imgui.Button(u8'������ �� ����(1)', btn_size) then playAnim("SnM_Cane_P", "SnM", 4.0, true, false, false, false) end
			if imgui.Button(u8'������ �� ����(2)', btn_size) then playAnim("SpankingP", "SnM", 4.0, true, false, false, false) end
			if imgui.Button(u8'ĸ������� �� ������(1)', btn_size) then playAnim("SnM_Cane_W", "SnM", 4.0, true, false, false, false) end
			if imgui.Button(u8'ĸ������� �� ������(2)', btn_size) then playAnim("SpankingW", "SnM", 4.0, true, false, false, false) end
			if imgui.Button(u8'������� ������ �� ����', btn_size) then playAnim("Spanking_endP", "SnM", 4.0, false, false, false, false) end	
			if imgui.Button(u8'������� �� ������', btn_size) then playAnim("Spanking_endW", "SnM", 4.0, false, true, false, true) end
			if imgui.Button(u8'˸���� ������ �� ����(�����)', btn_size) then playAnim("sweet_ass_slap", "SWEET", 4.0, false, false, false, false) end
			if imgui.Button(u8'������ �� �������', btn_size) then playAnim("Sweet_injuredloop", "SWEET", 4.0, false, false, false, true) end
			if imgui.Button(u8'�������(1)', btn_size) then playAnim("wank_loop", "PAULNMAC", 4.0, true, false, false, false) end
			if imgui.Button(u8'�������(1<-)', btn_size) then playAnim("wank_out", "PAULNMAC", 4.0, false, false, false, false) end
			if imgui.Button(u8'���� 1.1(M)', btn_size) then playAnim("SEX_1_CUM_P", "SEX", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� 1.1(W)', btn_size) then playAnim("SEX_1_CUM_W", "SEX", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� 1.2(M)', btn_size) then playAnim("SEX_1_P", "SEX", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� 1.2(W)', btn_size) then playAnim("SEX_1_W", "SEX", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� 1.3(M)', btn_size) then playAnim("SEX_1_FAIL_P", "SEX", 4.0, false, false, false, true) end
			if imgui.Button(u8'���� 1.3(W)', btn_size) then playAnim("SEX_1_FAIL_W", "SEX", 4.0, false, false, false, true) end
			if imgui.Button(u8'���� 2.1(M)', btn_size) then playAnim("SEX_2_P", "SEX", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� 2.1(W)', btn_size) then playAnim("SEX_2_W", "SEX", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� 2.2(M)', btn_size) then playAnim("SEX_2_FAIL_P", "SEX", 4.0, false, false, false, true) end
			if imgui.Button(u8'���� 2.2(W)', btn_size) then playAnim("SEX_2_FAIL_W", "SEX", 4.0, false, false, false, true) end	
			if imgui.Button(u8'���� 3.1(M)', btn_size) then playAnim("SEX_3_P", "SEX", 4.0, true, false, false, false) end	
			if imgui.Button(u8'���� 3.1(W)', btn_size) then playAnim("SEX_3_W", "SEX", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� 3.2(M)', btn_size) then playAnim("SEX_3_FAIL_P", "SEX", 4.0, false, false, false, true) end
			if imgui.Button(u8'���� 3.2(W)', btn_size) then playAnim("SEX_3_FAIL_W", "SEX", 4.0, false, false, false, true) end	
		elseif act == 6 then
			if imgui.Button(u8'<< �����', btn_size) then act = 0 end
			if imgui.Button(u8'�������', btn_size) then playAnim("EAT_Vomit_P", "FOOD", 4.0, false, false, false, false) end
			if imgui.Button(u8'������', btn_size) then playAnim("CAS_G2_GasKO", "HEIST9", 4.0, false, false, false, true) end
			if imgui.Button(u8'������(1)', btn_size) then playAnim("CS_Dead_Guy", "WUZI", 4.0, false, false, false, true) end
			if imgui.Button(u8'������(2)', btn_size) then playAnim("KILL_Knife_Ped_Die", "KNIFE", 4.0, false, false, false, true) end
			if imgui.Button(u8'���� ������(1)', btn_size) then playAnim("RAP_A_Loop", "LOWRIDER", 4.0, true, false, false, false) end
			if imgui.Button(u8'���� ������(2)', btn_size) then playAnim("RAP_B_Loop", "LOWRIDER", 4.0, true, false, false, false) end
			if imgui.Button(u8'��������� �� �����', btn_size) then playAnim("tran_stmb", "TRAIN", 4.0, false, false, false, true) end
			if imgui.Button(u8'��������� �� �����', btn_size) then playAnim("swt_vnt_sht_in", "SWAT", 4.0, false, false, false, true) end
			if imgui.Button(u8'������ �����', btn_size) then playAnim("ROB_Shifty", "SHOP", 4.0, true, false, false, false) end
			if imgui.Button(u8'���������� ����', btn_size) then playAnim("RIOT_ANGRY", "RIOT", 4.0, true, false, false, false) end
			if imgui.Button(u8'�����������', btn_size) then playAnim("stretch", "PLAYIDLES", 4.0, true, false, false, false) end
			if imgui.Button(u8'������ �� ������', btn_size) then playAnim("Plunger_01", "MISC", 4.0, false, false, false, false) end
			if imgui.Button(u8'��������� �� �����(1)', btn_size) then playAnim("leanIN", "GANGS", 4.0, false, false, false, true) end
			if imgui.Button(u8'��������� �� �����(2)', btn_size) then playAnim("Plyrlean_loop", "MISC", 4.0, false, false, false, true) end
			if imgui.Button(u8'��a������', btn_size) then playAnim("shake_cara", "GANGS", 4.0, false, false, false, false) end
			if imgui.Button(u8'�������� �����', btn_size) then playAnim("shake_carK", "GANGS", 4.0, false, false, false, false) end
			if imgui.Button(u8'�������� ��������', btn_size) then playAnim("shake_carSH", "GANGS", 4.0, false, false, false, false) end
			if imgui.Button(u8'�������', btn_size) then playAnim("IDLE_tired", "FAT", 4.0, true, false, false, false) end
			if imgui.Button(u8'������ ������', btn_size) then playAnim("Fixn_Car_Loop", "CAR", 4.0, true, false, false, false) end	
			if imgui.Button(u8'���� �������', btn_size) then playAnim("flag_drop", "CAR", 4.0, false, false, false, false) end	
			if imgui.Button(u8'�������� �����', btn_size) then playAnim("BOM_Plant", "BOMBER", 4.0, false, false, false, false) end	
		elseif act == 7 then
			if imgui.Button(u8'<< �����', btn_size) then act = 0 end
			imgui.Text(u8'�������� ��� GTA:SA.\n������ �������� �� ���� ����������\n��������.')
			imgui.Text(u8'"<-" - ���������� �� ��������,\n������� ����� ������������ �����\n���������.')
			imgui.Text(u8'W - ��� �������\nM - ��� ������')
			imgui.Text(u8'� Snoopcheg')
			if imgui.CollapsingHeader(u8'���������')then
				imgui.Checkbox(u8"�������� ������� �������� ����", dragmainw)
				imgui.Checkbox(u8"�������� ������� ���������� ����", dragsecw)
				imgui.Checkbox(u8'��������� ������ ��������(/sanim)', actkey)
				if inicfg.save(mainIni, "..\\config\\anims\\animation.ini") then
					mainIni = {
						location = {
							xmain = imgui.GetWindowPos().x,
							ymain = imgui.GetWindowPos().y,
							xsecond = secondWindow.x[0],
							ysecond = secondWindow.y[0]
						},
						main = {
							activation = actkey[0]
						}
					} inicfg.save(mainIni, "..\\config\\anims\\animation.ini")
				end
				inicfg.load(mainIni, "..\\config\\anims\\animation.ini")
				if imgui.Button(u8'�������������', btn_size) then
					thisScript():reload()
				end
			end
			imgui.End()
		end
	end
)

local SecondFrame = imgui.OnFrame(
	function() return secondWindow.active[0] or dragsecw[0] end,
	function(self)
		self.HideCursor = true
		imgui.SetNextWindowPos(imgui.ImVec2(secondWindow.x[0]+90, secondWindow.y[0]+20), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(180, 40), imgui.Cond.FirstUseEver)
		imgui.Begin("##11", secondWindow.active, (dragsecw[0] and 0 or imgui.WindowFlags.NoMove) + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.SetCursorPos(imgui.ImVec2(4,11))
		imgui.TextColoredRGB("Press {FF0000}F {FFFFFF}to stop the animation")
		secondWindow.x[0], secondWindow.y[0] = imgui.GetWindowPos().x, imgui.GetWindowPos().y
		imgui.End()
	end
)

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
	if not doesFileExist('moonloader/config/anims/animation.ini') then
		inicfg.save(mainIni, "..\\config\\anims\\animation.ini")
	end
	loadAnims()
	sampRegisterChatCommand("sanim", function() mainWindow.active[0] = not mainWindow.active[0] end)
	while true do wait(0)
		if animStatus and not antiflood then
			secondWindow.active[0] = not secondWindow.active[0]
			antiflood = true
		elseif not animStatus and antiflood then
			secondWindow.active[0] = not secondWindow.active[0]
			antiflood = false
		end
	end
end

function onWindowMessage(msg, wparam, lparam)
    if msg == 0x100 or msg == 0x101 then
        if (wparam == key.VK_ESCAPE and mainWindow.active[0]) and not isPauseMenuActive() then
            consumeWindowMessage(true, false)
            if msg == 0x101 then
                mainWindow.active[0] = false
            end
        end
		if (wparam == key.VK_F and animStatus) and not isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() then
			if msg == 0x101 then
				taskPlayAnim(PLAYER_PED, "abseil", "PED", 4.0, false, false, true, false, -1)
				animStatus = false
			end
		end
		if (wparam == key.VK_X) and not sampIsChatInputActive() and not isGamePaused() and not sampIsDialogActive() and sampIsLocalPlayerSpawned() then
			if not mainIni.main.activation then
				if msg == 0x101 then
					mainWindow.active[0] = not mainWindow.active[0]
				end
			end
		end
    end
end

function sampev.onClearPlayerAnimation(id)
	if animStatus then
		return false
	end
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local col = imgui.Col
    
    local designText = function(text__)
        local pos = imgui.GetCursorPos()
        if sampGetChatDisplayMode() == 2 then
            for i = 1, 1 do
                imgui.SetCursorPos(imgui.ImVec2(pos.x + i, pos.y))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) 
                imgui.SetCursorPos(imgui.ImVec2(pos.x - i, pos.y))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) 
                imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y + i))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) 
                imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y - i))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) 
            end
        end
        imgui.SetCursorPos(pos)
    end    
    
    local text = text:gsub('{(%x%x%x%x%x%x)}', '{%1FF}')

    local color = colors[col.Text]
    local start = 1
    local a, b = text:find('{........}', start)   
    
    while a do
        local t = text:sub(start, a - 1)
        if #t > 0 then
            designText(t)
            imgui.TextColored(color, t)
            imgui.SameLine(nil, 0)
        end

        local clr = text:sub(a + 1, b - 1)
        if clr:upper() == 'STANDART' then color = colors[col.Text]
        else
            clr = tonumber(clr, 16)
            if clr then
                local r = bit.band(bit.rshift(clr, 24), 0xFF)
                local g = bit.band(bit.rshift(clr, 16), 0xFF)
                local b = bit.band(bit.rshift(clr, 8), 0xFF)
                local a = bit.band(clr, 0xFF)
                color = imgui.ImVec4(r / 255, g / 255, b / 255, a / 255)
            end
        end

        start = b + 1
        a, b = text:find('{........}', start)
    end
    imgui.NewLine()
    if #text >= start then
        imgui.SameLine(nil, 0)
        designText(text:sub(start))
        imgui.TextColored(color, text:sub(start))
    end
end

function apply_custom_style()
	local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

	style.WindowBorderSize = 0.0
	style.WindowRounding = 5.5
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.FrameRounding = 10.0
    style.ScrollbarSize = 9.0
    style.ScrollbarRounding = 10.0
    style.GrabMinSize = 17.5
    style.GrabRounding = 10.0
    style.WindowPadding = imgui.ImVec2(3.5, 3.5)
    style.FramePadding = imgui.ImVec2(3.5, 3.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.4)

	colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg] = imgui.ImVec4(0.0, 0.0, 0.0, 0.6)
    colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border] = imgui.ImVec4(0.0, 0.56, 0.60, 0.4)
    colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg] = imgui.ImVec4(0.6, 0.1, 0.1, 1.0)
    colors[clr.FrameBgHovered] = imgui.ImVec4(0.6, 0.1, 0.1, 0.5)
    colors[clr.FrameBgActive] = imgui.ImVec4(0.6, 0.1, 0.1, 0.5)
    colors[clr.TitleBg] = imgui.ImVec4(0.1, 0.0, 0.0, 1.0)
    colors[clr.TitleBgActive] = imgui.ImVec4(0.6, 0.1, 0.1, 1.0)
    colors[clr.TitleBgCollapsed] = ImVec4(0.05, 0.05, 0.05, 0.79)
    colors[clr.CheckMark] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.Button] = imgui.ImVec4(0.6, 0.1, 0.1, 1.0)
	colors[clr.ButtonHovered] = imgui.ImVec4(0.8, 0.1, 0.1, 1.0)
	colors[clr.ButtonActive] = imgui.ImVec4(0.8, 0.1, 0.1, 1.0)
	colors[clr.Header] = imgui.ImVec4(0.6, 0.1, 0.1, 1.0)
	colors[clr.HeaderHovered] = imgui.ImVec4(0.8, 0.1, 0.1, 1.0)
	colors[clr.HeaderActive] = imgui.ImVec4(0.8, 0.1, 0.1, 1.0)
	colors[clr.SliderGrab] = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.SliderGrabActive] = imgui.ImVec4(1.00, 1.00, 1.00, 0.50)
end