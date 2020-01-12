package net.spider.anim
{
    import flash.display.*;

    dynamic public class vhaa extends SpellW
    {
        public var w6:MovieClip;
        public var w1:MovieClip;
        public var w2:MovieClip;
        public var w3:MovieClip;
        public var w4:MovieClip;
        public var w5:MovieClip;
        public var w7:MovieClip;
        public var w8:MovieClip;
        public var trueTarget:MovieClip;
        public var trueSelf:MovieClip;

        public function vhaa()
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
            addFrameScript(0, this.frame1, 25, this.frame27);
            return;
        }// end function

        function rand(param1:Number, param2:Number) : Number
        {
            return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
        }// end function

        function frame1()
        {
            this.w1.visible = false;
            this.w2.visible = false;
            this.w3.visible = false;
            this.w4.visible = false;
            this.w5.visible = false;
            this.w6.visible = false;
            this.w7.visible = false;
            this.w8.visible = false;
            switch(this.rand(1, 8))
            {
                case 1:
                {
                    this.w1.visible = true;
                    break;
                }
                case 2:
                {
                    this.w2.visible = true;
                    break;
                }
                case 3:
                {
                    this.w3.visible = true;
                    break;
                }
                case 4:
                {
                    this.w4.visible = true;
                    break;
                }
                case 5:
                {
                    this.w5.visible = true;
                    break;
                }
                case 6:
                {
                    this.w6.visible = true;
                    break;
                }
                case 7:
                {
                    this.w7.visible = true;
                    break;
                }
                case 8:
                {
                    this.w8.visible = true;
                    break;
                }
                default:
                {
                    this.w5.visible = true;
                    break;
                    break;
                }
            }
            init();
            return;
        }// end function

        function frame27()
        {
            killSpell();
            return;
        }// end function

    }
}
