// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.modules.battlepet

package net.spider.modules
{
    import flash.display.MovieClip;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.ui.*;

    public class battlepet extends MovieClip 
    {


        public static function onExtensionResponseHandler(e:*):void
        {
            var dID:*;
            var resObj:*;
            var cmd:*;
            var o:*;
            if (!optionHandler.bBattlePet)
            {
                return;
            };
            var protocol:* = e.params.type;
            if (protocol == "json")
            {
                resObj = e.params.dataObj;
                cmd = resObj.cmd;
                switch (cmd)
                {
                    case "ct":
                        if (resObj.anims == null)
                        {
                            return;
                        };
                        if (!main.Game.world.myAvatar.objData.eqp["pe"])
                        {
                            return;
                        };
                        for each (o in resObj.anims)
                        {
                            if (((o.tInf.indexOf("m:") > -1) && (o.cInf.indexOf("p:") > -1)))
                            {
                                if (main.Game.world.getAvatarByUserID(String(o.cInf.split(":")[1])).isMyAvatar)
                                {
                                    if (o.animStr == main.Game.world.actions.active[0].anim)
                                    {
                                        if (main.Game.world.myAvatar.objData.eqp["pe"])
                                        {
                                            main.Game.world.myAvatar.pMC.queueAnim("PetAttack");
                                        };
                                        return;
                                    };
                                };
                            };
                        };
                        break;
                };
            };
        }


    }
}//package net.spider.modules

