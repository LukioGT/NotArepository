// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.dEntry

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import net.spider.main;
    import flash.events.MouseEvent;
    import net.spider.handlers.optionHandler;
    import flash.text.*;

    public class dEntry extends MovieClip 
    {

        public var btPreview:SimpleButton;
        public var icon:MovieClip;
        public var overEntryBar:MovieClip;
        public var btNo:SimpleButton;
        public var txtDrop:TextField;
        public var iconAC:MovieClip;
        public var btYes:SimpleButton;
        public var entryBar:MovieClip;
        public var itemObj:Object;
        internal var format:TextFormat = new TextFormat();

        public function dEntry(resObj:Object, relQty:int):void
        {
            var AssetClass:Class;
            var mcIcon:* = undefined;
            super();
            this.gotoAndStop("idle");
            this.btYes.visible = false;
            this.btNo.visible = false;
            this.btPreview.visible = false;
            this.itemObj = resObj;
            this.iconAC.visible = (resObj.bCoins == 1);
            this.txtDrop.text = "";
            this.txtDrop.htmlText = "";
            if (resObj.bUpg == 1)
            {
                this.txtDrop.htmlText = (((("<font color='#FCC749'>" + resObj.sName) + " x ") + relQty) + "</font>");
            }
            else
            {
                this.txtDrop.text = ((resObj.sName + " x ") + relQty);
            };
            if (this.iconAC.visible)
            {
                this.iconAC.x = (this.txtDrop.textWidth + 35);
            };
            var sIcon:String = "";
            if (resObj.sType.toLowerCase() == "enhancement")
            {
                sIcon = main.Game.getIconBySlot(resObj.sES);
            }
            else
            {
                if (((resObj.sType.toLowerCase() == "serveruse") || (resObj.sType.toLowerCase() == "clientuse")))
                {
                    if (((("sFile" in resObj) && (resObj.sFile.length > 0)) && (!(main.Game.world.getClass(resObj.sFile) == null))))
                    {
                        sIcon = resObj.sFile;
                    }
                    else
                    {
                        sIcon = resObj.sIcon;
                    };
                }
                else
                {
                    if ((((resObj.sIcon == null) || (resObj.sIcon == "")) || (resObj.sIcon == "none")))
                    {
                        if (resObj.sLink.toLowerCase() != "none")
                        {
                            sIcon = "iidesign";
                        }
                        else
                        {
                            sIcon = "iibag";
                        };
                    }
                    else
                    {
                        sIcon = resObj.sIcon;
                    };
                };
            };
            try
            {
                AssetClass = (main.Game.world.getClass(sIcon) as Class);
                mcIcon = this.icon.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
                AssetClass = (main.Game.world.getClass("iibag") as Class);
                mcIcon = this.icon.addChild(new (AssetClass)());
            };
            mcIcon.scaleX = (mcIcon.scaleY = 0.4);
            this.addEventListener(MouseEvent.ROLL_OVER, this.onHighlight, false, 0, true);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onDeHighlight, false, 0, true);
            this.btYes.addEventListener(MouseEvent.CLICK, this.onBtYes, false, 0, true);
            this.btNo.addEventListener(MouseEvent.CLICK, this.onBtNo, false, 0, true);
            this.btPreview.addEventListener(MouseEvent.CLICK, this.onBtPreview, false, 0, true);
        }

        internal function updateFormat(size:int):void
        {
            this.format.size = size;
            this.txtDrop.setTextFormat(this.format);
        }

        internal function onBtYes(e:MouseEvent):void
        {
            var nutext:String;
            var i:int;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                if (this.itemObj.iStk == 1)
                {
                    if (main.Game.ui.dropStack.getChildAt(i).cnt.strName.text == this.itemObj.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        break;
                    };
                }
                else
                {
                    nutext = main.Game.ui.dropStack.getChildAt(i).cnt.strName.text;
                    nutext = nutext.substring(0, nutext.lastIndexOf(" x"));
                    if (nutext == this.itemObj.sName)
                    {
                        main.Game.ui.dropStack.getChildAt(i).cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        break;
                    };
                };
                i++;
            };
        }

        internal function onBtNo(e:MouseEvent):void
        {
            optionHandler.dropmenutwoMC.onBtNo(this.itemObj);
        }

        internal function onBtPreview(e:MouseEvent):void
        {
            if (main.Game.ui.getChildByName("renderPreview"))
            {
                main.Game.ui.removeChild(main.Game.ui.getChildByName("renderPreview"));
            };
            var dRenderObj:* = new dRender(this.itemObj);
            dRenderObj.name = "renderPreview";
            main.Game.ui.addChild(dRenderObj);
        }

        internal function onHighlight(e:MouseEvent):void
        {
            this.gotoAndStop("hover");
            this.btYes.visible = true;
            this.btNo.visible = true;
            this.btPreview.visible = true;
        }

        internal function onDeHighlight(e:MouseEvent):void
        {
            this.gotoAndStop("idle");
            this.btYes.visible = false;
            this.btNo.visible = false;
            this.btPreview.visible = false;
        }


    }
}//package net.spider.draw

