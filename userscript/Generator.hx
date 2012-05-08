package userscript;

import haxe.macro.Expr;

class Generator
{
    private var meta:Metadata;

    public function new(meta:Metadata)
    {
        this.meta = meta;
    }

    private function get_string_value(e:ExprDef):String
    {
        switch (e) {
            case EConst(c):
                switch (c) {
                    case CString(val):
                        return val;
                    default:
                }
            default:
        }

        return null;
    }

    private function get_values(e:ExprDef):Array<String>
    {
        var out:Array<String> = new Array();

        switch (e) {
            case EConst(c):
                switch (c) {
                    case CString(val):
                        return [val];
                    default:
                }
            case EArrayDecl(a):
                for (val in a) {
                    out.push(this.get_string_value(val.expr));
                }
            default:
        }

        return out;
    }
}
