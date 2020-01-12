// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.chatfilter

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class chatfilter extends MovieClip 
    {

        internal static var firstRuntimePassed:Boolean = false;
        public static var eventInitialized:Boolean = false;
        private static var clog:*;
        private static var txt:*;


        public static function onToggle():void
        {
            var i:uint;
            var k:*;
            var j:*;
            if (!optionHandler.chatFilter)
            {
                if (!main.Game.ui)
                {
                    return;
                };
                clog = main.Game.ui.mcInterface.t1;
                i = 0;
                while (i < clog.numChildren)
                {
                    if (!clog.getChildAt(i).getChildAt(0).ti)
                    {
                    }
                    else
                    {
                        if (!clog.getChildAt(i).getChildAt(0).visible)
                        {
                            clog.getChildAt(i).getChildAt(0).visible = true;
                        };
                    };
                    i++;
                };
                if (((optionHandler.filterChecks["chkRedSkills"]) && (firstRuntimePassed)))
                {
                    if (eventInitialized)
                    {
                        main._stage.addEventListener(KeyboardEvent.KEY_UP, main.Game.key_actBar, false, 0, true);
                        k = 1;
                        while (k < 6)
                        {
                            main.Game.ui.mcInterface.actBar.getChildByName(("i" + k)).removeEventListener(MouseEvent.CLICK, actIconClick);
                            main.Game.ui.mcInterface.actBar.getChildByName(("i" + k)).addEventListener(MouseEvent.CLICK, main.Game.actIconClick, false, 0, true);
                            k++;
                        };
                        eventInitialized = false;
                    };
                };
            }
            else
            {
                if (((optionHandler.filterChecks["chkRedSkills"]) && (firstRuntimePassed)))
                {
                    if (!eventInitialized)
                    {
                        main._stage.removeEventListener(KeyboardEvent.KEY_UP, main.Game.key_actBar);
                        j = 1;
                        while (j < 6)
                        {
                            main.Game.ui.mcInterface.actBar.getChildByName(("i" + j)).addEventListener(MouseEvent.CLICK, actIconClick, false, 0, true);
                            main.Game.ui.mcInterface.actBar.getChildByName(("i" + j)).removeEventListener(MouseEvent.CLICK, main.Game.actIconClick);
                            j++;
                        };
                        eventInitialized = true;
                    };
                };
            };
            if (!firstRuntimePassed)
            {
                firstRuntimePassed = true;
            };
        }

        public static function onKey(param1:KeyboardEvent):*
        {
            var toRound:Number;
            var curTime:Number;
            var skillObj:*;
            if (!optionHandler.chatFilter)
            {
                return;
            };
            if (!optionHandler.filterChecks["chkRedSkills"])
            {
                return;
            };
            if (((main._stage.focus == null) || ((!(main._stage.focus == null)) && (!("text" in main._stage.focus)))))
            {
                if (param1.charCode == 49)
                {
                    main.Game.world.approachTarget();
                    return;
                };
                if (((param1.charCode > 49) && (param1.charCode < 55)))
                {
                    toRound = (1 - Math.min(Math.max(main.Game.world.myAvatar.dataLeaf.sta.$tha, -1), 0.5));
                    curTime = new Date().getTime();
                    skillObj = main.Game.world.actions.active[(param1.charCode - 49)];
                    if (skillObj != null)
                    {
                        if (skillObj.isOK)
                        {
                            if (!((curTime - main.Game.world.GCDTS) < main.Game.world.GCD))
                            {
                                if ((curTime - skillObj.ts) >= Math.round((skillObj.cd * toRound)))
                                {
                                    main.Game.world.testAction(skillObj);
                                    skillObj = null;
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function actIconClick(param1:MouseEvent):*
        {
            var skillObj:* = MovieClip(param1.currentTarget).actObj;
            if (((!(skillObj.auto == null)) && (skillObj.auto == true)))
            {
                main.Game.world.approachTarget();
                return;
            };
            var toRound:Number = (1 - Math.min(Math.max(main.Game.world.myAvatar.dataLeaf.sta.$tha, -1), 0.5));
            var curTime:Number = new Date().getTime();
            if (skillObj != null)
            {
                if (skillObj.isOK)
                {
                    if (!((curTime - main.Game.world.GCDTS) < main.Game.world.GCD))
                    {
                        if ((curTime - skillObj.ts) >= Math.round((skillObj.cd * toRound)))
                        {
                            main.Game.world.testAction(skillObj);
                            skillObj = null;
                        };
                    };
                };
            };
        }

        public static function onFrameUpdate():void
        {
            if (((!(optionHandler.chatFilter)) || (!(main.Game.sfc.isConnected))))
            {
                return;
            };
            clog = main.Game.ui.mcInterface.t1;
            var i:uint;
            while (i < clog.numChildren)
            {
                if (!clog.getChildAt(i).getChildAt(0).ti)
                {
                }
                else
                {
                    txt = clog.getChildAt(i).getChildAt(0).ti.htmlText;
                    switch (true)
                    {
                        case ((optionHandler.filterChecks["chkRed"]) && (txt.indexOf('COLOR="#FF0000"') > -1)):
                        case ((optionHandler.filterChecks["chkBlue"]) && (txt.indexOf('COLOR="#00FFFF"') > -1)):
                            if (txt.indexOf("Server shutdown") > -1)
                            {
                                break;
                            };
                            clog.getChildAt(i).getChildAt(0).visible = false;
                            break;
                    };
                };
                i++;
            };
        }


    }
}//package net.spider.modules

