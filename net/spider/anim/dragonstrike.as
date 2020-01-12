package net.spider.anim
{
    import flash.display.*;

    dynamic public class dragonstrike extends SpellW
    {
        public var trueTarget:MovieClip;
        public var trueSelf:MovieClip;

        public function dragonstrike()
        {
            if (this.trueTarget != null)
            {
                if (this.trueTarget.x < this.trueSelf.x)
                {
                    MovieClip(this).scaleX = MovieClip(this).scaleX * -1;
                }
            }
            addFrameScript(0, this.frame1, 9, this.frame10);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame10()
        {
            killSpell();
            return;
        }// end function

    }
}
