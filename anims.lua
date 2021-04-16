script_name("Animations")
script_author("Snoopcheg")
script_version("0.7.4")

--require 'deps' {'fyp:mimgui'}
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
  		requestAnimation(v); table.insert(checkArray, hasAnimationLoaded(v)); --print('Animation ' .. v .. ' was loaded')
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
	local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
	style.WindowBorderSize = 0.0
	local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
	mainfont = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 16.5, nil, glyph_ranges)
end)

local antiflood = false
local act = 0
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local renderMainWindow = new.bool()
local renderSecondWindow = new.bool()
local xmainslider = new.int(mainIni.location.xmain)
local ymainslider = new.int(mainIni.location.ymain)
local xsecondslider = new.int(mainIni.location.xsecond)
local ysecondslider = new.int(mainIni.location.ysecond)
local actkey = new.bool(mainIni.main.activation)

local mainFrame = imgui.OnFrame(
	function() return renderMainWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.xmain, mainIni.location.ymain), nil, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(250, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Anim menu', renderMainWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
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
		imgui.Text(u8'�������� ��� GTA:SA.\n������ �������� �� ���� ����������\n��������(������� ����� �����������\n�� ��� ����).')
		imgui.Text(u8'"<-" - ���������� �� ��������,\n������� ����� ������������ �����\n���������.')
		imgui.Text(u8'W - ��� �������\nM - ��� ������')
		imgui.Text(u8'� Snoopcheg')
		if imgui.CollapsingHeader(u8'���������')then
			imgui.Text(u8'�������� ����')
			imgui.SliderInt('X position##1', xmainslider, 130, gw - 135)
			imgui.SliderInt('Y position##1', ymainslider, 120, gh - 120)
			imgui.Text(u8'��������� ����')
			imgui.SliderInt('X position##2', xsecondslider, 120, gw - 120)
			imgui.SliderInt('Y position##2', ysecondslider, 30, gh - 30)
			imgui.Checkbox(u8'��������� ������ ��������', actkey)
			if inicfg.save(mainIni, "..\\config\\anims\\animation.ini") then
				mainIni = {
					location = {
						xmain = xmainslider[0],
						ymain = ymainslider[0],
						xsecond = xsecondslider[0],
						ysecond = ysecondslider[0]
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

local SecondFrame
SecondFrame = imgui.OnFrame(
	function() return renderSecondWindow[0] end,
	function(self)
		SecondFrame.HideCursor = true
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.xsecond, mainIni.location.ysecond), nil, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 40), imgui.Cond.FirstUseEver)
		imgui.Begin("##11", renderSecondWindow, imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.SetCursorPos(imgui.ImVec2(4,11))
		imgui.PushFont(mainfont)
		imgui.Text("Press   to stop the animation")
		imgui.SetCursorPos(imgui.ImVec2(42,11))
		imgui.TextColored(imgui.ImVec4(0.7, 0.1, 0.1, 1.0), "F")
		imgui.PopFont()
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
	local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	autoupdate("https://raw.githubusercontent.com/TheSnoopcheg/anims/main/update.json", '['..string.upper(thisScript().name)..']: ', "vk.com/snoopcheg")
	openchangelog("https://github.com/TheSnoopcheg/anims/blob/main/CHANGELOG.md")
	sampRegisterChatCommand("sanim", function() renderMainWindow[0] = not renderMainWindow[0] end)
	while true do wait(0)
		if not mainIni.main.activation then
			if wasKeyPressed(key.VK_X) and not sampIsChatInputActive() and not isGamePaused() and not sampIsDialogActive() and isPlayerPlaying(PLAYER_HANDLE) then
				renderMainWindow[0] = not renderMainWindow[0]
			end
		end
		if wasKeyPressed(key.VK_F) and not isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and animStatus then
			taskPlayAnim(PLAYER_PED, "abseil", "PED", 4.0, false, false, true, false, -1)
			animStatus = false
		end
		if animStatus and not antiflood then
			renderSecondWindow[0] = not renderSecondWindow[0]
			antiflood = true
		elseif not animStatus and antiflood then
			renderSecondWindow[0] = not renderSecondWindow[0]
			antiflood = false
		end
	end
end

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
			if info.stats ~= nil then
                stats = info.stats
            end
            updatelink = info.updateurl
            updateversion = info.latest
			if info.changelog ~= nil then
                changelogurl = info.changelog
            end
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('�������� ���������� ���������.')
                      sampAddChatMessage((prefix..'���������� ���������!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end

function openchangelog(url)
    sampRegisterChatCommand(
        "showupdatelist",
        function()
            lua_thread.create(
                function()
                    if changelogurl == nil then
                        changelogurl = url
                    end
                    sampShowDialog(
                        222228,
                        "{ff0000}���������� �� ����������",
                        "{ffffff}" ..
                            thisScript().name ..
                                " {ffe600}���������� ������� ���� changelog ��� ���.\n���� �� ������� {ffffff}�������{ffe600}, ������ ���������� ������� ������:\n        {ffffff}" ..
                                    changelogurl ..
                                        "\n{ffe600}���� ���� ���� ���������, �� ������ ������� ��� ������ ����.",
                        "�������",
                        "��������"
                    )
                    while sampIsDialogActive() do
                        wait(100)
                    end
                    local result, button, list, input = sampHasDialogRespond(222228)
                    if button == 1 then
                        os.execute('explorer "' .. changelogurl .. '"')
                    end
                end
            )
        end
    )
end

function sampev.onClearPlayerAnimation(id)
	if animStatus then
		return false
	end
end