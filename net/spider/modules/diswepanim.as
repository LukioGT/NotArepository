// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.diswepanim

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

    public class diswepanim extends MovieClip 
    {


        public static function onToggle():void
        {
            var playerMC:*;
            if (!optionHandler.disWepAnim)
            {
                for (playerMC in main.Game.world.avatars)
                {
                    if (!main.Game.world.avatars[playerMC].objData)
                    {
                    }
                    else
                    {
                        if (main.Game.world.avatars[playerMC].pMC)
                        {
                            try
                            {
                                main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon.gotoAndPlay(0);
                                (main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip).gotoAndPlay(0);
                                movieClipPlayAll(main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon);
                                movieClipPlayAll((main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip));
                            }
                            catch(exception)
                            {
                            };
                        };
                    };
                };
            };
        }

        public static function onFrameUpdate():void
        {
            var playerMC:*;
            if ((((!(optionHandler.disWepAnim)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.myAvatar))))
            {
                return;
            };
            for (playerMC in main.Game.world.avatars)
            {
                if (!main.Game.world.avatars[playerMC].objData)
                {
                }
                else
                {
                    if (optionHandler.filterChecks["chkDisWepAnim"])
                    {
                        if (main.Game.world.avatars[playerMC].isMyAvatar)
                        {
                            continue;
                        };
                    };
                    if (main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon)
                    {
                        try
                        {
                            main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon.gotoAndStop(0);
                            (main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip).gotoAndStop(0);
                            movieClipStopAll(main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon);
                            movieClipStopAll((main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip));
                        }
                        catch(exception)
                        {
                        };
                    };
                };
            };
        }

        public static function movieClipStopAll(container:MovieClip):void
        {
            var i:uint;
            while (i < container.numChildren)
            {
                if ((container.getChildAt(i) is MovieClip))
                {
                    try
                    {
                        (container.getChildAt(i) as MovieClip).gotoAndStop(0);
                        movieClipStopAll((container.getChildAt(i) as MovieClip));
                    }
                    catch(exception)
                    {
                    };
                };
                i++;
            };
        }

        public static function movieClipPlayAll(container:MovieClip):void
        {
            var i:uint;
            while (i < container.numChildren)
            {
                if ((container.getChildAt(i) is MovieClip))
                {
                    try
                    {
                        (container.getChildAt(i) as MovieClip).gotoAndPlay(0);
                        movieClipPlayAll((container.getChildAt(i) as MovieClip));
                    }
                    catch(exception)
                    {
                    };
                };
                i++;
            };
        }


    }
}//package net.spider.modules

