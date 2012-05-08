package userscript;

import haxe.macro.Expr;

typedef StringMeta = {
    var name:String;
    var values:List<String>;
}

class Generator
{
    private var meta:List<StringMeta>;

    public function new(meta:Metadata)
    {
        this.meta = new List();

        for (m in meta) {
            var name:String = m.name;
            var values:List<String> = new List();

            for (p in m.params) {
                values = Lambda.concat(values, this.get_values(p.expr));
            }

            this.meta.add({name: name, values: values});
        }
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

    private function get_values(e:ExprDef):List<String>
    {
        var out:List<String> = new List();

        switch (e) {
            case EConst(c):
                switch (c) {
                    case CString(val):
                        out.add(val);
                        return out;
                    default:
                }
            case EArrayDecl(a):
                for (val in a) {
                    out.add(this.get_string_value(val.expr));
                }
            default:
        }

        return out;
    }
}
