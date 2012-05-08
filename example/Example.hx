package;

@name("Haxe UserScript example")
@namespace("http://www.example.com/my_example_userscript/")
@description("This is some example userscript written in Haxe.")
@include(["http://www.example.com/*", "http://*.example.org/foo/", "*"])
@run_at("document-end")

@watch_for("ready", "true")

class Example implements userscript.UserScript
{
    public function new()
    {
        js.Lib.alert("Hello world!");
    }

    public static function main()
    {
        new Example();
    }
}
