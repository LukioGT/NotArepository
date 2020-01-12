// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.detaildrops

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.text.TextFormat;
    import flash.utils.getQualifiedClassName;
    import flash.filters.GlowFilter;
    import net.spider.draw.dRender;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import net.spider.draw.*;
    import flash.ui.*;
    import flash.filters.*;

    public class detaildrops extends MovieClip 
    {

        public static var itemArchive:Array;


        public static function onToggle():void
        {
            if (optionHandler.detaildrop)
            {
                itemArchive = new Array();
            }
            else
            {
                itemArchive = null;
            };
        }

        public static function onExtensionResponseHandler(e:*):void
        {
            var dID:*;
            var resObj:*;
            var cmd:*;
            if (!optionHandler.detaildrop)
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
                    case "dropItem":
                        for (dID in resObj.items)
                        {
                            if (itemArchive[dID] == null)
                            {
                                itemArchive.push(main.Game.copyObj(resObj.items[dID]));
                            };
                        };
                        break;
                };
            };
        }

        public static function onFrameUpdate():void
        {
            var mcDrop:* = undefined;
            var sName:String;
            var item:* = undefined;
            var flag:mcCoin;
            var glowFilter:* = undefined;
            var txtFormat:TextFormat;
            if ((((!(optionHandler.detaildrop)) || (!(main.Game.sfc.isConnected))) || (main.Game.ui.dropStack.numChildren < 1)))
            {
                return;
            };
            var i:int;
            for (;i < main.Game.ui.dropStack.numChildren;(i = (i + 1)))
            {
                try
                {
                    mcDrop = (main.Game.ui.dropStack.getChildAt(i) as MovieClip);
                    if (getQualifiedClassName(mcDrop) != "DFrame2MC")
                    {
                        continue;
                    };
                    if (!mcDrop.cnt.bg.getChildByName("flag"))
                    {
                        sName = mcDrop.cnt.strName.text.replace(/ x[0-9]/g, "");
                        for each (item in itemArchive)
                        {
                            if (item.sName == sName)
                            {
                                if (item.bCoins == 1)
                                {
                                    glowFilter = new GlowFilter(16173610, 1, 8, 8, 2, 1, false, false);
                                    mcDrop.filters = [glowFilter];
                                };
                                if (item.bUpg)
                                {
                                    txtFormat = mcDrop.cnt.strName.defaultTextFormat;
                                    txtFormat.color = 16566089;
                                    mcDrop.cnt.strName.setTextFormat(txtFormat);
                                };
                                flag = new mcCoin();
                                flag.visible = false;
                                flag.name = "flag";
                                mcDrop.cnt.bg.addChild(flag);
                            };
                        };
                    };
                }
                catch(exception)
                {
                    trace(("Error handling drops: " + exception));
                };
            };
        }

        public static function onPreview(itemObj:*):Function
        {
            return (function (e:MouseEvent):void
            {
                if (main.Game.ui.getChildByName("renderPreview"))
                {
                    main.Game.ui.removeChild(main.Game.ui.getChildByName("renderPreview"));
                };
                var dRenderObj:* = new dRender(itemObj);
                dRenderObj.name = "renderPreview";
                main.Game.ui.addChild(dRenderObj);
            });
        }


    }
}//package net.spider.modules

