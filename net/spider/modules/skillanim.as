// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.skillanim

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

    public class skillanim extends MovieClip 
    {


        public static function onTimerUpdate():void
        {
            var playerMC:*;
            if (((((!(optionHandler.disableSkillAnim)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.myAvatar))) || (!(main.Game.world.myAvatar.pMC.spFX))))
            {
                return;
            };
            if (((main.Game.world.avatars.length < 2) && (!(optionHandler.filterChecks["chkSelfOnly"]))))
            {
                main.Game.world.myAvatar.pMC.spFX.strl = "";
            }
            else
            {
                for (playerMC in main.Game.world.avatars)
                {
                    if (optionHandler.filterChecks["chkSelfOnly"])
                    {
                        if (main.Game.world.avatars[playerMC].isMyAvatar)
                        {
                            continue;
                        };
                    };
                    if (main.Game.world.avatars[playerMC].pMC)
                    {
                        main.Game.world.avatars[playerMC].pMC.spFX.strl = "";
                    };
                };
            };
        }


    }
}//package net.spider.modules

