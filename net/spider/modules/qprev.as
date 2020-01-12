// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.qprev

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.main;
    import net.spider.handlers.optionHandler;
    import flash.events.MouseEvent;
    import net.spider.draw.dRender;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class qprev extends MovieClip 
    {

        public static var frame:*;
        public static var itemUI:*;


        public static function onFrameUpdate():void
        {
            if (((!(optionHandler.qPrev)) || (!(main.Game.sfc.isConnected))))
            {
                return;
            };
            if (main.Game.ui.ModalStack.numChildren)
            {
                frame = main.Game.ui.ModalStack.getChildAt(0);
                if (frame.cnt.core)
                {
                    if (frame.cnt.core.rewardsStatic)
                    {
                        establishRender(frame.cnt.core.rewardsStatic);
                    };
                    if (frame.cnt.core.rewardsRoll)
                    {
                        establishRender(frame.cnt.core.rewardsRoll);
                    };
                    if (frame.cnt.core.rewardsChoice)
                    {
                        establishRender(frame.cnt.core.rewardsChoice);
                    };
                    if (frame.cnt.core.rewardsRandom)
                    {
                        establishRender(frame.cnt.core.rewardsRandom);
                    };
                };
            };
        }

        public static function establishRender(core:*):void
        {
            var s:*;
            var j:*;
            var k:*;
            var i:* = 1;
            while (i < core.numChildren)
            {
                itemUI = core.getChildAt(i);
                if (itemUI.hasEventListener(MouseEvent.CLICK))
                {
                }
                else
                {
                    _loop_1:
                    for each (s in frame.qData.reward)
                    {
                        if (s["ItemID"] == itemUI.ItemID)
                        {
                            for each (j in frame.qData.oRewards)
                            {
                                for each (k in j)
                                {
                                    if (k.ItemID == s["ItemID"])
                                    {
                                        itemUI.addEventListener(MouseEvent.CLICK, onQuestItemRender(k), false, 0, true);
                                        break _loop_1;
                                    };
                                };
                            };
                        };
                    };
                };
                i++;
            };
        }

        public static function onQuestItemRender(item:Object):Function
        {
            return (function (e:MouseEvent):void
            {
                if (main.Game.ui.getChildByName("renderPreview"))
                {
                    main.Game.ui.removeChild(main.Game.ui.getChildByName("renderPreview"));
                };
                var dRenderObj:* = new dRender(item);
                dRenderObj.name = "renderPreview";
                main.Game.ui.addChild(dRenderObj);
            });
        }


    }
}//package net.spider.modules

