package userscript;

#if macro
import haxe.macro.Type;
import haxe.macro.Expr;
#end

#if macro
class UserScript
{
    @:macro public static function generate(infile:String):Expr
    {
        var outfile = Builder.get_uscript_filename(infile);
        var template = sys.io.File.getContent(outfile);

        var code = new jsmin.JSMin(sys.io.File.getContent(infile)).output;

        var out = sys.io.File.write(outfile, false);
        out.writeString(
            StringTools.replace(template, Constants.CODE_PLACEHOLDER, code)
        );
        out.close();
        return null;
    }
}
#else
@:autoBuild(userscript.Builder.build()) interface UserScript {}
#end
