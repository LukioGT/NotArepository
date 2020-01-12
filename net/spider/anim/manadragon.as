package net.spider.anim
{

    dynamic public class manadragon extends SpellW
    {

        public function manadragon()
        {
            addFrameScript(0, this.frame1, 47, this.frame48);
            return;
        }// end function

        function frame1()
        {
            return;
        }// end function

        function frame48()
        {
            killSpell();
            return;
        }// end function

    }
}
