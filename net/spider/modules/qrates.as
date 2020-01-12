// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.qrates

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.main;
    import net.spider.handlers.optionHandler;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class qrates extends MovieClip 
    {

        public static var doneOnce:Boolean = false;


        public static function onFrameUpdate():void
        {
            var frame:*;
            var i:Number;
            var rItem:*;
            var s:*;
            if (((!(optionHandler.qRates)) || (!(main.Game.sfc.isConnected))))
            {
                return;
            };
            if (main.Game.ui.ModalStack.numChildren)
            {
                frame = main.Game.ui.ModalStack.getChildAt(0);
                if (frame.cnt.core)
                {
                    if (!frame.cnt.core.rewardsRoll)
                    {
                        return;
                    };
                    i = 1;
                    while (i < frame.cnt.core.rewardsRoll.numChildren)
                    {
                        rItem = frame.cnt.core.rewardsRoll.getChildAt(i);
                        if (rItem.strType.text.indexOf("%") >= 0)
                        {
                        }
                        else
                        {
                            for each (s in frame.qData.reward)
                            {
                                if (s["ItemID"] == rItem.ItemID)
                                {
                                    if (rItem.strQ.visible)
                                    {
                                        if (s["iQty"].toString() != rItem.strQ.text.substring(1))
                                        {
                                            continue;
                                        };
                                    };
                                    rItem.strType.text = (rItem.strType.text + ((" (" + s["iRate"]) + "%)"));
                                    rItem.strType.width = 100;
                                    rItem.strRate.visible = false;
                                    break;
                                };
                            };
                        };
                        i++;
                    };
                };
            };
        }


    }
}//package net.spider.modules

