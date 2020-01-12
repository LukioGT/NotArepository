// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.draw.colorPicker

package net.spider.draw
{
    import flash.display.MovieClip;
    import fl.controls.TextInput;
    import flash.display.SimpleButton;
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import fl.motion.Color;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import net.spider.handlers.*;
    import flash.text.*;
    import flash.utils.*;

    public class colorPicker extends MovieClip 
    {

        public var txtGreen:TextInput;
        public var txtHex:TextInput;
        public var txtRed:TextInput;
        public var colorPreview:MovieClip;
        public var btnColor:SimpleButton;
        public var txtBlue:TextInput;
        public var ui:MovieClip;
        private var _stageBitmap:BitmapData;

        public function colorPicker()
        {
            this.txtRed.text = "255";
            this.txtGreen.text = "255";
            this.txtBlue.text = "255";
            this.txtHex.text = "#ffffff";
            this.ui.addEventListener(MouseEvent.MOUSE_DOWN, this.onDrag, false, 0, true);
            this.ui.addEventListener(MouseEvent.MOUSE_UP, this.onMRelease, false, 0, true);
            this.ui.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            this.btnColor.addEventListener(MouseEvent.CLICK, this.onBtColor, false, 0, true);
            this.__setProp_txtGreen_ColorPickerUI_Layer1_0();
            this.__setProp_txtBlue_ColorPickerUI_Layer1_0();
            this.__setProp_txtHex_ColorPickerUI_Layer1_0();
            this.__setProp_txtRed_ColorPickerUI_Layer1_0();
        }

        private function onClose(e:MouseEvent):void
        {
            this.visible = false;
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

        private function onDrag(e:MouseEvent):void
        {
            this.startDrag();
        }

        private function onMRelease(e:MouseEvent):void
        {
            this.stopDrag();
        }

        internal function __setProp_txtGreen_ColorPickerUI_Layer1_0():*
        {
            try
            {
                this.txtGreen["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.txtGreen.displayAsPassword = false;
            this.txtGreen.editable = true;
            this.txtGreen.enabled = true;
            this.txtGreen.maxChars = 0;
            this.txtGreen.restrict = "";
            this.txtGreen.text = "255";
            this.txtGreen.visible = true;
            try
            {
                this.txtGreen["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function __setProp_txtBlue_ColorPickerUI_Layer1_0():*
        {
            try
            {
                this.txtBlue["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.txtBlue.displayAsPassword = false;
            this.txtBlue.editable = true;
            this.txtBlue.enabled = true;
            this.txtBlue.maxChars = 0;
            this.txtBlue.restrict = "";
            this.txtBlue.text = "255";
            this.txtBlue.visible = true;
            try
            {
                this.txtBlue["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function __setProp_txtHex_ColorPickerUI_Layer1_0():*
        {
            try
            {
                this.txtHex["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.txtHex.displayAsPassword = false;
            this.txtHex.editable = true;
            this.txtHex.enabled = true;
            this.txtHex.maxChars = 0;
            this.txtHex.restrict = "";
            this.txtHex.text = "#ffffff";
            this.txtHex.visible = true;
            try
            {
                this.txtHex["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function __setProp_txtRed_ColorPickerUI_Layer1_0():*
        {
            try
            {
                this.txtRed["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.txtRed.displayAsPassword = false;
            this.txtRed.editable = true;
            this.txtRed.enabled = true;
            this.txtRed.maxChars = 0;
            this.txtRed.restrict = "";
            this.txtRed.text = "255";
            this.txtRed.visible = true;
            try
            {
                this.txtRed["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }


    }
}//package net.spider.draw

