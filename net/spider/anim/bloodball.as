package net.spider.anim
{

    dynamic public class bloodball extends SpellW
    {

        public function bloodball()
        {
            addFrameScript(0, this.frame1, 56, this.frame57);
            return;
        }// end function

        function frame1()
        {
            init();
            return;
        }// end function

        function frame57()
        {
            killSpell();
            return;
        }// end function

    }
}
