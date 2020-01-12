// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.qlog

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.events.MouseEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.KeyboardEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class qlog extends MovieClip 
    {


        public static function onToggle():void
        {
            if (optionHandler.qLog)
            {
                if (((main.Game.sfc.isConnected) && (main.Game.ui)))
                {
                    main.Game.ui.mcInterface.mcMenu.btnQuest.addEventListener(MouseEvent.CLICK, onRegister, false, 0, true);
                };
            }
            else
            {
                main.Game.ui.mcInterface.mcMenu.btnQuest.removeEventListener(MouseEvent.CLICK, onRegister);
            };
        }

        public static function onKey(e:KeyboardEvent):*
        {
            var delay:* = undefined;
            if (!optionHandler.qLog)
            {
                return;
            };
            var chatF:* = main.Game.chatF;
            var world:* = main.Game.world;
            var ui:* = main.Game.ui;
            if (!("text" in e.target))
            {
                if (String.fromCharCode(e.charCode) == "l")
                {
                    if (main._stage.focus != ui.mcInterface.te)
                    {
                        delay = new Timer(100, 1);
                        delay.addEventListener(TimerEvent.TIMER_COMPLETE, function (e:TimerEvent):void
                        {
                            main.Game.world.toggleQuestLog();
                            main.Game.world.showQuests(main.Game.world.getActiveQuests(), "q");
                        }, false, 0, true);
                        delay.start();
                    };
                };
            };
        }

        public static function onRegister(e:MouseEvent):void
        {
            try
            {
                main.Game.ui.mcInterface.mcMenu.btnQuest.getChildAt(1).addEventListener(MouseEvent.CLICK, showQuests, false, 0, true);
            }
            catch(exception)
            {
                main.Game.ui.mcInterface.mcMenu.btnQuest.getChildAt(1).addEventListener(MouseEvent.CLICK, showQuests, false, 0, true);
            };
        }

        public static function showQuests(e:MouseEvent):void
        {
            if (e.target.mTxt.text != "Quests")
            {
                return;
            };
            var delay:* = new Timer(100, 1);
            delay.addEventListener(TimerEvent.TIMER_COMPLETE, function (e:TimerEvent):void
            {
                main.Game.world.toggleQuestLog();
                main.Game.world.showQuests(main.Game.world.getActiveQuests(), "q");
            }, false, 0, true);
            delay.start();
        }


    }
}//package net.spider.modules

