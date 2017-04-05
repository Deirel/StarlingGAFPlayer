package com.catalystapps.gaf.data.config {
import starling.textures.Texture;

public interface ICTextureAtlasProvider {

    function getTexture(name:String):Texture;

    function createAtlas(name:String, callback:Function):void;
}
}
