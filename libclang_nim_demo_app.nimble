version       = "0.1.0"
author        = "Aditya Siram"
description   = "Bindings to LibClang"
license       = "MIT"
backend       = "c"
srcDir        = "src"
bin           = @["demo"]

requires "nim >= 1.3.3"
requires "https://github.com/deech/libclang_bindings#c5c1d042a2440d1316e92df68d6a2af538ce9f7c"

import os

# The 'nimscript_utils' and 'libclang_nim_bundler' repos contain
# the Nims scripts needed to build and link a local 'libclang'.
# We need them at this point in the build so the rest can depend on
# them.
let bundlerGit = "https://github.com/deech/libclang_nim_bundler"
let nimscript_utilsGit = "https://github.com/deech/nimscript_utils"

proc cloneIfNeeded(root: string, repoDir: string, url: string) =
  if (not system.existsDir(root / repoDir)):
    echo "Cloning " & url & " into " & root
    withDir root:
      exec("git clone --depth 1 " & url)

let root =  projectDir() / "src"
cloneIfNeeded(root, "libclang_nim_bundler", bundlerGit)
cloneIfNeeded(root / "libclang_nim_bundler", "nimscript_utils", nimscript_utilsGit)

import src/libclang_nim_bundler/bundle

task setup, "Download and build libclang locally":
  bundle.build()
