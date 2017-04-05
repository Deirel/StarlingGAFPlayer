/**
 * Created by Nazar on 11.03.2015.
 */
package com.catalystapps.gaf.display {
import com.catalystapps.gaf.data.GAF;
import com.catalystapps.gaf.data.config.CFilter;
import com.catalystapps.gaf.data.config.ICFilterData;
import com.catalystapps.gaf.utils.DisplayUtility;
import com.catalystapps.gaf.utils.FiltersUtility;

import feathers.controls.text.BitmapFontTextEditor;

import feathers.controls.text.TextFieldTextEditor;

import flash.display.BitmapData;
import flash.display3D.Context3DProfile;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextFormat;

import starling.core.Starling;
import starling.display.Image;
import starling.textures.ConcreteTexture;
import starling.textures.Texture;
import starling.utils.getNextPowerOfTwo;

/** @private */
public class GAFBitmapFontTextEditor extends BitmapFontTextEditor implements IGAFTextEditor {

    public function GAFBitmapFontTextEditor() {
        super();
    }

    /** @private */
    public function setFilterConfig(value:CFilter, scale:Number = 1):void {
    }

    public function setNativeTextFormat(value:TextFormat):void {
        // TODO
    }
}
}
