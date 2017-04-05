package com.catalystapps.gaf.data {
import starling.animation.IAnimatable;
import starling.display.Sprite;

public interface IMaskController extends IAnimatable {
    function registerMask(mask:IMaskDisplayObject):void;

    function registerMasked(masked:Sprite, name:String):void;

    function unregisterMask(mask:IMaskDisplayObject, name:String):void;

    function unregisterMasked(masked:Sprite, name:String):void;
}
}
