// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.hidemonsters

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

    public class hidemonsters extends MovieClip 
    {


        public static function onToggle():void
        {
            var mons:Array;
            var _m:*;
            if (!optionHandler.hideM)
            {
                if (!main.Game.world.strFrame)
                {
                    return;
                };
                mons = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
                for each (_m in mons)
                {
                    if (!_m)
                    {
                    }
                    else
                    {
                        if (!_m.pMC)
                        {
                        }
                        else
                        {
                            if (!_m.pMC.getChildAt(1))
                            {
                            }
                            else
                            {
                                if (!_m.pMC.getChildAt(1).visible)
                                {
                                    _m.pMC.getChildAt(1).visible = true;
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function onFrameUpdate():void
        {
            var _m:*;
            if ((((!(optionHandler.hideM)) || (!(main.Game.sfc.isConnected))) || (!(main.Game.world.myAvatar))))
            {
                return;
            };
            if (!main.Game.world.strFrame)
            {
                return;
            };
            var mons:Array = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
            for each (_m in mons)
            {
                if (!_m)
                {
                }
                else
                {
                    if (!_m.pMC)
                    {
                    }
                    else
                    {
                        if (!_m.pMC.getChildAt(1))
                        {
                        }
                        else
                        {
                            if (_m.pMC.getChildAt(1).visible)
                            {
                                trace("shadowed");
                                _m.pMC.getChildAt(1).visible = false;
                                _m.pMC.shadow.addEventListener(MouseEvent.CLICK, onClickHandler, false, 0, true);
                                _m.pMC.shadow.mouseEnabled = true;
                                _m.pMC.shadow.buttonMode = true;
                            };
                        };
                    };
                };
            };
        }

        public static function onClickHandler(e:MouseEvent):void
        {
            var tAvt:*;
            tAvt = e.currentTarget.parent.pAV;
            if (e.shiftKey)
            {
                main.Game.world.onWalkClick();
            }
            else
            {
                if (!e.ctrlKey)
                {
                    if (((((!(tAvt == main.Game.world.myAvatar)) && (main.Game.world.bPvP)) && (!(tAvt.dataLeaf.pvpTeam == main.Game.world.myAvatar.dataLeaf.pvpTeam))) && (tAvt == main.Game.world.myAvatar.target)))
                    {
                        main.Game.world.approachTarget();
                    }
                    else
                    {
                        if (tAvt != main.Game.world.myAvatar.target)
                        {
                            main.Game.world.setTarget(tAvt);
                        };
                    };
                };
            };
        }


    }
}//package net.spider.modules

