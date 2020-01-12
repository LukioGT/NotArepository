// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.blackList

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import fl.controls.List;
    import flash.events.MouseEvent;
    import net.spider.main;
    import fl.data.DataProvider;
    import net.spider.handlers.optionHandler;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import net.spider.handlers.*;
    import flash.text.*;
    import flash.utils.*;

    public class blackList extends MovieClip 
    {

        public var btnClearBlacklist:SimpleButton;
        public var btnRemoveBlacklist:SimpleButton;
        public var txtBlacklist:TextField;
        public var ui:MovieClip;
        public var btnAddBlacklist:SimpleButton;
        public var listBlack:List;

        public function blackList()
        {
            this.ui.addEventListener(MouseEvent.MOUSE_DOWN, this.onDrag, false, 0, true);
            this.ui.addEventListener(MouseEvent.MOUSE_UP, this.onMRelease, false, 0, true);
            this.btnAddBlacklist.addEventListener(MouseEvent.CLICK, this.onBtnAddBlacklist, false, 0, true);
            this.btnRemoveBlacklist.addEventListener(MouseEvent.CLICK, this.onBtnRemoveBlacklist, false, 0, true);
            this.btnClearBlacklist.addEventListener(MouseEvent.CLICK, this.onBtnClearBlacklist, false, 0, true);
            this.ui.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            if (main.sharedObject.data.listBlack)
            {
                this.listBlack.dataProvider = new DataProvider(main.sharedObject.data.listBlack);
            };
        }

        private function onClose(e:MouseEvent):void
        {
            this.visible = false;
        }

        private function onBtnAddBlacklist(evt:MouseEvent):void
        {
            if (!this.listBlack)
            {
                return;
            };
            this.listBlack.dataProvider.addItem({
                "label":this.txtBlacklist.text.toUpperCase(),
                "value":this.txtBlacklist.text.toUpperCase()
            });
            main.sharedObject.data.listBlack = this.listBlack.dataProvider.toArray();
            main.sharedObject.flush();
            optionHandler.blackListed = this.listBlack.dataProvider.toArray();
            this.txtBlacklist.text = "";
        }

        private function onBtnRemoveBlacklist(evt:MouseEvent):void
        {
            if (!this.listBlack)
            {
                return;
            };
            if (this.listBlack.selectedIndex != -1)
            {
                this.listBlack.removeItemAt(this.listBlack.selectedIndex);
                this.listBlack.selectedIndex = -1;
            };
            main.sharedObject.data.listBlack = this.listBlack.dataProvider.toArray();
            main.sharedObject.flush();
            optionHandler.blackListed = this.listBlack.dataProvider.toArray();
        }

        private function onBtnClearBlacklist(evt:MouseEvent):void
        {
            if (!this.listBlack)
            {
                return;
            };
            this.listBlack.removeAll();
            main.sharedObject.data.listBlack = this.listBlack.dataProvider.toArray();
            main.sharedObject.flush();
            optionHandler.blackListed = this.listBlack.dataProvider.toArray();
        }

        private function onDrag(e:MouseEvent):void
        {
            this.startDrag();
        }

        private function onMRelease(e:MouseEvent):void
        {
            this.stopDrag();
        }


    }
}//package net.spider.draw

