package com.catalystapps.gaf.data {
import flash.geom.Rectangle;

import starling.display.DisplayObject;
import starling.display.Stage;

public interface IMaskDisplayObject {
    function get maskName():String;

    function set maskName(value:String):void;

    function unregisterMaskFromController():void;

    function get stage():Stage;

    function set visible(value:Boolean):void;

    function getBounds(targetSpace: DisplayObject, resultRect: Rectangle=null):Rectangle;
}
}
