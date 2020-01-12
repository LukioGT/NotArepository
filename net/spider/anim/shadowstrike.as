package net.spider.anim
{

    dynamic public class shadowstrike extends SpellW
    {

        public function shadowstrike()
        {
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
