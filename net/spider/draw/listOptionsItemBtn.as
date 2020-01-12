// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.listOptionsItemBtn

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import net.spider.handlers.optionHandler;

    public class listOptionsItemBtn extends MovieClip 
    {

        public var txtName:TextField;
        public var btnActive:SimpleButton;
        public var sDesc:String;

        public function listOptionsItemBtn(sDesc:String)
        {
            this.sDesc = sDesc;
            this.btnActive.addEventListener(MouseEvent.CLICK, this.onActive, false, 0, true);
        }

        public function onActive(e:MouseEvent):void
        {
            optionHandler.cmd(this.txtName.text);
        }


    }
}//package net.spider.draw

