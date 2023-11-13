import StringTools.*;
import Std.*;
import Math.*;

using hx.strings.Strings;

typedef AI = Array<Int>;
typedef AS = Array<String>;
typedef AAS = Array<Array<String>>;
typedef AAAS = Array<Array<Array<String>>>;

class Day4_2021{
    static function main() {
        var con:AS = [for (i in sys.io.File.getContent('Advent Files_2021/Day4.txt').split('\n')) trim(i)];
        var nums:AI = [for (i in con[0].split(',')) parseInt(i)];
        var con:AAS = [for (i in con.slice(2,con.length)) replace(i, "  ", " " ).split(' ')];
        var tmpArr:AAS = [], tmptmp:AAS = [[],[],[],[],[]]; 
        var boards:AAAS = [];
        var boards2:AAAS = []; 

        for (i in con) {
            if (i.toString() != [].toString()) tmpArr.push(i);
            else {
                boards.push(tmpArr);
                tmpArr = [];    
            }
        }
        for (i in con) {
            for (ind => val in i) {
                if (i.toString() != [].toString()) tmptmp[ind].push(val);
                else {
                    boards2.push(tmptmp);
                    tmptmp = [[],[],[],[],[]];
                }
            }
        }

        trace(winner(boards,boards2,nums));
        trace(loser(boards,boards2,nums));
    }

    static function winner(boards:AAAS, boards2:AAAS, nums:AI): Int {
        var sum = 0, final_num = 0;
        for (k in nums) {
            for (i in 0...boards.length) {
                for (ind => j in boards[i]) {
                    boards[i][ind] = boards[i][ind].filter(item -> item != '$k');
                    boards2[i][ind] = boards2[i][ind].filter(item -> item != '$k');
                    if (boards[i][ind].toString() == [].toString()) {
                        final_num = k;
                        for (x in boards[i]) {
                            for (y in x) sum += parseInt(y);
                        }
                        return sum * final_num;
                    }
                    if (boards2[i][ind].toString() == [].toString()) {
                        final_num = k;
                        for (x in boards2[i]) {
                            for (y in x) sum += parseInt(y);
                        }
                        return sum * final_num;
                    }
                }
            }
        }
        return null;
    }

    static inline function loser(boards:AAAS, boards2:AAAS, nums:AI): Int {
        var final_num = 0, last_win = 0, board = 0, sum = 0;
        for (k in nums) {
            for (i in 0...boards.length) {
                for (ind => j in boards[i]) {
                    if (boards[i].filter(item -> item.toString() == [].toString()).length == 0 &&  
                        boards2[i].filter(item -> item.toString() == [].toString()).length == 0) {
                        boards[i][ind] = boards[i][ind].filter(item -> item != '$k');
                        boards2[i][ind] = boards2[i][ind].filter(item -> item != '$k');
                        if (boards[i][ind].toString() == [].toString()) {
                            final_num = k;
                            last_win = i;
                        }
                        if (boards2[i][ind].toString() == [].toString()) {
                            final_num = k;
                            last_win = i;
                            board = 1;
                        }
                    }   
                }
            }
        }
        if (board == 0) {
            for (i in boards[last_win]) {
                for (j in i) sum += parseInt(j);
            }
        }
        else {
            for (i in boards2[last_win]) {
                for (j in i) sum += parseInt(j);
            }
        }
        return (sum * final_num);
    }
}