﻿// Decompiled by AS3 Sorcerer 6.20
// www.as3sorcerer.com

//net.spider.handlers.ClientEvent

package net.spider.handlers
{
    import flash.events.Event;

    public class ClientEvent extends Event 
    {

        public static const onToggle:String = "onToggle";
        public static const onShow:String = "onShow";
        public static const onEnable:String = "onEnable";
        public static const onUpdate:String = "onUpdate";
        public static const onTimerUpdate:String = "onTimerUpdate";
        public static const onFrameUpdate:String = "onFrameUpdate";
        public static const onCostumePending:String = "onCostumePending";

        public var params:Object;

        public function ClientEvent(param1:String)
        {
            super(param1);
        }

    }
}//package net.spider.handlers

