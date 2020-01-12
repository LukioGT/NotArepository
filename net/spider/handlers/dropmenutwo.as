// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.handlers.dropmenutwo

package net.spider.handlers
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.spider.main;
    import flash.events.Event;
    import flash.utils.getQualifiedClassName;
    import com.adobe.utils.StringUtil;
    import net.spider.draw.dEntry;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import flash.ui.*;

    public class dropmenutwo extends MovieClip 
    {

        public var menuBar:MovieClip;
        public var menu:MovieClip;
        public var txtQty:TextField;
        internal var itemCount:Object;
        internal var invTree:Array;

        public function dropmenutwo()
        {
            this.visible = false;
            this.itemCount = {};
            this.invTree = new Array();
            this.menu.visible = false;
            this.txtQty.mouseEnabled = false;
            this.menuBar.addEventListener(MouseEvent.CLICK, this.onToggleMenu);
            this.menuBar.addEventListener(MouseEvent.MOUSE_DOWN, this.onHold, false);
            this.menuBar.addEventListener(MouseEvent.MOUSE_UP, this.onMouseRelease, false);
            var pos:* = main.sharedObject.data.dmtPos;
            if (pos)
            {
                this.x = pos.x;
                this.y = pos.y;
            };
            this.visible = false;
            main.Game.sfc.addEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseHandler, false, 0, true);
            main._stage.addEventListener(Event.ENTER_FRAME, this.onDropFrame, false, 0, true);
        }

        public function onShow():void
        {
            this.visible = (!(this.visible));
        }

        private function onHold(e:MouseEvent):void
        {
            this.startDrag();
        }

        private function onMouseRelease(e:MouseEvent):void
        {
            this.stopDrag();
            main.sharedObject.data.dmtPos = {
                "x":this.x,
                "y":this.y
            };
            main.sharedObject.flush();
        }

        public function onUpdate():*
        {
            this.itemCount = {};
            this.invTree = new Array();
            this.reDraw();
        }

        public function onBtNo(e:*):void
        {
            var val:*;
            var i:int;
            var nutext:String;
            for (val in this.invTree)
            {
                if (this.invTree[val].ItemID == e.ItemID)
                {
                    this.itemCount[this.invTree[val].dID] = null;
                    this.invTree.splice(val, 1);
                };
            };
            i = 0;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                if (e.iStk == 1)
                {
                    if (main.Game.ui.dropStack.getChildAt(i).cnt.strName.text == e.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                }
                else
                {
                    nutext = main.Game.ui.dropStack.getChildAt(i).cnt.strName.text;
                    nutext = nutext.substring(0, nutext.lastIndexOf(" x"));
                    if (nutext == e.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                };
                i++;
            };
            this.reDraw();
        }

        public function onToggleMenu(e:MouseEvent):void
        {
            this.menu.visible = (!(this.menu.visible));
            if (this.menu.visible)
            {
                this.reDraw();
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
                    if (getQualifiedClassName((main.Game.ui.dropStack.getChildAt(i) as MovieClip)).indexOf("DFrame2MC") > -1)
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
                        };
                        this.reDraw();
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
                                };
                            };
                        };
                        this.reDraw();
                        break;
                };
            };
        }

        public function reDraw():void
        {
            var item:*;
            var dropItemGet:*;
            var qtyCtr:int;
            while (this.menu.numChildren > 1)
            {
                this.menu.removeChildAt(1);
            };
            var ctr:int;
            for each (item in this.invTree)
            {
                dropItemGet = new dEntry(item, this.itemCount[item.dID]);
                if (optionHandler.filterChecks["chkInvertDrop"])
                {
                    dropItemGet.x = 2;
                    dropItemGet.y = (161 + (21.5 * ctr));
                }
                else
                {
                    dropItemGet.x = 2;
                    dropItemGet.y = (108 - (21.5 * ctr));
                };
                dropItemGet.name = item.sName;
                this.menu.addChild(dropItemGet);
                qtyCtr = (qtyCtr + this.itemCount[item.dID]);
                ctr++;
            };
            this.txtQty.text = (" x " + qtyCtr);
            if (optionHandler.filterChecks["chkInvertDrop"])
            {
                this.menu.menuBG.y = 158;
                this.menu.menuBG.height = ((21.5 * ctr) + 6);
            }
            else
            {
                this.menu.menuBG.y = ((108 - (21.5 * (ctr - 1))) - 3);
                this.menu.menuBG.height = ((21.5 * ctr) + 6);
            };
        }


    }
}//package net.spider.handlers

