import StringTools.*;
import Std.*;
import Tools;

using hx.strings.Strings;
using Lambda;

class Day9 {
    static function main() {
        var arr = parsefile();
        var s1 = solution1(arr);
        var s2 = solution2(arr, s1.lows);
        Sys.println('Part 1: ${s1.pt1}\nPart 2: ${s2}');
    }

    static function parsefile() {
        var con: AS = [for (i in sys.io.File.getContent('Advent Files_2021/Day9.txt').split('\n')) trim(i)];
        var arr: AAI = [for (i in con) i.split('').map(item -> parseInt(item))]; 
        return arr;
    }

    static function solution1(arr: AAI) {
        var ttl = 0;
        var lows: AAI = [];
        for (row => rval in arr) {
            for (col => cval in rval) {
                var tmp = nbrs(arr, [row, col]).vals;
                if (tmp.filter(item -> cast(item, Int) > cval).length == tmp.length) {
                    ttl += cval + 1;
                    lows.push([row, col]);
                }
            }
        }
        return {lows: lows, pt1: ttl};
    }

    static function solution2(arr: AAI, lows: AAI) {
        var basin = [for (i in lows) [i]];
        var m = [for (i in lows) [i.join("") => arrValue(arr, i)]];
        
        while (basin.count(item -> item.empty()) != basin.length) {
            for (ind => i in basin) {
                var tmp: AAI = [];
                for (j in i) {
                    var lowest: Int = arrValue(arr, j);
                    var n4 = nbrs(arr, j).indices.filter(item -> arrValue(arr, item) != 9 && cast(arrValue(arr, item), Int) > lowest && !m[ind].exists(item.join("")));
                    tmp = tmp.concat(n4);
                    for (vals in n4) m[ind][vals.join("")] = arrValue(arr, vals);
                }
                basin[ind] = tmp;
            }
        }
        var sol = [for (i in m) i.count()];
        sol.sort((a, b) -> b - a);
        return intProd(sol.slice(0, 3));
    }   
}
