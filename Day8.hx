import StringTools.*;
import Std.*;
import Math.*;
import haxe.macro.*;
import haxe.ds.*;
import Tools;

using hx.strings.Strings;
using Lambda;

class Day8 {
    static function main() {
        var con = parsefile();
        var part1 = solution1(con);
        var part2 = solution2(con);
        Sys.println('Part 1: $part1\nPart 2: $part2');
    }

    static inline function parsefile() {
        var con:AS = [for (i in sys.io.File.getContent('Advent Files_2021/Day8.txt').split('\n')) trim(i)];
        return con;
    }

    static function solution1(con: AS): Int {
        var ttl = 0;
        var con = [for (i in con) trim(i.split('|')[1])];
        for (i in con) {
            for (j in i.split(' ')) {
                if (j.length == 2 || j.length == 3 || j.length == 4 || j.length == 7) ttl++;
            }
        }
        return ttl;
    }

    static function solution2(lst: AS): Int {
        var con = [for (i in lst) trim(i.split('|')[0])];
        var con1 = [for (i in lst) trim(i.split('|')[1])];
        var cnt = 0;
        var final_arr: AI = [];
        
        for (i in con) {
            var str = "";
            var mp = new MIS(), mp2 = new MSI();
            var arr: AS = [], tmp: AS = [];

            for (j in i.split(' ')) {
                j = alphabetSort(j);
                if (j.length == 2) mp[1] = j;
                else if (j.length == 3) mp[7] = j;
                else if (j.length == 4) mp[4] = j;
                else if (j.length == 7) mp[8] = j;
                else arr.push(j);
            }

            for (j in arr) {
                if (j.length == 6) {
                    if (j.containsAll(mp[1].split('')) == false) mp[6] = j;
                    else if (j.containsAll(mp[4].split('')) == true) mp[9] = j;
                    else mp[0] = j; 
                }
                else if (j.length == 5) {
                    if (j.containsAll(mp[1].split('')) == true) mp[3] = j;
                    else tmp.push(j);
                }
            }
            for (j in tmp) {
                if (mp[6].containsAll(j.split('')) == true) mp[5] = j;
                else mp[2] = j;
            }
            for (j in mp.keyValueIterator()) mp2[j.value] = j.key;

            for (j in con1[cnt].split(' ')) {
                str += string(mp2[alphabetSort(j)]);
            }
            final_arr.push(parseInt(str));
            cnt++;
        }
        return intSum(final_arr);
    }
}