/**
 * Created by Pavel Suvorov on 10.02.2017.
 */
package com.catalystapps.gaf.data.config {
public interface IParticleProvider {
    function  getParticleFactory(behaviour:String):IParticleFactory
}
}
