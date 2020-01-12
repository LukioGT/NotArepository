package net.spider.anim
{
    import flash.display.*;

    dynamic public class firedragon extends SpellW
    {
        public var trueTarget:MovieClip;
        public var trueSelf:MovieClip;

        public function firedragon()
        {
            MovieClip(this).scaleX = MovieClip(this).scaleX * 0.7;
            MovieClip(this).scaleY = MovieClip(this).scaleY * 0.7;
            if (this.trueTarget != null)
            {
                if (this.trueTarget.x < this.trueSelf.x)
                {
                    MovieClip(this).scaleX = MovieClip(this).scaleX * -1;
                }
            }
            addFrameScript(0, this.frame1, 28, this.frame29);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame29()
        {
            killSpell();
            return;
        }// end function

    }
}
