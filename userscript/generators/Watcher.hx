package userscript.generators;

private typedef Target = {
    var name:String;
    var value:String;
}

class Watcher
{
    private var targets:List<Target>;

    public function new()
    {
        this.targets = new List();
    }

    /*
       Observe specified variable. If a second argument is passed, check if the
       variable has that specific value.
     */
    public function watch(on:String, ?value:String)
    {
        this.targets.add({name: on, value: value});
    }

    private function get_checks():String
    {
        var code = "";

        for (target in this.targets) {
            if (code.length > 0)
                code += "&&";

            code += target.value != null ?
                target.name + "==" + target.value :
                "typeof(" + target.name + ")" + "!=" + "'undefined'";
        }

        return code;
    }

    /*
       Generate the observer, passing an argument which is called as soon as
       all observed variables meet the conditions.
     */
    public function generate(cb:String):String
    {
        var retry = "window.setTimeout(watch_timer__, 1000)";

        var code = "";
        code += "function watch_timer__(){";
        code +=     "if(" + this.get_checks() + "){";
        code +=         cb + ";";
        code +=     "} else {";
        code +=         retry + ";";
        code +=     "}";
        code += "}";
        code += retry + ";";

        return code;
    }
}
