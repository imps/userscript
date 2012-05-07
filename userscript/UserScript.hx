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
        var script = new MetaGenerator(outfile);
        script.from_infile(infile);
        script.write(outfile);
        return null;
    }
}
#else
@:autoBuild(userscript.Builder.build()) interface UserScript {}
#end
