package net.spider.mcSkel
{
    import flash.display.*;

    public class Face_76 extends MovieClip
    {

        public function Face_76()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        function frame1()
        {
            try
            {
                MovieClip(this.parent).pAV.pMC.setColor(this, "a", "Skin", "Dark");
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
