package net.spider.anim
{
    import flash.display.*;

    dynamic public class vha4 extends SpellW
    {
        public var w1:MovieClip;
        public var w2:MovieClip;
        public var w3:MovieClip;
        public var w4:MovieClip;
        public var w5:MovieClip;
        public var w7:MovieClip;
        public var trueTarget:MovieClip;
        public var trueSelf:MovieClip;

        public function vha4()
        {
            if (this.trueTarget != null)
            {
                if (this.trueTarget.x < this.trueSelf.x)
                {
                    MovieClip(this).scaleX = MovieClip(this).scaleX * -1;
                }
            }
            addFrameScript(0, this.frame1, 62, this.frame27);
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
