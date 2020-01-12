// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.dRender

package net.spider.draw
{
    import flash.display.MovieClip;
    import net.spider.avatar.AvatarMC;
    import flash.display.SimpleButton;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.Timer;
    import flash.display.Loader;
    import net.spider.main;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import net.spider.handlers.ClientEvent;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.filters.GlowFilter;
    import flash.events.IOErrorEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import net.spider.avatar.*;
    import flash.filters.*;

    public class dRender extends MovieClip 
    {

        public var btnTryMe:MovieClip;
        public var pMC:AvatarMC;
        public var btnClose:SimpleButton;
        internal var rootClass:MovieClip;
        internal var mcStage:MovieClip;
        internal var curItem:Object;
        internal var sLinkArmor:String = "";
        internal var sLinkCape:String = "";
        internal var sLinkHelm:String = "";
        internal var sLinkPet:String = "";
        internal var sLinkWeapon:String = "";
        internal var sLinkHouse:String = "";
        internal var pLoaderD:ApplicationDomain;
        internal var pLoaderC:LoaderContext;
        internal var petDisable:Timer = new Timer(0);
        internal var ldr:* = new Loader();

        public function dRender(e:*):void
        {
            this.rootClass = MovieClip(main.Game);
            this.pLoaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
            this.pLoaderC = new LoaderContext(false, this.pLoaderD);
            this.x = 325;
            this.y = 90;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.xClick, false, 0, true);
            this.btnTryMe.addEventListener(MouseEvent.CLICK, this.xTryMe, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onHold, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseRelease, false, 0, true);
            this.mcStage = MovieClip(this.addChild(new MovieClip()));
            this.loadItem(e);
        }

        private function xClick(event:MouseEvent):*
        {
            this.parent.removeChild(this);
        }

        private function xTryMe(event:MouseEvent):*
        {
            var sES:String;
            switch (this.curItem.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    sES = this.curItem.sES;
                    if (sES == "ar")
                    {
                        sES = "co";
                    };
                    if (sES == "pe")
                    {
                        if (main.Game.world.myAvatar.objData.eqp["pe"])
                        {
                            main.Game.world.myAvatar.unloadPet();
                        };
                    };
                    if (!main.Game.world.myAvatar.objData.eqp[sES])
                    {
                        main.Game.world.myAvatar.objData.eqp[sES] = {};
                        main.Game.world.myAvatar.objData.eqp[sES].wasCreated = true;
                    };
                    if (!main.Game.world.myAvatar.objData.eqp[sES].isPreview)
                    {
                        main.Game.world.myAvatar.objData.eqp[sES].isPreview = true;
                        if (("sType" in this.curItem))
                        {
                            main.Game.world.myAvatar.objData.eqp[sES].oldType = main.Game.world.myAvatar.objData.eqp[sES].sType;
                            main.Game.world.myAvatar.objData.eqp[sES].sType = this.curItem.sType;
                        };
                        main.Game.world.myAvatar.objData.eqp[sES].oldFile = main.Game.world.myAvatar.objData.eqp[sES].sFile;
                        main.Game.world.myAvatar.objData.eqp[sES].oldLink = main.Game.world.myAvatar.objData.eqp[sES].sLink;
                        main.Game.world.myAvatar.objData.eqp[sES].sFile = ((this.curItem.sFile == "undefined") ? "" : this.curItem.sFile);
                        main.Game.world.myAvatar.objData.eqp[sES].sLink = this.curItem.sLink;
                    }
                    else
                    {
                        if (("sType" in this.curItem))
                        {
                            main.Game.world.myAvatar.objData.eqp[sES].sType = this.curItem.sType;
                        };
                        main.Game.world.myAvatar.objData.eqp[sES].sFile = ((this.curItem.sFile == "undefined") ? "" : this.curItem.sFile);
                        main.Game.world.myAvatar.objData.eqp[sES].sLink = this.curItem.sLink;
                    };
                    main.Game.world.myAvatar.loadMovieAtES(sES, this.curItem.sFile, this.curItem.sLink);
                    if (((sES == "pe") && (!(this.curItem.sName.indexOf("Bank Pet") == -1))))
                    {
                        this.petDisable.addEventListener(TimerEvent.TIMER, this.onPetDisable, false, 0, true);
                        this.petDisable.start();
                    };
                    this.visible = false;
                    main.events.dispatchEvent(new ClientEvent(ClientEvent.onCostumePending));
                    break;
            };
        }

        internal function onPetDisable(e:TimerEvent):void
        {
            if (!main.Game.world.myAvatar.petMC.mcChar)
            {
                return;
            };
            main.Game.world.myAvatar.petMC.mcChar.mouseEnabled = false;
            main.Game.world.myAvatar.petMC.mcChar.mouseChildren = false;
            main.Game.world.myAvatar.petMC.mcChar.enabled = false;
            this.petDisable.reset();
            this.petDisable.removeEventListener(TimerEvent.TIMER, this.onPetDisable);
        }

        public function loadItem(e:*):void
        {
            this.visible = true;
            var param1:* = e;
            if (this.curItem != param1)
            {
                this.btnTryMe.visible = false;
                this.pMC.visible = false;
                this.curItem = param1;
                switch (this.curItem.sES)
                {
                    case "Weapon":
                    case "he":
                    case "ba":
                    case "pe":
                    case "ar":
                    case "co":
                        if (this.curItem.bUpg == 1)
                        {
                            if (!main.Game.world.myAvatar.isUpgraded())
                            {
                                this.btnTryMe.visible = false;
                            }
                            else
                            {
                                this.btnTryMe.visible = true;
                            };
                        }
                        else
                        {
                            this.btnTryMe.visible = true;
                        };
                        break;
                };
                switch (param1.sES)
                {
                    case "Weapon":
                        this.loadWeapon(param1.sFile, param1.sLink);
                        break;
                    case "he":
                        this.loadHelm(param1.sFile, param1.sLink);
                        break;
                    case "ba":
                        this.loadCape(param1.sFile, param1.sLink);
                        break;
                    case "pe":
                        this.loadPet(param1.sFile, param1.sLink);
                        break;
                    case "ar":
                    case "co":
                        this.loadArmor(param1.sFile, param1.sLink);
                        break;
                    case "ho":
                        this.loadHouse(param1.sFile);
                        break;
                    case "hi":
                        this.loadHouseItem(param1.sFile, param1.sLink);
                        break;
                    default:
                        this.loadItemFile();
                };
            };
        }

        private function clearStage():void
        {
            var _loc_1:* = (this.mcStage.numChildren - 1);
            while (_loc_1 >= 0)
            {
                this.mcStage.removeChildAt(_loc_1);
                _loc_1--;
            };
        }

        private function loadHouseItem(param1:*, param2:*):void
        {
            this.clearStage();
            this.sLinkHouse = param2;
            this.ldr = new Loader();
            this.ldr.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + param1)), this.pLoaderC);
            this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onloadHouseItemComplete, false, 0, true);
        }

        private function onloadHouseItemComplete(param1:Event):void
        {
            var _loc_3:* = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkHouse) as Class);
            var _loc_4:* = new (_loc_3)();
            _loc_4.x = 150;
            _loc_4.y = 200;
            this.mcStage.addChild(_loc_4);
            this.addGlow(_loc_4);
        }

        private function loadWeapon(param1:*, param2:*):void
        {
            this.clearStage();
            this.sLinkWeapon = param2;
            this.ldr = new Loader();
            this.ldr.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + param1)), this.pLoaderC);
            this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadWeaponComplete, false, 0, true);
        }

        private function loadCape(param1:*, param2:*):void
        {
            this.clearStage();
            this.sLinkCape = param2;
            this.ldr = new Loader();
            this.ldr.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + param1)), this.pLoaderC);
            this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadCapeComplete, false, 0, true);
        }

        private function loadHelm(param1:*, param2:*):void
        {
            this.clearStage();
            this.sLinkHelm = param2;
            this.ldr = new Loader();
            this.ldr.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + param1)), this.pLoaderC);
            this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadHelmComplete, false, 0, true);
        }

        private function loadPet(param1:*, param2:*):void
        {
            this.clearStage();
            this.sLinkPet = param2;
            this.ldr = new Loader();
            this.ldr.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + param1)), this.pLoaderC);
            this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadPetComplete, false, 0, true);
        }

        private function loadHouse(param1:*):void
        {
            this.clearStage();
            var _loc_2:* = (("maps/" + this.curItem.sFile.substr(0, -4)) + "_preview.swf");
            this.ldr = new Loader();
            this.ldr.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + _loc_2)), this.pLoaderC);
            this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadHouseComplete, false, 0, true);
        }

        internal function onLoadHouseComplete(event:Event):void
        {
            var _loc_2:* = (this.curItem.sFile.substr(0, -4).substr((this.curItem.sFile.lastIndexOf("/") + 1)).split("-").join("_") + "_preview");
            var _loc_3:* = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(_loc_2) as Class);
            var _loc_4:* = new (_loc_3)();
            _loc_4.x = 150;
            _loc_4.y = 200;
            this.mcStage.addChild(_loc_4);
            this.addGlow(_loc_4);
        }

        private function loadArmor(param1:*, param2:*):void
        {
            this.clearStage();
            this.sLinkArmor = param2;
            var _loc_3:* = this.pMC;
            var objChar:Object = new Object();
            objChar.strGender = main.Game.world.myAvatar.objData.strGender;
            _loc_3.pAV.objData = objChar;
            _loc_3.x = 150;
            _loc_3.y = 250;
            var _loc_4:* = 1.65;
            _loc_3.scaleY = 1.65;
            _loc_3.scaleX = _loc_4;
            _loc_3.loadArmor(param1, param2);
            this.addGlow(_loc_3);
            _loc_3.visible = true;
        }

        internal function onLoadWeaponComplete(event:Event):void
        {
            var mc:MovieClip;
            var AssetClass:Class;
            var e:* = undefined;
            e = event;
            try
            {
                AssetClass = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkWeapon) as Class);
                mc = new (AssetClass)();
            }
            catch(err:Error)
            {
                mc = MovieClip(e.target.content);
            };
            mc.x = 150;
            mc.y = 180;
            var _loc_3:* = 0.3;
            mc.scaleY = 0.3;
            mc.scaleX = _loc_3;
            this.mcStage.addChild(mc);
            this.addGlow(mc);
        }

        internal function onLoadCapeComplete(event:Event):void
        {
            var _loc_2:* = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkCape) as Class);
            var _loc_3:* = new (_loc_2)();
            _loc_3.x = 150;
            _loc_3.y = 150;
            var _loc_4:* = 0.5;
            _loc_3.scaleY = 0.5;
            _loc_3.scaleX = _loc_4;
            this.mcStage.addChild(_loc_3);
            this.addGlow(_loc_3);
        }

        internal function onLoadHelmComplete(event:Event):void
        {
            var _loc_2:* = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkHelm) as Class);
            var _loc_3:* = new (_loc_2)();
            _loc_3.x = 170;
            _loc_3.y = 200;
            this.mcStage.addChild(_loc_3);
            this.addGlow(_loc_3);
        }

        internal function onLoadPetComplete(event:Event):void
        {
            var _loc_2:* = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkPet) as Class);
            var _loc_3:* = new (_loc_2)();
            _loc_3.x = 150;
            _loc_3.y = 250;
            var _loc_4:* = 2;
            _loc_3.scaleY = 2;
            _loc_3.scaleX = _loc_4;
            this.mcStage.addChild(_loc_3);
            this.addGlow(_loc_3);
        }

        private function addGlow(param1:MovieClip):void
        {
            var _loc_2:* = new GlowFilter(0xFFFFFF, 1, 8, 8, 2, 1, false, false);
            param1.filters = [_loc_2];
        }

        private function loadItemFile():void
        {
            this.clearStage();
            var _loc_1:* = new Loader();
            _loc_1.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + this.curItem.sFile)), this.pLoaderC);
            _loc_1.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadItemFileComplete, false, 0, true);
            _loc_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError, false, 0, true);
        }

        internal function onLoadItemFileComplete(event:Event):void
        {
            var _loc_2:* = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.curItem.sLink) as Class);
            var _loc_3:* = new (_loc_2)();
            _loc_3.x = 150;
            _loc_3.y = 250;
            if (_loc_3.height > 225)
            {
                _loc_3.height = 225;
                _loc_3.scaleX = _loc_3.scaleY;
            };
            if (_loc_3.width > 275)
            {
                _loc_3.width = 275;
                _loc_3.scaleY = _loc_3.scaleX;
            };
            this.mcStage.addChild(_loc_3);
            this.addGlow(_loc_3);
        }

        internal function onLoadError(event:Event):void
        {
            var _loc_2:* = (main.Game.world.getClass("iibag") as Class);
            var _loc_3:* = new (_loc_2)();
            _loc_3.x = 150;
            _loc_3.y = 180;
            _loc_3.scaleY = (_loc_3.scaleX = 1);
            this.mcStage.addChild(_loc_3);
            this.addGlow(_loc_3);
        }

        private function onHold(e:MouseEvent):void
        {
            this.startDrag();
        }

        private function onMouseRelease(e:MouseEvent):void
        {
            this.stopDrag();
        }


    }
}//package net.spider.draw

