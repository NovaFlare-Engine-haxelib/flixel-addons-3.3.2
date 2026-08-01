package flixel.addons.editors.spine.texture;

import flixel.graphics.FlxGraphic;
import openfl.Assets;
import openfl.display.BitmapData;
import spinehaxe.atlas.AtlasPage;
import spinehaxe.atlas.AtlasRegion;
import spinehaxe.atlas.TextureLoader;
#if sys
import sys.FileSystem;
#end

class FlixelTextureLoader implements TextureLoader
{
	var prefix:String;

	public function new(prefix:String)
	{
		this.prefix = prefix;
	}

	public function loadPage(page:AtlasPage, path:String):Void
	{
		var fullPath:String = prefix + path;
		var bitmapData:BitmapData = null;

		#if sys
		if (FileSystem.exists(fullPath) && !FileSystem.isDirectory(fullPath))
			bitmapData = BitmapData.fromFile(fullPath);
		#end

		if (bitmapData == null)
			bitmapData = Assets.getBitmapData(StringTools.replace(fullPath, "\\", "/"));
		if (bitmapData == null)
			throw("BitmapData not found on disk or in Assets: " + fullPath);
		page.rendererObject = FlxG.bitmap.add(bitmapData);
		page.width = bitmapData.width;
		page.height = bitmapData.height;
	}

	public function loadRegion(region:AtlasRegion):Void {}

	public function unloadPage(page:AtlasPage):Void
	{
		FlxG.bitmap.remove(cast page.rendererObject);
	}
}
