// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.detailquests

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.main;
    import net.spider.handlers.optionHandler;
    import net.spider.draw.fadedAC;
    import flash.text.TextFormat;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import net.spider.draw.*;
    import flash.ui.*;

    public class detailquests extends MovieClip 
    {

        public static var frame:*;
        public static var itemUI:*;


        public static function onFrameUpdate():void
        {
            if (((!(optionHandler.detailquest)) || (!(main.Game.sfc.isConnected))))
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
            var flag:mcCoin;
            var ac:fadedAC;
            var txtFormat:TextFormat;
            var i:* = 1;
            while (i < core.numChildren)
            {
                itemUI = core.getChildAt(i);
                if (itemUI.getChildByName("flag"))
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
                                        if (k.bCoins == 1)
                                        {
                                            ac = new fadedAC();
                                            ac.width = 68.55;
                                            ac.height = 38.1;
                                            ac.x = (itemUI.bg.width - 72);
                                            ac.alpha = 0.25;
                                            itemUI.addChild(ac);
                                        };
                                        if (k.bUpg)
                                        {
                                            txtFormat = itemUI.strName.defaultTextFormat;
                                            txtFormat.color = 16566089;
                                            itemUI.strName.setTextFormat(txtFormat);
                                            txtFormat = itemUI.strQ.defaultTextFormat;
                                            txtFormat.color = 16566089;
                                            itemUI.strQ.setTextFormat(txtFormat);
                                        };
                                        flag = new mcCoin();
                                        flag.visible = false;
                                        flag.name = "flag";
                                        itemUI.addChild(flag);
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


    }
}//package net.spider.modules

