A set of macros for writing GreaseMonkey userscripts.
-----------------------------------------------------

In order to use this library, you just need to define a class implementing
userscript.UserScript which should contain the GreaseMonkey metadata as Haxe
metadata definitions. Please note that in order to use @run-at, you have to use
@run\_at, as Haxe doesn't allow dashes in metadata keywords.

All metadata must be either just String or an array of Strings. Other values are
not supported at the moment.

There is one additional metadata keyword, which isn't included in GreaseMonkey
and affects the loader code produced by this library:

@watch\_for(variable:String, ?value:String)

These definitions are executed in the order they are specified within the loader
code. It is a chain of variable to value equality checks (or existance checks if
the value is omitted) which ensure that the main Javascript code is only
executed after these conditions are met.

To compile your project using this library, you need to add an additional
compilation step, which has to contain the following macro call:

`--macro userscript.UserScript.generate(filename:String)`

Where the filename is the output file in the first compilation step. After that
postprocessing is done, you will find a file called like the specified filename
but with a suffix of `.user.js`.

For further infos about how to use the library, please have a look into the
`example` folder.
