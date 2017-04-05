package com.catalystapps.gaf.data {
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import starling.display.Quad;

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
                if (!_masksVector.length && _addedToAnimator) {
                    _addedToAnimator = false;
                    _animator.remove(this);
                }
                maskData.destroy();
                break;
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
                var clipRect:Quad = maskData.clipRects[masked] as Quad;
                clipRect.x = _helperRect.x;
                clipRect.y = _helperRect.y;
                clipRect.width = _helperRect.width;
                clipRect.height = _helperRect.height;
            }
        }
    }
}
}
import com.catalystapps.gaf.data.IMaskDisplayObject;

import flash.utils.Dictionary;

import starling.display.Quad;

import starling.display.Sprite;

internal class MaskData {
    public var mask:IMaskDisplayObject;
    public var masked:Vector.<Sprite> = new Vector.<Sprite>();
    public var name:String;
    public var clipRects:Dictionary = new Dictionary();

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
            var maskQuad:Quad = new Quad(10, 10);
            clipRects[masked] = maskQuad;
            masked.mask = maskQuad;
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

    public function destroy():void {
        mask = null;
        var i:int = masked.length;
        while (i--) {
            masked[i].mask = null;
        }
        masked.length = 0;
        masked = null;
        if (clipRects) {
            for (var key:Object in clipRects) {
                var quad:Quad = key as Quad;
                quad && quad.dispose();
            }
        }
        clipRects = null;
    }
}