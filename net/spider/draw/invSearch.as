﻿// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.invSearch

package net.spider.draw
{
    import flash.display.MovieClip;
    import fl.controls.TextInput;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.text.TextFormat;
    import net.spider.main;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;

    public class invSearch extends MovieClip 
    {

        public var txtSearch:TextInput;

        public function invSearch()
        {
            this.txtSearch.addEventListener(Event.CHANGE, this.onTextFormat, false, 0, true);
            this.txtSearch.addEventListener(KeyboardEvent.KEY_DOWN, this.onInvSearch, false, 0, true);
        }

        public function onFilter(inventory:*, index:int, arr:Array):Boolean
        {
            return (inventory.sName.toLowerCase().indexOf(this.txtSearch.text.toLowerCase()) > -1);
        }

        public function onTextFormat(e:*):void
        {
            this.txtSearch.textField.setTextFormat(new TextFormat("Arial", 16, 0xFFFFFF), (this.txtSearch.textField.caretIndex - 1));
        }

        internal function onInvSearch(e:KeyboardEvent):void
        {
            if (((e.charCode == 13) && (main.Game.ui.mcPopup.getChildByName("mcInventory"))))
            {
                MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).fOpen({
                    "fData":{
                        "itemsInv":((this.txtSearch.text != "") ? main.Game.world.myAvatar.items.filter(this.onFilter) : main.Game.world.myAvatar.items),
                        "objData":main.Game.world.myAvatar.objData
                    },
                    "r":{
                        "x":0,
                        "y":0,
                        "w":stage.stageWidth,
                        "h":stage.stageHeight
                    },
                    "sMode":"inventory"
                });
            };
        }


    }
}//package net.spider.draw

