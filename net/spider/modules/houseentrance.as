// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.houseentrance

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.main;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class houseentrance extends MovieClip 
    {

        private static var passInit:Boolean = false;
        private static var houseEvent:Boolean = false;


        public static function onToggle():void
        {
            if (!main.Game)
            {
                return;
            };
            if (!main.Game.ui)
            {
                return;
            };
            if (((!(houseEvent)) && (passInit)))
            {
                main.Game.ui.mcInterface.mcMenu.btnHouse.addEventListener(MouseEvent.CLICK, onHouseClick, false, 0, true);
                houseEvent = true;
            }
            else
            {
                main.Game.ui.mcInterface.mcMenu.btnHouse.removeEventListener(MouseEvent.CLICK, onHouseClick);
                houseEvent = false;
            };
            if (!passInit)
            {
                passInit = true;
            };
        }

        public static function onHouseClick(e:MouseEvent):void
        {
            if (main.Game.world.strMapName.toLowerCase() == "house")
            {
                main.Game.world.moveToCell("Enter", "Spawn");
            };
        }


    }
}//package net.spider.modules

