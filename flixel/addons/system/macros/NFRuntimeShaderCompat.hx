package flixel.addons.system.macros;
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using Lambda;
/** Complements project overrides without replacing their runtime shader implementation. */
class NFRuntimeShaderCompat {
 public static function build():Array<Field> {
  // Existing project subclasses may already expose these methods without override.
  Context.getLocalClass().get().meta.add(":autoBuild",
   [macro flixel.addons.system.macros.NFRuntimeShaderCompat.buildOverrides()], Context.currentPos());
  var fields=Context.getBuildFields();
  var compatibility = macro class {
	public function setBitmapData(name:String, value:openfl.display.BitmapData):Void
	{
		final shaderInput:openfl.display.ShaderInput<openfl.display.BitmapData> = Reflect.field(data, name);

		if (shaderInput == null)
		{
			trace('[WARN] Shader sampler2D input "$name" not found.');
			return;
		}

		shaderInput.input = value;
	}
	public function getBitmapData(name:String):Null<openfl.display.BitmapData>
	{
		final shaderInput:openfl.display.ShaderInput<openfl.display.BitmapData> = Reflect.field(data, name);

		if (shaderInput == null)
		{
			trace('[WARN] Shader sampler2D input "$name" not found.');
			return null;
		}

		return shaderInput.input;
	}
  };
  for (field in compatibility.fields) if (!fields.exists(f -> f.name == field.name)) fields.push(field);
  return fields;
 }
 public static function buildOverrides():Array<Field> {
  var fields=Context.getBuildFields();
  for (field in fields) if (field.name == "setBitmapData" || field.name == "getBitmapData") switch (field.kind) {
   case FFun(_):
    if (field.access == null) field.access=[];
    if (!field.access.contains(AStatic) && !field.access.contains(AOverride)) field.access.push(AOverride);
   default:
  }
  return fields;
 }
}
#end
