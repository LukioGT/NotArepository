package net.spider
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import net.spider.draw.*;
    import net.spider.handlers.*;

    public class main extends MovieClip
    {
        public var loader:MovieClip;
        var sURL:Object = "https://game.aq.com/game/";
        var gameFile:Object = "gameversion.asp";
        var sFile:Object;
        var aqliteLoader:URLLoader;
        var versionLoader:URLLoader;
        var swfLoader:Loader;
        var swfRequest:URLRequest;
        var titleDomain:ApplicationDomain;
        var loginURL:String = "https://game.aq.com/game/cf-userlogin.asp";
        var sBG:String;
        var hasEvent:Boolean = false;
        private var hasLeft:Boolean = false;
        private var waitForLogin:Timer;
        var runOnce:Boolean;
        var modulesInit:Boolean = false;
        public static var events:EventDispatcher = new EventDispatcher();
        public static var Game:Object;
        public static var aqlData:SharedObject;
        public static var _stage:Object;
        public static var rootDisplay:Object;
        public static var dropMenu:Object;
        public static var gameDomain:ApplicationDomain;
        public static var curVersion:Number = 13.1;
        public static var isUpdated:Boolean;
        public static var latestVersion:String = "not set";

        public function main()
        {
            this.waitForLogin = new Timer(0);
            this.addEventListener(Event.ADDED_TO_STAGE, this.stageHandler);
            return;
        }// end function

        public function onCostumePending(event:ClientEvent) : void
        {
            if (!this.hasEvent)
            {
                Game.sfc.addEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseHandler);
                this.hasEvent = true;
            }
            return;
        }// end function

        public function onExtensionResponseHandler(param1) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = param1.params.type;
            if (param1.params.type == "json")
            {
                _loc_4 = param1.params.dataObj;
                _loc_5 = _loc_4.cmd;
                switch(_loc_5)
                {
                    case "moveToArea":
                    {
                        for (_loc_6 in main.Game.world.myAvatar.objData.eqp)
                        {
                            
                            if (main.Game.world.myAvatar.objData.eqp[_loc_6].wasCreated)
                            {
                                delete main.Game.world.myAvatar.objData.eqp[_loc_6];
                                main.Game.world.myAvatar.unloadMovieAtES(_loc_6);
                                continue;
                            }
                            if (_loc_6 == "pe")
                            {
                                if (main.Game.world.myAvatar.objData.eqp["pe"])
                                {
                                    main.Game.world.myAvatar.unloadPet();
                                }
                            }
                            if (main.Game.world.myAvatar.objData.eqp[_loc_6].isPreview)
                            {
                                main.Game.world.myAvatar.objData.eqp[_loc_6].sType = main.Game.world.myAvatar.objData.eqp[_loc_6].oldType;
                                main.Game.world.myAvatar.objData.eqp[_loc_6].sFile = main.Game.world.myAvatar.objData.eqp[_loc_6].oldFile;
                                main.Game.world.myAvatar.objData.eqp[_loc_6].sLink = main.Game.world.myAvatar.objData.eqp[_loc_6].oldLink;
                                main.Game.world.myAvatar.loadMovieAtES(_loc_6, main.Game.world.myAvatar.objData.eqp[_loc_6].oldFile, main.Game.world.myAvatar.objData.eqp[_loc_6].oldLink);
                                main.Game.world.myAvatar.objData.eqp[_loc_6].isPreview = null;
                            }
                        }
                        Game.sfc.removeEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseHandler);
                        this.hasEvent = false;
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function stageHandler(event:Event) : void
        {
            trace(Capabilities.version);
            main.events.addEventListener(ClientEvent.onCostumePending, this.onCostumePending);
            aqlData = SharedObject.getLocal("AQLite_Data", "/");
            aqlData.flush();
            addFrameScript(0, this.frame1);
            stage.addEventListener(Event.MOUSE_LEAVE, this.focusGame);
            stage.addEventListener(MouseEvent.MOUSE_OVER, this.refocusGame);
            return;
        }// end function

        public function focusGame(param1) : void
        {
            if (!this.hasLeft)
            {
                this.hasLeft = true;
            }
            return;
        }// end function

        public function refocusGame(param1) : void
        {
            if (this.hasLeft)
            {
                stage.focus = null;
                this.hasLeft = false;
            }
            return;
        }// end function

        public function frame1() : void
        {
            _stage = stage;
            Security.allowDomain("*");
            stop();
            this.GetVersion();
            return;
        }// end function

        function LoadGame()
        {
            this.swfLoader = new Loader();
            this.swfRequest = new URLRequest(this.sURL + "gamefiles/" + this.sFile);
            this.swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onGameComplete, false, 0, true);
            this.swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress, false, 0, true);
            this.swfLoader.load(this.swfRequest, new LoaderContext(false, ApplicationDomain.currentDomain));
            return;
        }// end function

        function onGameComplete(event:Event)
        {
            var _loc_2:* = undefined;
            rootDisplay = root as DisplayObjectContainer;
            dropMenu = (root as DisplayObjectContainer).getChildByName("dropsUI2");
            stage.addChildAt(MovieClip(event.currentTarget.content), 0);
            event.currentTarget.content.y = 0;
            event.currentTarget.content.x = 0;
            Game = Object(event.currentTarget.content).root;
            gameDomain = event.currentTarget.applicationDomain;
            for (_loc_2 in root.loaderInfo.parameters)
            {
                
                trace(_loc_2 + ": " + root.loaderInfo.parameters[_loc_2]);
                Game.params[_loc_2] = root.loaderInfo.parameters[_loc_2];
            }
            Game.params.sURL = this.sURL;
            Game.params.sTitle = "Soul Hero";
            Game.params.isWeb = false;
            Game.params.doSignup = false;
            Game.params.loginURL = this.loginURL;
            Game.params.sBG = "";
            Game.titleDomain = this.titleDomain;
            this.waitForLogin.addEventListener(TimerEvent.TIMER, this.onWait);
            this.waitForLogin.start();
            return;
        }// end function

        function onWait(event:TimerEvent) : void
        {
            var _loc_2:forestbg = null;
            if (Game.mcLogin)
            {
                if (Game.mcLogin.currentLabel == "GetLauncher")
                {
                    Game.mcLogin.gotoAndStop("Init");
                }
                if (!Game.mcLogin.mcTitle.getChildByName("forest"))
                {
                    Game.mcLogin.mcTitle.removeChildAt(0);
                    _loc_2 = new forestbg();
                    _loc_2.name = "forest";
                    Game.mcLogin.mcTitle.addChild(_loc_2);
                    Game.mcLogin.mcTitle.visible = true;
                }
            }
            if (Game.sfc.isConnected)
            {
                if (Game.world.actions.active != null && !Game.world.mapLoadInProgress)
                {
                    if (Game.world.myAvatar.invLoaded && Game.world.myAvatar.pMC.artLoaded())
                    {
                        this.waitForLogin.reset();
                        this.waitForLogin.removeEventListener(TimerEvent.TIMER, this.onWait);
                        this.waitForLogin.addEventListener(TimerEvent.TIMER, this.onLogout);
                        this.waitForLogin.start();
                        this.runOnce = false;
                    }
                }
            }
            return;
        }// end function

        function onLogout(event:TimerEvent) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:iconDrops = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (!Game.sfc.isConnected)
            {
                this.waitForLogin.reset();
                this.waitForLogin.addEventListener(TimerEvent.TIMER, this.onWait);
                this.waitForLogin.start();
            }
            if (!this.runOnce && Game.ui)
            {
                if (!this.modulesInit)
                {
                    modules.create();
                    this.modulesInit = true;
                }
                Game.ui.mcPortrait.addEventListener(MouseEvent.CLICK, this.targetPlayer, false, 0, true);
                Game.ui.mcPortrait.removeEventListener(MouseEvent.CLICK, Game.portraitClick);
                Game.ui.mcPortraitTarget.addEventListener(MouseEvent.CLICK, this.targetPlayer, false, 0, true);
                Game.ui.mcPortraitTarget.removeEventListener(MouseEvent.CLICK, Game.portraitClick);
                if (!Game.ui.mcPortrait.getChildByName("iconDrops"))
                {
                    _loc_3 = new iconDrops();
                    _loc_3.name = "iconDrops";
                    Game.ui.mcPortrait.addChild(_loc_3);
                    _loc_3.x = 40;
                    _loc_3.y = 72.15;
                    _loc_3.visible = optionHandler.cDrops || optionHandler.sbpcDrops;
                }
                if (optionHandler.cDrops && !Game.ui.getChildByName("dropmenu"))
                {
                    optionHandler.dropmenuMC = new dropmenu();
                    optionHandler.dropmenuMC.name = "dropmenu";
                    main.Game.ui.addChild(optionHandler.dropmenuMC);
                }
                if (optionHandler.sbpcDrops && !Game.ui.getChildByName("dropmenutwo"))
                {
                    optionHandler.dropmenutwoMC = new dropmenutwo();
                    optionHandler.dropmenutwoMC.name = "dropmenutwo";
                    main.Game.ui.addChild(optionHandler.dropmenutwoMC);
                }
                if (optionHandler.cSkillAnim && Game.ui)
                {
                    _loc_4 = 2;
                    while (_loc_4 < 6)
                    {
                        
                        Game.ui.mcInterface.actBar.getChildByName("i" + _loc_4).addEventListener(MouseEvent.CLICK, cskillanim.actIconClick, false, 0, true);
                        _loc_4 = _loc_4 + 1;
                    }
                }
                if (optionHandler.qPin && Game.ui)
                {
                    Game.ui.iconQuest.addEventListener(MouseEvent.CLICK, qpin.onPinQuests);
                    Game.ui.iconQuest.removeEventListener(MouseEvent.CLICK, Game.oniconQuestClick);
                }
                if (optionHandler.qLog && Game.ui.mcInterface.mcMenu.btnQuest)
                {
                    Game.ui.mcInterface.mcMenu.btnQuest.addEventListener(MouseEvent.CLICK, qlog.onRegister, false, 0, true);
                }
                if (optionHandler.chatFilter && Game.ui && optionHandler.filterChecks["chkRedSkills"])
                {
                    stage.removeEventListener(KeyboardEvent.KEY_UP, main.Game.key_actBar);
                    _loc_5 = 1;
                    while (_loc_5 < 6)
                    {
                        
                        Game.ui.mcInterface.actBar.getChildByName("i" + _loc_5).addEventListener(MouseEvent.CLICK, chatfilter.actIconClick, false, 0, true);
                        Game.ui.mcInterface.actBar.getChildByName("i" + _loc_5).removeEventListener(MouseEvent.CLICK, Game.actIconClick);
                        _loc_5 = _loc_5 + 1;
                    }
                }
                if (optionHandler.skill && Game.ui)
                {
                    if (!Game.ui.getChildByName("skillsMC"))
                    {
                        optionHandler.skillsMC = new skills();
                        optionHandler.skillsMC.name = "skillsMC";
                        Game.ui.addChild(optionHandler.skillsMC);
                        optionHandler.targetskillsMC = new targetskills();
                        optionHandler.targetskillsMC.name = "targetskillsMC";
                        Game.ui.addChild(optionHandler.targetskillsMC);
                    }
                }
                if (optionHandler.bHouseEntrance)
                {
                    Game.ui.mcInterface.mcMenu.btnHouse.addEventListener(MouseEvent.CLICK, houseentrance.onHouseClick, false, 0, true);
                }
                Game.world.myAvatar.factions.sortOn("sName");
                _loc_2 = false;
                Game.ui.mcUpdates.mouseChildren = false;
                Game.ui.mcUpdates.mouseEnabled = _loc_2;
                this.runOnce = true;
            }
            return;
        }// end function

        function targetPlayer(event:MouseEvent) : void
        {
            var _loc_2:cMenu = null;
            if (getQualifiedClassName(event.target).indexOf("ib2") > -1)
            {
                return;
            }
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            _loc_3 = MovieClip(event.currentTarget);
            if (!Game.ui.getChildByName("customMenu"))
            {
                _loc_2 = new cMenu();
                _loc_2.name = "customMenu";
                Game.ui.addChild(_loc_2);
            }
            var _loc_5:* = Game.ui.getChildByName("customMenu");
            if (_loc_3.pAV.npcType == "player")
            {
                _loc_4 = {};
                _loc_4.ID = _loc_3.pAV.objData.CharID;
                _loc_4.strUsername = _loc_3.pAV.objData.strUsername;
                if (_loc_3.pAV != Game.world.myAvatar)
                {
                    _loc_5.fOpenWith("user", _loc_4);
                }
                else
                {
                    _loc_5.fOpenWith("self", _loc_4);
                }
            }
            else
            {
                _loc_4 = {};
                _loc_4.ID = _loc_3.pAV.objData.MonMapID;
                _loc_4.strUsername = _loc_3.pAV.objData.strMonName;
                _loc_4.target = main.Game.world.getMonster(_loc_4.ID).pMC;
                _loc_5.fOpenWith("mons", _loc_4);
            }
            return;
        }// end function

        function GetVersion()
        {
            this.aqliteLoader = new URLLoader();
            this.aqliteLoader.addEventListener(Event.COMPLETE, this.onAQLiteVersion, false, 0, true);
            this.aqliteLoader.load(new URLRequest("https://api.github.com/repos/133spider/AQLite/releases/latest"));
            this.versionLoader = new URLLoader();
            this.versionLoader.addEventListener(Event.COMPLETE, this.onVersionComplete, false, 0, true);
            this.versionLoader.load(new URLRequest(this.sURL + this.gameFile));
            return;
        }// end function

        function onProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = event.currentTarget.bytesLoaded / event.currentTarget.bytesTotal * 100;
            this.loader.progress.text = Math.floor(_loc_2).toString() + "%";
            if (_loc_2 == 100)
            {
                this.removeChild(this.loader);
            }
            return;
        }// end function

        function onVersionComplete(event:Event)
        {
            var _loc_2:URLVariables = null;
            _loc_2 = new URLVariables(event.target.data);
            if (_loc_2.status == "success")
            {
                this.sFile = _loc_2.sFile;
                this.sBG = _loc_2.sBG;
                this.titleDomain = new ApplicationDomain();
                this.LoadGame();
            }
            this.versionLoader.removeEventListener(Event.COMPLETE, this.onVersionComplete);
            this.versionLoader = null;
            return;
        }// end function

        function onAQLiteVersion(event:Event)
        {
            var _loc_2:* = event.target.data;
            latestVersion = _loc_2.substring(_loc_2.indexOf("\"tag_name\":") + 11);
            latestVersion = latestVersion.substring((latestVersion.indexOf("\"") + 1));
            latestVersion = latestVersion.substring(0, latestVersion.indexOf("\""));
            if (Number(latestVersion) <= curVersion)
            {
                isUpdated = true;
            }
            trace("[AQLITE NEWEST VERSION]: " + latestVersion);
            trace("[AQLITE VERSION]: " + curVersion);
            this.aqliteLoader.removeEventListener(Event.COMPLETE, this.onAQLiteVersion);
            this.aqliteLoader = null;
            return;
        }// end function

        public static function get sharedObject() : SharedObject
        {
            if (!aqlData)
            {
                aqlData = SharedObject.getLocal("AQLite_Data", "/");
            }
            return aqlData;
        }// end function

    }
}
