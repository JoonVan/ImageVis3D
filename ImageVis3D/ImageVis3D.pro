######################################################################
# Generated by Jens Krueger
######################################################################

TEMPLATE          = app
CONFIG           += link_prl static warn_on stl exceptions
TARGET            = ../Build/ImageVis3D
RCC_DIR           = ../Build/rcc
OBJECTS_DIR       = ../Build/objects
UI_DIR            = UI/AutoGen
MOC_DIR           = UI/AutoGen
DEPENDPATH       += . ../Tuvok/Basics ../Tuvok/Controller Tuvok/DebugOut
DEPENDPATH       += ../Tuvok/IO ../Tuvok/Renderer ../Tuvok/Scripting
DEPENDPATH       += ../Tuvok/Build
DEPENDPATH       += DebugOut IO UI UI/AutoGen
INCLUDEPATH      += . ../Tuvok/3rdParty/boost ../Tuvok/3rdParty/GLEW ../Tuvok
QT               += opengl network
LIBS              = -L../Tuvok/Build -lTuvok
RESOURCES         = ImageVis3D.qrc
RC_FILE 	  = Resources/ImageVis3D.rc
QMAKE_INFO_PLIST  = ../IV3D.plist
ICON              = Resources/ImageVis3D.icns
unix:QMAKE_CXXFLAGS += -fno-strict-aliasing
unix:QMAKE_CFLAGS += -fno-strict-aliasing

# If this is a 10.5 machine, build for both x86 and x86_64.  Not
# the best idea (there's no guarantee the machine will have a
# 64bit compiler), but the best we can do via qmake.
macx {
    exists(/Developer/SDKs/MacOSX10.5.sdk/) {
        CONFIG += x86 x86_64
    }
}

### Should we link Qt statically or as a shared lib?
# Find the location of QtGui's prl file, and include it here so we can look at
# the QMAKE_PRL_CONFIG variable.
TEMP = $$[QT_INSTALL_LIBS] libQtGui.prl
include($$join(TEMP, "/"))

# If that contains the `shared' configuration, the installed Qt is shared.
# In that case, disable the image plugins.
contains(QMAKE_PRL_CONFIG, shared) {
  message("Shared build, ensuring there will be image plugins linked in.")
  QTPLUGIN -= qgif qjpeg qtiff
} else {
  message("Static build, forcing image plugins to get loaded.")
  QTPLUGIN += qgif qjpeg qtiff
}


# Input
HEADERS += StdDefines.h \
           UI/SettingsDlg.h \
           UI/BrowseData.h \
           UI/ImageVis3D.h \
           UI/PleaseWait.h \
           UI/FTPDialog.h \
           UI/QTransferFunction.h \
           UI/Q1DTransferFunction.h \
           UI/Q2DTransferFunction.h \
           UI/QDataRadioButton.h \
           UI/RenderWindow.h \
           UI/RenderWindowGL.h \
           UI/RAWDialog.h \
           UI/MIPRotDialog.h \ 
           UI/Welcome.h \
           UI/AboutDlg.h \
           UI/URLDlg.h \
           UI/BugRepDlg.h \
           UI/LODDlg.h \
           UI/MergeDlg.h \
           UI/CrashDetDlg.h \
           DebugOut/QTOut.h \
           DebugOut/QTLabelOut.h \
           IO/DialogConverter.h

FORMS += UI/UI/BrowseData.ui \
         UI/UI/ImageVis3D.ui \
         UI/UI/PleaseWait.ui \
         UI/UI/SettingsDlg.ui \
         UI/UI/RAWDialog.ui \
         UI/UI/FTPDialog.ui \
         UI/UI/Welcome.ui \
         UI/UI/CrashDetDlg.ui \
         UI/UI/About.ui \
         UI/UI/URLDlg.ui \
         UI/UI/LODDlg.ui \
         UI/UI/BugRepDlg.ui \
         UI/UI/MIPRotDialog.ui \
         UI/UI/MergeDlg.ui

SOURCES += UI/BrowseData.cpp \
           UI/ImageVis3D.cpp \
           UI/ImageVis3D_Capturing.cpp \
           UI/ImageVis3D_Progress.cpp \
           UI/ImageVis3D_1DTransferFunction.cpp \
           UI/ImageVis3D_2DTransferFunction.cpp \
           UI/ImageVis3D_FileHandling.cpp \
           UI/ImageVis3D_WindowHandling.cpp \
           UI/ImageVis3D_DebugWindow.cpp \
           UI/ImageVis3D_Settings.cpp \
           UI/ImageVis3D_Locking.cpp \
           UI/ImageVis3D_Stereo.cpp \
           UI/ImageVis3D_Scripting.cpp \
           UI/ImageVis3D_Help.cpp \
           UI/PleaseWait.cpp \
           UI/Welcome.cpp \
           UI/AboutDlg.cpp \
           UI/URLDlg.cpp \
           UI/FTPDialog.cpp \
           UI/BugRepDlg.cpp \
           UI/LODDlg.cpp \           
           UI/QTransferFunction.cpp \
           UI/Q1DTransferFunction.cpp \
           UI/Q2DTransferFunction.cpp \
           UI/QDataRadioButton.cpp \
           UI/RenderWindowGL.cpp \
           UI/RenderWindow.cpp \
           UI/SettingsDlg.cpp \
           UI/RAWDialog.cpp \
           UI/MIPRotDialog.cpp \           
           UI/MergeDlg.cpp \
           UI/CrashDetDlg.cpp \
           DebugOut/QTOut.cpp \
           DebugOut/QTLabelOut.cpp \
           IO/DialogConverter.cpp \
           main.cpp

win32 {
  HEADERS += UI/RenderWindowDX.h
  SOURCES += UI/RenderWindowDX.cpp
}
