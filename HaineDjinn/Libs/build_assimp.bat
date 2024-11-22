setlocal

:: Clear PATH var env
set PATH=C:\windows\system32
set PATH=%PATH%;C:\Program Files\CMake\bin\

:: Disable tools, unit tests and exporters
set FEATURES=-DBUILD_SHARED_LIBS=FALSE ^
	-DASSIMP_BUILD_ASSIMP_TOOLS=FALSE ^
	-DASSIMP_BUILD_TESTS=FALSE ^
	-DASSIMP_BUILD_ALL_IMPORTERS_BY_DEFAULT=FALSE ^
	-DASSIMP_NO_EXPORT=TRUE

:: Enable only importers that we need
:: AMF 3DS AC ASE ASSBIN B3D BVH COLLADA DXF CSM HMP IRRMESH IQM IRR LWO LWS M3D MD2 MD3 MD5 MDC MDL NFF NDO OFF OBJ OGRE OPENGEX PLY MS3D COB BLEND IFC XGL FBX Q3D Q3BSP RAW SIB SMD STL TERRAGEN 3D X X3D GLTF 3MF MMD
set IMPORTERS=-DASSIMP_BUILD_GLTF_IMPORTER=TRUE ^
	-DASSIMP_BUILD_OBJ_IMPORTER=TRUE ^
	-DASSIMP_BUILD_FBX_IMPORTER=TRUE

:: Setup build (in assimp-build dir)
cmake -S assimp -B assimp-build --install-prefix %~dp0\assimp-lib %FEATURES% %IMPORTERS%

:: Lanunch builds
cmake --build assimp-build --parallel --config Release
cmake --build assimp-build --parallel --config Debug
:: Lanunch install (copy headers + .lib) (in assimp-install dir)
cmake --install assimp-build --prefix %~dp0\assimp-install\release --config Release
cmake --install assimp-build --prefix %~dp0\assimp-install\debug --config Debug
