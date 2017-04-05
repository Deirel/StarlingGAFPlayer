/**
 * Created by petr on 17.10.2016.
 */
package com.catalystapps.gaf.data {

import com.catalystapps.gaf.display.GAFMovieClip;
import com.kosmos.common.utils.IDestroyable;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.Stage;
import starling.events.Event;

public class GAFAnimator implements IAnimator, IAnimatable, IDestroyable {
    private var _animAll:Vector.<IAnimatable> = new Vector.<IAnimatable>();
    private var _animToUpdate:Vector.<IAnimatable> = new Vector.<IAnimatable>();
    private var _numToUpdate:int = 0;

    private var _addedToJuggler:Boolean = false;
    private var _stage:Stage;

    public function GAFAnimator() {
    }

    public function init(stage:Stage):void {
        if (_stage) {
            throw new Error("GAFAnimator is already inited");
        }
        _stage = stage;
        _stage.addEventListener(Event.ADDED, updateUpdatableList);
        _stage.addEventListener(Event.REMOVED, updateUpdatableList);
        updateUpdatableList();
    }

    public function add(anim:IAnimatable):void {
        if (anim && _animAll.indexOf(anim) == -1) {
            _animAll.push(anim);
        }
    }

    public function remove(anim:IAnimatable):void {
        var id:int = _animAll.indexOf(anim);
        if (id != -1) {
            _animAll.splice(id, 1);
            var currentId:int = _animToUpdate.indexOf(anim);
            if (currentId != -1) {
                if (_i > -1 && currentId <= _i) {
                    _i--;
                }
                _animToUpdate.splice(currentId, 1);
                _numToUpdate--;
            }
        }
    }

    public function pause(anim:IAnimatable):void {
        remove(anim);
    }

    public function resume(anim:IAnimatable):void {
        add(anim);
        updateUpdatableList();
    }

    private function updateUpdatableList(e:Event = null):void {
        _numToUpdate = 0;
        var i:int = _animAll.length;
        while (i--) {
            var anim:IAnimatable = _animAll[i];
            var mc:GAFMovieClip = anim as GAFMovieClip;
            if (!mc || mc.stage) {
                _animToUpdate[_numToUpdate++] = anim;
            }
        }
        if (_numToUpdate < _animToUpdate.length) {
            _animToUpdate.length = _numToUpdate;
        }
        if (_numToUpdate > 0 && !_addedToJuggler) {
            Starling.juggler.add(this);
            _addedToJuggler = true;
        } else if (_numToUpdate == 0 && _addedToJuggler) {
            Starling.juggler.remove(this);
            _addedToJuggler = false;
        }
    }

    private var _i:int = -1;

    public function advanceTime(time:Number):void {
        for (_i = 0; _i < _numToUpdate; _i++) {
            _animToUpdate[_i].advanceTime(time);
        }
        _i = -1;
    }

    public function destroy():void {
        _stage.removeEventListener(Event.ADDED, updateUpdatableList);
        _stage.removeEventListener(Event.REMOVED, updateUpdatableList);
        _stage = null;
        if (_addedToJuggler) {
            Starling.juggler.remove(this);
        }
        _animAll = _animToUpdate = null;
        _numToUpdate = 0;
    }
}
}
