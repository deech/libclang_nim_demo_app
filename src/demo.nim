include buildFlags

import libclang_bindings/raw/index
import libclang_bindings/porcelain
import system, options, os, parseopt, strformat

proc printEnums(c:Cursor,_:Option[Cursor]) =
  if c.kind == CXCursor_EnumConstantDecl:
    echo(fmt"Cursor spelling, value: {c.spelling} {clang_getEnumConstantDeclValue(c.cxCursor)}")

template printHelp() = echo "./demo /path/to/a-header-file.H"

var filename:string
for kind, key, val in getOpt():
  case kind
  of cmdArgument:
    filename = key
  of cmdLongOption, cmdShortOption:
     case key
     of "help", "h": printHelp()
     else: discard
  of cmdEnd: discard
if filename == "":
  printHelp()
else:
  parseFile(
    os.absolutePath filename,
    printEnums
  )
