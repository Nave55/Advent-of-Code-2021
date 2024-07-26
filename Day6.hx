import haxe.Int64;
import StringTools.*;
import Std.*;
import Math.*;
import haxe.macro.*;
import haxe.ds.*;
import Tools;

using hx.strings.Strings;

class Day6 {
    static function main() {
        var mp = parsefile();
        solution(mp);
    }

    static function parsefile(): Map<Int,Int64> {
        var con:AI = [for (i in sys.io.File.getContent('Advent Files_2021/Day6.txt').split(',')) parseInt(i)];
        var mp: Map<Int, Int64> = [];
        for (i in 0...9) mp.set(i, 0);
        for (i in con) mp.set(i, mp[i] + 1);
        return mp;
    }

    static function solution(mp: Map<Int,Int64>) {
        var sum:Int64 = 0, sum2:Int64 = 0;
        for (j in 1...257) {
            var six:Int64 = 0, eight:Int64 = 0;
            for (i in 0...9) {
                if (i == 0) {
                    six = mp[0];
                    eight = mp[0];
                }
                else mp[i - 1] = mp[i];
            }
            mp[6] += six;
            mp[8] = eight;
            if (j == 80) for (i in mp) sum += i;
            if (j == 256) for (i in mp) sum2 += i;          
        }
        Sys.println('Part 1: $sum\nPart 2: $sum2');
    }
}