﻿// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.avatar.mcSkel

package net.spider.avatar
{
    import flash.display.MovieClip;
    import flash.geom.Point;
    import net.spider.handlers.optionHandler;
    import net.spider.main;

    public class mcSkel extends MovieClip 
    {

        public var idlefoot:MovieClip;
        public var chest:MovieClip;
        public var weaponOff:MovieClip;
        public var frontthigh:MovieClip;
        public var cape:MovieClip;
        public var frontshoulder:MovieClip;
        public var weaponFistOff:MovieClip;
        public var hitbox:MovieClip;
        public var head:MovieClip;
        public var backshoulder:MovieClip;
        public var hip:MovieClip;
        public var backthigh:MovieClip;
        public var backhair:MovieClip;
        public var weaponFist:MovieClip;
        public var backshin:MovieClip;
        public var weaponTemp:MovieClip;
        public var robe:MovieClip;
        public var pvpFlag:MovieClip;
        public var weapon:MovieClip;
        public var frontshin:MovieClip;
        public var backfoot:MovieClip;
        public var backrobe:MovieClip;
        public var arrow:MovieClip;
        public var emoteFX:MovieClip;
        public var shield:MovieClip;
        public var frontfoot:MovieClip;
        public var backhand:MovieClip;
        public var fronthand:MovieClip;
        public var animLoop:int;
        public var avtMC:MovieClip;
        public var projClass:Class;
        public var projMC:MovieClip;
        public var sp:Point;
        public var ep:Point;
        public var onMove:Boolean = false;

        public function mcSkel()
        {
            addFrameScript(0, this.frame1, 7, this.frame8, 8, this.frame9, 16, this.frame17, 20, this.frame21, 29, this.frame30, 43, this.frame44, 44, this.frame45, 60, this.frame61, 61, this.frame62, 68, this.frame69, 74, this.frame75, 75, this.frame76, 92, this.frame93, 93, this.frame94, 106, this.frame107, 107, this.frame108, 131, this.frame132, 141, this.frame142, 142, this.frame143, 161, this.frame162, 162, this.frame163, 176, this.frame177, 185, this.frame186, 186, this.frame187, 220, this.frame221, 221, this.frame222, 237, this.frame238, 238, this.frame239, 247, this.frame248, 0x0100, this.frame257, 264, this.frame265, 265, this.frame266, 285, this.frame286, 288, this.frame289, 289, this.frame290, 321, this.frame322, 322, this.frame323, 340, this.frame341, 342, this.frame343, 343, this.frame344, 368, this.frame369, 369, this.frame370, 433, this.frame434, 434, this.frame435, 451, this.frame452, 470, this.frame471, 478, this.frame479, 486, this.frame487, 487, this.frame488, 488, this.frame489, 534, this.frame535, 535, this.frame536, 565, this.frame566, 566, this.frame567, 574, this.frame575, 575, this.frame576, 583, this.frame584, 596, this.frame597, 597, this.frame598, 608, this.frame609, 609, this.frame610, 612, this.frame613, 628, this.frame629, 629, this.frame630, 632, this.frame633, 658, this.frame659, 659, this.frame660, 663, this.frame664, 687, this.frame688, 688, this.frame689, 692, this.frame693, 715, this.frame716, 716, this.frame717, 733, this.frame734, 734, this.frame735, 755, this.frame756, 756, this.frame757, 762, this.frame763, 763, this.frame764, 792, this.frame793, 793, this.frame794, 816, this.frame817, 817, this.frame818, 820, this.frame821, 837, this.frame838, 838, this.frame839, 841, this.frame842, 864, this.frame865, 865, this.frame866, 868, this.frame869, 890, this.frame891, 891, this.frame892, 894, this.frame895, 908, this.frame909, 909, this.frame910, 920, this.frame921, 921, this.frame922, 924, this.frame925, 940, this.frame941, 941, this.frame942, 944, this.frame945, 955, this.frame956, 956, this.frame957, 977, this.frame978, 978, this.frame979, 989, this.frame990, 990, this.frame991, 994, this.frame995, 1003, this.frame1004, 1004, this.frame1005, 1007, this.frame1008, 1018, this.frame1019, 1019, this.frame1020, 1029, this.frame1030, 1033, this.frame1034, 1042, this.frame1043, 1043, this.frame1044, 1046, this.frame1047, 1057, this.frame1058, 1058, this.frame1059, 1069, this.frame1070, 1070, this.frame1071, 1073, this.frame1074, 1085, this.frame1086, 1086, this.frame1087, 1089, this.frame1090, 1098, this.frame1099, 1099, this.frame1100, 1110, this.frame1111, 1111, this.frame1112, 1113, this.frame1114, 1114, this.frame1115, 1128, this.frame1129, 1129, this.frame1130, 1133, this.frame1134, 1150, this.frame1151, 1154, this.frame1155, 1160, this.frame1161, 1161, this.frame1162, 1164, this.frame1165, 1173, this.frame1174, 1174, this.frame1175, 1176, this.frame1177, 1190, this.frame1191, 1191, this.frame1192, 1202, this.frame1203, 1203, this.frame1204, 1204, this.frame1205, 1214, this.frame1215, 1226, this.frame1227, 1227, this.frame1228, 1246, this.frame1247, 1247, this.frame1248, 1261, this.frame1262, 1262, this.frame1263, 1277, this.frame1278, 1278, this.frame1279, 1311, this.frame1312, 1312, this.frame1313, 1349, this.frame1350, 1350, this.frame1351, 1358, this.frame1359, 1359, this.frame1360, 1431, this.frame1432, 1432, this.frame1433, 1469, this.frame1470, 1470, this.frame1471, 1485, this.frame1486, 1486, this.frame1487, 1495, this.frame1496, 1496, this.frame1497, 1527, this.frame1528, 1528, this.frame1529, 1531, this.frame1532, 1554, this.frame1555, 1555, this.frame1556, 1558, this.frame1559, 1580, this.frame1581, 1581, this.frame1582, 1597, this.frame1598, 1598, this.frame1599, 1611, this.frame1612, 1612, this.frame1613, 1631, this.frame1632, 1632, this.frame1633, 1673, this.frame1674);
        }

        public function emoteLoopFrame():int
        {
            var _loc1_:int;
            while (_loc1_ < currentLabels.length)
            {
                if (currentLabels[_loc1_].name == currentLabel)
                {
                    return (currentLabels[_loc1_].frame);
                };
                _loc1_++;
            };
            return (8);
        }

        public function emoteLoop(param1:int, param2:Boolean=true):void
        {
            var _loc3_:int = this.emoteLoopFrame();
            if (_loc3_ > 8)
            {
                if (++this.animLoop < param1)
                {
                    this.gotoAndPlay((_loc3_ + 1));
                    return;
                };
            };
            if (param2)
            {
                this.gotoAndPlay("Idle");
            };
        }

        public function showIdleFoot():*
        {
            if (!optionHandler.cameratoolMC.isCharHidden)
            {
                this.frontfoot.visible = false;
                this.idlefoot.visible = true;
            }
            else
            {
                this.frontfoot.visible = false;
                this.idlefoot.visible = false;
            };
        }

        public function showFrontFoot():*
        {
            if (!optionHandler.cameratoolMC.isCharHidden)
            {
                this.idlefoot.visible = false;
                this.frontfoot.visible = true;
            }
            else
            {
                this.frontfoot.visible = false;
                this.idlefoot.visible = false;
            };
        }

        override public function gotoAndPlay(param1:Object, param2:String=null):void
        {
            this.handleAnimEvent(String(param1));
            super.gotoAndPlay(param1);
        }

        private function handleAnimEvent(param1:String):void
        {
            var _loc3_:Function;
            var _loc2_:Object = MovieClip(parent).AnimEvent;
            if (_loc2_[param1] == null)
            {
                return;
            };
            var _loc4_:uint;
            while (_loc4_ < _loc2_[param1].length)
            {
                _loc3_ = _loc2_[param1][_loc4_];
                (_loc3_());
                _loc4_++;
            };
        }

        internal function frame1():*
        {
            this.animLoop = 0;
            this.avtMC = null;
            this.gotoAndPlay("Idle");
        }

        internal function frame8():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
            stop();
        }

        internal function frame9():*
        {
            gotoAndStop("Idle");
        }

        internal function frame17():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndPlay("Move");
        }

        internal function frame21():*
        {
            if (this.onMove)
            {
                this.gotoAndPlay("mountWalk");
            };
        }

        internal function frame30():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndPlay("Move");
        }

        internal function frame44():*
        {
            if (this.onMove)
            {
                this.gotoAndPlay("Walk");
            };
        }

        internal function frame45():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame61():*
        {
            this.gotoAndPlay("Dance");
        }

        internal function frame62():*
        {
            this.animLoop = 0;
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame69():*
        {
            this.emoteLoop(3, false);
        }

        internal function frame75():*
        {
            stop();
        }

        internal function frame76():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame93():*
        {
            stop();
        }

        internal function frame94():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame107():*
        {
            this.gotoAndPlay("Use");
        }

        internal function frame108():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame132():*
        {
            this.emoteLoop(3, false);
        }

        internal function frame142():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame143():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame162():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame163():*
        {
            this.animLoop = 0;
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame177():*
        {
            this.emoteLoop(3, false);
        }

        internal function frame186():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame187():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame221():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame222():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame238():*
        {
            this.gotoAndPlay("Airguitar");
        }

        internal function frame239():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame248():*
        {
            this.showFrontFoot();
        }

        internal function frame257():*
        {
            this.showIdleFoot();
        }

        internal function frame265():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame266():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame286():*
        {
            if (this.scaleX < 0)
            {
                this.emoteFX.scaleX = (this.emoteFX.scaleX * -1);
            };
        }

        internal function frame289():*
        {
            stop();
        }

        internal function frame290():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame322():*
        {
            if (this.onMove)
            {
                this.gotoAndPlay("Walk");
            };
            stop();
        }

        internal function frame323():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame341():*
        {
            this.showIdleFoot();
        }

        internal function frame343():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame344():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame369():*
        {
            this.gotoAndPlay("Dance2");
        }

        internal function frame370():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame434():*
        {
            this.gotoAndPlay("Swordplay");
        }

        internal function frame435():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame452():*
        {
            this.showFrontFoot();
        }

        internal function frame471():*
        {
            stop();
        }

        internal function frame479():*
        {
            this.animLoop = 0;
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame487():*
        {
            this.emoteLoop(3);
        }

        internal function frame488():*
        {
            stop();
        }

        internal function frame489():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame535():*
        {
            stop();
        }

        internal function frame536():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame566():*
        {
            stop();
        }

        internal function frame567():*
        {
            this.animLoop = 0;
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame575():*
        {
            this.emoteLoop(3);
        }

        internal function frame576():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame584():*
        {
            this.weapon.visible = true;
        }

        internal function frame597():*
        {
            stop();
        }

        internal function frame598():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame609():*
        {
            stop();
        }

        internal function frame610():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame613():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame629():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame630():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame633():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame659():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame660():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame664():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame688():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame689():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame693():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame716():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame717():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame734():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame735():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame756():*
        {
            stop();
        }

        internal function frame757():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame763():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame764():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame793():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame794():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame817():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame818():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame821():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame838():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame839():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame842():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame865():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame866():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame869():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame891():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame892():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame895():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame909():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame910():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame921():*
        {
            stop();
        }

        internal function frame922():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame925():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame941():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame942():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame945():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame956():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame957():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame978():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame979():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame990():*
        {
            stop();
        }

        internal function frame991():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame995():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1004():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1005():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1008():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1019():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1020():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1030():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1034():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1043():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1044():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1047():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1058():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1059():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1070():*
        {
            stop();
        }

        internal function frame1071():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1074():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1086():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1087():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1090():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1099():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1100():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1111():*
        {
            stop();
        }

        internal function frame1112():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
            this.avtMC = MovieClip(parent);
        }

        internal function frame1114():*
        {
            var Projectile:Class;
            if ((((this.avtMC.spFX.strl == null) || (this.avtMC.spFX.strl == "")) || (this.avtMC.spFX.avts == null)))
            {
                trace("creating projectile");
                if (this.avtMC.pAV.strProj != "")
                {
                    trace((("strProj:" + this.avtMC.pAV.strProj) + ":end"));
                    try
                    {
                        this.projClass = (this.avtMC.pAV.rootClass.world.getClass(this.avtMC.pAV.strProj) as Class);
                    }
                    catch(e)
                    {
                    };
                };
                trace(("projClass: " + this.projClass));
                if (this.projClass == null)
                {
                    this.projClass = (this.avtMC.pAV.rootClass.world.getClass("p_ar") as Class);
                };
                if (this.projClass != null)
                {
                    this.projMC = (new this.projClass() as MovieClip);
                    this.projMC.scaleX = (this.projMC.scaleX * 0.3);
                    this.projMC.scaleY = (this.projMC.scaleY * 0.3);
                    this.sp = this.backhand.localToGlobal(new Point(this.backhand.x, this.backhand.y));
                    this.projMC.x = this.sp.x;
                    this.projMC.y = this.sp.y;
                    this.ep = new Point(this.avtMC.pAV.target.pMC.x, this.avtMC.pAV.target.pMC.y);
                    this.ep.y = (this.ep.y - (this.avtMC.pAV.target.pMC.height / 3.5));
                    this.avtMC.pAV.rootClass.world.addChild(this.projMC);
                    Projectile = main.Game.world.getClass("Projectile");
                    this.avtMC.projClass = new Projectile(this.sp, this.ep, this.projMC, this.avtMC.pAV.rootClass);
                    this.projClass = null;
                };
            };
        }

        internal function frame1115():*
        {
            if ((((!(this.avtMC.spFX.strl == null)) && (!(this.avtMC.spFX.strl == ""))) && (!(this.avtMC.spFX.avts == null))))
            {
            };
        }

        internal function frame1129():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1130():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
            this.avtMC = MovieClip(parent);
        }

        internal function frame1134():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1151():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1155():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1161():*
        {
            stop();
        }

        internal function frame1162():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1165():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1174():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1175():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1177():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1191():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1192():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1203():*
        {
            this.showIdleFoot();
        }

        internal function frame1204():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1205():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1215():*
        {
            this.showIdleFoot();
        }

        internal function frame1227():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1228():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1247():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1248():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1262():*
        {
            stop();
        }

        internal function frame1263():*
        {
            this.showFrontFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1278():*
        {
            stop();
        }

        internal function frame1279():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1312():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1313():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1350():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1351():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1359():*
        {
            this.gotoAndPlay("Cry2");
        }

        internal function frame1360():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1432():*
        {
            this.gotoAndPlay("Spar");
        }

        internal function frame1433():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1470():*
        {
            this.gotoAndPlay("Samba");
        }

        internal function frame1471():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1486():*
        {
            this.gotoAndPlay("Stepdance");
        }

        internal function frame1487():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1496():*
        {
            this.gotoAndPlay("Headbang");
        }

        internal function frame1497():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1528():*
        {
            this.gotoAndPlay("Dazed");
        }

        internal function frame1529():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1532():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1555():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1556():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1559():*
        {
            this.avtMC = MovieClip(parent);
        }

        internal function frame1581():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1582():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1598():*
        {
            this.gotoAndPlay("Danceweapon");
        }

        internal function frame1599():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1612():*
        {
            this.gotoAndPlay("Useweapon");
        }

        internal function frame1613():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1632():*
        {
            MovieClip(parent).endAction();
        }

        internal function frame1633():*
        {
            this.showIdleFoot();
            this.cape.cape.gotoAndStop("Idle");
        }

        internal function frame1674():*
        {
            MovieClip(parent).endAction();
        }


    }
}//package net.spider.avatar

