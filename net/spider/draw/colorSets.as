﻿// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.colorSets

package net.spider.draw
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import fl.controls.ComboBox;
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import net.spider.main;
    import fl.data.DataProvider;
    import flash.geom.ColorTransform;
    import fl.motion.Color;
    import fl.data.SimpleCollectionItem;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;

    public class colorSets extends MovieClip 
    {

        public var txtGreen:TextField;
        public var txtColor1:TextField;
        public var cPreview2:MovieClip;
        public var btnAdd:SimpleButton;
        public var cPreview3:MovieClip;
        public var cPreview1:MovieClip;
        public var btnDel:SimpleButton;
        public var txtHex:TextField;
        public var cbSets:ComboBox;
        public var txtRed:TextField;
        public var btnColor:SimpleButton;
        public var colorPreview:MovieClip;
        public var txtBlue:TextField;
        public var txtName:TextField;
        public var bg:MovieClip;
        public var btnCopy:SimpleButton;
        public var btnApply:SimpleButton;
        public var txtColor3:TextField;
        public var txtColor2:TextField;
        public var mode:String;
        private var _stageBitmap:BitmapData;

        public function colorSets()
        {
            this.txtRed.text = "255";
            this.txtGreen.text = "255";
            this.txtBlue.text = "255";
            this.txtHex.text = "#ffffff";
            this.txtColor1.text = "#ffffff";
            this.txtColor2.text = "#ffffff";
            this.txtColor3.text = "#ffffff";
            this.txtName.text = "My Color Set 1";
            this.bg.addEventListener(MouseEvent.MOUSE_DOWN, this.onHold, false);
            this.bg.addEventListener(MouseEvent.MOUSE_UP, this.onMouseRelease, false);
            this.cbSets.addEventListener(MouseEvent.CLICK, this.onCbSets, false, 0, true);
            this.cbSets.addEventListener(Event.CHANGE, this.onCbSets, false, 0, true);
            this.txtColor1.addEventListener(Event.CHANGE, this.onTxtColor1, false, 0, true);
            this.txtColor2.addEventListener(Event.CHANGE, this.onTxtColor2, false, 0, true);
            this.txtColor3.addEventListener(Event.CHANGE, this.onTxtColor3, false, 0, true);
            this.btnColor.addEventListener(MouseEvent.CLICK, this.onBtColor, false, 0, true);
            this.btnApply.addEventListener(MouseEvent.CLICK, this.onBtApply, false, 0, true);
            this.btnAdd.addEventListener(MouseEvent.CLICK, this.onBtAdd, false, 0, true);
            this.btnDel.addEventListener(MouseEvent.CLICK, this.onBtDel, false, 0, true);
            this.btnCopy.addEventListener(MouseEvent.CLICK, this.onBtCopy, false, 0, true);
            this.__setProp_cbSets_mcColorSets_Layer1_0();
        }

        public function onUpdate():void
        {
            if (main.sharedObject.data.colorSets)
            {
                this.cbSets.dataProvider = new DataProvider(main.sharedObject.data.colorSets);
            };
        }

        private function onBtCopy(e:MouseEvent):void
        {
            if (this.mode == "mcCustomize")
            {
                this.txtColor1.text = ("#" + main.Game.ui.mcPopup.mcCustomize.cpHair.selectedColor.toString(16));
                this.txtColor2.text = ("#" + main.Game.ui.mcPopup.mcCustomize.cpSkin.selectedColor.toString(16));
                this.txtColor3.text = ("#" + main.Game.ui.mcPopup.mcCustomize.cpEye.selectedColor.toString(16));
            }
            else
            {
                this.txtColor1.text = ("#" + main.Game.ui.mcPopup.mcCustomizeArmor.cpBase.selectedColor.toString(16));
                this.txtColor2.text = ("#" + main.Game.ui.mcPopup.mcCustomizeArmor.cpTrim.selectedColor.toString(16));
                this.txtColor3.text = ("#" + main.Game.ui.mcPopup.mcCustomizeArmor.cpAccessory.selectedColor.toString(16));
            };
            this.txtColor1.dispatchEvent(new Event(Event.CHANGE));
            this.txtColor2.dispatchEvent(new Event(Event.CHANGE));
            this.txtColor3.dispatchEvent(new Event(Event.CHANGE));
        }

        private function onBtApply(e:MouseEvent):void
        {
            if (this.mode == "mcCustomize")
            {
                main.Game.ui.mcPopup.mcCustomize.cpHair.selectedColor = int(("0x" + this.txtColor1.text.replace("#", "")));
                main.Game.ui.mcPopup.mcCustomize.cpSkin.selectedColor = int(("0x" + this.txtColor2.text.replace("#", "")));
                main.Game.ui.mcPopup.mcCustomize.cpEye.selectedColor = int(("0x" + this.txtColor3.text.replace("#", "")));
                if (!main.Game.ui.mcPopup.mcCustomize.backData.intColorHair)
                {
                    main.Game.ui.mcPopup.mcCustomize.backData.intColorHair = main.Game.world.myAvatar.objData.intColorHair;
                };
                if (!main.Game.ui.mcPopup.mcCustomize.backData.intColorSkin)
                {
                    main.Game.ui.mcPopup.mcCustomize.backData.intColorSkin = main.Game.world.myAvatar.objData.intColorSkin;
                };
                if (!main.Game.ui.mcPopup.mcCustomize.backData.intColorEye)
                {
                    main.Game.ui.mcPopup.mcCustomize.backData.intColorEye = main.Game.world.myAvatar.objData.intColorEye;
                };
                main.Game.world.myAvatar.objData.intColorHair = int(("0x" + this.txtColor1.text.replace("#", "")));
                main.Game.world.myAvatar.objData.intColorSkin = int(("0x" + this.txtColor2.text.replace("#", "")));
                main.Game.world.myAvatar.objData.intColorEye = int(("0x" + this.txtColor3.text.replace("#", "")));
            }
            else
            {
                main.Game.ui.mcPopup.mcCustomizeArmor.cpBase.selectedColor = int(("0x" + this.txtColor1.text.replace("#", "")));
                main.Game.ui.mcPopup.mcCustomizeArmor.cpTrim.selectedColor = int(("0x" + this.txtColor2.text.replace("#", "")));
                main.Game.ui.mcPopup.mcCustomizeArmor.cpAccessory.selectedColor = int(("0x" + this.txtColor3.text.replace("#", "")));
                if (!main.Game.ui.mcPopup.mcCustomizeArmor.backData.intColorBase)
                {
                    main.Game.ui.mcPopup.mcCustomizeArmor.backData.intColorBase = main.Game.world.myAvatar.objData.intColorBase;
                };
                if (!main.Game.ui.mcPopup.mcCustomizeArmor.backData.intColorTrim)
                {
                    main.Game.ui.mcPopup.mcCustomizeArmor.backData.intColorTrim = main.Game.world.myAvatar.objData.intColorTrim;
                };
                if (!main.Game.ui.mcPopup.mcCustomizeArmor.backData.intColorAccessory)
                {
                    main.Game.ui.mcPopup.mcCustomizeArmor.backData.intColorAccessory = main.Game.world.myAvatar.objData.intColorAccessory;
                };
                main.Game.world.myAvatar.objData.intColorBase = int(("0x" + this.txtColor1.text.replace("#", "")));
                main.Game.world.myAvatar.objData.intColorTrim = int(("0x" + this.txtColor2.text.replace("#", "")));
                main.Game.world.myAvatar.objData.intColorAccessory = int(("0x" + this.txtColor3.text.replace("#", "")));
            };
            main.Game.world.myAvatar.pMC.updateColor();
        }

        private function onCbSets(e:Event):void
        {
            if (this.cbSets.selectedIndex < 0)
            {
                return;
            };
            this.txtName.text = this.cbSets.selectedItem.label;
            this.txtColor1.text = this.cbSets.selectedItem.color1;
            this.txtColor2.text = this.cbSets.selectedItem.color2;
            this.txtColor3.text = this.cbSets.selectedItem.color3;
            this.txtColor1.dispatchEvent(new Event(Event.CHANGE));
            this.txtColor2.dispatchEvent(new Event(Event.CHANGE));
            this.txtColor3.dispatchEvent(new Event(Event.CHANGE));
        }

        private function onTxtColor1(e:Event):void
        {
            var myColorTransform:*;
            try
            {
                myColorTransform = new ColorTransform();
                myColorTransform.color = int(("0x" + this.txtColor1.text.replace("#", "")));
                this.cPreview1.transform.colorTransform = myColorTransform;
            }
            catch(exception)
            {
            };
        }

        private function onTxtColor2(e:Event):void
        {
            var myColorTransform:*;
            try
            {
                myColorTransform = new ColorTransform();
                myColorTransform.color = int(("0x" + this.txtColor2.text.replace("#", "")));
                this.cPreview2.transform.colorTransform = myColorTransform;
            }
            catch(exception)
            {
            };
        }

        private function onTxtColor3(e:Event):void
        {
            var myColorTransform:*;
            try
            {
                myColorTransform = new ColorTransform();
                myColorTransform.color = int(("0x" + this.txtColor3.text.replace("#", "")));
                this.cPreview3.transform.colorTransform = myColorTransform;
            }
            catch(exception)
            {
            };
        }

        private function onBtAdd(evt:MouseEvent):void
        {
            this.cbSets.addItem({
                "label":this.txtName.text,
                "color1":this.txtColor1.text,
                "color2":this.txtColor2.text,
                "color3":this.txtColor3.text
            });
            main.sharedObject.data.colorSets = this.cbSets.dataProvider.toArray();
            main.sharedObject.flush();
        }

        private function onBtDel(evt:MouseEvent):void
        {
            if (this.cbSets.selectedIndex != -1)
            {
                this.cbSets.removeItemAt(this.cbSets.selectedIndex);
            };
            this.cbSets.selectedIndex = -1;
            main.sharedObject.data.colorSets = this.cbSets.dataProvider.toArray();
            main.sharedObject.flush();
        }

        private function onBtColor(evt:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.getColor, false, 0, true);
        }

        private function getColor(evt:MouseEvent):void
        {
            if (this._stageBitmap == null)
            {
                this._stageBitmap = new BitmapData(stage.width, stage.height);
            };
            this._stageBitmap.draw(stage);
            var rgb:uint = this._stageBitmap.getPixel(stage.mouseX, stage.mouseY);
            var red:* = ((rgb >> 16) & 0xFF);
            var green:* = ((rgb >> 8) & 0xFF);
            var blue:* = (rgb & 0xFF);
            this.txtRed.text = red.toString();
            this.txtGreen.text = green.toString();
            this.txtBlue.text = blue.toString();
            this.txtHex.text = ("#" + rgb.toString(16));
            var c:Color = new Color();
            c.setTint(rgb, 1);
            this.colorPreview.transform.colorTransform = c;
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.getColor);
        }

        private function onHold(e:MouseEvent):void
        {
            if (!(e.target is TextField))
            {
                this.startDrag();
            };
        }

        private function onMouseRelease(e:MouseEvent):void
        {
            this.stopDrag();
        }

        internal function __setProp_cbSets_mcColorSets_Layer1_0():*
        {
            var itemObj4:SimpleCollectionItem;
            var collProps4:Array;
            var collProp4:Object;
            var i4:int;
            var j4:*;
            try
            {
                this.cbSets["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            var collObj4:DataProvider = new DataProvider();
            collProps4 = [];
            i4 = 0;
            while (i4 < collProps4.length)
            {
                itemObj4 = new SimpleCollectionItem();
                collProp4 = collProps4[i4];
                for (j4 in collProp4)
                {
                    itemObj4[j4] = collProp4[j4];
                };
                collObj4.addItem(itemObj4);
                i4++;
            };
            this.cbSets.dataProvider = collObj4;
            this.cbSets.editable = false;
            this.cbSets.enabled = true;
            this.cbSets.prompt = "";
            this.cbSets.restrict = "";
            this.cbSets.rowCount = 5;
            this.cbSets.visible = true;
            try
            {
                this.cbSets["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }


    }
}//package net.spider.draw

