// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.listOptionsItem

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.spider.handlers.optionHandler;
    import net.spider.main;
    import flash.events.*;

    public class listOptionsItem extends MovieClip 
    {

        public var txtName:TextField;
        public var txtStatus:TextField;
        public var btnLeft:MovieClip;
        public var btnRight:MovieClip;
        public var bEnabled:Boolean;
        public var sDesc:String;

        public function listOptionsItem(bEnabled:Boolean, sDesc:String)
        {
            this.txtStatus.text = ((bEnabled) ? "ON" : " OFF");
            this.bEnabled = bEnabled;
            this.sDesc = sDesc;
            this.btnLeft.addEventListener(MouseEvent.CLICK, this.onToggle, false, 0, true);
            this.btnRight.addEventListener(MouseEvent.CLICK, this.onToggle, false, 0, true);
        }

        public function onToggle(e:MouseEvent):void
        {
            var modalClass:Class;
            var modal:*;
            var modalO:*;
            switch (this.txtName.text)
            {
                case "Custom Drops UI":
                    if (optionHandler.sbpcDrops)
                    {
                        modalClass = main.Game.world.getClass("ModalMC");
                        modal = new (modalClass)();
                        modalO = {};
                        modalO.strBody = "You can only have one version of the Custom Drops UI enabled! Disable the other one before enabling this one!";
                        modalO.params = {};
                        modalO.glow = "red,medium";
                        modalO.btns = "mono";
                        main._stage.addChild(modal);
                        modal.init(modalO);
                        return;
                    };
                    break;
                case "SBP's Custom Drops UI":
                    if (optionHandler.cDrops)
                    {
                        modalClass = main.Game.world.getClass("ModalMC");
                        modal = new (modalClass)();
                        modalO = {};
                        modalO.strBody = "You can only have one version of the Custom Drops UI enabled! Disable the other one before enabling this one!";
                        modalO.params = {};
                        modalO.glow = "red,medium";
                        modalO.btns = "mono";
                        main._stage.addChild(modal);
                        modal.init(modalO);
                        return;
                    };
                    break;
            };
            this.bEnabled = (!(this.bEnabled));
            this.txtStatus.text = ((this.bEnabled) ? "ON" : " OFF");
            optionHandler.cmd(this.txtName.text);
        }


    }
}//package net.spider.draw

