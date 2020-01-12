// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.monstype

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

    public class monstype extends MovieClip 
    {


        public static function onFrameUpdate():void
        {
            if (((((!(optionHandler.mType)) || (!(main.Game.sfc.isConnected))) || (main.Game.world.myAvatar == null)) || (main.Game.world.myAvatar.target == null)))
            {
                return;
            };
            if (main.Game.world.myAvatar.target.npcType == "monster")
            {
                if (main.Game.ui.mcPortraitTarget.strClass.text != main.Game.world.myAvatar.target.objData.sRace)
                {
                    main.Game.ui.mcPortraitTarget.strClass.text = main.Game.world.myAvatar.target.objData.sRace;
                };
            };
        }


    }
}//package net.spider.modules

