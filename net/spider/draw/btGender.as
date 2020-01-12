// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.btGender

package net.spider.draw
{
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.display.MovieClip;
    import flash.utils.getQualifiedClassName;
    import net.spider.main;
    import net.spider.avatar.AvatarMC;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;

    public class btGender extends SimpleButton 
    {

        public function btGender()
        {
            this.addEventListener(MouseEvent.CLICK, this.onBtGender, false, 0, true);
        }

        public function onClick(e:MouseEvent):void
        {
            var mcFocus:String;
            var focusMovie:MovieClip;
            if (getQualifiedClassName(e.target).indexOf("LPFElementListItemItem") > -1)
            {
                if (main.Game.ui.mcPopup.currentLabel == "Shop")
                {
                    focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).previewPanel.getChildAt(3);
                    mcFocus = "mcShop";
                }
                else
                {
                    if (main.Game.ui.mcPopup.currentLabel == "MergeShop")
                    {
                        focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).mergePanel.getChildAt(3);
                        mcFocus = "mcShop";
                    }
                    else
                    {
                        focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).previewPanel.getChildAt(3);
                        mcFocus = "mcInventory";
                    };
                };
                focusMovie.mcPreview.visible = true;
                focusMovie.removeChild(focusMovie.getChildByName("genderPreview"));
                MovieClip(main.Game.ui.mcPopup.getChildByName(mcFocus)).removeEventListener(MouseEvent.CLICK, this.onClick);
            };
        }

        public function onBtGender(e:Event):void
        {
            var mcFocus:String;
            var focusMovie:MovieClip;
            var genderPreview:*;
            var objChar:Object;
            switch (main.Game.ui.mcPopup.currentLabel)
            {
                case "Shop":
                    focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).previewPanel.getChildAt(3);
                    mcFocus = "mcShop";
                    break;
                case "MergeShop":
                    focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).mergePanel.getChildAt(3);
                    mcFocus = "mcShop";
                    break;
                case "Inventory":
                    focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).previewPanel.getChildAt(3);
                    mcFocus = "mcInventory";
                    break;
            };
            focusMovie.mcPreview.visible = (!(focusMovie.mcPreview.visible));
            if (!focusMovie.getChildByName("genderPreview"))
            {
                genderPreview = focusMovie.addChild(new AvatarMC());
                genderPreview.name = "genderPreview";
            };
            focusMovie.getChildByName("genderPreview").visible = (!(focusMovie.mcPreview.visible));
            if (focusMovie.getChildByName("genderPreview").visible)
            {
                objChar = new Object();
                objChar.strGender = ((main.Game.world.myAvatar.objData.strGender == "M") ? "F" : "M");
                (focusMovie.getChildByName("genderPreview") as AvatarMC).pAV.objData = objChar;
                focusMovie.getChildByName("genderPreview").x = focusMovie.mcPreview.x;
                focusMovie.getChildByName("genderPreview").y = focusMovie.mcPreview.y;
                (focusMovie.getChildByName("genderPreview") as AvatarMC).loadArmor(main.Game.ui.mcPopup.getChildByName(mcFocus).iSel.sFile, main.Game.ui.mcPopup.getChildByName(mcFocus).iSel.sLink);
                focusMovie.setChildIndex(focusMovie.getChildByName("genderPreview"), (focusMovie.getChildIndex(focusMovie.tInfo) - 1));
            };
            if (!MovieClip(main.Game.ui.mcPopup.getChildByName(mcFocus)).hasEventListener(MouseEvent.CLICK))
            {
                MovieClip(main.Game.ui.mcPopup.getChildByName(mcFocus)).addEventListener(MouseEvent.CLICK, this.onClick);
            };
        }


    }
}//package net.spider.draw

