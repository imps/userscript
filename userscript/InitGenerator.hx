package userscript;

class InitGenerator extends Generator
{
    public function get_init()
    {
        var watcher = new userscript.generators.Watcher();
        for (m in this.meta) {
            if (m.name != "watch_for")
                continue;

            if (m.values.length == 2)
                watcher.watch(m.values.first(), m.values.last());
            else if (m.values.length == 1)
                watcher.watch(m.values.first());
        }

        return watcher.generate("userscript_main_code__()");
    }

    private function get_loader():String
    {
        var code = "";

        code += "var inject__=document.createElement('script');";
        code += "inject__.setAttribute('type','text/javascript');";
        code += "inject__.innerHTML='('+userscript_closure__.toString()+')()';";
        code += "document.body.appendChild(inject__);";
        code += "document.body.removeChild(inject__);";

        return code;
    }

    private function get_main_closure():String
    {
        var code = "";
        code  = "function userscript_closure__(){";
        code +=     "function userscript_main_code__(){";
        code +=         Constants.CODE_PLACEHOLDER;
        code +=     "}";
        code +=     this.get_init();
        code += "}";

        return code;
    }

    public function generate()
    {
        var code = "";
        code += this.get_main_closure();
        code += this.get_loader();

        return "(function(){" + code + "})();";
    }
}
