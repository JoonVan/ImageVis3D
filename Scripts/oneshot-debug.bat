REM Script to build everything we can in a single invocation, using
REM a set of options which is appropriate for creating debug builds.

set w32_cf="-D_CRT_SECURE_NO_WARNINGS=1 -D_SCL_SECURE_NO_WARNINGS=1"
REM qmake -tp vc ^
REM  QMAKE_CFLAGS+=%w32_cf% ^
REM  QMAKE_CXXFLAGS+=%w32_cf% ^
REM  -recursive ^
REM  ImageVis3d.pro
REM hardcoding vs2010 express for now =(
REM set bld="C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\VCExpress.exe"

set bld="msbuild"
IF "%1"=="x64" (
  REM Handle 64 bit compilation
  call "%VS100COMNTOOLS%\..\..\VC\vcvarsall.bat" x64
  %bld% ^
    ImageVis3D-2010.sln ^
    /nologo ^
    /p:Configuration="Debug",Platform=x64 ^
    /t:Rebuild
) ELSE (
  REM Handle 32 bit compilation
  call "%VS100COMNTOOLS%\..\..\VC\vcvarsall.bat"
  %bld% ^
    ImageVis3D-2010.sln ^
    /nologo ^
    /p:Configuration="Debug",Platform=Win32 ^
    /t:Rebuild
)

pushd Tuvok\IO\test
  python ../3rdParty/cxxtest/cxxtestgen.py ^
    --no-static-init ^
    --error-printer ^
    -o alltests.cpp ^
    quantize.h ^
    jpeg.h

  qmake -tp vc ^
    QMAKE_CFLAGS+=%w32_cf% ^
    QMAKE_CXXFLAGS+=%w32_cf% ^
    -recursive ^
    test.pro

  %bld% ^
    cxxtester.vcproj ^
    /nologo ^
    /t:Rebuild
popd

REM download documentation
set manual="http://www.sci.utah.edu/images/docs/imagevis3d.pdf"
set mdata="http://ci.sci.utah.edu:8011/devbuilds/GettingDataIntoImageVis3D.pdf"
wget --no-check-certificate -q %manual%
wget --no-check-certificate -q %mdata%

REM bundle it.
IF "%1"=="x64" (
  iscc Scripts/installer/64-debug.iss
) ELSE (
  iscc Scripts/installer/32-debug.iss
)
