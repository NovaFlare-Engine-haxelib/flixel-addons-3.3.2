# NovaFlare additive compatibility interfaces

Restores the original tiled sprite lifecycle/drawing, tilemap overlap callback and transition state lifecycle. Runtime shader sampler methods and subclass override metadata are additive interfaces only. Existing runtime methods are not replaced.

The earlier broad integration changed existing behavior and is superseded by this repair. Compatibility additions must preserve existing NF calls, defaults and update/render/audio paths. Unsupported additions may return a neutral result instead of replacing a legacy implementation.

Windows x64 and Android ARMv7/ARM64/x86_64 native Lime binaries have been rebuilt. The full game targets Windows x64 and Android ARM64. Visual gameplay acceptance is performed manually by the project owner.
