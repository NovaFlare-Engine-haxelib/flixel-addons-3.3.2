# NovaFlare compatibility

Adds bitmap input access to FlxRuntimeShader, nested-sprite insertion, and compatibility members. Backdrop/SkewedSprite inherit NF's shaderEnabled property instead of redeclaring it.

The Lime include.xml installs an idempotent build macro for projects that override the original Shader/FlxRuntimeShader source files. It supplies only missing compatibility fields and preserves existing implementation logic. Direct haxe users with overrides can add the corresponding NFShaderCompat/NFRuntimeShaderCompat build metadata explicitly.

Upstream licenses and contributor notices are preserved.
