import haxe.macro.Expr;

typedef AS = Array<String>;
typedef AI = Array<Int>;
typedef AF = Array<Float>;
typedef AAS = Array<Array<String>>;
typedef AAI = Array<Array<Int>>;
typedef AAF = Array<Array<Float>>;
typedef AAAS = Array<Array<Array<String>>>;
typedef AAAI = Array<Array<Array<Int>>>;
typedef AAAF = Array<Array<Array<Float>>>;


macro function swap(a:Expr, b:Expr) {
    return macro {var v = $a; $a = $b; $b = v;};
}

function sum(arr:Array<Int>):Int {
    var ttl = 0;
    for (i in arr) ttl += i;
    return ttl;
}