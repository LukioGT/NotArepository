// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.memoryusage

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.system.System;

    public class memoryusage extends MovieClip 
    {

        public var bg:MovieClip;
        public var txtMemory:TextField;

        public function memoryusage()
        {
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onHold, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseRelease, false, 0, true);
            this.addEventListener(Event.ENTER_FRAME, this.onFrame);
        }

        private function onFrame(e:*):void
        {
            this.txtMemory.text = (((((("Not In Use: " + (System.freeMemory / 1000000)) + "mb\nIn Use: ") + (System.totalMemory / 1000000)) + "mb\nAllocated: ") + (System.privateMemory / 1000000)) + "mb");
        }

        public function cleanup():void
        {
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onHold);
            this.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseRelease);
            this.removeEventListener(Event.ENTER_FRAME, this.onFrame);
        }

        private function onHold(e:MouseEvent):void
        {
            this.startDrag();
        }

        private function onMouseRelease(e:MouseEvent):void
        {
            this.stopDrag();
        }


    }
}//package net.spider.draw

