﻿// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.untarget

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

    public class untarget extends MovieClip 
    {


        public static function onTimerUpdate():void
        {
            if ((((!(optionHandler.untargetMon)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.myAvatar))))
            {
                return;
            };
            if (main.Game.world.myAvatar.target)
            {
                if (main.Game.world.myAvatar.target.dataLeaf.intState == 0)
                {
                    main.Game.world.cancelTarget();
                };
            };
        }


    }
}//package net.spider.modules

