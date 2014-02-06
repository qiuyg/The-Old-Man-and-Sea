--
-- Author: qiuyg
-- Date: 2014-01-15 17:10:06
--
local PlaceJetton = import("..c2s.PlaceJetton")
local UserInfoReq = import("..c2s.UserInfoReq")
local ChairUserInfoReq = import("..c2s.ChairUserInfoReq")
local GameOption = import("..c2s.GameOption")
local GameResult = import("..subWindow.GameResult")
local History = import("..subWindow.History")
local QuickStartGame = import("..c2s.QuickStartGame")
local UserStandUp = import("..c2s.UserStandUp")
local BankerInfo = import("..subWindow.BankerInfo")


local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)


GameScene.BTN_HISTORY = {
    normal  = "game/btn_history.png",
    pressed = "game/btn_history_pressed.png"
}

GameScene.BTN_BACK = {
    normal  = "login/gologin/back.png",
    pressed = "login/gologin/back_click.png"
}

GameScene.BTN_BANKER_INFO = {
	normal  = "game/bankerInfo.png",
	pressed = "game/bankerInfo_pressed.png"
}

GameScene.RADIO_BTN_GLOD_100 = {
    on = "#100_pressed.png",
    off = "#100.png",
    off_disabled = "#100_disable.png"
}

GameScene.RADIO_BTN_GLOD_1K = {
    on = "#1K_pressed.png",
    off = "#1K.png",
    off_disabled = "#1K_disable.png"
}

GameScene.RADIO_BTN_GLOD_10K = {
    on = "#10K_pressed.png",
    off = "#10K.png",
    off_disabled = "#10K_disable.png"
}

GameScene.RADIO_BTN_GLOD_100K = {
    on = "#100K_pressed.png",
    off = "#100K.png",
    off_disabled = "#100K_disable.png"
}

GameScene.RADIO_BTN_GLOD_1M = {
    on = "#1M_pressed.png",
    off = "#1M.png",
    off_disabled = "#1M_disable.png"
}

GameScene.RADIO_BTN_GLOD_5M = {
    on = "#5M_pressed.png",
    off = "#5M.png",
    off_disabled = "#5M_disable.png"
}

GameScene.BTN_JETTONAREA_ONE = {
    normal  = "#jettonArea_one.png",
    pressed = "#jettonArea_one_pressed.png"
}

GameScene.BTN_JETTONAREA_TWO = {
    normal  = "#jettonArea_two.png",
    pressed = "#jettonArea_two_pressed.png"
}

GameScene.BTN_JETTONAREA_THREE = {
    normal  = "#jettonArea_three.png",
    pressed = "#jettonArea_three_pressed.png"
}

GameScene.BTN_JETTONAREA_FOUR= {
    normal  = "#jettonArea_four.png",
    pressed = "#jettonArea_four_pressed.png"
}

GameScene.BTN_JETTONAREA_FIVE = {
    normal  = "#jettonArea_five.png",
    pressed = "#jettonArea_five_pressed.png"
}

GameScene.BTN_JETTONAREA_SIX = {
    normal  = "#jettonArea_six.png",
    pressed = "#jettonArea_six_pressed.png"
}

GameScene.BTN_JETTONAREA_SEVEN = {
    normal  = "#jettonArea_seven.png",
    pressed = "#jettonArea_seven_pressed.png"
}

GameScene.BTN_JETTONAREA_EIGHT = {
    normal  = "#jettonArea_eight.png",
    pressed = "#jettonArea_eight_pressed.png"
}


function GameScene:ctor()
	--初始化其他玩家信息
	GameScene.players = {}
	History.cars = {}
	
    display.addSpriteFramesWithFile(CAR_LEFT_BOTTOM_TEXTURE_DATA_FILENAME, CAR_LEFT_BOTTOM_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(CAR_RIGHT_BOTTOM_TEXTURE_DATA_FILENAME, CAR_RIGHT_BOTTOM_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(CAR_RIGHT_TOP_TEXTURE_DATA_FILENAME, CAR_RIGHT_TOP_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(CAR_LEFT_TOP_TEXTURE_DATA_FILENAME, CAR_LEFT_TOP_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(ICON_TEXTURE_DATA_FILENAME, ICON_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(GOLD_TEXTURE_DATA_FILENAME, GOLD_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(JETTON_AREA_TEXTURE_DATA_FILENAME, JETTON_AREA_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(JETTON_TEXTURE_DATA_FILENAME, JETTON_TEXTURE_IMAGE_FILENAME)

	local bottom = display.newSprite("game/bottom.jpg", display.cx, display.cy)
	self:addChild(bottom)
	
	GameScene.bg=display.newSprite("game/bg.jpg", display.cx, display.cy)
	self:addChild(GameScene.bg)

	--胜利特效资源
	GameScene.light_left_top = display.newSprite("game/light_left_top.png", 0, 640)
	GameScene.light_left_top:setAnchorPoint(ccp(0,1))
	GameScene.light_left_top:setVisible(false)
	GameScene.bg:addChild(GameScene.light_left_top)

	GameScene.light_left_bottom = display.newSprite("game/light_left_bottom.png", 3, 115)
	GameScene.light_left_bottom:setAnchorPoint(ccp(0,0))
	GameScene.light_left_bottom:setVisible(false)
	GameScene.bg:addChild(GameScene.light_left_bottom)
	
	GameScene.light_right_top = display.newSprite("game/light_right_top.png", 1136, 640)
	GameScene.light_right_top:setAnchorPoint(ccp(1,1))
	GameScene.light_right_top:setVisible(false)
	GameScene.bg:addChild(GameScene.light_right_top)
	
	GameScene.light_right_bottom = display.newSprite("game/light_right_bottom.png", 1136, 112)
	GameScene.light_right_bottom:setAnchorPoint(ccp(ccp(1,0)))
	GameScene.light_right_bottom:setVisible(false)
	GameScene.bg:addChild(GameScene.light_right_bottom)

	--8个区域，总下注
	GameScene.areaTotalScore = {}
	--8个区域，自己下注
	GameScene.areaSelfScore = {}
	--显示总下注的8个label
	GameScene.totalScoreLabels = {}
	--显示自己下注的8个label
	GameScene.selfScoreLabels = {}
	
	self:addJectionArea(GameScene.bg)
	self:addIcons(GameScene.bg)
	self:addGoldBtn(GameScene.bg)

	mapratio=display.size.width/1136
	GameScene.bg:setScale(mapratio)

    local frames_right_top = display.newFrames("1_%d.png", 61, 30, true)
    GameScene.car_right_top = display.newAnimation(frames_right_top, 0.2/30)
    GameScene.car_right_top:retain()

    local frames_right_bottom = display.newFrames("1_%d.png", 31, 30, true)
    GameScene.car_right_bottom = display.newAnimation(frames_right_bottom, 0.2/30)
    GameScene.car_right_bottom:retain()

    local frames_left_bottom = display.newFrames("1_%02d.png", 1, 30, true)
    GameScene.car_left_bottom = display.newAnimation(frames_left_bottom, 0.2/30)
   	GameScene.car_left_bottom:retain()
    
    local frames_left_top = display.newFrames("1_%d.png", 91, 30, true)
    GameScene.car_left_top = display.newAnimation(frames_left_top,  0.2/30)
    GameScene.car_left_top:retain()

    GameScene.car_orign=display.newAnimation(display.newFrames("1_%d.png", 90, 1), 0.2/30)
	GameScene.car_orign:retain()

	cc.ui.UIPushButton.new(GameScene.BTN_BACK)
        :onButtonClicked(function(event)

        	if GameScene.state == GAME_STATE_PLACEJETTON  then
        		device.showAlert("提示", "您正在游戏中,强行退出将被扣分,确定要强退吗?", {"是","否"}, function (  sender  )
		        	if sender.buttonIndex == 1 then
		        		--发送离开游戏
						local UserStandUp = UserStandUp.new();

					    BaseMessage.wMainCmdID = MDM_GR_USER   
					    BaseMessage.wSubCmdID  = SUB_GR_USER_STANDUP

					    UserStandUp.wTableID  = user.wTableID
					    UserStandUp.wChairID = user.wChairID 
					    UserStandUp.cbForceLeave = 1
					    socket:sendMessage(UserStandUp:serialize())

					    app:enterMenuScene()
					    print("发送离开游戏")
		        	end
			    end)
			else
				--发送离开游戏
				local UserStandUp = UserStandUp.new();

			    BaseMessage.wMainCmdID = MDM_GR_USER   
			    BaseMessage.wSubCmdID  = SUB_GR_USER_STANDUP

			    UserStandUp.wTableID  = user.wTableID
			    UserStandUp.wChairID = user.wChairID 
			    UserStandUp.cbForceLeave = 1
			    socket:sendMessage(UserStandUp:serialize())

			    app:enterMenuScene()
			    print("发送离开游戏")
        	end
        end)
        :align(display.TOP_LEFT, 5, display.height - 5)
        :addTo(GameScene.bg)

    GameScene.history = History.new()
    GameScene.bg:addChild(GameScene.history,999)
    GameScene.history:setVisible(false)
	cc.ui.UIPushButton.new(GameScene.BTN_HISTORY)
        :onButtonClicked(function(event)
        	GameScene.history:refresh()
        	GameScene.history:setVisible(true)
        end)
        :align(display.TOP_RIGHT, 1137, display.height - 2)
        :addTo(GameScene.bg)

   	GameScene.rdm = nil 

	GameScene.isRunning = false;
	GameScene.car = display.newSprite("#1_90.png",245,547)
	GameScene.bg:addChild(GameScene.car)
	GameScene.currentIcon = 0

	GameScene.timeBg = display.newSprite("game/time_bg.png", 569, 385)
	GameScene.bg:addChild(GameScene.timeBg)
	GameScene.timeBg:setVisible(false)

	GameScene.timeNum = CCLabelAtlas:create("01", "game/time_num.png", 28, 34, string.byte("0"))
	GameScene.timeBg:addChild(GameScene.timeNum)
	GameScene.timeNum:setAnchorPoint(ccp(0.5,0.5))
	GameScene.timeNum:setPosition(ccp(38,40))

	GameScene.selfName = CCLabelTTF:create(user["szNickName"], "", 28)
	GameScene.selfName:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfName:setColor(ccc3(164, 255, 253))
    GameScene.selfName:setPosition(ccp(148,78))
    GameScene.bg:addChild(GameScene.selfName)
    GameScene.resizeLableForFixedSize(GameScene, GameScene.selfName, 150)

    GameScene.selfScore = CCLabelTTF:create(format_gold_string(user.lScore), "", 28)
	GameScene.selfScore:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScore:setColor(ccc3(164, 255, 253))                                                                                                                   
    GameScene.selfScore:setPosition(ccp(148,38))
    GameScene.bg:addChild(GameScene.selfScore)
    GameScene.resizeLableForFixedSize(GameScene, GameScene.selfScore, 150)

    GameScene.selfResult = CCLabelTTF:create("0", "", 28)
	GameScene.selfResult:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfResult:setColor(ccc3(164, 255, 253))                                                                                                                   
    GameScene.selfResult:setPosition(ccp(1048,78))
    GameScene.bg:addChild(GameScene.selfResult)
    GameScene.resizeLableForFixedSize(GameScene, GameScene.selfResult, 150)

    GameScene.selfBetting = CCLabelTTF:create("0", "", 28)
	GameScene.selfBetting:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfBetting:setColor(ccc3(164, 255, 253))                                                                                                                   
    GameScene.selfBetting:setPosition(ccp(1048,38))
    GameScene.bg:addChild(GameScene.selfBetting)
    GameScene.resizeLableForFixedSize(GameScene, GameScene.selfBetting, 150)

	self:scheduleUpdate(GameScene.update)
	GameScene.carSecondAnimation = nil
	GameScene.carStop = nil
	GameScene.winIconTwinkleSchedule = nil
	GameScene.winLightTwinkleSchedule = nil
	GameScene.goldImages = {}

	GameScene.bankerInfo = BankerInfo.new()
	
    GameScene.bg:addChild(GameScene.bankerInfo, 1000)
	GameScene.bankerInfo:setVisible(false)

	cc.ui.UIPushButton.new(GameScene.BTN_BANKER_INFO)
        :onButtonClicked(function(event)
        	GameScene.bankerInfo:setVisible(not GameScene.bankerInfo:isVisible())
        end)
        :align(display.TOP_LEFT, 235, 127)
        :addTo(GameScene.bg)

    local placeJettonWord = display.newSprite("game/placeJettonWord.png", 558, 175)
    placeJettonWord:setTag(102)
	GameScene.bg:addChild(placeJettonWord, 999999)
	placeJettonWord:setVisible(false)
end

function GameScene:resizeLableForFixedSize(label, size)
	if label:getContentSize().width > size then
		label:setScale(size / label:getContentSize().width)
	end
end


function GameScene:update()
	if GameScene.isRunning then
		for i=1,32 do
		    local x = GameScene.icons[i].bright:getPositionX() - GameScene.car:getPositionX()
		   	local y = GameScene.icons[i].bright:getPositionY() - GameScene.car:getPositionY()
		    local dis = math.sqrt(x * x + y * y)
		    if dis < 68 then
		  		GameScene.icons[i].bright:setVisible(true)
		  		GameScene.icons[i].dark:setVisible(false)

		  		GameScene.icons[(i+30)%32 + 1].bright:setVisible(false)
		      	GameScene.icons[(i+30)%32 + 1].dark:setVisible(true)     
		  		if GameScene.carStop  then
   					if (math.fmod(GameScene.finalIndex + 29, 32) + 1) == i then
   						GameScene.car:stopAllActions()
   						GameScene.isRunning = false
   						GameScene.carStop = false

   						SimpleAudioEngine:sharedEngine():playEffect("sound/idc_snd_.mp3")
   						--播放胜利效果
   						if GameScene.lUserScore > 0 then
   							GameScene:winEffect()
   						end
   						--显示游戏结果
   						local result = GameResult.new()
   						result:setPosition(ccp(568,350))
   						result:setTag(100)
   						GameScene.bg:addChild(result, 9999999)
   						result:setResult({selfScore = GameScene.lUserScore, selfCapital = GameScene.lUserReturnScore, bankerScore = GameScene.lBankerWinScore})
   						--更新右下角面板数据
   						local result = GameScene.selfResult:getString()
   						GameScene.selfResult:setString(format_gold_string(string.gsub(result, ',', '')  + GameScene.lUserScore))
   						GameScene:resizeLableForFixedSize(GameScene.selfResult, 150)
   						--更新庄家信息
   						if GameScene.wBankerUser ~= 65535 then
							GameScene.bankerInfo:updateCFLabel(GameScene.lBankerScore + GameScene.lBankerWinScore)
	   						GameScene.bankerInfo:updateCJLabel(GameScene.lBankerTotallScore)
	   						GameScene.bankerInfo:updateLZLabel(GameScene.nBankerTime)
						end
   						--历史面板插入结果
   						GameScene.history:addAHistory(GameScene.finalIndex)
   						GameScene.history:refresh()
   					end
   				end
   			else
   				GameScene.icons[i].bright:setVisible(false)
		  		GameScene.icons[i].dark:setVisible(true)
   			end
   			if GameScene.stepSecond == 1 then
   				GameScene.stepSecond = 0
   				if GameScene.carSecondAnimation ~= nil then
   					GameScene.car:runAction(GameScene.carSecondAnimation)
   				end
   			end
		end
	end
end

function GameScene:winEffect()
	GameScene.winIconTwinkleSchedule  = scheduler.scheduleGlobal(GameScene.winIconTwinkle, 0.3)
    GameScene.winLightTwinkleSchedule = scheduler.scheduleGlobal(GameScene.winLightTwinkle, 0.3)
end

function GameScene:winIconTwinkle()
	GameScene.icons[math.fmod(GameScene.finalIndex + 29, 32) + 1].bright:setVisible(
		not GameScene.icons[math.fmod(GameScene.finalIndex + 29, 32) + 1].bright:isVisible())
	GameScene.icons[math.fmod(GameScene.finalIndex + 29, 32) + 1].dark:setVisible(
		not GameScene.icons[math.fmod(GameScene.finalIndex + 29, 32) + 1].dark:isVisible())
end

function GameScene:winLightTwinkle()
	GameScene.light_left_top:setVisible(not GameScene.light_left_top:isVisible())
	GameScene.light_left_bottom:setVisible(not GameScene.light_left_bottom:isVisible())
	GameScene.light_right_top:setVisible(not GameScene.light_right_top:isVisible())
	GameScene.light_right_bottom:setVisible(not GameScene.light_right_bottom:isVisible())
end

function GameScene:updateGoldBtn()
	local selectedIndex = nil
	for i=1, #GameScene.goldGroup.buttons_ do
		if  GameScene.goldGroup.buttons_[i]:isButtonSelected() then
			selectedIndex = i
		end
		GameScene.goldGroup.buttons_[i]:setScale(1.0)
		GameScene.goldGroup.buttons_[i]:setButtonSelected(false)
		GameScene.goldGroup.buttons_[i]:setButtonEnabled(false)
	end
	if GameScene.state == GAME_STATE_FREE or GameScene.state == GAME_STATE_CARANIMATION or GameScene.state == GAME_STATE_RESULT then
		
	elseif GameScene.state == GAME_STATE_PLACEJETTON  then
		self:updateGoldBtnByScore(user.lScore)
	end
	if  selectedIndex ~= nil and GameScene.goldGroup.buttons_[selectedIndex]:isButtonEnabled() then
		GameScene.goldGroup.buttons_[selectedIndex]:setScale(1.18)
		GameScene.goldGroup.buttons_[selectedIndex]:setButtonSelected(true)
	end
end

function GameScene:updateGoldBtnByScore(score)
	if score >= 100 then
		GameScene.goldGroup.buttons_[1]:setButtonEnabled(true)
	else 
		return
	end
	if score >= 1000 then
		GameScene.goldGroup.buttons_[2]:setButtonEnabled(true)
	else
		return
	end
	if score >= 10000 then
		GameScene.goldGroup.buttons_[3]:setButtonEnabled(true)
	else 
		return
	end
	if score >= 100000 then
		GameScene.goldGroup.buttons_[4]:setButtonEnabled(true)
	else
		return
	end
	if score >= 1000000 then
		GameScene.goldGroup.buttons_[5]:setButtonEnabled(true)
	else
		return
	end
	if score >= 5000000 then
		GameScene.goldGroup.buttons_[6]:setButtonEnabled(true)
	end
end

function GameScene:addGoldBtn(bg)
        GameScene.goldGroup = cc.ui.UICheckBoxButtonGroup.new(display.LEFT_TO_RIGHT)
        :addButton(cc.ui.UICheckBoxButton.new(GameScene.RADIO_BTN_GLOD_100)
            :align(display.CENTER))
        :addButton(cc.ui.UICheckBoxButton.new(GameScene.RADIO_BTN_GLOD_1K)
            :align(display.CENTER))
        :addButton(cc.ui.UICheckBoxButton.new(GameScene.RADIO_BTN_GLOD_10K)
            :align(display.CENTER))
        :addButton(cc.ui.UICheckBoxButton.new(GameScene.RADIO_BTN_GLOD_100K)
            :align(display.CENTER))
        :addButton(cc.ui.UICheckBoxButton.new(GameScene.RADIO_BTN_GLOD_1M)
            :align(display.CENTER))
        :addButton(cc.ui.UICheckBoxButton.new(GameScene.RADIO_BTN_GLOD_5M)
            :align(display.CENTER))
        :setButtonsLayoutMargin(10, 10, 10, 10)
        :align(display.LEFT_BOTTOM, 282, -10)
        :addTo(GameScene.bg) 

    	GameScene.goldGroup:onButtonSelectChanged(function(event)
            printf("Option %d selected, Option %d unselected", event.selected, event.last)
            GameScene.jettonIndex = event.selected
            GameScene.goldGroup.buttons_[event.selected]:setScale(1.18)
            if event.last ~= 0 then 
            	GameScene.goldGroup.buttons_[event.last]:setScale(1)
            end
        end)
end


function GameScene:addIcons(bg)
	GameScene.icons={}
	for i=1,8 do
		GameScene.icons[i]={}
		GameScene.icons[i].dark = display.newSprite(string.format("#icon%02d.png", i), 315 + (i-1) * 83, 605)
		GameScene.icons[i].bright = display.newSprite(string.format("#icon%02d_b.png", i), 315 + (i-1) * 83, 605) GameScene.bg:addChild(GameScene.icons[i].dark)
		GameScene.bg:addChild(GameScene.icons[i].bright)
		GameScene.icons[i].bright:setVisible(false)
	end
	GameScene.icons[9]={}
	GameScene.icons[9].dark = display.newSprite(string.format("#icon%02d.png", 1), 987 , 588)
	GameScene.icons[9].bright = display.newSprite(string.format("#icon%02d_b.png", 1), 987, 588)
	GameScene.bg:addChild(GameScene.icons[9].dark)
	GameScene.bg:addChild(GameScene.icons[9].bright)
	GameScene.icons[9].bright:setVisible(false)

	GameScene.icons[10]={}
	GameScene.icons[10].dark = display.newSprite(string.format("#icon%02d.png", 2), 1051, 537)
	GameScene.icons[10].bright = display.newSprite(string.format("#icon%02d_b.png", 2), 1051, 537)
	GameScene.bg:addChild(GameScene.icons[10].dark)
	GameScene.bg:addChild(GameScene.icons[10].bright)
	GameScene.icons[10].bright:setVisible(false)

	GameScene.icons[11]={}
	GameScene.icons[11].dark = display.newSprite(string.format("#icon%02d.png", 3), 1093 , 463)
	GameScene.icons[11].bright = display.newSprite(string.format("#icon%02d_b.png", 3), 1093, 463)
	GameScene.bg:addChild(GameScene.icons[11].dark)
	GameScene.bg:addChild(GameScene.icons[11].bright)
	GameScene.icons[11].bright:setVisible(false)

	GameScene.icons[12]={}
	GameScene.icons[12].dark = display.newSprite(string.format("#icon%02d.png", 4), 1105 , 385)
	GameScene.icons[12].bright = display.newSprite(string.format("#icon%02d_b.png", 4), 1105, 385)
	GameScene.bg:addChild(GameScene.icons[12].dark)
	GameScene.bg:addChild(GameScene.icons[12].bright)
	GameScene.icons[12].bright:setVisible(false)

	GameScene.icons[13]={}
	GameScene.icons[13].dark = display.newSprite(string.format("#icon%02d.png", 5), 1093 , 307)
	GameScene.icons[13].bright = display.newSprite(string.format("#icon%02d_b.png", 5), 1093, 307)
	GameScene.bg:addChild(GameScene.icons[13].dark)
	GameScene.bg:addChild(GameScene.icons[13].bright)
	GameScene.icons[13].bright:setVisible(false)

	GameScene.icons[14]={}
	GameScene.icons[14].dark = display.newSprite(string.format("#icon%02d.png", 6), 1051 , 233)
	GameScene.icons[14].bright = display.newSprite(string.format("#icon%02d_b.png", 6), 1051, 233)
	GameScene.bg:addChild(GameScene.icons[14].dark)
	GameScene.bg:addChild(GameScene.icons[14].bright)
	GameScene.icons[14].bright:setVisible(false)

	GameScene.icons[15]={}
	GameScene.icons[15].dark = display.newSprite(string.format("#icon%02d.png", 7), 987, 182)
	GameScene.icons[15].bright = display.newSprite(string.format("#icon%02d_b.png", 7), 987, 182)
	GameScene.bg:addChild(GameScene.icons[15].dark)
	GameScene.bg:addChild(GameScene.icons[15].bright)
	GameScene.icons[15].bright:setVisible(false)

	GameScene.icons[16]={}
	GameScene.icons[16].dark = display.newSprite(string.format("#icon%02d.png", 8), 899 ,168)
	GameScene.icons[16].bright = display.newSprite(string.format("#icon%02d_b.png", 8), 899, 168)
	GameScene.bg:addChild(GameScene.icons[16].dark)
	GameScene.bg:addChild(GameScene.icons[16].bright)
	GameScene.icons[16].bright:setVisible(false)

	for i=1,8 do
		GameScene.icons[i+16]={}
		GameScene.icons[i+16].dark = display.newSprite(string.format("#icon%02d.png", i), 810 + (1-i) * 83, 168)
		GameScene.icons[i+16].bright = display.newSprite(string.format("#icon%02d_b.png", i), 810 + (1-i) * 83, 168)
		GameScene.bg:addChild(GameScene.icons[i+16].dark)
		GameScene.bg:addChild(GameScene.icons[i+16].bright)
		GameScene.icons[i+16].bright:setVisible(false)
	end


	GameScene.icons[25]={}
	GameScene.icons[25].dark = display.newSprite(string.format("#icon%02d.png", 1), 140 , 186)
	GameScene.icons[25].bright = display.newSprite(string.format("#icon%02d_b.png", 1), 140, 186)
	GameScene.bg:addChild(GameScene.icons[25].dark)
	GameScene.bg:addChild(GameScene.icons[25].bright)
	GameScene.icons[25].bright:setVisible(false)

	GameScene.icons[26]={}
	GameScene.icons[26].dark = display.newSprite(string.format("#icon%02d.png", 2), 85 , 233)
	GameScene.icons[26].bright = display.newSprite(string.format("#icon%02d_b.png", 2), 85, 233)
	GameScene.bg:addChild(GameScene.icons[26].dark)
	GameScene.bg:addChild(GameScene.icons[26].bright)
	GameScene.icons[26].bright:setVisible(false)

	GameScene.icons[27]={}
	GameScene.icons[27].dark = display.newSprite(string.format("#icon%02d.png", 3), 44 , 307)
	GameScene.icons[27].bright = display.newSprite(string.format("#icon%02d_b.png", 3), 44, 307)
	GameScene.bg:addChild(GameScene.icons[27].dark)
	GameScene.bg:addChild(GameScene.icons[27].bright)
	GameScene.icons[27].bright:setVisible(false)

	GameScene.icons[28]={}
	GameScene.icons[28].dark = display.newSprite(string.format("#icon%02d.png", 4), 33 , 385)
	GameScene.icons[28].bright = display.newSprite(string.format("#icon%02d_b.png", 4), 33, 385)
	GameScene.bg:addChild(GameScene.icons[28].dark)
	GameScene.bg:addChild(GameScene.icons[28].bright)
	GameScene.icons[28].bright:setVisible(false)

	GameScene.icons[29]={}
	GameScene.icons[29].dark = display.newSprite(string.format("#icon%02d.png", 5), 44 , 463)
	GameScene.icons[29].bright = display.newSprite(string.format("#icon%02d_b.png", 5), 44, 463)
	GameScene.bg:addChild(GameScene.icons[29].dark)
	GameScene.bg:addChild(GameScene.icons[29].bright)
	GameScene.icons[29].bright:setVisible(false)

	GameScene.icons[30]={}
	GameScene.icons[30].dark = display.newSprite(string.format("#icon%02d.png", 6), 85 , 537)
	GameScene.icons[30].bright = display.newSprite(string.format("#icon%02d_b.png", 6), 85, 537)
	GameScene.bg:addChild(GameScene.icons[30].dark)
	GameScene.bg:addChild(GameScene.icons[30].bright)
	GameScene.icons[30].bright:setVisible(false)

	GameScene.icons[31]={}
	GameScene.icons[31].dark = display.newSprite(string.format("#icon%02d.png", 7), 144 , 585)
	GameScene.icons[31].bright = display.newSprite(string.format("#icon%02d_b.png", 7), 144, 585)
	GameScene.bg:addChild(GameScene.icons[31].dark)
	GameScene.bg:addChild(GameScene.icons[31].bright)
	GameScene.icons[31].bright:setVisible(false)

	GameScene.icons[32]={}
	GameScene.icons[32].dark = display.newSprite(string.format("#icon%02d.png", 8), 232 ,605)
	GameScene.icons[32].bright = display.newSprite(string.format("#icon%02d_b.png", 8), 232, 605)
	GameScene.bg:addChild(GameScene.icons[32].dark)
	GameScene.bg:addChild(GameScene.icons[32].bright)
	GameScene.icons[32].bright:setVisible(false)
end


function GameScene:addJectionArea(bg)
	--筹码区域索引
	GameScene.jettonIndex = nil

	cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_ONE)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(1, GameScene.jettonIndex)
        end)
        :align(display.RIGHT_BOTTOM, 344, 386)
        :addTo(GameScene.bg)  

    GameScene.totalScoreLabels[1] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[1],99)
	GameScene.totalScoreLabels[1]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[1]:setPosition(ccp(255, 480))

	GameScene.selfScoreLabels[1] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[1],99)
	GameScene.selfScoreLabels[1]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[1]:setPosition(ccp(255, 420))

    cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_TWO)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(5,GameScene.jettonIndex)
        end)
        :align(display.RIGHT_BOTTOM, 344, 248)
        :addTo(GameScene.bg)

 	GameScene.totalScoreLabels[5] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[5],99)
	GameScene.totalScoreLabels[5]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[5]:setPosition(ccp(255, 350))

	GameScene.selfScoreLabels[5] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[5],99)
	GameScene.selfScoreLabels[5]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[5]:setPosition(ccp(255, 290))

    cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_THREE)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(2,GameScene.jettonIndex)

        end)
        :align(display.RIGHT_BOTTOM, 566, 386)
        :addTo(GameScene.bg)

    GameScene.totalScoreLabels[2] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[2],99)
	GameScene.totalScoreLabels[2]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[2]:setPosition(ccp(450, 480))

	GameScene.selfScoreLabels[2] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[2],99)
	GameScene.selfScoreLabels[2]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[2]:setPosition(ccp(450, 420))

    cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_FOUR)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(6,GameScene.jettonIndex)
        end)
        :align(display.RIGHT_BOTTOM, 566, 248)
        :addTo(GameScene.bg)

    GameScene.totalScoreLabels[6] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[6],99)
	GameScene.totalScoreLabels[6]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[6]:setPosition(ccp(450, 350))

	GameScene.selfScoreLabels[6] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[6],99)
	GameScene.selfScoreLabels[6]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[6]:setPosition(ccp(450, 290))

    cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_FIVE)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(3,GameScene.jettonIndex)
        end)
        :align(display.RIGHT_BOTTOM, 795, 386)
        :addTo(GameScene.bg)

    GameScene.totalScoreLabels[3] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[3],99)
	GameScene.totalScoreLabels[3]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[3]:setPosition(ccp(688, 480))

	GameScene.selfScoreLabels[3] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[3],99)
	GameScene.selfScoreLabels[3]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[3]:setPosition(ccp(688, 420))

    cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_SIX)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(7,GameScene.jettonIndex)
        end)
        :align(display.RIGHT_BOTTOM, 795, 248)
        :addTo(GameScene.bg)

    GameScene.totalScoreLabels[7] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[7],99)
	GameScene.totalScoreLabels[7]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[7]:setPosition(ccp(688, 350))

	GameScene.selfScoreLabels[7] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[7],99)
	GameScene.selfScoreLabels[7]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[7]:setPosition(ccp(688, 290))

    cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_SEVEN)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(4,GameScene.jettonIndex)
        end)
        :align(display.RIGHT_BOTTOM, 1017, 386)
        :addTo(GameScene.bg)

    GameScene.totalScoreLabels[4] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[4],99)
	GameScene.totalScoreLabels[4]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[4]:setPosition(ccp(890, 480))

	GameScene.selfScoreLabels[4] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[4],99)
	GameScene.selfScoreLabels[4]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[4]:setPosition(ccp(890, 420))

	GameScene.totalScoreLabels[8] = CCLabelAtlas:create("0", "game/totalJettonNum.png", 21, 26, string.byte("0"))
	GameScene.bg:addChild(GameScene.totalScoreLabels[8],99)
	GameScene.totalScoreLabels[8]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.totalScoreLabels[8]:setPosition(ccp(890, 350))

	GameScene.selfScoreLabels[8] = CCLabelAtlas:create("0", "game/selfJettonNum.png", 16, 20, string.byte("0"))
	GameScene.bg:addChild(GameScene.selfScoreLabels[8],99)
	GameScene.selfScoreLabels[8]:setAnchorPoint(ccp(0.5,0.5))
	GameScene.selfScoreLabels[8]:setPosition(ccp(890, 290))

    cc.ui.UIPushButton.new(GameScene.BTN_JETTONAREA_EIGHT)
        :onButtonClicked(function(event)
           self:sendPlaceJettonMessage(8,GameScene.jettonIndex)
        end)
        :align(display.RIGHT_BOTTOM, 1017, 248)
        :addTo(GameScene.bg)

    for i=1, #GameScene.totalScoreLabels do
    	GameScene.totalScoreLabels[i]:setVisible(false)
    end
    for i=1, #GameScene.selfScoreLabels do
    	GameScene.selfScoreLabels[i]:setVisible(false)
    end
end

function GameScene:sendPlaceJettonMessage(areaIndex, jettonIndex)
	if  jettonIndex ~= nil then
		local placeJetton = PlaceJetton.new()

		BaseMessage.wMainCmdID = MDM_GF_GAME 		
		BaseMessage.wSubCmdID  = SUB_C_PLACE_JETTON

		placeJetton.cbJettonArea = areaIndex
		placeJetton.lJettonScore = self:jettonNumByIndex(jettonIndex)

		socket:sendMessage(placeJetton:serialize())
		print("send place jetton")
	end
end

function GameScene:placeJettonToArea(areaIndex, jettonIndex)
	if jettonIndex ~= nil then
		local x = 232
		local y = 453
		if areaIndex == 1 then
			 x = x + math.random(-36,78)
			 y = y + math.random(-30,30)
		elseif areaIndex == 5 then
			 x= 232 + math.random(-36,78)
			 y= 315 + math.random(-30,30)
		elseif areaIndex == 2 then
			 x= 457 + math.random(-56,56)
			 y= 453 + math.random(-30,30)
	    elseif areaIndex == 6 then
			 x= 457 + math.random(-56,56)
			 y= 315 + math.random(-30,30)
	    elseif areaIndex == 3 then
			 x= 682 + math.random(-56,56)
			 y= 453 + math.random(-30,30)
	    elseif areaIndex == 7 then
			 x= 682 + math.random(-56,56)
			 y= 315 + math.random(-30,30)
	    elseif areaIndex == 4 then
			 x= 907 + math.random(-68,30)
			 y= 453 + math.random(-30,28)
	    elseif areaIndex == 8 then
			 x= 907 + math.random(-68,30)
			 y= 315 + math.random(-28,30)
	    end
		GameScene.goldImages[1 + #GameScene.goldImages] = self:jettonByIndex(jettonIndex,x,y)
	    GameScene.bg:addChild(GameScene.goldImages[#GameScene.goldImages])
	end
end

function GameScene:jettonNumByIndex(jettonIndex)
	if jettonIndex == 1 then
		return 100
	elseif jettonIndex == 2 then
		return 1000
	elseif jettonIndex == 3 then
		return 10000
	elseif jettonIndex == 4 then
		return 100000
	elseif jettonIndex == 5 then
		return 1000000
	elseif jettonIndex == 6 then
		return 5000000
	end
end

function GameScene:jettonIndexByNum(jettonNum)
	if jettonNum == 100 then
		return 1
	elseif jettonNum == 1000 then
		return 2
	elseif jettonNum == 10000 then
		return 3
	elseif jettonNum == 100000 then
		return 4
	elseif jettonNum == 1000000 then
		return 5
	elseif jettonNum == 5000000 then
		return 6
	end
end

function GameScene:jettonByIndex(jettonIndex, x, y)
	local jetton = display.newSprite(string.format("#jetton%d.png",jettonIndex), x, y)
	return jetton
end

-- function GameScene:carAnimation(index)
--     actions={}
--     if index < 9 then
--        actions[#actions + 1] = CCMoveBy:create(0.4 - 0.05 * (index - 1), ccp(664 - 83 * (index - 1),0))
--     end
-- end


function GameScene:clearIcon()
	for i=1,32 do
		self.icons[i].dark:setVisible(true);
		self.icons[i].bright:setVisible(false);
	end
end

function GameScene:rdmTwinkleIcon()
	if(rdm ~= nil) then	
		GameScene.icons[rdm].bright:setVisible(false);
		GameScene.icons[rdm].dark:setVisible(true);
	end
	rdm=math.random(1,32)
	GameScene.icons[rdm].bright:setVisible(true);
	GameScene.icons[rdm].dark:setVisible(false);
end

--用户进入
function GameScene:onUserEnter()
	print("onUserEnter")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end

    --用户进入并且是坐下状态/游戏状态,发送游戏规则
    if user.dwUserID==rcvMsg.dwUserID then
    	local tempTable = user.wTableID

    	user.wTableID = rcvMsg.wTableID
        user.wChairID = rcvMsg.wChairID
		user.lScore = rcvMsg.lScore

        if (rcvMsg.cbUserStatus == US_SIT or rcvMsg.cbUserStatus == US_PLAYING) and tempTable ~= rcvMsg.wTableID then
            print("发送游戏规则")
			local gameOption = GameOption.new()

		    BaseMessage.wMainCmdID = MDM_GF_FRAME   
		    BaseMessage.wSubCmdID  = SUB_GF_GAME_OPTION          

		    gameOption.cbAllowLookon = 0
		    gameOption.dwFrameVersion = 0
		    gameOption.dwClientVersion = 0

		    socket:sendMessage(gameOption:serialize())
        end
    else
    	if rcvMsg.wTableID ==  user.wTableID then
    		--记录所有玩家信息
	    	GameScene.players[rcvMsg.wChairID] = rcvMsg

	    	if GameScene.wBankerUser ==rcvMsg.wChairID  then
	    		print("更新庄家信息")
	    		print(rcvMsg.szNickname)
	    		--更新庄家信息
	    		GameScene.bankerInfo:updateZJLabel(rcvMsg.szNickname)
	    		GameScene.bankerInfo:updateCFLabel(rcvMsg.lScore)
	    	end
    	end
    end
end

--用户状态
function GameScene:onUserState()
	print("onUserState")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end

    if user.dwUserID==rcvMsg.dwUserID then
    	local tempTable = user.wTableID

    	user.wTableID = rcvMsg.wTableID
        user.wChairID = rcvMsg.wChairID
		user.lScore = rcvMsg.lScore

        if (rcvMsg.cbUserStatus == US_SIT or rcvMsg.cbUserStatus ==  US_PLAYING) and tempTable ~= rcvMsg.wTableID then
			print("发送游戏规则")
			local gameOption = GameOption.new()

		    BaseMessage.wMainCmdID = MDM_GF_FRAME   
		    BaseMessage.wSubCmdID  = SUB_GF_GAME_OPTION          

		    gameOption.cbAllowLookon = 0
		    gameOption.dwFrameVersion = 0
		    gameOption.dwClientVersion = 0

		    socket:sendMessage(gameOption:serialize())
        end
        --离开游戏
        if rcvMsg.cbUserStatus == US_FREE then
			socket:close()
            app:enterMenuScene()        
        end
    else
   --  	--请求玩家信息
   --  	if GameScene.players[rcvMsg.dwUserID] == nil and rcvMsg.wTableID  == user.wTableID  then
   --  		--开始请求玩家信息
			-- local userInfoReq = UserInfoReq.new();

		 --    BaseMessage.wMainCmdID = MDM_GR_USER   
		 --    BaseMessage.wSubCmdID  = SUB_GR_USER_INFO_REQ

		 --    userInfoReq.dwUserIDReq  = rcvMsg.dwUserID
		 --    userInfoReq.wTablePos = rcvMsg.wTableID 

		 --    print("请求用户信息")
		 --    socket:sendMessage(userInfoReq:serialize())
   --  	end
    end
end

--用户分数
function GameScene:onUserScore()
	print("onUserScore")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end

    if user.dwUserID==rcvMsg.dwUserID then
    	user.lScore = rcvMsg.lScore
    	GameScene.selfScore:setString(format_gold_string(rcvMsg.lScore))
    end
end

--游戏状态,正在游戏
function GameScene:statusPlay()
	print("statusPlay")
    for k,v in pairs(rcvMsg) do
    	if type(v) ~= "table" then
        	print(k.."="..v)
        else
        	print(k.."= {")
        	for i=1, table.nums(v) do
        		print(i.."_"..v[tostring(i)])
        	end
        	print("}")
       	end
    end
    if rcvMsg.cbGameStatus == 100 then
    	GameScene.state = GAME_STATE_PLACEJETTON 
    else
    	GameScene.state = GAME_STATE_FREE
    end


    --保存以及更新庄家用户信息
    GameScene.wBankerUser = rcvMsg.wBankerUser
    GameScene.bEnableSysBanker = rcvMsg.bEnableSysBanker   --是否允许系统坐庄
    if rcvMsg.wBankerUser ~= 65535 then
    	GameScene.bankerInfo:updateLZLabel(rcvMsg.cbBankerTime)
		GameScene.bankerInfo:updateCJLabel(rcvMsg.lBankerWinScore)
		GameScene.bankerInfo:updateCFLabel(rcvMsg.lBankerScore)
		GameScene.lBankerScore=rcvMsg.lBankerScore
		--开始请求庄家信息
		local chairUserInfoReq = ChairUserInfoReq.new();

	    BaseMessage.wMainCmdID = MDM_GR_USER   
	    BaseMessage.wSubCmdID  = SUB_GR_USER_CHAIR_INFO_REQ

	    ChairUserInfoReq.wTableID  = user.wTableID 
	    ChairUserInfoReq.wChairID = rcvMsg.wBankerUser

	    print("请求庄家信息")
	    socket:sendMessage(ChairUserInfoReq:serialize())
	else
		if rcvMsg.bEnableSysBanker ~= 0 then
			GameScene.bankerInfo:updateZJLabel("系统坐庄")
		else
			GameScene.bankerInfo:updateZJLabel("无人坐庄")
		end
    end
	
    GameScene:updateGoldBtn()
	GameScene.goldGroup.currentSelectedIndex_ = 0
    -- 刷新分数
    if GameScene.state == GAME_STATE_PLACEJETTON then
    	for i=2, table.nums(rcvMsg.lUserJettonScore) do
    		local leftScore = math.fmod(rcvMsg.lUserJettonScore[tostring(i)], 100) 
    		local score = string.gsub(format_gold_string(rcvMsg.lUserJettonScore[tostring(i)] - leftScore), ',', ':')
    		GameScene.selfScoreLabels[i-1]:setString(score)
    		GameScene.selfScoreLabels[i-1]:setVisible(true)
			GameScene:addJettonToAreaByNum(rcvMsg.lUserJettonScore[tostring(i)], i-1)
    	end
    	for i=2, table.nums(rcvMsg.lAllJettonScore) do
    		local leftScore = math.fmod(rcvMsg.lAllJettonScore[tostring(i)], 100)
    		local score = string.gsub(format_gold_string(rcvMsg.lAllJettonScore[tostring(i)] - leftScore), ',', ':')
    		GameScene.totalScoreLabels[i-1]:setString(score)
    		GameScene.totalScoreLabels[i-1]:setVisible(true)
    		GameScene:addJettonToAreaByNum(rcvMsg.lAllJettonScore[tostring(i)], i-1)
    	end
    	local placeJettonWord = GameScene.bg:getChildByTag(102)
	    placeJettonWord:setVisible(true)
	    placeJettonWord:runAction(transition.sequence({
	    	CCRepeat:create(transition.sequence({
	    		CCMoveBy:create(0.5,ccp(0, -30)),
	    		CCMoveBy:create(0.5,ccp(0, 30))}), 3),
	    	CCCallFunc:create(GameScene.hidePlaceJettonWord)}))
    else
    	local waitWord= display.newSprite("game/waitWord.png", 590, 325)
    	waitWord:setTag(101)
    	GameScene.bg:addChild(waitWord)
    end
    -- 倒计时
    GameScene.scheduleCountDown(GameScene, rcvMsg.cbTimeLeave)
end

function  GameScene:addJettonToAreaByNum(jettonNum, areaIndex)
	while jettonNum >= 5000000 do
		GameScene:placeJettonToArea(areaIndex, 6)
		jettonNum = jettonNum - 5000000
	end
	while jettonNum >= 1000000 do
		GameScene:placeJettonToArea(areaIndex, 5)
		jettonNum = jettonNum - 1000000
	end
	while jettonNum >= 100000 do
		GameScene:placeJettonToArea(areaIndex, 4)
		jettonNum = jettonNum - 100000
	end
	while jettonNum >= 10000 do
		GameScene:placeJettonToArea(areaIndex, 3)
		jettonNum = jettonNum - 10000
	end
	while jettonNum >= 1000 do
		GameScene:placeJettonToArea(areaIndex, 2)
		jettonNum = jettonNum - 1000
	end
	while jettonNum >= 100 do
		GameScene:placeJettonToArea(areaIndex, 1)
		jettonNum = jettonNum - 100
	end
end

function  GameScene:onRoomMessage()
	for k,v in pairs(rcvMsg) do
    	print(k..'=='..v)
    end

    CCMessageBox(rcvMsg.szString,"提醒")

    if rcvMsg.wType == 263 then
    	app:enterMenuScene()	
    end
end

--游戏状态,空闲
function GameScene:statusFree()
	print("statusFree")
    for k,v in pairs(rcvMsg) do
    	if type(v) ~= "table" then
        	print(k.."="..v)
        else
        	for n,m in pairs(v) do
        		print(n.."="..m)
        	end
       	end
    end
    GameScene.state = GAME_STATE_FREE 

	--保存以及更新庄家用户信息
    GameScene.wBankerUser = rcvMsg.wBankerUser
    GameScene.bEnableSysBanker = rcvMsg.bEnableSysBanker   --是否允许系统坐庄
    if rcvMsg.wBankerUser ~= 65535 then
    	GameScene.bankerInfo:updateLZLabel(rcvMsg.cbBankerTime)
		GameScene.bankerInfo:updateCJLabel(rcvMsg.lBankerWinScore)
		GameScene.bankerInfo:updateCFLabel(rcvMsg.lBankerScore)
		GameScene.lBankerScore=rcvMsg.lBankerScore

		--开始请求庄家信息
		local chairUserInfoReq = ChairUserInfoReq.new();

	    BaseMessage.wMainCmdID = MDM_GR_USER   
	    BaseMessage.wSubCmdID  = SUB_GR_USER_CHAIR_INFO_REQ

	    ChairUserInfoReq.wTableID  = user.wTableID 
	    ChairUserInfoReq.wChairID = rcvMsg.wBankerUser

	    print("请求庄家信息")
	    socket:sendMessage(ChairUserInfoReq:serialize())
	else
		if rcvMsg.bEnableSysBanker ~= 0 then
			GameScene.bankerInfo:updateZJLabel("系统坐庄")
		else
			GameScene.bankerInfo:updateZJLabel("无人坐庄")
		end
    end

    GameScene.updateGoldBtn(GameScene)
    if rcvMsg.cbTimeLeave > 0 then
    	GameScene.scheduleCountDown(GameScene,rcvMsg.cbTimeLeave)
    	GameScene.scheduleRdmTwinkle(GameScene)
    end
end

function GameScene:scheduleCountDown(num)
	GameScene.timeBg:setVisible(true)
    GameScene.timeNum:setString(num or 0)
    if GameScene.countDownSchedule ~= nil then
    	scheduler.unscheduleGlobal(GameScene.countDownSchedule)
    end
   	GameScene.countDownSchedule = scheduler.scheduleGlobal(GameScene.countDown, 1.0)
end

function GameScene:scheduleRdmTwinkle()
	if GameScene.rdmTwinkleSchedule ~= nil then
		scheduler.unscheduleGlobal(GameScene.rdmTwinkleSchedule)
	end
	GameScene.rdmTwinkleSchedule = scheduler.scheduleGlobal(GameScene.rdmTwinkleIcon, 0.2)
end

function GameScene:unscheduleRdmTwinkle()
	if GameScene.rdmTwinkleSchedule ~= nil then
		scheduler.unscheduleGlobal(GameScene.rdmTwinkleSchedule)
	end
end

function GameScene:countDown()
	local num = GameScene.timeNum:getString()
	num = num - 1
	if num <=5 and GameScene.state == GAME_STATE_PLACEJETTON then
		SimpleAudioEngine:sharedEngine():playEffect("sound/TIME_WARIMG.mp3", false)
	end
	GameScene.timeNum:setString(num)
	if num == 0 then 
		scheduler.unscheduleGlobal(GameScene.countDownSchedule)
		GameScene.countDownSchedule = nil
		GameScene.timeBg:setVisible(false)
	end
end

--系统公告,系统消息
function GameScene:systemMessage()
	print("systemMessage")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end
end

--游戏开始
function GameScene:gameStart()
	if GameScene.state ~= GAME_STATE_PLACEJETTON then
		GameScene.state = GAME_STATE_PLACEJETTON 

		if GameScene.wBankerUser ~= 65535 then
			GameScene.bankerInfo:updateCFLabel(rcvMsg.lBankerScore)
		end

	    SimpleAudioEngine:sharedEngine():playEffect("sound/GAME_START.mp3", false)

		print("gameStart")
	    for k,v in pairs(rcvMsg) do
	        print(k.."="..v)
	    end
	    GameScene.state = GAME_STATE_PLACEJETTON  
		GameScene.updateGoldBtn(GameScene)
		GameScene.goldGroup.currentSelectedIndex_ = 0
	    GameScene.scheduleCountDown(GameScene, rcvMsg.cbTimeLeave - 1)
		GameScene.lBankerScore=rcvMsg.lBankerScore

		for i=1, #GameScene.totalScoreLabels do
			GameScene.totalScoreLabels[i]:setVisible(true)
	    end
	    for i=1, #GameScene.selfScoreLabels do
	    	GameScene.selfScoreLabels[i]:setVisible(true)
	    end
	    local placeJettonWord = GameScene.bg:getChildByTag(102)
	    placeJettonWord:setVisible(true)
	    placeJettonWord:runAction(transition.sequence({
	    	CCRepeat:create(transition.sequence({
	    		CCMoveBy:create(0.5,ccp(0, -30)),
	    		CCMoveBy:create(0.5,ccp(0, 30))}), 3),
	    	CCCallFunc:create(GameScene.hidePlaceJettonWord)}))
	end
end

function GameScene:hidePlaceJettonWord()
	GameScene.bg:getChildByTag(102):setVisible(false)
end

--游戏结束
function GameScene:gameEnd()
	if GameScene.state ~= GAME_STATE_CARANIMATION then
		GameScene.state = GAME_STATE_CARANIMATION
		SimpleAudioEngine:sharedEngine():playEffect("sound/kaicheyinyue.mp3", false)

		GameScene.bg:getChildByTag(102):setVisible(false)


		--不允许下注 
		GameScene.updateGoldBtn(GameScene)
		GameScene.jettonIndex = nil

		--停止随机闪烁
		GameScene.unscheduleRdmTwinkle(GameScene)
		GameScene.clearIcon(GameScene)

		--隐藏倒计时
		GameScene.timeBg:setVisible(false)

		GameScene.finalIndex = rcvMsg.cbTableCardArray

		GameScene.lBankerTotallScore = rcvMsg.lBankerTotallScore
		GameScene.nBankerTime = rcvMsg.nBankerTime
		GameScene.lBankerWinScore = rcvMsg.lBankerScore
		GameScene.lUserScore   = rcvMsg.lUserScore
		GameScene.lUserReturnScore = rcvMsg.lUserReturnScore

		print("gameEnd")
	    for k,v in pairs(rcvMsg) do
	        if type(v)=="table" then
	        	for _k,_v in pairs(v) do
					if type(_v)=="table" then
	        			for __k,__v in pairs(_v) do
	        				print(__k.."="..__v)	
	        			end	
	       			else
	        			print(_k.."=".._v)	
	        		end
	        	end	
	        else
	        	print(k.."="..v)	
	        end
	    end

	    GameScene.isRunning = true

	    local configOne = ccBezierConfig:new()
		configOne.endPosition = ccp(192,-163)
		configOne.controlPoint_1 = ccp(135,0)
		configOne.controlPoint_2 = ccp(192,-60)

		local configTwo = ccBezierConfig:new()
		configTwo.endPosition = ccp(-176,-161)
		configTwo.controlPoint_1 = ccp(0,-110)
		configTwo.controlPoint_2 = ccp(-100,-161)

		local configThree = ccBezierConfig:new()
		configThree.endPosition = ccp(-160,148)
		configThree.controlPoint_1 = ccp(-100,0)
		configThree.controlPoint_2 = ccp(-160,68)

		local configFour = ccBezierConfig:new()
		configFour.endPosition = ccp(147,176)
		configFour.controlPoint_1 = ccp(0,70)
		configFour.controlPoint_2 = ccp(15,176)

		if GameScene.carSecondAnimation ~= nil then
			GameScene.carSecondAnimation:release()
			GameScene.carSecondAnimation = nil
		end
	    
		if GameScene.finalIndex > 1 and GameScene.finalIndex < 18 then
			GameScene.carSecondAnimation = transition.sequence({
	 		CCMoveBy:create(0.4, ccp(615,0)), 
	 		CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configOne),CCAnimate:create(GameScene.car_right_top)),
	  		CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configTwo),CCAnimate:create(GameScene.car_right_bottom)),
	 		CCEaseOut:create(CCMoveBy:create(0.6, ccp(-619,0)), 1.1),
	 		CCCallFunc:create(GameScene.carWillStop),
	  		CCSpawn:createWithTwoActions(CCBezierBy:create(0.5, configThree),CCAnimate:create(display.newAnimation(display.newFrames("1_%02d.png", 1, 30, true), 0.5/30))),
	  		CCSpawn:createWithTwoActions(CCBezierBy:create(0.6, configFour),CCAnimate:create(display.newAnimation(display.newFrames("1_%d.png", 91, 30, true), 0.6/30))),
	 		CCEaseIn:create(CCMoveBy:create(1.3, ccp(616,0)), 1.1), 
	 		CCSpawn:createWithTwoActions(CCBezierBy:create(0.8, configOne),CCAnimate:create(display.newAnimation(display.newFrames("1_%d.png", 61, 30, true), 0.8/30))),
	  		CCSpawn:createWithTwoActions(CCBezierBy:create(1.0, configTwo),CCAnimate:create(display.newAnimation(display.newFrames("1_%d.png", 31, 30, true), 1.0/30))),
	 		CCEaseOut:create(CCMoveBy:create(2.0, ccp(-619,0)), 1.2)
	 		})
	    else
	  		GameScene.carSecondAnimation = transition.sequence({
	  		CCCallFunc:create(GameScene.carWillStop),
	  		CCEaseOut:create(CCMoveBy:create(0.65, ccp(615,0)),  1.1), 
	  		CCSpawn:createWithTwoActions(CCBezierBy:create(0.4, configOne),CCAnimate:create(display.newAnimation(display.newFrames("1_%d.png", 61, 30, true), 0.4/30))),
	   		CCSpawn:createWithTwoActions(CCBezierBy:create(0.5, configTwo),CCAnimate:create(display.newAnimation(display.newFrames("1_%d.png", 31, 30, true), 0.5/30))),
	  		CCEaseOut:create(CCMoveBy:create(1.3, ccp(-619,0)),  1.2),
	   		CCSpawn:createWithTwoActions(CCBezierBy:create(0.9, configThree),CCAnimate:create(display.newAnimation(display.newFrames("1_%02d.png", 1, 30, true), 0.9/30))),
	   		CCSpawn:createWithTwoActions(CCBezierBy:create(1.0, configFour),CCAnimate:create(display.newAnimation(display.newFrames("1_%d.png", 91, 30, true), 1.0/30)))
	  		})
		end
		GameScene.carSecondAnimation:retain()

		local carActions = {
				transition.sequence({
				CCEaseIn:create(CCMoveBy:create(1.0, ccp(615,0)), 1.1), 
				CCSpawn:createWithTwoActions(CCBezierBy:create(0.4, configOne),CCAnimate:create(display.newAnimation(display.newFrames("1_%d.png", 61, 30, true), 0.4/30))),
		 		CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configTwo),CCAnimate:create(GameScene.car_right_bottom)),
				CCMoveBy:create(0.4, ccp(-619,0)),
		 		CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configThree),CCAnimate:create(GameScene.car_left_bottom)),
		 		CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configFour),CCAnimate:create(GameScene.car_left_top))
				}),

				CCRepeat:create( 
				transition.sequence({CCMoveBy:create(0.4, ccp(615,0)),
			  	CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configOne),CCAnimate:create(GameScene.car_right_top)),
			  	CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configTwo),CCAnimate:create(GameScene.car_right_bottom)),
				CCMoveBy:create(0.4, ccp(-619,0)),
			  	CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configThree),CCAnimate:create(GameScene.car_left_bottom)),
			 	CCSpawn:createWithTwoActions(CCBezierBy:create(0.2, configFour),CCAnimate:create(GameScene.car_left_top))
			 	}), 2),

				CCCallFunc:create(GameScene.carStepSecond)
			}

			GameScene.car:runAction(transition.sequence(carActions))
	end
end

function GameScene:carStepSecond()
	GameScene.stepSecond = 1
end

function GameScene:carWillStop()
	GameScene.carStop = true
end

--用户下注
function GameScene:placeJetton()

	local jettondata = rcvMsg
    -- 更新下方面板数据
    if rcvMsg.wChairID == user.wChairID then
    	SimpleAudioEngine:sharedEngine():playEffect("sound/ADD_GOLD.mp3", false)
	    GameScene:placeJettonToArea(jettondata.cbJettonArea, GameScene.jettonIndexByNum(GameScene, jettondata.lJettonScore))
	    -- 显示下注分数变化
	    GameScene:updateJettonAreaScore(jettondata.wChairID, jettondata.cbJettonArea, jettondata.lJettonScore)

    	local bettingScore = GameScene.selfBetting:getString()
    	GameScene.selfBetting:setString(format_gold_string(string.gsub(bettingScore, ',', '') +  jettondata.lJettonScore))
    	GameScene:resizeLableForFixedSize(GameScene.selfBetting, 150)

    	-- local selfScore = GameScene.selfScore:getString()
    	-- user.lScore = string.gsub(selfScore, ',', '') -  jettondata.lJettonScore
    	-- GameScene.selfScore:setString(format_gold_string(user.lScore))
    	-- GameScene:resizeLableForFixedSize(GameScene.selfScore, 150)

    	-- 更新按钮使能
    	GameScene:updateGoldBtn()
    else
    	-- 显示下注分数变化
		if GameScene.placeJettoncount==nil then
			GameScene.placeJettoncount=0
		end
		GameScene.placeJettoncount = GameScene.placeJettoncount+1
		math.randomseed(GameScene.placeJettoncount)
		local time  = math.random()

		scheduler.performWithDelayGlobal(function()
			SimpleAudioEngine:sharedEngine():playEffect("sound/ADD_GOLD.mp3", false)
		    GameScene:placeJettonToArea(jettondata.cbJettonArea, GameScene.jettonIndexByNum(GameScene, jettondata.lJettonScore))
		    -- 显示下注分数变化
		    GameScene:updateJettonAreaScore(jettondata.wChairID, jettondata.cbJettonArea, jettondata.lJettonScore)
	    end, time)
    end

end

function GameScene:updateJettonAreaScore(chairID, jettonArea, jettonScore)
	if jettonScore < 100 then
		return
	end
	local totalScore = GameScene.totalScoreLabels[jettonArea]:getString()
	local scoreTotal = string.gsub(format_gold_string(string.gsub(totalScore, ':', '') + jettonScore), ',', ':')
	GameScene.totalScoreLabels[jettonArea]:setString(scoreTotal)

    if chairID == user.wChairID then
    	local selfScore = GameScene.selfScoreLabels[jettonArea]:getString()
    	local scoreSelf = string.gsub(format_gold_string(string.gsub(selfScore, ':', '') + jettonScore), ',', ':')
    	GameScene.selfScoreLabels[jettonArea]:setString(scoreSelf)
    end
end

--下注失败
function GameScene:placeJettonFail()
	print("placeJettonFail")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end
end
--换庄家
function GameScene:changeBanker()
	print("changeBanker")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end

    GameScene.bankerInfo:updateLZLabel("")
	GameScene.bankerInfo:updateCJLabel("")

	GameScene.wBankerUser = rcvMsg.wBankerUser
	GameScene.lBankerScore=rcvMsg.lBankerScore


	if rcvMsg.wBankerUser == 65535 then
		GameScene.bankerInfo:updateCFLabel("")		
		if rcvMsg.bEnableSysBanker ~= 0 then
			GameScene.bankerInfo:updateLZLabel("系统坐庄")
		else
			GameScene.bankerInfo:updateLZLabel("无人坐庄")
		end
	else
		GameScene.bankerInfo:updateCFLabel(rcvMsg.lBankerScore)
		if GameScene.players[rcvMsg.wBankerUser] ~= nil then
			GameScene.bankerInfo:updateZJLabel(GameScene.players[rcvMsg.wBankerUser].szNickname)
		else
			GameScene.bankerInfo:updateZJLabel("")

			--开始请求庄家信息
			local chairUserInfoReq = ChairUserInfoReq.new();

		    BaseMessage.wMainCmdID = MDM_GR_USER   
		    BaseMessage.wSubCmdID  = SUB_GR_USER_CHAIR_INFO_REQ

		    ChairUserInfoReq.wTableID  = user.wTableID 
		    ChairUserInfoReq.wChairID = rcvMsg.wBankerUser

		    print("请求庄家信息")
		    socket:sendMessage(ChairUserInfoReq:serialize())
		end
	end
end
--路单
function GameScene:serverGameRecord()
	--是个64个数的数组
	print("serverGameRecord")
	for k, v in pairs(rcvMsg) do
		if type(v) == 'table' then
			for _k,_v in pairs(v.bWinMen) do
				if _v==4 then
					print(k,_k)
					History.carsData[tonumber(k)] = tonumber(_k)
					break
				end
			end
		end
	end
	History.cards = {}
	GameScene.history:refresh()
end

function GameScene:requestFailure()
    -- socket:close()
    print("RequestFailure")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end

    CCMessageBox(rcvMsg.szDescribeString, "提示")
    print("---------------")
end 
function GameScene:gameServerLoginFailure()
    -- socket:close()
    print("RequestFailure")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end

    CCMessageBox(rcvMsg.szDescribeString, "提示")
    app:enterMenuScene()
    print("---------------")
end 


function GameScene:gameStatus()
    print("GameStatus")
    for k,v in pairs(rcvMsg) do
        print(k.."="..v)
    end

    socket:updateGameStatus(tostring(rcvMsg.cbGameStatus))
end

function GameScene:gameFree()
	local gameResult = GameScene.bg:getChildByTag(100)
	if gameResult ~= nil then
		gameResult:removeFromParentAndCleanup(true)
	end
	local waitWord = GameScene.bg:getChildByTag(101)
	if waitWord ~= nil then
		waitWord:removeFromParentAndCleanup(true)
	end
	--取消赢钱效果
	if GameScene.winIconTwinkleSchedule ~= nil then
		scheduler.unscheduleGlobal(GameScene.winIconTwinkleSchedule)
		GameScene.winIconTwinkleSchedule = nil
	end

	if GameScene.winLightTwinkleSchedule ~= nil then
		scheduler.unscheduleGlobal(GameScene.winLightTwinkleSchedule)
		GameScene.winLightTwinkleSchedule = nil
		
		GameScene.light_left_top:setVisible(false)
		GameScene.light_left_bottom:setVisible(false)
		GameScene.light_right_top:setVisible(false)
		GameScene.light_right_bottom:setVisible(false)
	end

    GameScene.car:runAction(CCAnimate:create(GameScene.car_orign))
    GameScene.car:setPosition(ccp(245,547))
	GameScene.clearJettonArea(GameScene)
	GameScene.clearIcon(GameScene)
	GameScene.selfBetting:setString("0")
	--开始倒计时
	GameScene.scheduleCountDown(GameScene, rcvMsg.cbTimeLeave)

	--随机闪烁灯
	GameScene.scheduleRdmTwinkle(GameScene)
end

function GameScene:disConnect()
	print("disConnect")
	CCMessageBox("游戏已断开,请稍后重新链接", "提示")
	app:enterMenuScene()        

end

function GameScene:clearJettonArea()
	for i=1, #GameScene.goldImages do	
		GameScene.goldImages[i]:removeFromParentAndCleanup(true)
		GameScene.goldImages[i] = nil
	end
	for i=1, #GameScene.totalScoreLabels do
		GameScene.totalScoreLabels[i]:setVisible(false)
		GameScene.totalScoreLabels[i]:setString("0")
	end
	for i=1, #GameScene.selfScoreLabels do
		GameScene.selfScoreLabels[i]:setVisible(false)
		GameScene.selfScoreLabels[i]:setString("0")
	end
end


function  GameScene:onEnter()
	
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.disConnect, EVENT_DISCONNECT)
    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.gameServerLoginFailure, s2c_messages.gameMessage["GameServerLoginFailure"]["type"])

    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.onUserEnter, s2c_messages.gameMessage["UserEnter"]["type"])
    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.onUserState, s2c_messages.gameMessage["UserState"]["type"])
    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.statusPlay, s2c_messages.gameMessage["StatusPlay"]["type"])
    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.systemMessage, s2c_messages.gameMessage["SystemMessage"]["type"])
    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.gameStart, s2c_messages.gameMessage["GameStart"]["type"])
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.gameEnd, s2c_messages.gameMessage["GameEnd"]["type"])

	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.statusFree, s2c_messages.gameMessage["StatusFree"]["type"])
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.placeJetton, s2c_messages.gameMessage["PlaceJetton"]["type"])
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.changeBanker, s2c_messages.gameMessage["ChangeBanker"]["type"])
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.serverGameRecord, s2c_messages.gameMessage["tagServerGameRecord"]["type"])
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.placeJettonFail, s2c_messages.gameMessage["PlaceJettonFail"]["type"])
	CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.onUserScore, s2c_messages.gameMessage["UserScore"]["type"])


    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.requestFailure, s2c_messages.gameMessage["RequestFailure"]["type"])    
    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.gameStatus, s2c_messages.gameMessage["GameStatus"]["type"])
    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.gameFree, s2c_messages.gameMessage["GameFree"]["type"])

    CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(self, GameScene.onRoomMessage, s2c_messages.gameMessage["RoomMessage"]["type"])

	SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
    SimpleAudioEngine:sharedEngine():playBackgroundMusic("sound/BACK_GROUND.mp3", true)


    --发送快速开始
	local quickStartGame = QuickStartGame.new();

    BaseMessage.wMainCmdID = MDM_GR_LOGON   
    BaseMessage.wSubCmdID  = SUB_GR_LOGON_MOBILE

    quickStartGame.wGameID  = 108
    quickStartGame.dwProcessVersion = VERSION_CLIENT 
    quickStartGame.cbDeviceType = 64

    quickStartGame.wBehaviorFlags  = bit.bxor(BEHAVIOR_LOGON_IMMEDIATELY,VIEW_MODE_PART)
    quickStartGame.wPageTableCount = PAGE_TABLE_COUNT;
    quickStartGame.dwUserID = user["dwUserID"];

    quickStartGame.szPassword  =  user["password"]
    quickStartGame.szMachineID =  PHONE_ID()

    print("发送快速开始")
    socket:sendMessage(quickStartGame:serialize())

    
end

function  GameScene:onExit()
	CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, EVENT_DISCONNECT)


	CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["GameServerLoginFailure"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["UserEnter"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["UserState"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["StatusPlay"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["SystemMessage"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["GameStart"]["type"])    
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["GameEnd"]["type"])    

    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["StatusFree"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["PlaceJetton"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["ChangeBanker"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["tagServerGameRecord"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["PlaceJettonFail"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["UserScore"]["type"])

    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["RequestFailure"]["type"])
    CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["GameStatus"]["type"])    
	CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["GameFree"]["type"]) 
	CCNotificationCenter:sharedNotificationCenter():unregisterScriptObserver(self, s2c_messages.gameMessage["RoomMessage"]["type"]) 


	SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
	SimpleAudioEngine:sharedEngine():stopAllEffects()

	GameScene.car_right_top:release()
	GameScene.car_right_bottom:release()
	GameScene.car_left_bottom:release()
	GameScene.car_left_top:release()	

	if GameScene.countDownSchedule ~= nil then
    	scheduler.unscheduleGlobal(GameScene.countDownSchedule)
    end
    self:unscheduleRdmTwinkle()
end

return GameScene

