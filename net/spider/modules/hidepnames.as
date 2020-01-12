// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.hidepnames

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

    public class hidepnames extends MovieClip 
    {

        internal static var mouseOverAvatar:*;


        public static function onToggle():void
        {
            var playerMC:*;
            if (!optionHandler.hideP)
            {
                for (playerMC in main.Game.world.avatars)
                {
                    if (main.Game.world.avatars[playerMC].pMC)
                    {
                        main.Game.world.avatars[playerMC].pMC.pname.visible = true;
                    };
                };
            };
        }

        public static function onMouseAvatarOver(e:*):void
        {
            mouseOverAvatar = e.currentTarget.parent.pname.ti.text;
        }

        public static function onMouseAvatarOut(e:*):void
        {
            mouseOverAvatar = "";
        }

        public static function onFrameUpdate():void
        {
            var playerMC:*;
            if ((((!(optionHandler.hidePNames)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.myAvatar))))
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
                    if (((main.Game.world.avatars[playerMC].pMC.pname.visible) && (!(mouseOverAvatar == main.Game.world.avatars[playerMC].pMC.pname.ti.text))))
                    {
                        main.Game.world.avatars[playerMC].pMC.pname.visible = false;
                    }
                    else
                    {
                        if (((!(main.Game.world.avatars[playerMC].pMC.pname.visible)) && (main.Game.world.avatars[playerMC].pMC.pname.ti.text == mouseOverAvatar)))
                        {
                            main.Game.world.avatars[playerMC].pMC.pname.visible = true;
                        };
                    };
                    if (!main.Game.world.avatars[playerMC].dataLeaf.hasMouseOverEvent)
                    {
                        try
                        {
                            main.Game.world.avatars[playerMC].pMC.mcChar.addEventListener(MouseEvent.ROLL_OVER, onMouseAvatarOver, false, 0, true);
                            main.Game.world.avatars[playerMC].pMC.mcChar.addEventListener(MouseEvent.ROLL_OUT, onMouseAvatarOut, false, 0, true);
                            main.Game.world.avatars[playerMC].dataLeaf.hasMouseOverEvent = true;
                        }
                        catch(exception)
                        {
                        };
                    };
                };
            };
        }


    }
}//package net.spider.modules

