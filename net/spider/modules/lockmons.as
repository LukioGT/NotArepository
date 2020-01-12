// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.lockmons

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class lockmons extends MovieClip 
    {


        public static function onToggle():void
        {
            var mons:Array;
            var _m:*;
            if (!optionHandler.lockm)
            {
                mons = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
                for each (_m in mons)
                {
                    if (!_m)
                    {
                    }
                    else
                    {
                        if (!_m.pMC)
                        {
                        }
                        else
                        {
                            if (_m.pMC.noMove)
                            {
                                _m.pMC.noMove = false;
                            };
                        };
                    };
                };
            };
        }

        public static function onTimerUpdate():void
        {
            var _m:*;
            if ((((!(optionHandler.lockm)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.strFrame))))
            {
                return;
            };
            var mons:Array = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
            for each (_m in mons)
            {
                if (!_m)
                {
                }
                else
                {
                    if (!_m.pMC)
                    {
                    }
                    else
                    {
                        if (!_m.pMC.noMove)
                        {
                            _m.pMC.noMove = true;
                        };
                    };
                };
            };
        }


    }
}//package net.spider.modules

