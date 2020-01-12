package net.spider.anim
{
    import flash.display.*;

    dynamic public class darknessdragon extends SpellW
    {
        public var head:MovieClip;

        public function darknessdragon()
        {
            addFrameScript(0, this.frame1, 46, this.frame47);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame47()
        {
            killSpell();
            return;
        }// end function

    }
}
