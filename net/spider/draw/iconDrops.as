// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.iconDrops

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.MouseEvent;
    import net.spider.handlers.optionHandler;

    public class iconDrops extends MovieClip 
    {

        private var iconTimer:Timer;

        public function iconDrops()
        {
            this.buttonMode = true;
            this.addEventListener(MouseEvent.CLICK, this.onBtDrop);
        }

        public function onBtDrop(e:MouseEvent):void
        {
            e.stopPropagation();
            if (optionHandler.cDrops)
            {
                optionHandler.dropmenuMC.onShow();
            };
            if (optionHandler.sbpcDrops)
            {
                optionHandler.dropmenutwoMC.onShow();
            };
        }


    }
}//package net.spider.draw

