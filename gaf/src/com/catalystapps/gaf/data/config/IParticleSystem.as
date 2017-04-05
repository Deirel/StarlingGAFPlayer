/**
 * Created by Pavel Suvorov on 10.02.2017.
 */
package com.catalystapps.gaf.data.config {

import starling.animation.IAnimatable;
import starling.display.DisplayObject;

public  interface IParticleSystem extends IAnimatable {

    function getDisplayObject():DisplayObject;

    function start(duration:Number = Number.MAX_VALUE):void;

    function  get isEmitting():Boolean;

    function stop(clearParticles:Boolean = false):void;

    function addEventListener(type:String, listener:Function):void;

    function removeEventListener(type:String, listener:Function):void;

    function dispose():void;

    function get emitterX():Number;

    function get emitterY():Number;

    function set emitterX(value:Number):void;

    function set emitterY(value:Number):void;

    function clear():void;
}
}
