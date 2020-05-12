import strformat
const LibclangBuildIncludeFlags {.strdefine.} = ""
const LibclangBuildLibDir {.strdefine.} = ""
if (not LibclangBuildIncludeFlags.len == 0):
  {.passC: fmt"-I{LibclangBuildIncludeFlags}".}
if (not LibclangBuildLibDir.len == 0):
  {.passL: fmt"-L{LibclangBuildLibDir}".}
when defined(buildQuick):
  {.passL: "-lclang -lstdc++ -ldl -lpthread"}
  when defined(macosx):
    {.passL: fmt" -L{LibclangBuildLibDir}/libz3.dylib -Wl,-rpath,{LibclangBuildLibDir}".}
  elif defined(linux):
    {.passL: fmt"-lm -Wl,-rpath={LibclangBuildLibDir}".}
else:
  {.passL: "-lclang_static_bundled -lstdc++ -lm -ldl -lpthread".}
  when defined(macosx):
    {.passL: "-lz".}
