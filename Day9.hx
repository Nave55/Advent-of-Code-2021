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
        var nines = [for (i in 0...con[0].length + 2) '9'].join("");
        var arr: AS = [nines].concat([for (i in con) i.insertAt(0, '9') + '9']).concat([nines]);
        var arr: AAI = [for (i in arr) i.split('').map(item -> parseInt(item))]; 
        return arr;
    }

    static function solution1(arr: AAI) {
        var ttl = 0;
        var row_len = arr.length - 1;
        var col_len = arr[0].length - 1;
        var lows: AAI = [];
        for (i in 1...row_len) {
            for (j in 1...col_len) {
                if (arr[i][j] < arr[i][j-1] && arr[i][j] < arr[i][j+1] &&
                    arr[i][j] < arr[i-1][j] && arr[i][j] < arr[i+1][j]) { 
                        ttl += arr[i][j] + 1;
                        lows.push([i, j]);
                }
            }
        }
        return {lows: lows, pt1: ttl};
    }

    static function solution2(arr: AAI, lows: AAI) {
        var dir = [[0, 1], [0, -1], [1, 0], [-1, 0]];
        var basin = [for (i in lows) [i]];
        var m = [for (i in lows) [i.join("") => arrValue(arr, i)]];
        
        while (basin.count(item -> item.empty()) != basin.length) {
            for (ind => i in basin) {
                var tmp: AAI = [];
                for (j in i) {
                    var lowest: Int = arrValue(arr, j);
                    for (k in dir) {
                        var adj_val: Int = arrValue(arr, addArrs(j, k));
                        var adj_ind = addArrs(j, k);
                        if (adj_val != 9 && adj_val > lowest && !m[ind].exists(adj_ind.join(""))) {
                            tmp.push(adj_ind);
                            m[ind][adj_ind.join("")] = adj_val;
                        }
                    } 
                }
                basin[ind] = tmp;
            }
        }
        var sol = [for (i in m) i.count()];
        sol.sort((a, b) -> b - a);
        return intProd(sol.slice(0, 3));
    }   
}
