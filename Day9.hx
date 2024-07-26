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
        var arr: AS = [];
        var nines = [for (i in 0...con[0].length + 2) '9'].join("");
        for (i in con) arr.push(i.insertAt(0, '9') + '9');
        arr.push(nines);
        arr.insert(0, nines);
        var arr: AAI = [for (i in arr) i.split('').map(item -> parseInt(item))]; 
        return arr;
    }

    static function solution1(arr: AAI) {
        var ttl = 0;
        var row_len = arr.length;
        var col_len = arr[0].length;
        var lows: AAI = [];
        for (i in 1...row_len-1) {
            for (j in 1...col_len-1) {
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
        
        while (true) {
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
            if (basin.filter(item -> item.length == 0).length == basin.length) break;
        }
        var sol = [for (i in m) i.count()];
        sol.sort((a, b) -> b - a);
        return intProd(sol.slice(0, 3));
    }   
}