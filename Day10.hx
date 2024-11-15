import haxe.Int64;
import StringTools.*;
import Std.*;
import Tools;

using hx.strings.Strings;
using Lambda;

class Day10 {
    static function main() {
        var con = parseFile();
        var sol = syntax(con);
        Sys.println('Part 1: ${sol.ttl}\nPart 2: ${sol.ttl2}');
    }

    static inline function parseFile() {
        var con: AS = [for (i in sys.io.File.getContent('Advent Files_2021/Day10.txt').split('\n')) trim(i)];
        return con;
    }

    static function syntax(con: AS) {
        var valid = ["[", "{", "<", "("];
        var mp: Map<String, String> = ["]" => "[", "}" => "{", ")" => "(", ">" => "<", 
                                       "[" => "]", "{" => "}", "(" => ")", "<" => ">"];
        var scorer: Map<String, Int> = [")" => 3, "]" => 57, "}" => 1197, ">" => 25137];
        var scorer2: Map<String, Int> = [")" => 1, "]" => 2, "}" => 3, ">" => 4];
        var incomplete: AAS = [];
        var ttl = 0;
        
        for (i in con) {
            var b: Array<String> = [];
            for (j in i.split("")) {
                if (valid.contains(j)) b.push(j);
                else if (mp[j] == b[b.length - 1]) b.pop();
                else {
                    ttl += scorer[j];
                    b = [];
                    break;
                }
            }
            if (b.length > 0) incomplete.push(b); 
        }

        var ttl2: AI64 = [];
        for (i in incomplete) {
            var tmp: Int64 = 0;
            for (j in new ReverseIterator(i.length - 1, 0)) {
                tmp *= 5;
                tmp += scorer2[mp[i[j]]];
            }
            ttl2.push(tmp);
        }

        ttl2.sort((a, b) -> Int64.compare(a, b));

        return {ttl: ttl, ttl2: ttl2[Std.int(ttl2.length / 2)]};
    }
}