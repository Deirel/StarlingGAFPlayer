package com.catalystapps.gaf.data
{
	import com.catalystapps.gaf.core.gaf_internal;
import com.catalystapps.gaf.data.config.CTextureAtlas;
import com.catalystapps.gaf.data.config.ICTextureAtlasProvider;
import com.catalystapps.gaf.display.GAFMovieClip;
import com.junkbyte.console.Cc;
import com.catalystapps.gaf.data.config.IParticleProvider;

import starling.animation.IAnimatable;

import starling.core.Starling;

	use namespace gaf_internal;
/**
	 * The GAF class defines global GAF library settings
	 */
	public class GAF
	{
		/**
		 * Optimize draw calls when animation contain mixed objects with alpha &lt; 1 and with alpha = 1.
		 * This is done by setting alpha = 0.99 for all objects that has alpha = 1.
		 * In this case all objects will be rendered by one draw call.
		 * When use99alpha = false the number of draw call may be much more
		 * (the number of draw calls depends on objects order in display list)
		 */
		public static var use99alpha: Boolean;

		/**
		 * Play sounds, triggered by the event "gafPlaySound" in a frame of the GAFMovieClip.
		 */
		public static var autoPlaySounds: Boolean = true;

		/**
		 * Indicates if mipMaps will be created for PNG textures (or enabled for ATF textures).
		 */
		public static var useMipMaps: Boolean;

		public static var pixelMaskEnabled: Boolean = true;

		public static var filtersEnabled: Boolean = true;

		public static var mcFrameDispatchEventsEnabled: Boolean = true;

		public static var mcPlaybackEventsEnabled: Boolean = true;

		public static var useBitmapFonts: Boolean = false;

		public static var defaultBitmapFontTextFormatFactory:Function = null;

		/** @private */
		gaf_internal static var useDeviceFonts: Boolean;

		private static var _animator:IAnimator;

		public static var useAnimator:Boolean = true;

		public static var maskController:IMaskController;

		/** @private */
		gaf_internal static function get maxAlpha(): Number
		{
			return use99alpha ? 0.99 : 1;
		}

		public static function set globalAtlasProvider(value:ICTextureAtlasProvider): void
		{
			CTextureAtlas.globalProvider = value;
		}
		public static function get animator():IAnimator
		{
			return _animator ? _animator : _animator = new GAFAnimator();
		}
	}
}

