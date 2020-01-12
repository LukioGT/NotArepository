// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.drops

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class drops extends MovieClip 
    {

        internal static var incr:int = 0;


        public static function onExtensionResponseHandler(e:*):void
        {
            var dID:*;
            var resObj:*;
            var cmd:*;
            var itemA:MovieClip;
            var itemB:MovieClip;
            var i:*;
            if (!optionHandler.draggable)
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
                        if (main.Game.ui.dropStack.numChildren <= 2)
                        {
                            return;
                        };
                        i = (main.Game.ui.dropStack.numChildren - 2);
                        while (i > -1)
                        {
                            itemA = (main.Game.ui.dropStack.getChildAt(i) as MovieClip);
                            itemB = (main.Game.ui.dropStack.getChildAt((i + 1)) as MovieClip);
                            itemA.fY = (itemA.y = (itemB.fY - (itemB.fHeight + 8)));
                            itemB.fX = (main.Game.ui.dropStack.getChildAt(0) as MovieClip).fX;
                            itemB.x = (main.Game.ui.dropStack.getChildAt(0) as MovieClip).x;
                            i--;
                        };
                        break;
                };
            };
        }

        public static function onFrameUpdate():void
        {
            var mcDrop:* = undefined;
            if ((((!(optionHandler.draggable)) || (!(main.Game.sfc.isConnected))) || (main.Game.ui.dropStack.numChildren < 1)))
            {
                return;
            };
            var i:int;
            while (i < main.Game.ui.dropStack.numChildren)
            {
                try
                {
                    mcDrop = (main.Game.ui.dropStack.getChildAt(i) as MovieClip);
                    if (!mcDrop.hasEventListener(MouseEvent.MOUSE_DOWN))
                    {
                        mcDrop.addEventListener(MouseEvent.MOUSE_DOWN, drops.startDrag, false, 0, true);
                        mcDrop.addEventListener(MouseEvent.MOUSE_UP, drops.stopDrag, false, 0, true);
                    };
                }
                catch(exception)
                {
                    trace(("Error handling drops: " + exception));
                };
                i = (i + 1);
            };
        }

        private static function startDrag(e:MouseEvent):void
        {
            e.currentTarget.startDrag();
        }

        private static function stopDrag(e:MouseEvent):void
        {
            e.currentTarget.stopDrag();
        }


    }
}//package net.spider.modules

