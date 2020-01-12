// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.handlers.flags

package net.spider.handlers
{
    import flash.display.MovieClip;
    import net.spider.main;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class flags extends MovieClip 
    {


        public static function isOptions():Boolean
        {
            return (main.Game.ui.mcPopup.currentLabel == "Option");
        }

        public static function isInventory():Boolean
        {
            return (((!(main.Game.ui.mcPVPQueue.visible)) && (main.Game.ui.mcPopup.currentLabel == "Inventory")) && (main.Game.ui.mcPopup.getChildByName("mcInventory")));
        }


    }
}//package net.spider.handlers

