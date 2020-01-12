package net.spider.anim
{

    dynamic public class healthdragon extends SpellW
    {

        public function healthdragon()
        {
            addFrameScript(0, this.frame1, 47, this.frame48);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame48()
        {
            killSpell();
            return;
        }// end function

    }
}
