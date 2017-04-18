package com.catalystapps.gaf.data.config {
import starling.textures.Texture;

public interface ICTextureFactory {

    function create(csf:Number):Texture;

    function createAsync(csf:Number, callback:Function):void;

    function dispose():void;
}
}
