import StringTools.*;
import Std.*;
import Math.*;
import haxe.macro.*;
import haxe.ds.*;
import Tools;

using hx.strings.Strings;
using Lambda;

class Day7_2021 {
    static function main() {
        var arr = parsefile();
        solution1(arr);
    }

    static function parsefile() {
        var arr:AI = [for (i in sys.io.File.getContent('Advent Files_2021/Day7.txt').split(',')) parseInt(i)];
        return arr;
    }

    static function solution1(arr: AI) {
        arr.sort((a,b) -> a - b);
        var mid = arr[int(arr.length / 2)];
        trace(floatSum([for (i in arr) abs(i - mid)]));
        
        var mean = floor(intSum(arr) / arr.length);
        var calc = function(x:Float) return (x*(x+1)/2);
        trace(floatSum([for (x in arr) calc(abs(x - mean))]));
    }
}