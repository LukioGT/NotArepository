// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.dismonanim

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.utils.getQualifiedClassName;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class dismonanim extends MovieClip 
    {


        public static function onToggle():void
        {
            var monsterMC:*;
            if (!optionHandler.disMonAnim)
            {
                for (monsterMC in main.Game.world.monsters)
                {
                    if (((!(main.Game.world.monsters[monsterMC].dataLeaf)) && (!(main.Game.world.monsters[monsterMC].dataLeaf.strFrame == main.Game.world.strFrame))))
                    {
                    }
                    else
                    {
                        if (!main.Game.world.monsters[monsterMC].pMC)
                        {
                        }
                        else
                        {
                            if (main.Game.world.monsters[monsterMC].dataLeaf.intState > 0)
                            {
                                try
                                {
                                    main.Game.world.monsters[monsterMC].pMC.gotoAndPlay(0);
                                    movieClipPlayAll((main.Game.world.monsters[monsterMC].pMC as MovieClip));
                                }
                                catch(exception)
                                {
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function onFrameUpdate():void
        {
            var monsterMC:*;
            if ((((!(optionHandler.disMonAnim)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.monsters))))
            {
                return;
            };
            for (monsterMC in main.Game.world.monsters)
            {
                if (((!(main.Game.world.monsters[monsterMC].dataLeaf)) && (!(main.Game.world.monsters[monsterMC].dataLeaf.strFrame == main.Game.world.strFrame))))
                {
                }
                else
                {
                    if (!main.Game.world.monsters[monsterMC].pMC)
                    {
                    }
                    else
                    {
                        if (main.Game.world.monsters[monsterMC].dataLeaf.intState > 0)
                        {
                            try
                            {
                                main.Game.world.monsters[monsterMC].pMC.getChildAt(1).gotoAndStop("Idle");
                                movieClipStopAll((main.Game.world.monsters[monsterMC].pMC.getChildAt(1) as MovieClip));
                            }
                            catch(exception)
                            {
                            };
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
                    if (getQualifiedClassName((container.getChildAt(i) as MovieClip)).indexOf("Display") > -1)
                    {
                    }
                    else
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
                    if (getQualifiedClassName((container.getChildAt(i) as MovieClip)).indexOf("Display") > -1)
                    {
                    }
                    else
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
                };
                i++;
            };
        }


    }
}//package net.spider.modules

