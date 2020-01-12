package net.spider.anim
{
    import flash.display.*;

    dynamic public class vha3 extends SpellW
    {
        public var trueTarget:MovieClip;
        public var trueSelf:MovieClip;

        public function vha3()
        {
            if (this.trueTarget != null)
            {
                if (this.trueTarget.x < this.trueSelf.x)
                {
                    MovieClip(this).scaleX = MovieClip(this).scaleX * -1;
                }
            }
            addFrameScript(0, this.frame1, 26, this.frame27);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame27()
        {
            killSpell();
            return;
        }// end function

    }
}
