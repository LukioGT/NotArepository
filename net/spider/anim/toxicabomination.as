package net.spider.anim
{
    import flash.display.*;

    dynamic public class toxicabomination extends SpellW
    {
        public var trueTarget:MovieClip;
        public var trueSelf:MovieClip;

        public function toxicabomination()
        {
            MovieClip(this).scaleX = MovieClip(this).scaleX * 0.5;
            MovieClip(this).scaleY = MovieClip(this).scaleY * 0.5;
            if (this.trueTarget != null)
            {
                if (this.trueTarget.x < this.trueSelf.x)
                {
                    MovieClip(this).scaleX = MovieClip(this).scaleX * -1;
                }
            }
            addFrameScript(0, this.frame1, 203, this.frame204);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame204()
        {
            killSpell();
            return;
        }// end function

    }
}
