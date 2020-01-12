package net.spider.anim
{

    dynamic public class onyxcombustion extends SpellW
    {

        public function onyxcombustion()
        {
            MovieClip(this).scaleX = MovieClip(this).scaleX * 0.7;
            MovieClip(this).scaleY = MovieClip(this).scaleY * 0.7;
            addFrameScript(0, this.frame1, 40, this.frame41);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame41()
        {
            killSpell();
            return;
        }// end function

    }
}
