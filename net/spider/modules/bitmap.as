// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.bitmap

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.utils.getQualifiedClassName;
    import fl.controls.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class bitmap extends MovieClip 
    {


        public static function onToggle():void
        {
            var playerMC:*;
            if (!optionHandler.bitmapP)
            {
                for (playerMC in main.Game.world.avatars)
                {
                    if (((!(main.Game.world.avatars[playerMC].dataLeaf)) && (!(main.Game.world.avatars[playerMC].dataLeaf.strFrame == main.Game.world.strFrame))))
                    {
                    }
                    else
                    {
                        if (!main.Game.world.avatars[playerMC].pMC)
                        {
                        }
                        else
                        {
                            if (main.Game.world.avatars[playerMC].isMyAvatar)
                            {
                            }
                            else
                            {
                                if (!main.Game.world.avatars[playerMC].pMC.getChildByName("avtCache"))
                                {
                                }
                                else
                                {
                                    if (main.Game.world.avatars[playerMC].dataLeaf.intState > 0)
                                    {
                                        try
                                        {
                                            main.Game.world.avatars[playerMC].pMC.removeChild(main.Game.world.avatars[playerMC].pMC.getChildByName("avtCache"));
                                            main.Game.world.avatars[playerMC].pMC.mcChar.visible = true;
                                            main.Game.world.avatars[playerMC].pMC.mouseEnabled = true;
                                        }
                                        catch(exception)
                                        {
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function onFrameUpdate():void
        {
            var playerMC:*;
            if ((((!(optionHandler.bitmapP)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.avatars))))
            {
                return;
            };
            for (playerMC in main.Game.world.avatars)
            {
                if (((!(main.Game.world.avatars[playerMC].dataLeaf)) && (!(main.Game.world.avatars[playerMC].dataLeaf.strFrame == main.Game.world.strFrame))))
                {
                }
                else
                {
                    if (!main.Game.world.avatars[playerMC].pMC)
                    {
                    }
                    else
                    {
                        if (main.Game.world.avatars[playerMC].isMyAvatar)
                        {
                        }
                        else
                        {
                            if (!main.Game.world.avatars[playerMC].pMC.isLoaded)
                            {
                            }
                            else
                            {
                                if (main.Game.world.avatars[playerMC].pMC.getChildByName("avtCache"))
                                {
                                }
                                else
                                {
                                    if (main.Game.world.avatars[playerMC].dataLeaf.intState > 0)
                                    {
                                        try
                                        {
                                            main.Game.world.avatars[playerMC].pMC.mcChar.gotoAndStop("Idle");
                                            trace(("Rasterizing - " + main.Game.world.avatars[playerMC].pMC.pname.ti.text));
                                            rasterize(main.Game.world.avatars[playerMC].pMC.mcChar);
                                        }
                                        catch(exception)
                                        {
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function createAvtBM(avt:DisplayObject):Bitmap
        {
            var avtMatrix:Matrix = avt.transform.concatenatedMatrix;
            var avtGBounds:Rectangle = avt.getBounds(avt.stage);
            var avtGPos:Point = avt.localToGlobal(new Point());
            var avtOffset:Point = new Point((avtGPos.x - avtGBounds.left), (avtGPos.y - avtGBounds.top));
            var scaledSprite:Sprite = new Sprite();
            avt.stage.addChild(scaledSprite);
            var scaledMatrix:Matrix = scaledSprite.transform.concatenatedMatrix;
            avt.stage.removeChild(scaledSprite);
            avtMatrix.tx = (avtOffset.x * scaledMatrix.a);
            avtMatrix.ty = (avtOffset.y * scaledMatrix.d);
            var avtBMD:BitmapData = new BitmapData((avtGBounds.width * scaledMatrix.a), (avtGBounds.height * scaledMatrix.d), true, 0);
            avtBMD.draw(avt, avtMatrix);
            var avtBM:Bitmap = new Bitmap(avtBMD);
            avtBM.x = (avtBM.x - avtOffset.x);
            avtBM.y = (avtBM.y - avtOffset.y);
            avtBM.scaleX = (1 / scaledMatrix.a);
            avtBM.scaleY = (1 / scaledMatrix.d);
            return (avtBM);
        }

        public static function rasterize(avtDisplay:MovieClip):void
        {
            var render:* = avtDisplay.parent.addChildAt(createAvtBM(avtDisplay), (avtDisplay.parent.getChildIndex(avtDisplay) + 1));
            render.name = "avtCache";
            render.parent.mouseEnabled = false;
            avtDisplay.visible = false;
        }

        public static function movieClipStopAll(container:MovieClip):void
        {
            var i:uint;
            while (i < container.numChildren)
            {
                if ((container.getChildAt(i) is MovieClip))
                {
                    if ((container.getChildAt(i) as MovieClip).name == "pvpFlag")
                    {
                    }
                    else
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
                    if ((container.getChildAt(i) as MovieClip).name == "pvpFlag")
                    {
                    }
                    else
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
                };
                i++;
            };
        }


    }
}//package net.spider.modules

