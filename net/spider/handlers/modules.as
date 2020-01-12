// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.handlers.modules

package net.spider.handlers
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import net.spider.modules.drops;
    import net.spider.modules.skillanim;
    import net.spider.modules.hideplayers;
    import net.spider.modules.monstype;
    import net.spider.modules.qrates;
    import net.spider.modules.qprev;
    import net.spider.modules.qlog;
    import net.spider.modules.untarget;
    import net.spider.modules.chatfilter;
    import net.spider.modules.untargetself;
    import net.spider.modules.diswepanim;
    import net.spider.modules.detaildrops;
    import net.spider.modules.detailquests;
    import net.spider.modules.dismonanim;
    import net.spider.modules.bitmap;
    import net.spider.modules.cskillanim;
    import net.spider.modules.qaccept;
    import net.spider.modules.qpin;
    import net.spider.modules.dismapanim;
    import net.spider.modules.lockmons;
    import net.spider.modules.smoothbg;
    import net.spider.modules.colorsets;
    import net.spider.modules.hidemonsters;
    import net.spider.modules.hidepnames;
    import net.spider.modules.battlepet;
    import net.spider.main;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import net.spider.draw.theArchive;
    import net.spider.draw.invSearch;
    import net.spider.modules.dynamicoptions;
    import com.adobe.utils.StringUtil;
    import net.spider.draw.btGender;
    import net.spider.draw.tryMe;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import net.spider.modules.*;
    import flash.ui.*;

    public class modules extends MovieClip 
    {

        private static var maintainTimer:Timer;
        private static var moduleList:Array;
        private static var performOnceFlag:Boolean = false;


        public static function create():void
        {
            moduleList = [{
                "moduleClass":passives,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":drops,
                "moduleType":"Frame",
                "responseHandler":true,
                "keyHandler":false
            }, {
                "moduleClass":skillanim,
                "moduleType":"Timer",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":hideplayers,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":monstype,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":qrates,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":qprev,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":qlog,
                "moduleType":"",
                "responseHandler":false,
                "keyHandler":true
            }, {
                "moduleClass":untarget,
                "moduleType":"Timer",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":chatfilter,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":true
            }, {
                "moduleClass":untargetself,
                "moduleType":"Timer",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":diswepanim,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":detaildrops,
                "moduleType":"Frame",
                "responseHandler":true,
                "keyHandler":false
            }, {
                "moduleClass":detailquests,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":dismonanim,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":bitmap,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":cskillanim,
                "moduleType":"Timer",
                "responseHandler":true,
                "keyHandler":true
            }, {
                "moduleClass":qaccept,
                "moduleType":"",
                "responseHandler":true,
                "keyHandler":false
            }, {
                "moduleClass":qpin,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":dismapanim,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":lockmons,
                "moduleType":"Timer",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":smoothbg,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":colorsets,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":boosts,
                "moduleType":"Timer",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":hidemonsters,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":hidepnames,
                "moduleType":"Frame",
                "responseHandler":false,
                "keyHandler":false
            }, {
                "moduleClass":battlepet,
                "moduleType":"",
                "responseHandler":true,
                "keyHandler":false
            }];
            optionHandler.readSettings();
            main.Game.sfc.addEventListener(SFSEvent.onExtensionResponse, onExtensionResponseHandler);
            main._stage.addEventListener(Event.ENTER_FRAME, onMaintainFrame);
            main._stage.addEventListener(KeyboardEvent.KEY_UP, onMaintainKeys);
            maintainTimer = new Timer(0);
            maintainTimer.addEventListener(TimerEvent.TIMER, onMaintainTimer);
            maintainTimer.start();
        }

        public static function onWheel(e:MouseEvent):void
        {
            var book:MovieClip = MovieClip(main.Game.ui.mcPopup.mcBook.getChildAt(0).content);
            if (e.delta > 0)
            {
                book.btnLeft.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            else
            {
                book.btnRight.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
        }

        public static function onInvWheel(e:MouseEvent):void
        {
            var i:Number;
            var j:Number;
            var inv:MovieClip = MovieClip(e.currentTarget.scr);
            if (e.delta > 0)
            {
                if (main.Game.ui.mcPopup.currentLabel == "MergeShop")
                {
                    e.currentTarget.scr.h.y = (e.currentTarget.scr.h.y - ((e.delta * 3) * 1.1));
                    if ((e.currentTarget.scr.h.y + e.currentTarget.scr.h.height) > e.currentTarget.scr.b.height)
                    {
                        e.currentTarget.scr.h.y = int((e.currentTarget.scr.b.height - e.currentTarget.scr.h.height));
                    };
                    if (e.currentTarget.scr.h.y < 0)
                    {
                        e.currentTarget.scr.h.y = 0;
                    };
                    return;
                };
                i = 0;
                while (i < e.delta)
                {
                    inv.a1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    i++;
                };
            }
            else
            {
                j = 0;
                while (j < (e.delta * -1))
                {
                    inv.a2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    j++;
                };
            };
        }

        public static function onQuestWheel(e:MouseEvent):void
        {
            var quest:MovieClip = MovieClip(e.currentTarget.scr);
            quest.h.y = (quest.h.y + ((e.delta * -1) * 3));
            if (quest.h.y < 0)
            {
                quest.h.y = 0;
            };
            if ((quest.h.y + quest.h.height) > quest.b.height)
            {
                quest.h.y = int((quest.b.height - quest.h.height));
            };
        }

        public static function onBankWheel(e:MouseEvent):void
        {
            var oldY:Number;
            var i:Number;
            var j:Number;
            if (e.delta > 0)
            {
                oldY = e.currentTarget.scr.h.y;
                i = 0;
                while (i < e.delta)
                {
                    MovieClip(e.currentTarget.scr).a1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    i++;
                };
                if (oldY == e.currentTarget.scr.h.y)
                {
                    e.currentTarget.scr.h.y = (e.currentTarget.scr.h.y - (e.delta * 1.1));
                    if ((e.currentTarget.scr.h.y + e.currentTarget.scr.h.height) > e.currentTarget.scr.b.height)
                    {
                        e.currentTarget.scr.h.y = int((e.currentTarget.scr.b.height - e.currentTarget.scr.h.height));
                    };
                    if (e.currentTarget.scr.h.y < 0)
                    {
                        e.currentTarget.scr.h.y = 0;
                    };
                };
            }
            else
            {
                j = 0;
                while (j < (e.delta * -1))
                {
                    MovieClip(e.currentTarget.scr).a2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    j++;
                };
            };
        }

        public static function onBtArchive(e:MouseEvent):void
        {
            var book:MovieClip = MovieClip(main.Game.ui.mcPopup.mcBook.getChildAt(0).content);
            var _archive:theArchive = new theArchive();
            main._stage.addChild(_archive);
            book.questList.removeEventListener(Event.ENTER_FRAME, book.dEF);
            book.btnBack.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }

        public static function _func_flag(e:MouseEvent):void
        {
            trace("Garbage temporary function flag for btnQuests");
        }

        public static function isPreviewable():Boolean
        {
            if (((main.Game.ui.mcPopup.getChildByName("mcShop")) && (!(main.Game.ui.mcPopup.currentLabel == "MergeShop"))))
            {
                if (main.Game.ui.mcPopup.getChildByName("mcShop").splitPanel.visible)
                {
                    return (false);
                };
            };
            if (main.Game.ui.mcPopup.getChildByName("mcInventory"))
            {
                if (main.Game.ui.mcPopup.getChildByName("mcInventory").splitPanel.visible)
                {
                    return (false);
                };
            };
            if (!main.Game.ui.mcPopup.getChildByName("mcShop"))
            {
                return (false);
            };
            if (!main.Game.ui.mcPopup.getChildByName("mcShop").iSel)
            {
                return (false);
            };
            switch (main.Game.ui.mcPopup.getChildByName("mcShop").iSel.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    if (main.Game.ui.mcPopup.getChildByName("mcShop").iSel.bUpg == 1)
                    {
                        if (!main.Game.world.myAvatar.isUpgraded())
                        {
                            return (false);
                        };
                    };
                    return (true);
                case "ho":
                case "hi":
                default:
                    return (false);
            };
        }

        public static function isGender(mcFocus:String):Boolean
        {
            if (main.Game.ui.mcPopup.currentLabel != "MergeShop")
            {
                if (main.Game.ui.mcPopup.getChildByName(mcFocus).splitPanel.visible)
                {
                    return (false);
                };
            };
            if (!main.Game.ui.mcPopup.getChildByName(mcFocus).iSel)
            {
                return (false);
            };
            switch (main.Game.ui.mcPopup.getChildByName(mcFocus).iSel.sES)
            {
                case "ar":
                case "co":
                    return (true);
                default:
                    return (false);
            };
        }

        public static function onMaintainFrame(e:Event):void
        {
            var _module:* = undefined;
            var mcFocus:MovieClip;
            var mcTarget:String;
            var mcUI:MovieClip;
            var mcDynamicOptions:* = undefined;
            var book:MovieClip;
            var invBackdrop:* = undefined;
            var invSearchMC:invSearch;
            var frame:MovieClip;
            var bank:MovieClip;
            var inv:MovieClip;
            var btGenderMC:* = undefined;
            var tryMeMC:* = undefined;
            var mcDrop:* = undefined;
            if (((!(main.Game)) || (!(main.Game.ui))))
            {
                return;
            };
            for each (_module in moduleList)
            {
                if (_module.moduleType == "Frame")
                {
                    _module.moduleClass.onFrameUpdate();
                };
            };
            if (main.Game.ui.mcPopup.currentLabel == "Option")
            {
                if (!main.Game.ui.mcPopup.getChildByName("dynamicoptions"))
                {
                    mcDynamicOptions = main.Game.ui.mcPopup.addChild(new dynamicoptions());
                    mcDynamicOptions.name = "dynamicoptions";
                    mcDynamicOptions.x = 133.35;
                    mcDynamicOptions.y = -20.4;
                };
            }
            else
            {
                if (main.Game.ui.mcPopup.getChildByName("dynamicoptions"))
                {
                    main.Game.ui.mcPopup.removeChild(main.Game.ui.mcPopup.getChildByName("dynamicoptions"));
                };
            };
            if (main.Game.ui.mcPopup.currentLabel == "Book")
            {
                if (main.Game.ui.mcPopup.mcBook)
                {
                    book = MovieClip(main.Game.ui.mcPopup.mcBook.getChildAt(0).content);
                    if (book)
                    {
                        if (book.btnRight)
                        {
                            if (!book.btnRight.hasEventListener(MouseEvent.MOUSE_WHEEL))
                            {
                                main._stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel, false, 0, true);
                            };
                        };
                        if (((book.btnQuests) && (!(book.btnQuests.hasEventListener(MouseEvent.DOUBLE_CLICK)))))
                        {
                            if (optionHandler.bTheArchive)
                            {
                                book.btnQuests.addEventListener(MouseEvent.CLICK, onBtArchive, false, 0, true);
                            };
                            book.btnQuests.addEventListener(MouseEvent.DOUBLE_CLICK, _func_flag, false, 0, true);
                        };
                    };
                };
            };
            if (main.Game.ui.mcPopup.currentLabel == "Inventory")
            {
                if (main.Game.ui.mcPopup.getChildByName("mcInventory"))
                {
                    if (!MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory").multiPanel.frames[4].mc).hasEventListener(MouseEvent.MOUSE_WHEEL))
                    {
                        MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory").multiPanel.frames[4].mc).addEventListener(MouseEvent.MOUSE_WHEEL, onInvWheel, false, 0, true);
                        MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory").splitPanel.frames[2].mc).addEventListener(MouseEvent.MOUSE_WHEEL, onInvWheel, false, 0, true);
                    };
                };
            };
            if (main.Game.ui.mcPopup.getChildByName("mcInventory"))
            {
                invBackdrop = MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory").multiPanel);
                if (flags.isInventory())
                {
                    if (!invBackdrop.getChildByName("invSearch"))
                    {
                        invSearchMC = new invSearch();
                        invSearchMC.name = "invSearch";
                        invBackdrop.addChild(invSearchMC);
                        invSearchMC.x = 32;
                        invSearchMC.y = 12;
                    };
                }
                else
                {
                    if (invBackdrop.getChildByName("invSearch"))
                    {
                        invBackdrop.removeChild(invBackdrop.getChildByName("invSearch"));
                    };
                };
            };
            if (main.Game.ui.mcPopup.currentLabel == "Shop")
            {
                if (main.Game.ui.mcPopup.getChildByName("mcShop"))
                {
                    if (!MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop").multiPanel.frames[5].mc).hasEventListener(MouseEvent.MOUSE_WHEEL))
                    {
                        MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop").multiPanel.frames[5].mc).addEventListener(MouseEvent.MOUSE_WHEEL, onInvWheel, false, 0, true);
                        MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop").splitPanel.frames[2].mc).addEventListener(MouseEvent.MOUSE_WHEEL, onInvWheel, false, 0, true);
                    };
                };
            };
            if (main.Game.ui.mcPopup.currentLabel == "MergeShop")
            {
                if (main.Game.ui.mcPopup.getChildByName("mcShop"))
                {
                    if (!MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop").mergePanel.frames[8].mc).hasEventListener(MouseEvent.MOUSE_WHEEL))
                    {
                        MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop").mergePanel.frames[8].mc).addEventListener(MouseEvent.MOUSE_WHEEL, onInvWheel, false, 0, true);
                    };
                };
            };
            if (main.Game.ui.ModalStack.numChildren)
            {
                frame = main.Game.ui.ModalStack.getChildAt(0);
                if (!MovieClip(frame.cnt).hasEventListener(MouseEvent.MOUSE_WHEEL))
                {
                    MovieClip(frame.cnt).addEventListener(MouseEvent.MOUSE_WHEEL, onQuestWheel, false, 0, true);
                };
            };
            if (main.Game.ui.mcPopup.currentLabel == "Bank")
            {
                if (main.Game.ui.mcPopup.getChildByName("mcBank"))
                {
                    bank = MovieClip(main.Game.ui.mcPopup.getChildByName("mcBank").bankPanel.frames[1].mc);
                    inv = MovieClip(main.Game.ui.mcPopup.getChildByName("mcBank").bankPanel.frames[7].mc);
                    if (!bank.hasEventListener(MouseEvent.MOUSE_WHEEL))
                    {
                        bank.addEventListener(MouseEvent.MOUSE_WHEEL, onBankWheel, false, 0, true);
                    };
                    if (!inv.hasEventListener(MouseEvent.MOUSE_WHEEL))
                    {
                        inv.addEventListener(MouseEvent.MOUSE_WHEEL, onBankWheel, false, 0, true);
                    };
                };
            };
            if (((main.Game.ui.mcPopup.getChildByName("mcCustomizeArmor")) && (!(performOnceFlag))))
            {
                main.Game.ui.mcPopup.mcCustomizeArmor.cpAccessory.addEventListener("ROLL_OVER", onItemRollOver, false, 0, true);
                main.Game.ui.mcPopup.mcCustomizeArmor.cpAccessory.addEventListener("ROLL_OUT", onItemRollOut, false, 0, true);
                performOnceFlag = true;
            }
            else
            {
                if (((performOnceFlag) && (!(main.Game.ui.mcPopup.getChildByName("mcCustomizeArmor")))))
                {
                    performOnceFlag = false;
                };
            };
            if (((main.Game.ui.mcOFrame.currentLabel == "Idle") && (main.Game.ui.mcOFrame.t1.txtTitle.text == "Friends List")))
            {
                main.Game.ui.mcOFrame.t1.txtTitle.text = (("Friends List (" + main.Game.world.myAvatar.friends.length) + "/40)");
            };
            switch (main.Game.ui.mcPopup.currentLabel)
            {
                case "Shop":
                    if (!main.Game.ui.mcPopup.getChildByName("mcShop"))
                    {
                        mcTarget = "None";
                        break;
                    };
                    mcFocus = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).previewPanel.getChildAt(3);
                    mcTarget = ((MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).previewPanel.visible) ? "mcShop" : "None");
                    break;
                case "MergeShop":
                    if (!main.Game.ui.mcPopup.getChildByName("mcShop"))
                    {
                        mcTarget = "None";
                        break;
                    };
                    mcFocus = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).mergePanel.getChildAt(3);
                    mcTarget = ((MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).mergePanel.visible) ? "mcShop" : "None");
                    break;
                case "Inventory":
                    if (!main.Game.ui.mcPopup.getChildByName("mcInventory"))
                    {
                        mcTarget = "None";
                        break;
                    };
                    mcFocus = MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).previewPanel.getChildAt(3);
                    mcTarget = ((MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).previewPanel.visible) ? "mcInventory" : "None");
                    break;
                default:
                    mcTarget = "None";
            };
            mcUI = main.Game.ui.mcPopup.getChildByName(mcTarget);
            if (!((mcTarget == "None") || (!(mcUI))))
            {
                if (mcFocus.tInfo.textHeight > mcFocus.tInfo.height)
                {
                    mcUI.iSel.sDesc = StringUtil.trim(mcUI.iSel.sDesc);
                    mcFocus.tInfo.htmlText = main.Game.getItemInfoStringB(mcUI.iSel);
                    if (mcFocus.tInfo.textHeight >= 109.8)
                    {
                        mcFocus.tInfo.y = int(((mcFocus.btnDelete.y + mcFocus.btnDelete.height) - (mcFocus.tInfo.height - (((mcFocus.tInfo.textHeight == 109.8) || (mcFocus.tInfo.textHeight == 122.95)) ? 15 : 3))));
                    };
                };
                if (isGender(mcTarget))
                {
                    if (!mcFocus.getChildByName("btGender"))
                    {
                        btGenderMC = new btGender();
                        btGenderMC.name = "btGender";
                        btGenderMC.height = 20;
                        btGenderMC.width = 25;
                        mcFocus.addChild(btGenderMC);
                    };
                    if ((((main.Game.ui.mcPopup.currentLabel == "Shop") && (mcUI.previewPanel.visible)) && (!(mcUI.splitPanel.visible))))
                    {
                        mcFocus.getChildByName("btGender").x = 0xFF;
                        mcFocus.getChildByName("btGender").y = 175;
                    }
                    else
                    {
                        if (main.Game.ui.mcPopup.currentLabel == "MergeShop")
                        {
                            mcFocus.getChildByName("btGender").x = 0xFF;
                            mcFocus.getChildByName("btGender").y = 175;
                        }
                        else
                        {
                            if (((main.Game.ui.mcPopup.currentLabel == "Inventory") && (!(mcUI.splitPanel.visible))))
                            {
                                mcFocus.getChildByName("btGender").x = 253;
                                mcFocus.getChildByName("btGender").y = 150;
                            };
                        };
                    };
                }
                else
                {
                    if (mcFocus.getChildByName("btGender"))
                    {
                        mcFocus.removeChild(mcFocus.getChildByName("btGender"));
                    };
                };
                if (isPreviewable())
                {
                    if (!mcFocus.getChildByName("tryMe"))
                    {
                        tryMeMC = new tryMe();
                        tryMeMC.name = "tryMe";
                        mcFocus.addChild(tryMeMC);
                    };
                    if ((((main.Game.ui.mcPopup.currentLabel == "Shop") && (mcUI.previewPanel.visible)) && (!(mcUI.splitPanel.visible))))
                    {
                        mcFocus.getChildByName("tryMe").x = 17;
                        mcFocus.getChildByName("tryMe").y = 333;
                    };
                    if ((main.Game.ui.mcPopup.currentLabel == "MergeShop"))
                    {
                        mcFocus.getChildByName("tryMe").x = 165;
                        mcFocus.getChildByName("tryMe").y = 293;
                    };
                }
                else
                {
                    if (mcFocus.getChildByName("tryMe"))
                    {
                        mcFocus.removeChild(mcFocus.getChildByName("tryMe"));
                    };
                };
            };
            if (((main.Game.ui.dropStack.numChildren < 1) || (optionHandler.blackListed.length < 1)))
            {
                return;
            };
            var i:int;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                try
                {
                    mcDrop = (main.Game.ui.dropStack.getChildAt(i) as MovieClip);
                    if (isBlacklisted(mcDrop.cnt.strName.text.toUpperCase()))
                    {
                        mcDrop.cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                }
                catch(exception)
                {
                    trace(("Error handling drops: " + exception));
                };
                i = (i + 1);
            };
        }

        public static function isBlacklisted(item:String):Boolean
        {
            var blacklisted:*;
            for each (blacklisted in optionHandler.blackListed)
            {
                if (item.indexOf(" X") != -1)
                {
                    item = item.substring(0, item.lastIndexOf(" X"));
                };
                if (StringUtil.trim(item) == StringUtil.trim(blacklisted.label))
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function onMaintainTimer(e:TimerEvent):void
        {
            var _module:*;
            var faction:*;
            if (((!(main.Game)) || (!(main.Game.ui))))
            {
                return;
            };
            for each (_module in moduleList)
            {
                if (_module.moduleType == "Timer")
                {
                    _module.moduleClass.onTimerUpdate();
                };
            };
            if (((optionHandler.cleanRep) && (!(main.Game.world.myAvatar.factions.hasOwnProperty("cleaned")))))
            {
                for each (faction in main.Game.world.myAvatar.factions)
                {
                    if (faction.iRank == "10")
                    {
                        faction.iSpillRep = 0;
                    };
                    if (((faction.sName == "Blacksmithing") && (faction.iRank == "4")))
                    {
                        faction.iSpellRep = 0;
                        faction.iRepToRank = 0;
                        faction.iRank = "10";
                    };
                };
                main.Game.world.myAvatar.factions.cleaned = true;
            };
            if (main.Game.world.myAvatar)
            {
                if (main.Game.world.myAvatar.target)
                {
                    if (main.Game.world.myAvatar.target.dataLeaf.intState == 0)
                    {
                        main.Game.world.myAvatar.pMC.clearQueue();
                    };
                };
            };
        }

        public static function onItemRollOver(param1:Event):void
        {
            var _loc2_:* = new Object();
            var avt:* = main.Game.world.myAvatar;
            _loc2_.intColorSkin = avt.objData.intColorSkin;
            _loc2_.intColorHair = avt.objData.intColorHair;
            _loc2_.intColorEye = avt.objData.intColorEye;
            _loc2_.intColorBase = avt.objData.intColorBase;
            _loc2_.intColorTrim = avt.objData.intColorTrim;
            _loc2_.intColorAccessory = param1.target.selectedColor;
            avt.pMC.updateColor(_loc2_);
        }

        public static function onItemRollOut(param1:Event):void
        {
            main.Game.world.myAvatar.pMC.updateColor();
        }

        public static function onExtensionResponseHandler(e:*):void
        {
            var _module:*;
            var dID:*;
            var protocol:*;
            var resObj:*;
            var cmd:*;
            if (((!(main.Game)) || (!(main.Game.ui))))
            {
                return;
            };
            for each (_module in moduleList)
            {
                if (_module.responseHandler == true)
                {
                    _module.moduleClass.onExtensionResponseHandler(e);
                };
            };
            protocol = e.params.type;
            if (protocol == "json")
            {
                resObj = e.params.dataObj;
                cmd = resObj.cmd;
                switch (cmd)
                {
                    case "bookInfo":
                        if (optionHandler.alphaBOL)
                        {
                            main.Game.world.bookData.HMBadge.sortOn("strName");
                            main.Game.world.bookData.OBadge.sortOn("strName");
                            main.Game.world.bookData.AchBadge.sortOn("strName");
                        };
                        break;
                };
            };
        }

        public static function onMaintainKeys(e:*):void
        {
            var _module:*;
            if (((!(main.Game)) || (!(main.Game.ui))))
            {
                return;
            };
            for each (_module in moduleList)
            {
                if (_module.keyHandler == true)
                {
                    _module.moduleClass.onKey(e);
                };
            };
        }


    }
}//package net.spider.handlers

