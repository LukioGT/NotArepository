// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.dismapanim

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.utils.getQualifiedClassName;
    import fl.controls.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class dismapanim extends MovieClip 
    {


        public static function onToggle():void
        {
            var ctr:Number;
            if (!optionHandler.disMapAnim)
            {
                propPlay(main.Game.world.CHARS);
                ctr = 0;
                while (ctr < main.Game.world.map.numChildren)
                {
                    if ((main.Game.world.map.getChildAt(ctr) is MovieClip))
                    {
                        mapPlay((main.Game.world.map.getChildAt(ctr) as MovieClip));
                    };
                    ctr++;
                };
            };
        }

        public static function propStop(container:MovieClip):void
        {
            var i:uint;
            while (i < container.numChildren)
            {
                if ((((container.getChildAt(i) is MovieClip) && ((container.getChildAt(i).hasOwnProperty("isProp")) || (container.getChildAt(i).hasOwnProperty("isHouseItem")))) && (!(container.getChildAt(i).hasOwnProperty("isEvent")))))
                {
                    try
                    {
                        (container.getChildAt(i) as MovieClip).gotoAndStop(0);
                        propStop((container.getChildAt(i) as MovieClip));
                    }
                    catch(exception)
                    {
                    };
                };
                i++;
            };
        }

        public static function mapStop(container:MovieClip):void
        {
            var i:uint;
            while (i < container.numChildren)
            {
                if (((container.getChildAt(i) is MovieClip) && (getQualifiedClassName(container.getChildAt(i)).indexOf("Eggs") == -1)))
                {
                    try
                    {
                        (container.getChildAt(i) as MovieClip).gotoAndStop(0);
                        mapStop((container.getChildAt(i) as MovieClip));
                    }
                    catch(exception)
                    {
                    };
                };
                i++;
            };
        }

        public static function onFrameUpdate():void
        {
            if (((!(optionHandler.disMapAnim)) || (!(main.Game.sfc.isConnected))))
            {
                return;
            };
            if (!main.Game.world.map)
            {
                return;
            };
            if (main.Game.world.map.numChildren < 1)
            {
                return;
            };
            propStop(main.Game.world.CHARS);
            var ctr:Number = 0;
            while (ctr < main.Game.world.map.numChildren)
            {
                if ((main.Game.world.map.getChildAt(ctr) is MovieClip))
                {
                    mapStop((main.Game.world.map.getChildAt(ctr) as MovieClip));
                };
                ctr++;
            };
        }

        public static function propPlay(container:MovieClip):void
        {
            var i:uint;
            while (i < container.numChildren)
            {
                if ((((container.getChildAt(i) is MovieClip) && ((container.getChildAt(i).hasOwnProperty("isProp")) || (container.getChildAt(i).hasOwnProperty("isHouseItem")))) && (!(container.getChildAt(i).hasOwnProperty("isEvent")))))
                {
                    try
                    {
                        (container.getChildAt(i) as MovieClip).gotoAndPlay(0);
                        propPlay((container.getChildAt(i) as MovieClip));
                    }
                    catch(exception)
                    {
                    };
                };
                i++;
            };
        }

        public static function mapPlay(container:MovieClip):void
        {
            var i:uint;
            while (i < container.numChildren)
            {
                if (((container.getChildAt(i) is MovieClip) && (getQualifiedClassName(container.getChildAt(i)).indexOf("Eggs") == -1)))
                {
                    try
                    {
                        (container.getChildAt(i) as MovieClip).gotoAndPlay(0);
                        mapPlay((container.getChildAt(i) as MovieClip));
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

