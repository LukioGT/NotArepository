// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.handlers.dropmenu

package net.spider.handlers
{
    import flash.display.MovieClip;
    import net.spider.avatar.AvatarMC;
    import flash.display.SimpleButton;
    import flash.display.Loader;
    import flash.utils.Timer;
    import net.spider.main;
    import flash.events.Event;
    import com.adobe.utils.StringUtil;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.IOErrorEvent;
    import flash.geom.Rectangle;
    import flash.events.TimerEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import flash.ui.*;

    public class dropmenu extends MovieClip 
    {

        public var pMC:AvatarMC;
        public var cnt:MovieClip;
        public var btnClose:SimpleButton;
        public var tTitle:MovieClip;
        public var bg:MovieClip;
        public var iListB:MovieClip;
        public var world:MovieClip;
        public var hit:MovieClip;
        public var iListA:MovieClip;
        public var rootClass:MovieClip;
        public var fxmask:MovieClip;
        public var CHARS:MovieClip;
        public var preview:MovieClip;
        internal var scrTgt:MovieClip;
        public var invTree:Array;
        internal var itemCount:Object;
        internal var ldr:Loader;
        internal var item_load:Object;

        internal var petDisable:Timer = new Timer(0);
        public var fData:Object = null;
        internal var mDown:Boolean = false;
        internal var hRun:int = 0;
        internal var dRun:int = 0;
        internal var mbY:int = 0;
        internal var mhY:int = 0;
        internal var mbD:int = 0;
        internal var ox:int = 0;
        internal var oy:int = 0;
        internal var mox:int = 0;
        internal var moy:int = 0;

        public function dropmenu():void
        {
            var mc:MovieClip;
            super();
            mc = (this as MovieClip);
            mc.tTitle.mouseEnabled = false;
            mc.preview.tPreview.mouseEnabled = false;
            mc.hit.alpha = 0;
            mc.hit.buttonMode = true;
            mc.visible = false;
            this.itemCount = {};
            this.invTree = new Array();
            this.ldr = new Loader();
            main.Game.sfc.addEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseHandler);
            main._stage.addEventListener(Event.ENTER_FRAME, this.onDropFrame);
        }

        internal function onUpdate():*
        {
            this.itemCount = {};
            this.invTree = new Array();
            this.fOpen();
        }

        public function onShow():void
        {
            var mc:MovieClip = (this as MovieClip);
            if (mc.visible)
            {
                this.fClose();
            }
            else
            {
                this.fOpen();
            };
        }

        public function cleanup():void
        {
            main.Game.sfc.removeEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseHandler);
            main._stage.removeEventListener(Event.ENTER_FRAME, this.onDropFrame);
            if (main.Game.ui.dropStack.numChildren < 1)
            {
                return;
            };
            var i:int;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                try
                {
                    if (!(main.Game.ui.dropStack.getChildAt(i) as MovieClip).visible)
                    {
                        (main.Game.ui.dropStack.getChildAt(i) as MovieClip).visible = true;
                    };
                }
                catch(exception)
                {
                    trace(("Error handling drops: " + exception));
                };
                i = (i + 1);
            };
        }

        public function onDropFrame(e:*):void
        {
            if (!main.Game.sfc.isConnected)
            {
                this.itemCount = {};
                this.invTree = new Array();
                return;
            };
            if (main.Game.ui.dropStack.numChildren < 1)
            {
                return;
            };
            var i:int;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                try
                {
                    if ((main.Game.ui.dropStack.getChildAt(i) as MovieClip).cnt.ybtn)
                    {
                        (main.Game.ui.dropStack.getChildAt(i) as MovieClip).visible = false;
                    };
                }
                catch(exception)
                {
                    trace(("Error handling drops: " + exception));
                };
                i = (i + 1);
            };
        }

        public function isBlacklisted(item:String):Boolean
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

        public function onExtensionResponseHandler(e:*):void
        {
            var dItem:*;
            var dID:*;
            var resObj:*;
            var cmd:*;
            var dropClass:Class;
            var droppedItem:*;
            var dropUI:*;
            var val:*;
            var protocol:* = e.params.type;
            if (protocol == "json")
            {
                resObj = e.params.dataObj;
                cmd = resObj.cmd;
                switch (cmd)
                {
                    case "dropItem":
                        for (dID in resObj.items)
                        {
                            if (main.Game.world.invTree[dID])
                            {
                                dItem = main.Game.copyObj(main.Game.world.invTree[dID]);
                                if (this.isBlacklisted(dItem.sName.toUpperCase()))
                                {
                                    continue;
                                };
                            }
                            else
                            {
                                if (this.isBlacklisted(resObj.items[dID].sName.toUpperCase()))
                                {
                                    continue;
                                };
                            };
                            if (this.itemCount[dID] == null)
                            {
                                this.itemCount[dID] = int(resObj.items[dID].iQty);
                                if (main.Game.world.invTree[dID] == null)
                                {
                                    this.invTree.push(main.Game.copyObj(resObj.items[dID]));
                                }
                                else
                                {
                                    dItem = main.Game.copyObj(main.Game.world.invTree[dID]);
                                    dItem.iQty = int(resObj.items[dID].iQty);
                                    this.invTree.push(dItem);
                                };
                                this.invTree[(this.invTree.length - 1)].dID = dID;
                            }
                            else
                            {
                                this.itemCount[dID] = (this.itemCount[dID] + int(resObj.items[dID].iQty));
                            };
                            if (((optionHandler.filterChecks["chkCDropNotification"]) && (!(main.Game.world.invTree[dID].bTemp))))
                            {
                                dropClass = (main.Game.world.getClass("DFrameMC") as Class);
                                droppedItem = main.Game.copyObj(main.Game.world.invTree[dID]);
                                droppedItem.iQty = int(resObj.items[dID].iQty);
                                dropUI = new dropClass(droppedItem);
                                main.Game.ui.dropStack.addChild(dropUI);
                                dropUI.init();
                                dropUI.fY = (dropUI.y = -(dropUI.fHeight + 8));
                                dropUI.fX = (dropUI.x = -(dropUI.fWidth / 2));
                                main.Game.cleanDropStack();
                            };
                        };
                        this.fOpen();
                        break;
                    case "getDrop":
                        for (val in this.invTree)
                        {
                            if (this.invTree[val].ItemID == resObj.ItemID)
                            {
                                if (resObj.bSuccess == 1)
                                {
                                    this.itemCount[this.invTree[val].dID] = null;
                                    this.invTree.splice(val, 1);
                                    this.fOpen();
                                };
                            };
                        };
                        break;
                };
            };
        }

        public function check(itemID:*):*
        {
            var val:*;
            for (val in this.invTree)
            {
                if (this.invTree[val].ItemID == itemID)
                {
                    return (val);
                };
            };
            return (null);
        }

        public function btnCloseClick(e:MouseEvent=null):void
        {
            this.rootClass.mixer.playSound("Click");
            this.hideEditMenu();
        }

        public function dEF(e:Event):*
        {
            var scr:*;
            var display:*;
            var hP:*;
            var tY:*;
            scr = MovieClip(e.currentTarget.parent).scr;
            display = MovieClip(e.currentTarget);
            hP = (-(scr.h.y) / this.hRun);
            tY = (int((hP * this.dRun)) + display.oy);
            if (Math.abs((tY - display.y)) > 0.2)
            {
                display.y = (display.y + ((tY - display.y) / 4));
            }
            else
            {
                display.y = tY;
            };
        }

        public function hEF(e:Event):*
        {
            var scr:*;
            if (MovieClip(e.currentTarget.parent).mDown)
            {
                scr = MovieClip(e.currentTarget.parent);
                this.mbD = (int(mouseY) - this.mbY);
                scr.h.y = (this.mhY + this.mbD);
                if ((scr.h.y + scr.h.height) > scr.b.height)
                {
                    scr.h.y = int((scr.b.height - scr.h.height));
                };
                if (scr.h.y < 0)
                {
                    scr.h.y = 0;
                };
            };
        }

        public function hideEditMenu():void
        {
            var mc:MovieClip;
            mc = MovieClip(this);
            mc.visible = false;
            mc.x = 1000;
            stage.focus = stage;
        }

        public function onMenuBGEnterFrame(e:Event):*
        {
            var mc:MovieClip;
            mc = (e.currentTarget.parent as MovieClip);
            if (mc.visible)
            {
                if (mc.mDown)
                {
                    mc.x = (mc.ox + (stage.mouseX - mc.mox));
                    mc.y = (mc.oy + (stage.mouseY - mc.moy));
                    if (mc.x < 0)
                    {
                        mc.x = 0;
                    };
                    if ((mc.x + mc.bg.width) > 960)
                    {
                        mc.x = (960 - mc.bg.width);
                    };
                    if (mc.y < 0)
                    {
                        mc.y = 0;
                    };
                    if ((mc.y + mc.bg.height) > 495)
                    {
                        mc.y = (495 - mc.bg.height);
                    };
                };
            };
        }

        public function resizeMe():*
        {
            var mc:MovieClip;
            var minWidth:*;
            mc = MovieClip(this);
            if (mc.iListA.visible)
            {
                mc.bg.width = ((mc.iListA.x + mc.iListA.w) + 5);
            };
            if (mc.iListB.visible)
            {
                mc.iListB.x = ((mc.iListA.x + mc.iListA.w) + 1);
                mc.bg.width = (mc.bg.width + (mc.iListB.w + 1));
                mc.iListA.divider.visible = (!(mc.iListA.scr.visible));
            }
            else
            {
                mc.iListA.divider.visible = false;
            };
            if (((mc.preview.t2.visible) || (mc.cnt.visible)))
            {
                mc.preview.x = ((mc.iListB.x + mc.iListB.w) + 4);
                mc.bg.width = (mc.bg.width + (mc.preview.width + 4));
                mc.iListB.divider.visible = (!(mc.iListB.scr.visible));
            }
            else
            {
                mc.iListB.divider.visible = false;
            };
            minWidth = ((((mc.tTitle.x + this.tTitle.width) + 4) + mc.btnClose.width) + 4);
            if (mc.bg.width < minWidth)
            {
                mc.bg.width = minWidth;
            };
            mc.btnClose.x = (mc.bg.width - 19);
            mc.fxmask.width = mc.bg.width;
            if (mc.x < 0)
            {
                mc.x = 0;
            };
            if ((mc.x + mc.bg.width) > 960)
            {
                mc.x = (960 - mc.bg.width);
            };
            if (mc.y < 0)
            {
                mc.y = 0;
            };
            if ((mc.y + mc.bg.height) > 495)
            {
                mc.y = (495 - mc.bg.height);
            };
        }

        public function fClose(e:MouseEvent=null):void
        {
            var mc:MovieClip;
            var mcp:MovieClip;
            var h:MovieClip;
            mc = MovieClip(this);
            mc.btnClose.removeEventListener(MouseEvent.CLICK, this.btnCloseClick);
            mc.bg.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMenuBGClick);
            mc.bg.removeEventListener(Event.ENTER_FRAME, this.onMenuBGEnterFrame);
            mc.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMenuBGClick);
            mc.hit.removeEventListener(Event.ENTER_FRAME, this.onMenuBGEnterFrame);
            mc.btnClose.removeEventListener(MouseEvent.CLICK, this.btnCloseClick);
            mc.preview.bTry.removeEventListener(MouseEvent.CLICK, this.onItemTryClick);
            mc.preview.bAdd.removeEventListener(MouseEvent.CLICK, this.onItemAddClick);
            mc.preview.bDel.removeEventListener(MouseEvent.CLICK, this.onItemDelClick);
            this.destroyIList(mc.iListA);
            this.destroyIList(mc.iListB);
            mc.visible = false;
            stage.focus = stage;
        }

        private function refreshIListB():void
        {
            var mc:MovieClip;
            var i:int;
            var imc:MovieClip;
            mc = MovieClip(this).iListB.iList;
            i = 1;
            while (i < mc.numChildren)
            {
                imc = (mc.getChildAt(i) as MovieClip);
                if (imc.val != null)
                {
                    imc.bg.visible = false;
                    if (imc.iSel)
                    {
                        imc.bg.visible = true;
                        imc.bg.alpha = 0.5;
                    };
                    if (int(imc.val.bEquip) == 1)
                    {
                        imc.bg.visible = true;
                        imc.bg.alpha = 1;
                    };
                };
                i++;
            };
        }

        public function scrDown(e:MouseEvent):*
        {
            this.mbY = int(mouseY);
            this.mhY = int(MovieClip(e.currentTarget.parent).h.y);
            this.scrTgt = MovieClip(e.currentTarget.parent);
            this.scrTgt.mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.scrUp, false, 0, true);
        }

        public function scrUp(e:MouseEvent):*
        {
            this.scrTgt.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.scrUp);
        }

        private function addGlow(mc:MovieClip):void
        {
            var mcFilter:*;
            mcFilter = new GlowFilter(0xFFFFFF, 1, 8, 8, 2, 1, false, false);
            mc.filters = [mcFilter];
        }

        public function onMenuBGRelease(e:MouseEvent):void
        {
            var mc:MovieClip;
            mc = MovieClip(this);
            mc.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMenuBGRelease);
        }

        public function onMenuItemClick(e:MouseEvent):void
        {
            var imc:MovieClip;
            var cmc:MovieClip;
            var parMC:MovieClip;
            var mc:MovieClip;
            var item:Object;
            var i:int;
            var s:String;
            imc = (e.currentTarget as MovieClip);
            parMC = (imc.parent as MovieClip);
            mc = (this as MovieClip);
            i = 0;
            s = "";
            if (imc.typ == "A")
            {
                i = 0;
                while (i < parMC.numChildren)
                {
                    MovieClip(parMC.getChildAt(i)).bg.visible = false;
                    i++;
                };
                imc.bg.visible = true;
                this.buildItemList(this.fData[imc.val], "B", MovieClip(imc.parent));
            };
            if (imc.typ == "B")
            {
                i = 1;
                while (i < parMC.numChildren)
                {
                    cmc = (parMC.getChildAt(i) as MovieClip);
                    cmc.iSel = false;
                    i++;
                };
                imc.iSel = true;
                this.refreshIListB();
                item = imc.val;
                this.item_load = imc.val;
                switch (item.sType.toLowerCase())
                {
                    case "armor":
                    case "class":
                        this.onLoadArmorComplete(item.sFile, item.sLink);
                        break;
                    case "quest item":
                    case "item":
                        this.loadItem();
                        break;
                    default:
                        trace(((("Loading " + item.sLink) + ":") + item.sFile));
                        this.ldr.load(new URLRequest(("http://aqworldscdn.aq.com/game/gamefiles/" + item.sFile)), new LoaderContext(false, ApplicationDomain.currentDomain));
                        this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
                        this.ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
                };
            };
        }

        public function repositionPreview(mc:MovieClip):void
        {
            var r:Rectangle;
            r = mc.getBounds(this);
            if (r.height > 113)
            {
                mc.scaleX = (mc.scaleX * (113 / r.height));
                mc.scaleY = (mc.scaleY * (113 / r.height));
            };
            mc.x = (MovieClip(this).preview.x - int(((mc.getBounds(this).x + (mc.getBounds(this).width / 2)) - (130 / 2))));
            mc.y = int((MovieClip(this).preview.y - mc.getBounds(this).y));
        }

        public function onLoadComplete(e:Event):void
        {
            var s:String;
            var itemC:Class;
            var mc:MovieClip;
            var item:* = undefined;
            var itemClip:MovieClip;
            var obj:* = this.item_load;
            s = obj.sLink;
            trace(("Obj type: " + obj.sType));
            mc = (MovieClip(this).cnt as MovieClip);
            if (mc.numChildren > 0)
            {
                mc.removeChildAt(0);
            };
            try
            {
                itemC = (this.ldr.contentLoaderInfo.applicationDomain.getDefinition(s) as Class);
                itemClip = new (itemC)();
            }
            catch(err:Error)
            {
                trace(" Weapon added to display list manually");
                itemClip = MovieClip(e.target.content);
            };
            switch (obj.sType.toLowerCase())
            {
                case "helm":
                    itemClip.scaleX = (itemClip.scaleY = 0.8);
                    break;
                case "pet":
                    itemClip.scaleX = (itemClip.scaleY = 2);
                    break;
                default:
                    itemClip.scaleX = (itemClip.scaleY = 0.3);
            };
            item = (mc.addChild(itemClip) as MovieClip);
            this.addGlow(itemClip);
            item.ItemID = obj.ItemID;
            MovieClip(this).preview.item = obj;
            switch (obj.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    if (obj.bUpg == 1)
                    {
                        if (main.Game.world.myAvatar.isUpgraded())
                        {
                            MovieClip(this).preview.bTry.visible = true;
                        };
                    }
                    else
                    {
                        MovieClip(this).preview.bTry.visible = true;
                    };
                    break;
            };
            MovieClip(this).preview.bAdd.visible = true;
            MovieClip(this).preview.bDel.visible = true;
            MovieClip(this).preview.tPreview.visible = true;
            MovieClip(this).preview.t2.visible = false;
            MovieClip(this).cnt.visible = true;
            MovieClip(this).pMC.visible = false;
            MovieClip(this).cnt.alpha = 1;
            if (obj.bCoins)
            {
                MovieClip(this).preview.mcCoin.visible = true;
            }
            else
            {
                MovieClip(this).preview.mcCoin.visible = false;
            };
            this.resizeMe();
            this.repositionPreview(itemClip);
        }

        public function onLoadError(e:IOErrorEvent):void
        {
            var s:String;
            var itemC:Class;
            var mc:MovieClip;
            var item:*;
            var itemClip:MovieClip;
            var obj:* = this.item_load;
            mc = (MovieClip(this).cnt as MovieClip);
            if (mc.numChildren > 0)
            {
                mc.removeChildAt(0);
            };
            itemC = (this.rootClass.world.getClass("iibag") as Class);
            itemClip = new (itemC)();
            itemClip.scaleX = (itemClip.scaleY = 1);
            itemClip.y = (itemClip.y - 35);
            item = (mc.addChild(itemClip) as MovieClip);
            this.addGlow(itemClip);
            item.ItemID = obj.ItemID;
            MovieClip(this).preview.item = obj;
            switch (obj.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    if (obj.bUpg == 1)
                    {
                        if (main.Game.world.myAvatar.isUpgraded())
                        {
                            MovieClip(this).preview.bTry.visible = true;
                        };
                    }
                    else
                    {
                        MovieClip(this).preview.bTry.visible = true;
                    };
                    break;
            };
            MovieClip(this).preview.bAdd.visible = true;
            MovieClip(this).preview.bDel.visible = true;
            MovieClip(this).preview.tPreview.visible = true;
            MovieClip(this).preview.t2.visible = false;
            MovieClip(this).cnt.visible = true;
            MovieClip(this).pMC.visible = false;
            MovieClip(this).cnt.alpha = 1;
            if (obj.bCoins)
            {
                MovieClip(this).preview.mcCoin.visible = true;
            }
            else
            {
                MovieClip(this).preview.mcCoin.visible = false;
            };
            this.resizeMe();
            this.repositionPreview(itemClip);
        }

        public function onLoadArmorComplete(sFile:*, sLink:*):void
        {
            var s:String;
            var itemC:Class;
            var mc:MovieClip;
            var item:*;
            var obj:* = this.item_load;
            s = obj.sLink;
            trace(("Obj type: " + obj.sType));
            var objChar:Object = new Object();
            objChar.strGender = main.Game.world.myAvatar.objData.strGender;
            mc = (MovieClip(this).cnt as MovieClip);
            if (mc.numChildren > 0)
            {
                mc.removeChildAt(0);
            };
            MovieClip(this).pMC.pAV.objData = objChar;
            MovieClip(this).pMC.loadArmor(sFile, sLink);
            MovieClip(this).pMC.visible = true;
            MovieClip(this).preview.item = obj;
            switch (obj.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    if (obj.bUpg == 1)
                    {
                        if (main.Game.world.myAvatar.isUpgraded())
                        {
                            MovieClip(this).preview.bTry.visible = true;
                        };
                    }
                    else
                    {
                        MovieClip(this).preview.bTry.visible = true;
                    };
                    break;
            };
            MovieClip(this).preview.bAdd.visible = true;
            MovieClip(this).preview.bDel.visible = true;
            MovieClip(this).preview.tPreview.visible = true;
            MovieClip(this).preview.t2.visible = false;
            MovieClip(this).cnt.visible = true;
            MovieClip(this).cnt.alpha = 0;
            if (obj.bCoins)
            {
                MovieClip(this).preview.mcCoin.visible = true;
            }
            else
            {
                MovieClip(this).preview.mcCoin.visible = false;
            };
            this.resizeMe();
            MovieClip(this).pMC.x = (MovieClip(this).preview.x + 60);
        }

        public function loadItem():void
        {
            var s:String;
            var itemC:Class;
            var mc:MovieClip;
            var item:*;
            var itemClip:MovieClip;
            var obj:* = this.item_load;
            mc = (MovieClip(this).cnt as MovieClip);
            if (mc.numChildren > 0)
            {
                mc.removeChildAt(0);
            };
            itemC = (this.rootClass.world.getClass("iibag") as Class);
            itemClip = new (itemC)();
            itemClip.scaleX = (itemClip.scaleY = 1);
            itemClip.y = (itemClip.y - 35);
            item = (mc.addChild(itemClip) as MovieClip);
            this.addGlow(itemClip);
            item.ItemID = obj.ItemID;
            MovieClip(this).preview.item = obj;
            switch (obj.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    if (obj.bUpg == 1)
                    {
                        if (main.Game.world.myAvatar.isUpgraded())
                        {
                            MovieClip(this).preview.bTry.visible = true;
                        };
                    }
                    else
                    {
                        MovieClip(this).preview.bTry.visible = true;
                    };
                    break;
            };
            MovieClip(this).preview.bAdd.visible = true;
            MovieClip(this).preview.bDel.visible = true;
            MovieClip(this).preview.tPreview.visible = true;
            MovieClip(this).preview.t2.visible = false;
            MovieClip(this).cnt.visible = true;
            MovieClip(this).pMC.visible = false;
            MovieClip(this).cnt.alpha = 1;
            if (obj.bCoins)
            {
                MovieClip(this).preview.mcCoin.visible = true;
            }
            else
            {
                MovieClip(this).preview.mcCoin.visible = false;
            };
            this.resizeMe();
            this.repositionPreview(itemClip);
        }

        public function showMenu():void
        {
            var mc:MovieClip;
            mc = MovieClip(this);
            this.buildMenu();
            mc.visible = true;
        }

        public function onHandleEnterFrame(e:Event):*
        {
            var mc:MovieClip;
            mc = (e.currentTarget as MovieClip);
            if (mc.visible)
            {
                mc.bCancel.x = ((mc.frame.width - mc.bCancel.width) - 4);
                mc.bDelete.x = ((mc.bCancel.x - mc.bDelete.width) - 4);
                if (mc.mDown)
                {
                    mc.x = (mc.ox + (stage.mouseX - mc.mox));
                    mc.y = (mc.oy + (stage.mouseY - mc.moy));
                    if ((mc.x + (mc.frame.width / 2)) < 0)
                    {
                        mc.x = -(int((mc.frame.width / 2)));
                    };
                    if ((mc.x + (mc.frame.width / 2)) > 960)
                    {
                        mc.x = int((960 - (mc.frame.width / 2)));
                    };
                    if ((mc.y + (mc.frame.height / 2)) < 0)
                    {
                        mc.y = -(int((mc.frame.height / 2)));
                    };
                    if ((mc.y + (mc.frame.height / 2)) > 495)
                    {
                        mc.y = int((495 - (mc.frame.height / 2)));
                    };
                    mc.tgt.x = Math.ceil((mc.x + (mc.frame.width / 2)));
                    mc.tgt.y = Math.ceil((mc.y - (mc.tgt.getBounds(stage).y - mc.tgt.y)));
                };
            };
        }

        public function onMenuBGClick(e:MouseEvent):void
        {
            var mc:MovieClip;
            mc = MovieClip(this);
            mc.mDown = true;
            mc.ox = mc.x;
            mc.oy = mc.y;
            mc.mox = stage.mouseX;
            mc.moy = stage.mouseY;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onMenuBGRelease, false, 0, true);
        }

        private function destroyIList(lmc:MovieClip):void
        {
            var child:MovieClip;
            while (lmc.iList.numChildren > 1)
            {
                child = lmc.iList.getChildAt(1);
                child.removeEventListener(MouseEvent.CLICK, this.onMenuItemClick);
                child.removeEventListener(MouseEvent.MOUSE_OVER, this.onMenuItemMouseOver);
                delete child.val;
                lmc.iList.removeChildAt(1);
            };
            lmc.scr.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.scrDown);
            lmc.scr.h.removeEventListener(Event.ENTER_FRAME, this.hEF);
            lmc.iList.removeEventListener(Event.ENTER_FRAME, this.dEF);
        }

        public function fOpen():void
        {
            var h:MovieClip;
            var mcp:MovieClip;
            var mc:MovieClip;
            this.rootClass = (main._stage.getChildAt(0) as MovieClip);
            this.world = (this.rootClass.world as MovieClip);
            this.CHARS = (this.rootClass.world.CHARS as MovieClip);
            mc = (this as MovieClip);
            mc.preview.bTry.buttonMode = true;
            mc.preview.bAdd.buttonMode = true;
            mc.preview.bDel.buttonMode = true;
            mc.preview.t2.mouseEnabled = false;
            mc.btnClose.addEventListener(MouseEvent.CLICK, this.btnCloseClick, false, 0, true);
            mc.bg.addEventListener(MouseEvent.MOUSE_DOWN, this.onMenuBGClick, false, 0, true);
            mc.bg.addEventListener(Event.ENTER_FRAME, this.onMenuBGEnterFrame, false, 0, true);
            mc.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.onMenuBGClick, false, 0, true);
            mc.hit.addEventListener(Event.ENTER_FRAME, this.onMenuBGEnterFrame, false, 0, true);
            mc.preview.bTry.addEventListener(MouseEvent.CLICK, this.onItemTryClick, false, 0, true);
            mc.preview.bAdd.addEventListener(MouseEvent.CLICK, this.onItemAddClick, false, 0, true);
            mc.preview.bDel.addEventListener(MouseEvent.CLICK, this.onItemDelClick, false, 0, true);
            mc.pMC.visible = false;
            this.showMenu();
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

        public function onItemTryClick(e:MouseEvent):void
        {
            var item:Object;
            var sES:String;
            item = MovieClip(e.currentTarget.parent).item;
            switch (item.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    sES = item.sES;
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
                        if (("sType" in item))
                        {
                            main.Game.world.myAvatar.objData.eqp[sES].oldType = main.Game.world.myAvatar.objData.eqp[sES].sType;
                            main.Game.world.myAvatar.objData.eqp[sES].sType = item.sType;
                        };
                        main.Game.world.myAvatar.objData.eqp[sES].oldFile = main.Game.world.myAvatar.objData.eqp[sES].sFile;
                        main.Game.world.myAvatar.objData.eqp[sES].oldLink = main.Game.world.myAvatar.objData.eqp[sES].sLink;
                        main.Game.world.myAvatar.objData.eqp[sES].sFile = ((item.sFile == "undefined") ? "" : item.sFile);
                        main.Game.world.myAvatar.objData.eqp[sES].sLink = item.sLink;
                    }
                    else
                    {
                        if (("sType" in item))
                        {
                            main.Game.world.myAvatar.objData.eqp[sES].sType = item.sType;
                        };
                        main.Game.world.myAvatar.objData.eqp[sES].sFile = ((item.sFile == "undefined") ? "" : item.sFile);
                        main.Game.world.myAvatar.objData.eqp[sES].sLink = item.sLink;
                    };
                    main.Game.world.myAvatar.loadMovieAtES(sES, item.sFile, item.sLink);
                    if (((sES == "pe") && (!(item.sName.indexOf("Bank Pet") == -1))))
                    {
                        this.petDisable.addEventListener(TimerEvent.TIMER, this.onPetDisable, false, 0, true);
                        this.petDisable.start();
                    };
                    main.events.dispatchEvent(new ClientEvent(ClientEvent.onCostumePending));
                    break;
            };
        }

        public function onItemAddClick(e:MouseEvent):void
        {
            var item:Object;
            var nutext:String;
            item = MovieClip(e.currentTarget.parent).item;
            var i:int;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                if (item.iStk == 1)
                {
                    if (main.Game.ui.dropStack.getChildAt(i).cnt.strName.text == item.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        break;
                    };
                }
                else
                {
                    nutext = main.Game.ui.dropStack.getChildAt(i).cnt.strName.text;
                    nutext = nutext.substring(0, nutext.lastIndexOf(" x"));
                    if (nutext == item.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        break;
                    };
                };
                i++;
            };
        }

        public function onItemDelClick(e:MouseEvent):void
        {
            var item:Object;
            var val:*;
            var i:int;
            var nutext:String;
            item = MovieClip(e.currentTarget.parent).item;
            for (val in this.invTree)
            {
                if (this.invTree[val].ItemID == item.ItemID)
                {
                    this.itemCount[this.invTree[val].dID] = null;
                    this.invTree.splice(val, 1);
                };
            };
            i = 0;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                if (item.iStk == 1)
                {
                    if (main.Game.ui.dropStack.getChildAt(i).cnt.strName.text == item.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                }
                else
                {
                    nutext = main.Game.ui.dropStack.getChildAt(i).cnt.strName.text;
                    nutext = nutext.substring(0, nutext.lastIndexOf(" x"));
                    if (nutext == item.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                };
                i++;
            };
            this.fOpen();
        }

        public function buildMenu():void
        {
            var i:int;
            var o:Object;
            var mc:MovieClip;
            var item:Object;
            var s:String;
            var a:Array;
            var ok:Boolean;
            var list:Array;
            var j:int;
            i = 0;
            o = {};
            mc = (this as MovieClip);
            item = {};
            s = "";
            a = [];
            ok = true;
            i = 0;
            while (i < this.invTree.length)
            {
                ok = true;
                item = this.invTree[i];
                s = item.sType;
                if (!(s in o))
                {
                    o[s] = [];
                };
                a = o[s];
                j = 0;
                while (j < a.length)
                {
                    if (a[j].ItemID == item.ItemID)
                    {
                        ok = false;
                    };
                    j++;
                };
                if (ok)
                {
                    a.push(item);
                };
                i++;
            };
            for (s in o)
            {
                o[s].sortOn("sName");
            };
            this.fData = o;
            list = [];
            for (s in o)
            {
                list.push(s);
            };
            list.sort(this.rootClass.arraySort);
            this.buildItemList(list, "A", mc);
        }

        public function onMenuItemMouseOver(e:MouseEvent):void
        {
            var mc:MovieClip;
            var item:MovieClip;
            var i:int;
            mc = MovieClip(e.currentTarget);
            i = 1;
            while (i < mc.parent.numChildren)
            {
                item = MovieClip(mc.parent.getChildAt(i));
                if (item.bg.alpha < 0.4)
                {
                    item.bg.visible = false;
                };
                i++;
            };
            if (!mc.bg.visible)
            {
                mc.bg.visible = true;
                mc.bg.alpha = 0.33;
            };
        }

        public function buildItemList(list:Array, typ:String, par:MovieClip):void
        {
            var i:int;
            var mc:MovieClip;
            var lmc:MovieClip;
            var item:MovieClip;
            var itemC:Class;
            var s:String;
            var ok:Boolean;
            var w:int;
            var scr:MovieClip;
            var bMask:MovieClip;
            var display:MovieClip;
            i = 0;
            mc = (this as MovieClip);
            s = "";
            ok = true;
            w = 90;
            mc.cnt.visible = false;
            mc.preview.mcCoin.visible = false;
            mc.pMC.visible = false;
            mc.preview.t2.visible = false;
            mc.preview.bTry.visible = false;
            mc.preview.bAdd.visible = false;
            mc.preview.bDel.visible = false;
            mc.preview.tPreview.visible = false;
            if (typ == "A")
            {
                mc.iListB.visible = false;
                lmc = mc.iListA;
                this.destroyIList(lmc);
                lmc.par = par;
                i = 0;
                while (i < list.length)
                {
                    itemC = (lmc.iList.iproto.constructor as Class);
                    item = lmc.iList.addChild(new (itemC)());
                    item.ti.autoSize = "left";
                    item.ti.text = String(list[i]);
                    if (item.ti.textWidth > w)
                    {
                        w = int(item.ti.textWidth);
                    };
                    item.hit.alpha = 0;
                    item.typ = typ;
                    item.val = list[i];
                    item.iSel = false;
                    item.addEventListener(MouseEvent.CLICK, this.onMenuItemClick, false, 0, true);
                    item.addEventListener(MouseEvent.MOUSE_OVER, this.onMenuItemMouseOver, false, 0, true);
                    item.y = (lmc.iList.iproto.y + (i * 16));
                    item.bg.visible = false;
                    item.buttonMode = true;
                    i++;
                };
                lmc.iList.iproto.visible = false;
                lmc.iList.y = ((lmc.imask.height / 2) - (lmc.iList.height / 2));
            }
            else
            {
                if (typ == "B")
                {
                    mc.iListB.visible = true;
                    lmc = mc.iListB;
                    this.destroyIList(lmc);
                    lmc.par = par;
                    i = 0;
                    while (i < list.length)
                    {
                        itemC = (lmc.iList.iproto.constructor as Class);
                        item = lmc.iList.addChild(new (itemC)());
                        item.ti.autoSize = "left";
                        if (list[i].bUpg == 1)
                        {
                            if (list[i].iStk > 1)
                            {
                                item.ti.htmlText = (((("<font color='#FCC749'>" + String(list[i].sName)) + " x") + String(this.itemCount[list[i].dID])) + "</font>");
                            }
                            else
                            {
                                item.ti.htmlText = (("<font color='#FCC749'>" + String(list[i].sName)) + "</font>");
                            };
                        }
                        else
                        {
                            if (list[i].iStk > 1)
                            {
                                item.ti.text = ((String(list[i].sName) + " x") + String(this.itemCount[list[i].dID]));
                            }
                            else
                            {
                                item.ti.text = String(list[i].sName);
                            };
                        };
                        if (item.ti.textWidth > w)
                        {
                            w = int(item.ti.textWidth);
                        };
                        item.hit.alpha = 0;
                        item.typ = typ;
                        item.val = list[i];
                        item.iSel = false;
                        item.addEventListener(MouseEvent.CLICK, this.onMenuItemClick, false, 0, true);
                        item.addEventListener(MouseEvent.MOUSE_OVER, this.onMenuItemMouseOver, false, 0, true);
                        item.y = (lmc.iList.iproto.y + (i * 16));
                        item.bg.visible = (item.val.bEquip == 1);
                        item.buttonMode = true;
                        i++;
                    };
                    lmc.iList.iproto.visible = false;
                    lmc.x = ((lmc.par.x + lmc.par.width) + 1);
                    lmc.iList.y = ((lmc.imask.height / 2) - (lmc.iList.height / 2));
                };
            };
            w = (w + 7);
            i = 1;
            while (i < lmc.iList.numChildren)
            {
                item = (lmc.iList.getChildAt(i) as MovieClip);
                item.bg.width = w;
                item.hit.width = w;
                i++;
            };
            scr = lmc.scr;
            bMask = lmc.imask;
            display = lmc.iList;
            scr.h.y = 0;
            scr.visible = false;
            scr.hit.alpha = 0;
            scr.mDown = false;
            if (display.height > scr.b.height)
            {
                scr.h.height = int(((scr.b.height / display.height) * scr.b.height));
                this.hRun = (scr.b.height - scr.h.height);
                this.dRun = ((display.height - scr.b.height) + 10);
                display.oy = (display.y = bMask.y);
                scr.visible = true;
                scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                display.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
            }
            else
            {
                scr.hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.scrDown);
                scr.h.removeEventListener(Event.ENTER_FRAME, this.hEF);
                display.removeEventListener(Event.ENTER_FRAME, this.dEF);
            };
            lmc.imask.width = (w - 1);
            lmc.divider.x = w;
            lmc.scr.x = w;
            if (lmc.scr.visible)
            {
                lmc.w = (w + lmc.scr.width);
            }
            else
            {
                lmc.w = (w + 1);
            };
            this.resizeMe();
        }


    }
}//package net.spider.handlers

