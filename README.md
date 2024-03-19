# OpenGLConfigurator
pascal header generator for OpenGL from specs

Missing files can be found at https://github.com/EugenPolyakov/OpenGLTools and https://github.com/EugenPolyakov/pascal-utils
OpenGL specs can be loaded from https://github.com/KhronosGroup/OpenGL-Registry/tree/main/xml

##Support console arguments:

'/f' load xml file
'/static' export extensions with static links (can use masks *?)
'/dynamic' export extensions with dynamic (manual) linking (can use masks *?)
'/except' excluded extensions (can use masks *?)
'/out' output file name
'/arrays' generate Delphi types for arrays, for example Vec3f = array [0..2] of Single; and all *Vec3f will generate const/var xx: Vec3f
'/enums' generate enums from block of constants
'/unicode' generate for unicode pascal
'/cfuncs' if use /arrays will generate both functions with Delphi style arguments and C style arguments
'/getproc' add static link to wglGetProcAddress
'/important' convert enums to sets
'/excluded' excluded enums from generation (recomended Boolean)
