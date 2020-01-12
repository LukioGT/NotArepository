// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.smoothbg

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.main;
    import net.spider.handlers.optionHandler;
    import flash.utils.getQualifiedClassName;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class smoothbg extends MovieClip 
    {


        public static function onFrameUpdate():void
        {
            if (((!(optionHandler.smoothBG)) || (!(main.Game.world))))
            {
                return;
            };
            if (!main.Game.world.map)
            {
                return;
            };
            var ctr:Number = 0;
            while (ctr < main.Game.world.map.numChildren)
            {
                if (((((main.Game.world.map.getChildAt(ctr) is MovieClip) && (main.Game.world.map.getChildAt(ctr).width >= 960)) && (!(main.Game.world.map.getChildAt(ctr).visible))) && (getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("mcShadow") == -1)))
                {
                    main.Game.world.map.getChildAt(ctr).visible = true;
                };
                if (((getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("Bitmap") > -1) && (main.Game.world.map.getChildAt(ctr).visible)))
                {
                    main.Game.world.map.getChildAt(ctr).visible = false;
                };
                if (((getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("mcFloor") > -1) && (main.Game.world.map.getChildAt(ctr).visible)))
                {
                    if (getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("mcFloors") == -1)
                    {
                        main.Game.world.map.getChildAt(ctr).visible = false;
                    };
                };
                if (((getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("Plate") > -1) && (main.Game.world.map.getChildAt(ctr).visible)))
                {
                    main.Game.world.map.getChildAt(ctr).visible = false;
                };
                ctr++;
            };
        }


    }
}//package net.spider.modules

