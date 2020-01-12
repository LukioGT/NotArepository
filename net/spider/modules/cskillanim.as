﻿// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.cskillanim

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.main;
    import net.spider.handlers.optionHandler;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.utils.getDefinitionByName;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class cskillanim extends MovieClip 
    {

        private static var stage:*;
        public static var eventInitialized:Boolean = false;


        public static function onToggle():void
        {
            var i:*;
            var j:*;
            stage = main._stage;
            if (optionHandler.cSkillAnim)
            {
                if (main.Game.ui)
                {
                    if (!eventInitialized)
                    {
                        i = 2;
                        while (i < 6)
                        {
                            main.Game.ui.mcInterface.actBar.getChildByName(("i" + i)).addEventListener(MouseEvent.CLICK, actIconClick, false, 0, true);
                            i++;
                        };
                        eventInitialized = true;
                    };
                };
            }
            else
            {
                if (eventInitialized)
                {
                    j = 2;
                    while (j < 6)
                    {
                        main.Game.ui.mcInterface.actBar.getChildByName(("i" + j)).removeEventListener(MouseEvent.CLICK, actIconClick);
                        j++;
                    };
                    eventInitialized = false;
                };
            };
        }

        public static function onTimerUpdate():void
        {
            if (((!(optionHandler.cSkillAnim)) || (!(main.Game.sfc.isConnected))))
            {
                return;
            };
            main.Game.world.myAvatar.pMC.spFX.strl = "";
        }

        public static function handleSkills(param1:String):void
        {
            switch (param1)
            {
                case "i2":
                    switch (main.Game.world.myAvatar.objData.strClassName)
                    {
                        case "Dragonlord":
                            main.Game.world.myAvatar.pMC.spFX.strl2 = "dragonstrike";
                            main.Game.world.myAvatar.pMC.spFX.fx = "w";
                            main.Game.world.myAvatar.pMC.spFX.tgt = "h";
                            break;
                    };
                    break;
                case "i3":
                    switch (main.Game.world.myAvatar.objData.strClassName)
                    {
                        case "Dragonlord":
                            main.Game.world.myAvatar.pMC.spFX.strl2 = "firedragon";
                            main.Game.world.myAvatar.pMC.spFX.fx = "w";
                            main.Game.world.myAvatar.pMC.spFX.tgt = "h";
                            break;
                    };
                    break;
                case "i4":
                    switch (main.Game.world.myAvatar.objData.strClassName)
                    {
                        case "Dragonlord":
                            main.Game.world.myAvatar.pMC.spFX.strl2 = "healthdragon";
                            main.Game.world.myAvatar.pMC.spFX.fx = "w";
                            main.Game.world.myAvatar.pMC.spFX.tgt = "s";
                            break;
                    };
                    break;
                case "i5":
                    switch (main.Game.world.myAvatar.objData.strClassName)
                    {
                        case "Dragonlord":
                            main.Game.world.myAvatar.pMC.spFX.strl2 = "darknessdragon";
                            main.Game.world.myAvatar.pMC.spFX.fx = "w";
                            main.Game.world.myAvatar.pMC.spFX.tgt = "s";
                            break;
                    };
                    break;
            };
            castSpellFX(main.Game.world.myAvatar.pMC.pAV, main.Game.world.myAvatar.pMC.spFX, null, main.Game.world.myAvatar.pMC.spellDur);
        }

        public static function actIconClick(e:*):void
        {
            if (main.Game.world.myAvatar.objData.strClassName == "Void Highlord")
            {
                return;
            };
            if (main.Game.world.myAvatar.objData.strClassName != "Dragonlord")
            {
                return;
            };
            handleSkills(e.target.name);
        }

        public static function onKey(param1:KeyboardEvent):*
        {
            if (!optionHandler.cSkillAnim)
            {
                return;
            };
            if (main.Game.world.myAvatar.objData.strClassName == "Void Highlord")
            {
                return;
            };
            if (main.Game.world.myAvatar.objData.strClassName != "Dragonlord")
            {
                return;
            };
            if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
            {
                if (((param1.charCode > 49) && (param1.charCode < 55)))
                {
                    switch (param1.charCode)
                    {
                        case 50:
                            if (main.Game.world.actions.active[1].isOK)
                            {
                                handleSkills("i2");
                            };
                            break;
                        case 51:
                            if (main.Game.world.actions.active[2].isOK)
                            {
                                handleSkills("i3");
                            };
                            break;
                        case 52:
                            if (main.Game.world.actions.active[3].isOK)
                            {
                                handleSkills("i4");
                            };
                            break;
                        case 53:
                            if (main.Game.world.actions.active[4].isOK)
                            {
                                handleSkills("i5");
                            };
                            break;
                    };
                };
            };
        }

        public static function onExtensionResponseHandler(e:*):void
        {
            var dID:*;
            var resObj:*;
            var cmd:*;
            var i:*;
            var o:*;
            if (!optionHandler.cSkillAnim)
            {
                return;
            };
            var protocol:* = e.params.type;
            if (protocol == "json")
            {
                resObj = e.params.dataObj;
                cmd = resObj.cmd;
                switch (cmd)
                {
                    case "sAct":
                        if (!eventInitialized)
                        {
                            i = 2;
                            while (i < 6)
                            {
                                main.Game.ui.mcInterface.actBar.getChildByName(("i" + i)).addEventListener(MouseEvent.CLICK, actIconClick, false, 0, true);
                                i++;
                            };
                            eventInitialized = true;
                        };
                        break;
                    case "ct":
                        if (((!(resObj.anims == null)) && (main.Game.world.myAvatar.objData.strClassName == "Void Highlord")))
                        {
                            for each (o in resObj.anims)
                            {
                                switch (o.strl)
                                {
                                    case "sp_voidhaa":
                                        main.Game.world.myAvatar.pMC.spFX.strl2 = "vhaa";
                                        break;
                                    case "sp_voidha1":
                                        main.Game.world.myAvatar.pMC.spFX.strl2 = "vha1";
                                        break;
                                    case "sp_voidha2":
                                        main.Game.world.myAvatar.pMC.spFX.strl2 = "vha2";
                                        break;
                                    case "sp_voidha3":
                                        main.Game.world.myAvatar.pMC.spFX.strl2 = "vha3";
                                        break;
                                    case "sp_voidha4":
                                        main.Game.world.myAvatar.pMC.spFX.strl2 = "vha4";
                                        break;
                                    default:
                                        return;
                                };
                                castSpellFX(main.Game.world.myAvatar.pMC.pAV, main.Game.world.myAvatar.pMC.spFX, null, main.Game.world.myAvatar.pMC.spellDur);
                                break;
                            };
                        };
                        break;
                };
            };
        }

        public static function castSpellFX(param1:*, param2:*, param3:*, param4:int=0):*
        {
            var rootClass:* = main.Game;
            var _loc5_:* = null;
            var _loc6_:Class;
            var _loc7_:* = undefined;
            var _loc8_:Array;
            var _loc9_:int;
            if ((((!(param2.strl2 == null)) && (!(param2.strl2 == ""))) && (!(param2.avts == null))))
            {
                _loc8_ = [];
                _loc9_ = 0;
                if (param2.fx == "c")
                {
                    if (param2.strl2 == "lit1")
                    {
                        _loc8_.push(param1.pMC.mcChar);
                        _loc9_ = 0;
                        while (_loc9_ < param2.avts.length)
                        {
                            _loc5_ = param2.avts[_loc9_];
                            if ((((!(_loc5_ == null)) && (!(_loc5_.pMC == null))) && (!(_loc5_.pMC.mcChar == null))))
                            {
                                _loc8_.push(_loc5_.pMC.mcChar);
                            };
                            _loc9_++;
                        };
                        if (_loc8_.length > 1)
                        {
                            _loc6_ = (getDefinitionByName(("net.spider.anim." + param2.strl2)) as Class);
                            if (_loc6_ != null)
                            {
                                _loc7_ = new (_loc6_)();
                                _loc7_.mouseEnabled = false;
                                _loc7_.mouseChildren = false;
                                _loc7_.visible = true;
                                _loc7_.world = rootClass.world;
                                _loc7_.strl2 = param2.strl2;
                                rootClass.drawChainsLinear(_loc8_, 33, MovieClip(main.Game.world.CHARS.addChild(_loc7_)));
                            };
                        };
                    };
                }
                else
                {
                    if (param2.fx == "f")
                    {
                        _loc8_.push(param1.pMC.mcChar);
                        _loc5_ = param2.avts[0];
                        if ((((!(_loc5_ == null)) && (!(_loc5_.pMC == null))) && (!(_loc5_.pMC.mcChar == null))))
                        {
                            _loc8_.push(_loc5_.pMC.mcChar);
                        };
                        if (_loc8_.length > 1)
                        {
                            _loc7_ = new MovieClip();
                            _loc7_.mouseEnabled = false;
                            _loc7_.mouseChildren = false;
                            _loc7_.visible = true;
                            _loc7_.world = rootClass.world;
                            _loc7_.strl2 = param2.strl2;
                            rootClass.drawFunnel(_loc8_, MovieClip(main.Game.world.CHARS.addChild(_loc7_)));
                        };
                    }
                    else
                    {
                        _loc9_ = 0;
                        while (_loc9_ < param2.avts.length)
                        {
                            _loc5_ = param2.avts[_loc9_];
                            _loc6_ = (getDefinitionByName(("net.spider.anim." + param2.strl2)) as Class);
                            if (_loc6_ != null)
                            {
                                _loc7_ = new (_loc6_)();
                                _loc7_.spellDur = param4;
                                if (param3 != null)
                                {
                                    _loc7_.transform = param3.transform;
                                };
                                main.Game.world.CHARS.addChild(_loc7_);
                                _loc7_.mouseEnabled = false;
                                _loc7_.mouseChildren = false;
                                _loc7_.visible = true;
                                _loc7_.world = rootClass.world;
                                _loc7_.strl2 = param2.strl2;
                                if (param2.tgt == "s")
                                {
                                    _loc7_.tMC = param1.pMC;
                                }
                                else
                                {
                                    if (main.Game.world.myAvatar.target)
                                    {
                                        _loc7_.tMC = _loc5_.pMC;
                                    }
                                    else
                                    {
                                        _loc7_.tMC = param1.pMC;
                                    };
                                };
                                if (main.Game.world.myAvatar.target)
                                {
                                    _loc7_.trueTarget = main.Game.world.myAvatar.target.pMC;
                                    _loc7_.trueSelf = param1.pMC;
                                };
                                switch (param2.fx)
                                {
                                    case "p":
                                        _loc7_.x = param1.pMC.x;
                                        _loc7_.y = (param1.pMC.y - (param1.pMC.mcChar.height * 0.5));
                                        _loc7_.dir = (((_loc5_.pMC.x - param1.pMC.x) >= 0) ? 1 : -1);
                                        break;
                                    case "w":
                                        _loc7_.x = _loc7_.tMC.x;
                                        _loc7_.y = (_loc7_.tMC.y + 3);
                                        if (param1 != null)
                                        {
                                            if (_loc5_.pMC.x < param1.pMC.x)
                                            {
                                                MovieClip(_loc7_).scaleX = (MovieClip(_loc7_).scaleX * -1);
                                            };
                                        };
                                        break;
                                    case "d":
                                        _loc7_.x = param1.pMC.x;
                                        _loc7_.y = param1.pMC.y;
                                        if (param1 != null)
                                        {
                                            if (_loc5_.pMC.x < param1.pMC.x)
                                            {
                                                MovieClip(_loc7_).scaleX = (MovieClip(_loc7_).scaleX * -1);
                                            };
                                        };
                                        break;
                                };
                            }
                            else
                            {
                                trace();
                                trace(("*>*>*> Could not load class " + param2.strl2));
                                trace();
                            };
                            _loc9_++;
                        };
                    };
                };
            };
        }


    }
}//package net.spider.modules

