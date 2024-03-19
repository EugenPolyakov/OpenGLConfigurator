# OpenGLConfigurator
pascal header generator for OpenGL from specs

Missing files can be found at https://github.com/EugenPolyakov/OpenGLTools and https://github.com/EugenPolyakov/pascal-utils
OpenGL specs can be loaded from https://github.com/KhronosGroup/OpenGL-Registry/tree/main/xml

## Support console arguments:

- '/f' load xml file
- '/static' export extensions with static links (can use masks *?)
- '/dynamic' export extensions with dynamic (manual) linking (can use masks *?)
- '/except' excluded extensions (can use masks *?)
- '/out' output file name
- '/arrays' generate Delphi types for arrays, for example Vec3f = array [0..2] of Single; and all *Vec3f will generate const/var xx: Vec3f
- '/enums' generate enums from block of constants
- '/unicode' generate for unicode pascal
- '/cfuncs' if use '**arrays**' will generate both functions with Delphi style arguments and C style arguments
- '/getproc' add static link to wglGetProcAddress
- '/important' export the required enums/sets anyway, even if they are not used in functions
- '/excluded' excluded enums from generation (recomended Boolean)

`
OpenGLConfigurator /f "gl.xml" /f "wgl.xml" /dynamic "gl_version_1_? gl_version_2_? WGL_ARB_create_context GL_ARB_texture_non_power_of_two GL_ARB_texture_rectangle GL_EXT_framebuffer_object" /static "gl_version_1_0 gl_version_1_1" /getproc /arrays /unicode /out "OpenGL.pas" /important "TextureMagFilter TextureMinFilter" /excluded "Boolean"
`

Will export static OpenGL **1.0**, **1.1** and dynamic **1.2**, **1.3**, **1.4**, **1.5**, **2.0**, **2.1**, **WGL_ARB_create_context**, **GL_ARB_texture_non_power_of_two**, **GL_ARB_texture_rectangle**, **GL_EXT_framebuffer_object**.
