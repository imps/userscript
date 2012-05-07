package userscript;

import haxe.macro.Expr;
import haxe.macro.Type;

class Builder
{
    public static function extract_meta(cls:ClassType)
    {
        var meta = cls.meta.get();
        var usheader = MetaGenerator.generate(meta);
        usheader += "\n#CODE_HERE#\n";

        // remove all metadata
        for (m in meta) {
            cls.meta.remove(m.name);
        }

        var filename:String = Builder.get_uscript_filename();
        var outfile = sys.io.File.write(filename, false);
        outfile.writeString(usheader);
        outfile.close();
    }

    public static function get_uscript_filename(?file:String):String
    {
        if (file == null)
            file = haxe.macro.Compiler.getOutput();

        var file_parts:Array<String> = file.split('.');

        if (file_parts[file_parts.length - 1] == "js") {
            file_parts.pop();
        }

        file_parts.push("user");
        file_parts.push("js");

        return file_parts.join('.');
    }

    @:macro public static function build():Array<Field>
    {
        switch (haxe.macro.Context.getLocalType()) {
            case TInst(c, _):
                var cls = c.get();
                Builder.extract_meta(cls);
            default:
        }

        return null;
    }
}
