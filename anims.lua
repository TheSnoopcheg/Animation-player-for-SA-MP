script_name("Animations")
script_author("Snoopcheg")
script_version("0.7")

--require 'deps' {'fyp:mimgui'}
local key = require ('vkeys')
local imgui = require 'mimgui'
local ffi = require 'ffi'
local encoding = require ('encoding')
local inicfg = require ('inicfg')
encoding.default = 'CP1251'
u8 = encoding.UTF8
local gw, gh =  getScreenResolution()

local mainIni = inicfg.load({
	location = {
		x = 155,
		y = 120
	},
	main = {
		activation = false
	}
}, "..\\config\\anims\\animation.ini")

function loadanim()
	requestAnimation("NEWANIMS_F")
	requestAnimation("NEWANIMS_S")
	requestAnimation("SEX")
	requestAnimation("DANCING")
	requestAnimation("Attractors")
	requestAnimation("BEACH")
	requestAnimation("SnM")
	requestAnimation("SWEET")
	requestAnimation("INT_OFFICE")
	requestAnimation("INT_SHOP")
	requestAnimation("INT_HOUSE")
	requestAnimation("FOOD")
	requestAnimation("STRIP")
	requestAnimation("HEIST9")
	requestAnimation("WUZI")
	requestAnimation("CRACK")
	requestAnimation("LOWRIDER")
	requestAnimation("SUNBATHE")
	requestAnimation("STRIP")
	requestAnimation("TRAIN")
	requestAnimation("SWAT")
	requestAnimation("SMOKING")
	requestAnimation("SHOP")
	requestAnimation("RIOT")
	requestAnimation("RAPPING")
	requestAnimation("POLICE")
	requestAnimation("PLAYIDLES")
	requestAnimation("PAULNMAC")
	requestAnimation("PARK")
	requestAnimation("MEDIC")
	requestAnimation("OTB")
	requestAnimation("ON_LOOKERS")
	requestAnimation("MISC")
	requestAnimation("KNIFE")
	requestAnimation("GRAVEYARD")
	requestAnimation("GANGS")
	requestAnimation("FAT")
	requestAnimation("COP_AMBIENT")
	requestAnimation("CAR")
	requestAnimation("BOMBER")
	requestAnimation("BAR")
	requestAnimation("BD_FIRE")
end

function playAnim(name, nameLib, speed, loop, lockX, lockY, lockF)
  if not isCharInAnyCar(PLAYER_PED) then
    animStatus = true
    taskPlayAnim(PLAYER_PED, name, nameLib, speed, loop, lockX, lockY, lockF, -1)
  else
     sampAddChatMessage('Выйдите из транспортного средства для того, чтобы использовать анимации.', -1)
  end
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
	local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
	style.WindowBorderSize = 0.0
end)

local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local renderMainWindow = new.bool()
local renderDanceWindow = new.bool()
local renderSocialWindow = new.bool()
local renderSitWindow = new.bool()
local renderOfficeWindow = new.bool()
local renderSexWindow = new.bool()
local renderOtherWindow = new.bool()
local renderInfoWindow = new.bool()
local xslider = new.int(mainIni.location.x)
local yslider = new.int(mainIni.location.y)
local actkey = new.bool(mainIni.main.activation)

local mainFrame = imgui.OnFrame(
	function() return renderMainWindow[0] end,
    function(player)
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Anim menu', renderMainWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
		if imgui.Button('Dance', btn_size) then
			renderDanceWindow[0] = not renderDanceWindow[0]
		end
		if imgui.Button('Social', btn_size) then
			renderSocialWindow[0] = not renderSocialWindow[0]
		end
		if imgui.Button('Sit/Lie down', btn_size) then
			renderSitWindow[0] = not renderSitWindow[0]
		end		
		if imgui.Button('Office', btn_size) then
			renderOfficeWindow[0] = not renderOfficeWindow[0]
		end
		if imgui.Button('Sex', btn_size) then
			renderSexWindow[0] = not renderSexWindow[0]
		end
		if imgui.Button('Other', btn_size) then
			renderOtherWindow[0] = not renderOtherWindow[0]
		end
		if imgui.Button('Stop anim', btn_size) then
			taskPlayAnim(PLAYER_PED, "abseil", "PED", 4.0, false, false, true, false, -1)
			animStatus = false
		end
		if imgui.Button('Info&Settings', btn_size) then
			renderInfoWindow[0] = not renderInfoWindow[0]
		end
		imgui.End()

	if renderDanceWindow[0] then
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x - 15, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(270, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Dance', renderDanceWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Text('From Fortnite:')
		if imgui.Button('Orange Justice', btn_size) then playAnim("DNCE_M_AA", "NEWANIMS_S", 4.0, true, false, false, false) end
		if imgui.Button('2 anim', btn_size) then playAnim("DNCE_M_BB", "NEWANIMS_S", 4.0, true, false, false, false) end
		if imgui.Button('3 anim', btn_size) then playAnim("DNCE_M_CC", "NEWANIMS_S", 4.0, true, false, false, false) end
		if imgui.Button('Electro Shuffle', btn_size) then playAnim("DNCE_M_DD", "NEWANIMS_S", 4.0, true, false, false, false) end
		if imgui.Button('Dab', btn_size) then playAnim("DNCE_M_EE", "NEWANIMS_S", 4.0, false, false, false, false) end
		if imgui.Button('Dance Moves', btn_size) then playAnim("BD_PANIC_LOOPP", "NEWANIMS_F", 4.0, true, false, false, false) end
		if imgui.Button('Fresh', btn_size) then playAnim("WASH_UPP", "NEWANIMS_F", 4.0, true, false, false, false) end
		imgui.Text('Other:')
		if imgui.Button('8 anim', btn_size) then playAnim("DNCE_M_D", "DANCING", 4.0, true, false, false, false) end
		if imgui.Button('9 anim', btn_size) then playAnim("DAN_DOWN_A", "DANCING", 4.0, true, false, false, false) end
		if imgui.Button('10 anim', btn_size) then playAnim("DAN_LOOP_A", "DANCING", 4.0, true, false, false, false) end
		if imgui.Button('Waves', btn_size) then playAnim("DNCE_M_A", "DANCING", 4.0, true, false, false, false) end
		if imgui.Button('Wiggle', btn_size) then playAnim("DNCE_M_B", "DANCING", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(1)', btn_size) then playAnim("strip_B", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(2)', btn_size) then playAnim("strip_E", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(3)', btn_size) then playAnim("strip_G", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(4)', btn_size) then playAnim("STR_A2B", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(5)', btn_size) then playAnim("STR_B2C", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(6)', btn_size) then playAnim("STR_C1", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(7)', btn_size) then playAnim("STR_C2", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(8)', btn_size) then playAnim("STR_Loop_A", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(9)', btn_size) then playAnim("STR_Loop_B", "STRIP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòðèïòèç(10)', btn_size) then playAnim("STR_Loop_C", "STRIP", 4.0, true, false, false, false) end
		imgui.End()
	end

	if renderSocialWindow[0] then
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x - 15, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(270, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Social', renderSocialWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
		if imgui.Button(u8'Êóðèòü(1)', btn_size) then playAnim("F_smklean_loop", "SMOKING", 4.0, true, false, false, false) end
		if imgui.Button(u8'Êóðèòü(2)', btn_size) then playAnim("M_smklean_loop", "SMOKING", 4.0, true, false, false, false) end
		if imgui.Button(u8'Êóðèòü(3)', btn_size) then playAnim("M_smkstnd_loop", "SMOKING", 4.0, true, false, false, false) end
		if imgui.Button(u8'Çàíþõíóòü', btn_size) then playAnim("M_smk_in", "SMOKING", 4.0, false, false, false, false) end
		if imgui.Button(u8'Íàñòàâèòü îðóæèå', btn_size) then playAnim("ROB_Loop_Threat", "SHOP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ïîäíÿòü ðóêè', btn_size) then playAnim("SHP_HandsUp_Scr", "SHOP", 4.0, false, false, false, true) end
		if imgui.Button(u8'Áîëåòü(1)', btn_size) then playAnim("RIOT_CHANT", "RIOT", 4.0, true, false, false, false) end
		if imgui.Button(u8'Áîëåòü(2)', btn_size) then playAnim("RIOT_PUNCHES", "RIOT", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ïîñëàòü', btn_size) then playAnim("RIOT_FUKU", "RIOT", 4.0, false, false, false, false) end
		if imgui.Button(u8'Êðè÷àòü', btn_size) then playAnim("RIOT_shout", "RIOT", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ïðîãíàòü', btn_size) then playAnim("CopTraf_Away", "POLICE", 4.0, false, false, false, false) end
		if imgui.Button(u8'Êî ìíå', btn_size) then playAnim("CopTraf_Come", "POLICE", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ñòîï', btn_size) then playAnim("CopTraf_Stop", "POLICE", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ññàòü(M)', btn_size) then playAnim("Piss_in", "PAULNMAC", 4.0, false, false, false, true) end
		if imgui.Button(u8'Éîãà', btn_size) then playAnim("Tai_Chi_Loop", "PARK", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ìàññàæ ñåðäöà', btn_size) then playAnim("CPR", "MEDIC", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ñëîæèòü ðóêè(1)', btn_size) then playAnim("wtchrace_in", "OTB", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ñëîæèòü ðóêè(2)', btn_size) then playAnim("prst_loopa", "GRAVEYARD", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ïðîèãðûøü(1<-)', btn_size) then playAnim("wtchrace_lose", "OTB", 4.0, false, false, false, true) end
		if imgui.Button(u8'Âûèãðûøü(1<-)', btn_size) then playAnim("wtchrace_win", "OTB", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ïîñìîòðåòü íà ÷àñû(1<-)', btn_size) then playAnim("Coplook_watch", "COP_AMBIENT", 4.0, false, false, false, true) end
		if imgui.Button(u8'Çàäóìàòüñÿ(1<-)', btn_size) then playAnim("Coplook_think", "COP_AMBIENT", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ïî÷åñàòü ïàõ', btn_size) then playAnim("Scratchballs_01", "MISC", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ïåðåäàòü äåíüãè', btn_size) then playAnim("shop_pay", "INT_SHOP", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ïëàêàòü(1)', btn_size) then playAnim("mrnF_loop", "GRAVEYARD", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ïëàêàòü(2)', btn_size) then playAnim("mrnM_loop", "GRAVEYARD", 4.0, true, false, false, false) end
		if imgui.Button(u8'Âûòàùèòü èç ïîä ñòîëà', btn_size) then playAnim("Barserve_bottle", "BAR", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ìàõíóòü ðóêîé(1)', btn_size) then playAnim("Laugh_01", "RAPPING", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ìàõíóòü ðóêîé(2)', btn_size) then playAnim("wave_loop", "ON_LOOKERS", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ìàõíóòü ðóêîé(3)', btn_size) then playAnim("BD_GF_Wave", "BD_FIRE", 4.0, false, false, false, false) end
		imgui.End()
	end
	
	if renderSitWindow[0] then
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x - 15, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(270, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Sit/Lie down', renderSitWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Text('Sit:')
		if imgui.Button('1 anim', btn_size) then playAnim("Stepsit_in", "Attractors", 4.0, false, false, false, true) end
		if imgui.Button('4 anim', btn_size) then playAnim("ParkSit_M_loop", "BEACH", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñåñòü(Áûòü ñëåâà)', btn_size) then playAnim("FF_Sit_In_L", "FOOD", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ñåñòü(Áûòü ñïðàâà)', btn_size) then playAnim("FF_Sit_In_R", "FOOD", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ñåñòü(1)', btn_size) then playAnim("LOU_In", "INT_HOUSE", 4.0, false, false, false, true) end
		if imgui.Button('5 anim', btn_size) then playAnim("ParkSit_W_loop", "BEACH", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñåñòü(2)', btn_size) then playAnim("ParkSit_M_in", "SUNBATHE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Âûòåðåòü ëîá(2<-)', btn_size) then playAnim("ParkSit_M_IdleB", "SUNBATHE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ïî÷åñàòü ïàõ(2<-)', btn_size) then playAnim("ParkSit_M_IdleC", "SUNBATHE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ñåñòü(3)', btn_size) then playAnim("ParkSit_W_in", "SUNBATHE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ïî÷åñàòü ïîïó(2<-)', btn_size) then playAnim("ParkSit_W_idleC", "SUNBATHE", 4.0, false, false, false, true) end
		imgui.Text('Lie down:')
		if imgui.Button('2 anim', btn_size) then playAnim("bather", "BEACH", 4.0, true, false, false, false) end
		if imgui.Button('3 anim', btn_size) then playAnim("Lay_Bac_Loop", "BEACH", 4.0, true, false, false, false) end
		if imgui.Button('6 anim', btn_size) then playAnim("SitnWait_loop_W", "BEACH", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ëå÷ü(Áûòü ñëåâà)', btn_size) then playAnim("BED_In_L", "INT_HOUSE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ëå÷ü(Áûòü ñïðàâà)', btn_size) then playAnim("BED_In_R", "INT_HOUSE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ëå÷ü(1)', btn_size) then playAnim("batherdown", "SUNBATHE", 4.0, false, false, false, true) end	
		imgui.Text('Other:')
		if imgui.Button(u8'Ðàíåí(1)', btn_size) then playAnim("crckidle1", "CRACK", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ðàíåí(2)', btn_size) then playAnim("crckidle2", "CRACK", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ðàíåí(3)', btn_size) then playAnim("crckidle3", "CRACK", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ðàíåí(4)', btn_size) then playAnim("crckidle4", "CRACK", 4.0, false, false, false, true) end
		imgui.End()
	end
	
	if renderOfficeWindow[0] then
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x - 15, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(270, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Office', renderOfficeWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
		if imgui.Button(u8'Ñåñòü(áûòü ïîçàäè ñòóëà)', btn_size) then playAnim("OFF_Sit_In", "INT_OFFICE", 4.0, false, true, false, true) end	
		if imgui.Button(u8'Ñòóêíóòü ïî ñòîëó', btn_size) then playAnim("OFF_Sit_Crash", "INT_OFFICE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Âûïèòü(çà ñòîëîì)', btn_size) then playAnim("OFF_Sit_Drink", "INT_OFFICE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ïå÷àòàòü', btn_size) then playAnim("OFF_Sit_Type_Loop", "INT_OFFICE", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ïîñìîòðåòü íà ÷àñû(çà ñòîëîì)', btn_size) then playAnim("OFF_Sit_Watch", "INT_OFFICE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Âñòàòü èç-çà ñòîëà', btn_size) then playAnim("OFF_Sit_2Idle_180", "INT_OFFICE", 4.0, false, true, true, false) end
		imgui.End()
	end
	
	if renderSexWindow[0] then
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x - 15, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(270, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Sex', renderSexWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
		if imgui.Button(u8'Ñòîÿòü ðàêîì(1)', btn_size) then playAnim("SnM_Caned_Idle_P", "SnM", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñòîÿòü ðàêîì(2)', btn_size) then playAnim("Spanking_IdleW", "SnM", 4.0, true, false, false, false) end
		if imgui.Button(u8'Øëåïîê ïî ïîïå(1)', btn_size) then playAnim("SnM_Cane_P", "SnM", 4.0, true, false, false, false) end
		if imgui.Button(u8'Øëåïîê ïî ïîïå(2)', btn_size) then playAnim("SpankingP", "SnM", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ä¸ðãàòüñÿ îò øëåïêà(1)', btn_size) then playAnim("SnM_Cane_W", "SnM", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ä¸ðãàòüñÿ îò øëåïêà(2)', btn_size) then playAnim("SpankingW", "SnM", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ñèëüíûé øëåïîê ïî ïîïå', btn_size) then playAnim("Spanking_endP", "SnM", 4.0, false, false, false, false) end	
		if imgui.Button(u8'Ïàäåíèå îò øëåïêà', btn_size) then playAnim("Spanking_endW", "SnM", 4.0, false, true, false, true) end
		if imgui.Button(u8'Ë¸ãêèé øëåïîê ïî ïîïå(Ñáîêó)', btn_size) then playAnim("sweet_ass_slap", "SWEET", 4.0, false, false, false, false) end
		if imgui.Button(u8'Ñòîÿòü íà êîëåíÿõ', btn_size) then playAnim("Sweet_injuredloop", "SWEET", 4.0, false, false, false, true) end
		if imgui.Button(u8'Äðî÷èòü(1)', btn_size) then playAnim("wank_loop", "PAULNMAC", 4.0, true, false, false, false) end
		if imgui.Button(u8'Äðî÷èòü(1<-)', btn_size) then playAnim("wank_out", "PAULNMAC", 4.0, false, false, false, false) end
		if imgui.Button('Sex 1.1(M)', btn_size) then playAnim("SEX_1_CUM_P", "SEX", 4.0, true, false, false, false) end
		if imgui.Button('Sex 1.1(W)', btn_size) then playAnim("SEX_1_CUM_W", "SEX", 4.0, true, false, false, false) end
		if imgui.Button('Sex 1.2(M)', btn_size) then playAnim("SEX_1_P", "SEX", 4.0, true, false, false, false) end
		if imgui.Button('Sex 1.2(W)', btn_size) then playAnim("SEX_1_W", "SEX", 4.0, true, false, false, false) end
		if imgui.Button('Sex 1.3(M)', btn_size) then playAnim("SEX_1_FAIL_P", "SEX", 4.0, false, false, false, true) end
		if imgui.Button('Sex 1.3(W)', btn_size) then playAnim("SEX_1_FAIL_W", "SEX", 4.0, false, false, false, true) end
		if imgui.Button('Sex 2.1(M)', btn_size) then playAnim("SEX_2_P", "SEX", 4.0, true, false, false, false) end
		if imgui.Button('Sex 2.1(W)', btn_size) then playAnim("SEX_2_W", "SEX", 4.0, true, false, false, false) end
		if imgui.Button('Sex 2.2(M)', btn_size) then playAnim("SEX_2_FAIL_P", "SEX", 4.0, false, false, false, true) end
		if imgui.Button('Sex 2.2(W)', btn_size) then playAnim("SEX_2_FAIL_W", "SEX", 4.0, false, false, false, true) end	
		if imgui.Button('Sex 3.1(M)', btn_size) then playAnim("SEX_3_P", "SEX", 4.0, true, false, false, false) end	
		if imgui.Button('Sex 3.1(W)', btn_size) then playAnim("SEX_3_W", "SEX", 4.0, true, false, false, false) end
		if imgui.Button('Sex 3.2(M)', btn_size) then playAnim("SEX_3_FAIL_P", "SEX", 4.0, false, false, false, true) end
		if imgui.Button('Sex 3.2(W)', btn_size) then playAnim("SEX_3_FAIL_W", "SEX", 4.0, false, false, false, true) end
		imgui.End()
	end
	
	if renderOtherWindow[0] then
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x - 15, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(270, 225), imgui.Cond.FirstUseEver)
		imgui.Begin('Other', renderOtherWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		local btn_size = imgui.ImVec2(-0.1, 0)
		if imgui.Button(u8'Òîøíîòà', btn_size) then playAnim("EAT_Vomit_P", "FOOD", 4.0, false, false, false, false) end
		if imgui.Button(u8'Óïàñòü', btn_size) then playAnim("CAS_G2_GasKO", "HEIST9", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ñìåðòü(1)', btn_size) then playAnim("CS_Dead_Guy", "WUZI", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ñìåðòü(2)', btn_size) then playAnim("KILL_Knife_Ped_Die", "KNIFE", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ìàõè ðóêàìè(1)', btn_size) then playAnim("RAP_A_Loop", "LOWRIDER", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ìàõè ðóêàìè(2)', btn_size) then playAnim("RAP_B_Loop", "LOWRIDER", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ïîâèñíóòü íà ðóêàõ', btn_size) then playAnim("tran_stmb", "TRAIN", 4.0, false, false, false, true) end
		if imgui.Button(u8'Ïîâèñíóòü íà íîãàõ', btn_size) then playAnim("swt_vnt_sht_in", "SWAT", 4.0, false, false, false, true) end
		if imgui.Button(u8'Íàäåòü ìàñêó', btn_size) then playAnim("ROB_Shifty", "SHOP", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ðàññòàâèòü ðóêè', btn_size) then playAnim("RIOT_ANGRY", "RIOT", 4.0, true, false, false, false) end
		if imgui.Button(u8'Ðàçìèíàòüñÿ', btn_size) then playAnim("stretch", "PLAYIDLES", 4.0, true, false, false, false) end
		if imgui.Button(u8'Íàæàòü íà êíîïêó', btn_size) then playAnim("Plunger_01", "MISC", 4.0, false, false, false, false) end
		if imgui.Button(u8'Îïåðåòüñÿ íà ñòåíó(1)', btn_size) then playAnim("leanIN", "GANGS", 4.0, false, false, false, true) end
		if imgui.Button(u8'Îïåðåòüñÿ íà ñòåíó(2)', btn_size) then playAnim("Plyrlean_loop", "MISC", 4.0, false, false, false, true) end
		if imgui.Button(u8'Òîaëêíóòü', btn_size) then playAnim("shake_cara", "GANGS", 4.0, false, false, false, false) end
		if imgui.Button(u8'Òîëêíóòü íîãîé', btn_size) then playAnim("shake_carK", "GANGS", 4.0, false, false, false, false) end
		if imgui.Button(u8'Òîëêíóòü êîðïóñîì', btn_size) then playAnim("shake_carSH", "GANGS", 4.0, false, false, false, false) end
		if imgui.Button(u8'Îòäûøêà', btn_size) then playAnim("IDLE_tired", "FAT", 4.0, true, false, false, false) end
		if imgui.Button(u8'×èíèòü ìàøèíó', btn_size) then playAnim("Fixn_Car_Loop", "CAR", 4.0, true, false, false, false) end	
		if imgui.Button(u8'Äàòü îòìàøêó', btn_size) then playAnim("flag_drop", "CAR", 4.0, false, false, false, false) end	
		if imgui.Button(u8'Çàëîæèòü áîìáó', btn_size) then playAnim("BOM_Plant", "BOMBER", 4.0, false, false, false, false) end	
		imgui.End()
	end
	
	if renderInfoWindow[0] then
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.location.x + 276, mainIni.location.y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(250, 225), imgui.Cond.FirstUseEver)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Begin('Info&Settings', renderInfoWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
		imgui.Text('Animations for GTA:SA\nThe script works on all current game\nprojects.')
		imgui.Text('"<-" - Indicates the animation to be\nin before using the next one.')
		imgui.Text('W - for woman\nM - for man')
		imgui.Text(u8'Â© Snoopcheg')
		imgui.SliderInt('X position', xslider, 155, gw - 400)
		imgui.SliderInt('Y position', yslider, 120, gh - 120)
		imgui.Checkbox('Use only command to activate', actkey)
		if inicfg.save(mainIni, "..\\config\\anims\\animation.ini") then
			mainIni = {
				location = {
					x = xslider[0],
					y = yslider[0]
				},
				main = {
					activation = actkey[0]
				}
			} inicfg.save(mainIni, "..\\config\\anims\\animation.ini")
		end
		inicfg.load(mainIni, "..\\config\\anims\\animation.ini")
		if imgui.Button('Accept changes', btn_size) then
			thisScript():reload()
		end
		imgui.End()
	end
	end
)

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
	IsLoaded1 = loadTextureDictionary("animation")
	press = loadSprite("pressf")
	loadanim()
	autoupdate("https://raw.githubusercontent.com/TheSnoopcheg/anims/main/update.json", '['..string.upper(thisScript().name)..']: ', "https://github.com/TheSnoopcheg/anims")
	sampRegisterChatCommand("ssanim", function() renderMainWindow[0] = not renderMainWindow[0] end)
	while true do wait(0)
		if mainIni.main.activation == false then
			if wasKeyPressed(key.VK_X) and not sampIsChatInputActive() and not isGamePaused() and not sampIsDialogActive()  then
				renderMainWindow[0] = not renderMainWindow[0]
			end
		end
		if wasKeyPressed(key.VK_F) and not isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and animStatus then
			taskPlayAnim(PLAYER_PED, "abseil", "PED", 4.0, false, false, true, false, -1)
			animStatus = false
		end
		if animStatus == true then
			drawSprite(press, 80, 330, 110.0, 155.0, 255, 255, 255, 255)
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
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Îáíàðóæåíî îáíîâëåíèå. Ïûòàþñü îáíîâèòüñÿ c '..thisScript().version..' íà '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Çàãðóæåíî %d èç %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Çàãðóçêà îáíîâëåíèÿ çàâåðøåíà.')
                      sampAddChatMessage((prefix..'Îáíîâëåíèå çàâåðøåíî!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Îáíîâëåíèå ïðîøëî íåóäà÷íî. Çàïóñêàþ óñòàðåâøóþ âåðñèþ..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Îáíîâëåíèå íå òðåáóåòñÿ.')
            end
          end
        else
          print('v'..thisScript().version..': Íå ìîãó ïðîâåðèòü îáíîâëåíèå. Ñìèðèòåñü èëè ïðîâåðüòå ñàìîñòîÿòåëüíî íà '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
