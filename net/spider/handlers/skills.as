// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.handlers.skills

package net.spider.handlers
{
    import flash.display.MovieClip;
    import net.spider.draw.ToolTipMC;
    import net.spider.main;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.display.DisplayObject;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.geom.ColorTransform;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import net.spider.modules.*;
    import flash.ui.*;

    public class skills extends MovieClip 
    {

        public var toolTip:ToolTipMC;
        public var eventInitialized:Boolean = false;
        public var lastSkill:Object;
        public var icons:Object;
        public var scalar:Number = 0.6;
        internal var iconPriority:Array;
        public var auras:Object;

        public function skills()
        {
            var i:*;
            var auraUI:MovieClip;
            var j:*;
            super();
            this.visible = false;
            if (this.toolTip == null)
            {
                this.toolTip = new ToolTipMC();
                main._stage.addChild(this.toolTip);
            };
            if (optionHandler.skill)
            {
                this.auras = new Object();
                if (main.Game.ui)
                {
                    if (!this.eventInitialized)
                    {
                        i = 2;
                        while (i < 6)
                        {
                            main.Game.ui.mcInterface.actBar.getChildByName(("i" + i)).addEventListener(MouseEvent.CLICK, this.actIconClick, false, 0, true);
                            i++;
                        };
                        this.eventInitialized = true;
                    };
                    if (!main.Game.ui.mcPortrait.getChildByName("auraUI"))
                    {
                        auraUI = main.Game.ui.mcPortrait.addChild(new MovieClip());
                        auraUI.name = "auraUI";
                        auraUI.x = 86;
                        auraUI.y = 82;
                        main.Game.ui.mcPortrait.getChildByName("auraUI").addEventListener(MouseEvent.MOUSE_DOWN, this.onHold, false, 0, true);
                        main.Game.ui.mcPortrait.getChildByName("auraUI").addEventListener(MouseEvent.MOUSE_UP, this.onMouseRelease, false, 0, true);
                    };
                };
                main._stage.addEventListener(KeyboardEvent.KEY_UP, this.key_actBar, false, 0, true);
                main.Game.sfc.addEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseHandler, false, 0, true);
            }
            else
            {
                main._stage.removeEventListener(KeyboardEvent.KEY_UP, this.key_actBar);
                main.Game.sfc.removeEventListener(SFSEvent.onExtensionResponse, this.onExtensionResponseHandler);
                if (this.eventInitialized)
                {
                    j = 2;
                    while (j < 6)
                    {
                        main.Game.ui.mcInterface.actBar.getChildByName(("i" + j)).removeEventListener(MouseEvent.CLICK, this.actIconClick);
                        j++;
                    };
                    this.eventInitialized = false;
                };
                this.auras = null;
                this.toolTip.close();
            };
        }

        public function actIconClick(e:*):void
        {
            this.lastSkill = MovieClip(e.currentTarget).actObj;
        }

        public function key_actBar(param1:KeyboardEvent):*
        {
            if (((main._stage.focus == null) || ((!(main._stage.focus == null)) && (!("text" in main._stage.focus)))))
            {
                if (((param1.charCode > 49) && (param1.charCode < 55)))
                {
                    switch (param1.charCode)
                    {
                        case 50:
                            this.lastSkill = main.Game.world.actions.active[1];
                            break;
                        case 51:
                            this.lastSkill = main.Game.world.actions.active[2];
                            break;
                        case 52:
                            this.lastSkill = main.Game.world.actions.active[3];
                            break;
                        case 53:
                            this.lastSkill = main.Game.world.actions.active[4];
                            break;
                    };
                };
            };
        }

        public function createIconMC(auraName:String, auraStacks:Number, isEnemy:Boolean):void
        {
            var icon:Class;
            var ico:MovieClip;
            var skillIcon:Class;
            var base:MovieClip;
            var visual:MovieClip;
            if (this.icons == null)
            {
                this.icons = new Object();
                this.iconPriority = new Array();
            };
            if (!this.icons.hasOwnProperty(auraName))
            {
                if (!isEnemy)
                {
                    if (this.lastSkill.icon.indexOf(",") > -1)
                    {
                        icon = (main.Game.world.getClass(this.lastSkill.icon.split(",")[(this.lastSkill.icon.split(",").length - 1)]) as Class);
                    }
                    else
                    {
                        icon = (main.Game.world.getClass(this.lastSkill.icon) as Class);
                    };
                }
                else
                {
                    icon = (main.Game.world.getClass("isp2") as Class);
                };
                ico = new (icon)();
                skillIcon = (main.gameDomain.getDefinition("ib2") as Class);
                base = new (skillIcon)();
                this.icons[auraName] = main.Game.ui.mcPortrait.getChildByName("auraUI").addChild(base);
                this.icons[auraName].auraName = auraName;
                this.icons[auraName].width = 42;
                this.icons[auraName].height = 39;
                this.icons[auraName].icon2 = null;
                this.icons[auraName].cnt.removeChildAt(0);
                this.icons[auraName].scaleX = this.scalar;
                this.icons[auraName].scaleY = this.scalar;
                this.icons[auraName].tQty.visible = false;
                visual = this.icons[auraName].cnt.addChild(ico);
                if (visual.width > visual.height)
                {
                    visual.scaleX = (visual.scaleY = (34 / visual.width));
                }
                else
                {
                    visual.scaleX = (visual.scaleY = (31 / visual.height));
                };
                visual.x = ((this.icons[auraName].bg.width / 2) - (visual.width / 2));
                visual.y = ((this.icons[auraName].bg.height / 2) - (visual.height / 2));
                this.icons[auraName].mouseChildren = false;
                this.icons[auraName].addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
                this.icons[auraName].addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
                this.iconPriority.push(auraName);
            };
            this.icons[auraName].auraStacks = auraStacks;
        }

        public function onOver(e:MouseEvent):void
        {
            this.toolTip.openWith({"str":(((e.target.auraName + " (") + e.target.auraStacks) + ")")});
        }

        public function onOut(e:MouseEvent):*
        {
            this.toolTip.close();
        }

        public function rearrangeIconMC():void
        {
            var nextRow:Number = 0;
            var rowCtr:Number = 0;
            var i:int;
            while (i < this.iconPriority.length)
            {
                if (((!(i == 0)) && ((i % 4) == 0)))
                {
                    nextRow = (nextRow + 28);
                    rowCtr++;
                };
                this.icons[this.iconPriority[i]].x = ((32 * (i - (4 * rowCtr))) + 3);
                this.icons[this.iconPriority[i]].y = nextRow;
                i++;
            };
        }

        public function onExtensionResponseHandler(e:*):void
        {
            var date:Date;
            var aura:*;
            var resObj:*;
            var cmd:*;
            var i:*;
            var j:*;
            var a:*;
            var b:*;
            var auraUI:MovieClip;
            var k:*;
            var protocol:* = e.params.type;
            if (protocol == "json")
            {
                resObj = e.params.dataObj;
                cmd = resObj.cmd;
                switch (cmd)
                {
                    case "ct":
                        if (resObj.a == null)
                        {
                            return;
                        };
                        for each (i in resObj.a)
                        {
                            if (i.tInf.indexOf("p") == -1)
                            {
                            }
                            else
                            {
                                if (i.tInf.substring(2) != main.Game.sfc.myUserId)
                                {
                                }
                                else
                                {
                                    if (i.auras)
                                    {
                                        for each (j in i.auras)
                                        {
                                            if (i.cmd.indexOf("+") > -1)
                                            {
                                                if (!this.auras.hasOwnProperty(j.nam))
                                                {
                                                    this.auras[j.nam] = 1;
                                                    this.createIconMC(j.nam, 1, (!(i.cInf.substring(2) == main.Game.sfc.myUserId)));
                                                    this.coolDownAct(this.icons[j.nam], (j.dur * 1000), new Date().getTime());
                                                }
                                                else
                                                {
                                                    this.auras[j.nam] = (this.auras[j.nam] + 1);
                                                    for each (a in main.Game.world.myAvatar.dataLeaf.auras)
                                                    {
                                                        if (a.nam == j.nam)
                                                        {
                                                            a.ts = j.ts;
                                                            this.createIconMC(j.nam, this.auras[j.nam], (!(i.cInf.substring(2) == main.Game.sfc.myUserId)));
                                                            this.coolDownAct(this.icons[j.nam], (j.dur * 1000), a.ts);
                                                            break;
                                                        };
                                                    };
                                                };
                                            }
                                            else
                                            {
                                                if (i.cmd.indexOf("-") > -1)
                                                {
                                                    this.auras[j.nam] = null;
                                                };
                                            };
                                        };
                                    }
                                    else
                                    {
                                        if (i.cmd.indexOf("+") > -1)
                                        {
                                            if (!this.auras.hasOwnProperty(i.aura.nam))
                                            {
                                                this.auras[i.aura.nam] = 1;
                                                this.createIconMC(i.aura.nam, 1, (!(i.cInf.substring(2) == main.Game.sfc.myUserId)));
                                                this.coolDownAct(this.icons[i.aura.nam], (i.aura.dur * 1000), new Date().getTime());
                                            }
                                            else
                                            {
                                                this.auras[i.aura.nam] = (this.auras[i.aura.nam] + 1);
                                                for each (b in main.Game.world.myAvatar.dataLeaf.auras)
                                                {
                                                    if (b.nam == i.aura.nam)
                                                    {
                                                        b.ts = i.aura.ts;
                                                        this.auras[i.aura.nam] = 1;
                                                        this.createIconMC(i.aura.nam, this.auras[i.aura.nam], (!(i.cInf.substring(2) == main.Game.sfc.myUserId)));
                                                        this.coolDownAct(this.icons[i.aura.nam], (i.aura.dur * 1000), b.ts);
                                                        break;
                                                    };
                                                };
                                            };
                                        }
                                        else
                                        {
                                            if (i.cmd.indexOf("-") > -1)
                                            {
                                                this.auras[i.aura.nam] = null;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        this.lastSkill = main.Game.world.actions.active[0];
                        break;
                    case "sAct":
                        if (!main.Game.ui.mcPortrait.getChildByName("auraUI"))
                        {
                            auraUI = main.Game.ui.mcPortrait.addChild(new MovieClip());
                            auraUI.name = "auraUI";
                            auraUI.x = 86;
                            auraUI.y = 82;
                            main.Game.ui.mcPortrait.getChildByName("auraUI").addEventListener(MouseEvent.MOUSE_DOWN, this.onHold, false, 0, true);
                            main.Game.ui.mcPortrait.getChildByName("auraUI").addEventListener(MouseEvent.MOUSE_UP, this.onMouseRelease, false, 0, true);
                        };
                        if (!this.eventInitialized)
                        {
                            k = 2;
                            while (k < 6)
                            {
                                main.Game.ui.mcInterface.actBar.getChildByName(("i" + k)).addEventListener(MouseEvent.CLICK, this.actIconClick, false, 0, true);
                                k++;
                            };
                            this.lastSkill = main.Game.world.actions.active[0];
                            this.eventInitialized = true;
                        };
                        break;
                };
            };
        }

        public function coolDownAct(actIcon:*, cd:int=-1, ts:Number=127):*
        {
            var icon1:MovieClip;
            var j:int;
            var icon2:*;
            var iMask:MovieClip;
            var bmd:*;
            var bm:*;
            var k:int;
            var iconF:DisplayObject;
            var stackQty:TextField;
            var tf:TextFormat;
            var ActMask:Class = (main.gameDomain.getDefinition("ActMask") as Class);
            var iconCT:ColorTransform = new ColorTransform(0.5, 0.5, 0.5, 1, -50, -50, -50, 0);
            icon1 = actIcon;
            icon2 = null;
            iMask = null;
            if (icon1.icon2 == null)
            {
                bmd = new BitmapData(50, 50, true, 0);
                bmd.draw(icon1, null, iconCT);
                bm = new Bitmap(bmd);
                icon2 = actIcon.addChild(bm);
                icon1.icon2 = icon2;
                icon2.transform = icon1.transform;
                icon2.scaleX = 1;
                icon2.scaleY = 1;
                icon1.ts = ts;
                icon1.cd = cd;
                icon1.auraName = icon1.auraName;
                iMask = (actIcon.addChild(new (ActMask)()) as MovieClip);
                iMask.scaleX = 0.33;
                iMask.scaleY = 0.33;
                iMask.x = int(((icon2.x + (icon2.width / 2)) - (iMask.width / 2)));
                iMask.y = int(((icon2.y + (icon2.height / 2)) - (iMask.height / 2)));
                k = 0;
                while (k < 4)
                {
                    iMask[(("e" + k) + "oy")] = iMask[("e" + k)].y;
                    k++;
                };
                icon2.mask = iMask;
                stackQty = new TextField();
                tf = new TextFormat();
                tf.size = 12;
                tf.bold = true;
                tf.font = "Arial";
                tf.color = 0xFFFFFF;
                stackQty.defaultTextFormat = tf;
                icon1.stacks = icon1.addChild(stackQty);
                icon1.stacks.x = 32;
                icon1.stacks.y = 27;
                icon1.stacks.mouseEnabled = false;
            }
            else
            {
                icon2 = icon1.icon2;
                iMask = icon2.mask;
                icon1.ts = ts;
                icon1.cd = cd;
                icon1.auraName = icon1.auraName;
            };
            icon1.stacks.text = icon1.auraStacks;
            iMask.e0.stop();
            iMask.e1.stop();
            iMask.e2.stop();
            iMask.e3.stop();
            icon1.removeEventListener(Event.ENTER_FRAME, this.countDownAct);
            icon1.addEventListener(Event.ENTER_FRAME, this.countDownAct, false, 0, true);
            this.rearrangeIconMC();
        }

        public function countDownAct(e:Event):void
        {
            var dat:*;
            var ti:*;
            var ct1:*;
            var ct2:*;
            var cd:*;
            var tp:*;
            var mc:*;
            var fr:*;
            var i:*;
            var iMask:*;
            dat = new Date();
            ti = dat.getTime();
            ct1 = MovieClip(e.target);
            ct2 = ct1.icon2;
            cd = (ct1.cd + 350);
            tp = ((ti - ct1.ts) / cd);
            mc = Math.floor((tp * 4));
            fr = (int(((tp * 360) % 90)) + 1);
            if (this.auras[ct1.auraName] == null)
            {
                tp = 1;
            };
            if (tp < 0.99)
            {
                i = 0;
                while (i < 4)
                {
                    if (i < mc)
                    {
                        ct2.mask[("e" + i)].y = -300;
                    }
                    else
                    {
                        ct2.mask[("e" + i)].y = ct2.mask[(("e" + i) + "oy")];
                        if (i > mc)
                        {
                            ct2.mask[("e" + i)].gotoAndStop(0);
                        };
                    };
                    i++;
                };
                MovieClip(ct2.mask[("e" + mc)]).gotoAndStop(fr);
            }
            else
            {
                iMask = ct2.mask;
                ct2.mask = null;
                ct2.parent.removeChild(iMask);
                ct1.removeEventListener(Event.ENTER_FRAME, this.countDownAct);
                this.icons[ct1.auraName].removeEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                this.icons[ct1.auraName].removeEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                main.Game.ui.mcPortrait.getChildByName("auraUI").stopDrag();
                this.toolTip.close();
                ct2.parent.removeChild(ct2);
                ct2.bitmapData.dispose();
                ct1.icon2 = null;
                main.Game.ui.mcPortrait.getChildByName("auraUI").removeChild(this.icons[ct1.auraName]);
                this.iconPriority.splice(this.iconPriority.indexOf(ct1.auraName), 1);
                delete this.icons[ct1.auraName];
                this.rearrangeIconMC();
            };
        }

        private function onHold(e:MouseEvent):void
        {
            main.Game.ui.mcPortrait.getChildByName("auraUI").startDrag();
        }

        private function onMouseRelease(e:MouseEvent):void
        {
            main.Game.ui.mcPortrait.getChildByName("auraUI").stopDrag();
        }


    }
}//package net.spider.handlers

