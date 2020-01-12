// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.listOptionsItemExtra

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import fl.controls.*;
    import flash.events.*;
    import flash.text.*;

    public class listOptionsItemExtra extends MovieClip 
    {

        public var txtName:TextField;
        public var chkActive:MovieClip;
        public var sDesc:String;

        public function listOptionsItemExtra(bEnabled:Boolean, sDesc:String)
        {
            this.sDesc = sDesc;
            this.chkActive.checkmark.visible = bEnabled;
            this.chkActive.addEventListener(MouseEvent.CLICK, this.onToggle, false, 0, true);
        }

        public function onToggle(e:MouseEvent):void
        {
            var modalClass:Class;
            var modal:*;
            var modalO:*;
            switch (this.txtName.text)
            {
                case "Disable Skill Warning Messages":
                    if (optionHandler.chatFilter)
                    {
                        modalClass = main.Game.world.getClass("ModalMC");
                        modal = new (modalClass)();
                        modalO = {};
                        modalO.strBody = "Chat Filter must be disabled before changing this setting!";
                        modalO.params = {};
                        modalO.glow = "red,medium";
                        modalO.btns = "mono";
                        main._stage.addChild(modal);
                        modal.init(modalO);
                        return;
                    };
                    break;
            };
            this.chkActive.checkmark.visible = (!(this.chkActive.checkmark.visible));
            optionHandler.cmd(this.txtName.text);
        }


    }
}//package net.spider.draw

