/**
 * Created by Pavel Suvorov on 10.02.2017.
 */
package com.catalystapps.gaf.data.config {
import com.kosmos.sps.resources.*;

import starling.display.DisplayObject;
import starling.textures.Texture;

public interface IParticleFactory {


    function createParticles(texture:Texture):IParticleSystem;
}
}
