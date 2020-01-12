// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.handlers.boosts

package net.spider.handlers
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.spider.main;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import net.spider.modules.*;
    import flash.ui.*;

    public class boosts extends MovieClip 
    {

        private static var runOnce:Boolean = false;

        public var activesTxt:TextField;
        public var titleBar:TextField;
        public var head:MovieClip;
        public var back:MovieClip;


        public static function onTimerUpdate():void
        {
            var pItem:*;
            var nuDesc:String;
            if (((!(optionHandler.boost)) || (!(main.Game.sfc.isConnected))))
            {
                return;
            };
            if (!main.Game.world.myAvatar)
            {
                return;
            };
            if (!main.Game.world.myAvatar.items)
            {
                return;
            };
            if (((!(flags.isInventory())) && (runOnce)))
            {
                runOnce = false;
            };
            if (((flags.isInventory()) && (!(runOnce))))
            {
                for each (pItem in main.Game.world.myAvatar.items)
                {
                    if (!pItem.oldDesc)
                    {
                        pItem.oldDesc = pItem.sDesc;
                    };
                    nuDesc = "";
                    if (pItem.sMeta)
                    {
                        nuDesc = (("sMeta: " + pItem.sMeta) + "\n");
                    };
                    pItem.sDesc = ((((((nuDesc + "Stacks: ") + pItem.iQty) + "/") + pItem.iStk) + "\n") + pItem.oldDesc);
                    nuDesc = null;
                };
                runOnce = true;
            };
        }


    }
}//package net.spider.handlers

