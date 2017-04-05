package com.catalystapps.gaf.data {
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import starling.display.Sprite;

public class MaskController implements IMaskController {
    private static const _helperRect:Rectangle = new Rectangle();

    private var _masks:Dictionary = new Dictionary();
    private var _masksVector:Vector.<MaskData> = new <MaskData>[];
    private var _addedToAnimator:Boolean = false;
    private var _animator:IAnimator;

    public function MaskController(animator:IAnimator) {
        _animator = animator;
    }

    public function registerMask(mask:IMaskDisplayObject):void {
        getMaskData(mask.maskName).setMask(mask);
    }

    public function registerMasked(masked:Sprite, name:String):void {
        getMaskData(name).setMasked(masked);
    }

    [Inline]
    final private function getMaskData(name:String):MaskData {
        var maskData:MaskData = _masks[name];
        if (!maskData) {
            _masks[name] = maskData = new MaskData(name);
            _masksVector.push(maskData);
            if (!_addedToAnimator) {
                _addedToAnimator = true;
                _animator.add(this);
            }
        }
        return maskData;
    }

    public function unregisterMasked(masked:Sprite, name:String):void {
        var maskData:MaskData = _masks[name];
        if (maskData) {
            maskData.removeMasked(masked);
        }
    }

    public function unregisterMask(mask:IMaskDisplayObject, name:String):void {
        removeMaskData(name);
    }

    private function removeMaskData(name:String):void {
        delete _masks[name];
        var i:int = _masksVector.length;
        while (i--) {
            var maskData:MaskData = _masksVector[i];
            if (maskData.name == name) {
                _masksVector.splice(i, 1);
                removeClipping(maskData);
                if (!_masksVector.length && _addedToAnimator) {
                    _addedToAnimator = false;
                    _animator.remove(this);
                }
                break;
            }
        }
    }

    private function removeClipping(maskData:MaskData):void {
        if (maskData.mask) {
            var i:int = maskData.masked.length;
            while (i--) {
                maskData.masked[i].clipRect = null;
            }
        }
    }

    public function advanceTime(time:Number):void {
        var i:int = _masksVector.length;
        while (i--) {
            processMaskData(_masksVector[i]);
        }
    }

//    [Inline]
    final private function processMaskData(maskData:MaskData):void {
        var mask:IMaskDisplayObject = maskData.mask;
        if (mask && mask.stage) {
            mask.visible = false;
            var i:int = maskData.masked.length;
            while (i--) {
                var masked:Sprite = maskData.masked[i];
                mask.getBounds(masked, _helperRect);
                masked.clipRect = _helperRect;
            }
        }
    }
}
}
import com.catalystapps.gaf.data.IMaskDisplayObject;

import starling.display.Sprite;

internal class MaskData {
    public var mask:IMaskDisplayObject;
    public var masked:Vector.<Sprite> = new Vector.<Sprite>();
    public var name:String;

    public function MaskData(name:String) {
        this.name = name;
    }

    public function setMask(mask:IMaskDisplayObject):MaskData {
        this.mask = mask;
        return this;
    }

    public function setMasked(masked:Sprite):MaskData {
        if (this.masked.indexOf(masked) == -1) {
            this.masked.push(masked);
        }
        return this;
    }

    public function removeMasked(spr:Sprite):void {
        var id:int = masked.indexOf(spr);
        if (id != -1) {
            masked.splice(id, 1);
        }
    }

    public function get numMasked():int {
        return masked.length;
    }
}