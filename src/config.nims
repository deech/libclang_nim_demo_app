import strformat
import libclang_nim_bundler/bundle

switch("d", fmt"libclangBuildIncludeFlags={bundle.includePath}")
switch("d", fmt"libclangBuildLibDir={bundle.libraryPath}")
switch("gc","arc")
