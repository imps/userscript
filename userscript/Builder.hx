package userscript;

import haxe.macro.Expr;
import haxe.macro.Type;

class Builder
{
    public static function extract_meta(cls:ClassType, file:String)
    {
        var meta = cls.meta.get();
        var usheader = MetaGenerator.generate(meta);
        usheader += "\n#CODE_HERE#\n";

        // remove all metadata
        for (m in meta) {
            cls.meta.remove(m.name);
        }

        var outfile = sys.io.File.write(file, false);
        outfile.writeString(usheader);
        outfile.close();
    }

    @:macro public static function build():Array<Field>
    {
        switch (haxe.macro.Context.getLocalType()) {
            case TInst(c, _):
                var cls = c.get();
                Builder.extract_meta(cls, "cncta.user.js");
            default:
        }

        return null;
    }

    public static function generate(infile:String, outfile:String)
    {
        var script = new MetaGenerator(outfile);
        script.from_infile(infile);
        script.write(outfile);
    }
}
