package net.spider.mcSkel
{
    import flash.display.*;

    public class Face_75 extends MovieClip
    {

        public function Face_75()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        function frame1()
        {
            try
            {
                MovieClip(this.parent).pAV.pMC.setColor(this, "a", "Skin", "None");
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
