/**
 * Created by petr on 17.10.2016.
 */
package com.catalystapps.gaf.data {
import starling.animation.IAnimatable;

public interface IAnimator {
    function add(anim:IAnimatable):void;
    function remove(anim:IAnimatable):void;
    function pause(anim:IAnimatable):void;
    function resume(anim:IAnimatable):void;
}
}
