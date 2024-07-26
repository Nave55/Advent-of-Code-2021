import haxe.macro.Type.AnonType;
import haxe.macro.Expr;
import haxe.Int64;
import Std.*;
import Math.*;

using Lambda;
using hx.strings.Strings;

typedef AS =   Array<String>;
typedef AI =   Array<Int>;
typedef AA =   Array<Any>;
typedef AF =   Array<Float>;
typedef ANI =  Array<Null<Int>>;
typedef ANF =  Array<Null<Float>>;
typedef AAS =  Array<Array<String>>;
typedef AAI =  Array<Array<Int>>;
typedef AAF =  Array<Array<Float>>;
typedef AAA =   Array<Array<Any>>;
typedef AANI = Array<Array<Null<Int>>>;
typedef AANF = Array<Array<Null<Float>>>;
typedef AAAS = Array<Array<Array<String>>>;
typedef AAAI = Array<Array<Array<Int>>>;
typedef AAAF = Array<Array<Array<Float>>>;
typedef MII =  Map<Int,    Int>;
typedef MSI =  Map<String, Int>;
typedef MIS =  Map<Int,    String>;
typedef MSS =  Map<String, String>;
typedef MI64 = Map<Int,    Int64>;
typedef MS64 = Map<String, Int64>;

/**
 * [Swaps two variables]
 
    Example:

        swap(a, b) -> Void

@param a The first variable
@param b The second variable
@return No return value
*/

macro function swap(a:Expr, b:Expr) {
    return macro {var v = $a; $a = $b; $b = v;};
}

/**
 * [Adds the values of two arrays together to form a new array]
 
    Example:

        var arr1 = [1, 2, 3, 4];

        var arr2 = [1, 2, 3, 4];

        addArrs(arr1, arr2) -> [2, 4, 6, 8]
        
@param arr An AI.
@param arr2 An AI.
@return An AI
*/

inline function addArrs(arr: AI, arr2: AI): AI {
    return [for (i in 0...arr.length) arr[i] + arr2[i]];
}

/**
 * [Find value in AAA using an AI]
 
    Example:'

        var arr =  [[1, 2, 3], [4, 5]]

        var arr2 = [0, 0]

        arrValue(arr, arr2) -> [1, 2, 3]

@param arr An AAA
@param arr2 An AI
@return An AI
*/

inline function arrValue(arr: AAA, arr2: AI) {
    return arr[arr2[0]][arr2[1]];
}

/**
 * [Get list of neighbor indices and values in a 2d array.]
 
    Example:'

        var arr =  [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

        var loc = [1, 1]

        arrValue(arr, loc) -> {indices: [[0, 1], [2, 1], [1, 2], [1 ,0]], values: [2, 8, 7, 9]}

@param arr An AAA
@param loc An AI
@return A struct of AAI and AA
*/

function nbrs(arr: AAA, loc: AI) {
    var dir = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    var indices: AAI = [];
    var vals: AA = [];
    for (i in dir) {
        var tmp = addArrs(loc, i);
        if (tmp[0] != -1 && tmp[1] != -1 && tmp[0] != arr.length && tmp[1] != arr[0].length) {
            indices.push(tmp);
            vals.push(arrValue(arr, tmp));
        }
    }
    return {indices: indices, vals: vals};
}

/**
 * [Sums an array of Ints]
 
    Example:
        
        intSum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) -> 55

@param arr An array that you want the sum of.
@return An Int value
*/

inline function intSum(arr: Array<Int>): Int {
    var ttl = 0;
    for (i in arr) ttl += i;
    return ttl;
}

/**
 * [Sums an array of Floats]
 
    Example:
        
        floatSum([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]) -> 55.0

@param arr An array that you want the sum of.
@return A Float value
*/

inline function floatSum(arr: Array<Float>): Float {
    var ttl:Float = 0;
    for (i in arr) ttl += i;
    return ttl;
}

/**
 * [Product of an array of Ints]
 
    Example:
        
        intProd([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) -> 3,628,800

@param arr An array that you want the product of.
@return An Int value
*/

inline function intProd(arr: Array<Int>): Int {
    var ttl = 1;
    for (i in arr) ttl *= i;
    return ttl;
}

/**
 * [Product of an array of Floats]
 
    Example:
        
        floatProd([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]) -> 3,628,800

@param arr An array that you want the sum of.
@return A Float value
*/

inline function floatProd(arr: Array<Float>): Float {
    var ttl:Float = 1.0;
    for (i in arr) ttl *= i;
    return ttl;
}

/**
 * [Min value of an array]
 
    Example:
        
        minVal([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]) -> 1.0

@param arr An array that you want to find the min value for.
@return A Float value
*/

inline function minVal(arr: Array<Any>): Float {
    var tmp: Float = arr[0];
    for (i in 1...arr.length) tmp = Math.min(tmp, arr[i]);
    return tmp;
}

/**
 * [Max value of an array]
 
    Example:
        
        maxVal([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]) -> 10.0

@param arr An array that you want to find the max value for.
@return A Float value
*/

inline function maxVal(arr: Array<Any>): Float {
    var tmp: Float = arr[0];
    for (i in 1...arr.length) tmp = Math.max(tmp, arr[i]);
    return tmp;
}

/**
 * [Converts binary to decimal]
 
    Example:

        binaryToDecimal("01011100") -> "92"

@param str The string to be converted.
@return Returns a string representation of the decimal value.
*/

inline function binaryToDecimal(str: String): String {
    var iter = str.length - 1;
    var dec = 1, ttl = 0;
    while (iter >= 0) {
        if (str.charAt(iter) == '1') ttl += dec;
        dec *= 2;
        --iter;
    }
    return string(ttl);
}

/**
 * [Converts decimal to binary]
 
    Example:

        binaryToDecimal("92") -> "1011100"

        binaryToDecimal("92", true) -> "01011100"

@param num The Int to be converted
@param eight Boolean that insures the string has 8 values
@return Returns a string representation of the binary value.
*/

inline function decimalToBinary(num: Int, eight = false): String {    
    var strs: String = ""; 
    while (num > 0) {
        if (num & 1 == 1) strs += "1";
        else strs += "0";
        num >>= 1;
    }
    if (eight) for (i in 0...8 - strs.length) strs += "0";
    return strs.reverse();
}

/**
 * [Sort string alphabetically]
 
    Example:

        alpabetSort("edcba") -> "abcde"
        alphabetSort("edcba", true) -> "edcba"

@param str The string to be sorted.
@param reverse A boolean to indicate whether the string should be reversed.
@return Returns a sorted string
*/

function alphabetSort(str: String, reverse = false): String {
    var arr: AI = [];
    for (i in 0...str.length) arr.push(str.charCodeAt(i));
    !reverse ? arr.sort((a, b) -> a - b) : arr.sort((a, b) -> b - a);
    return arr.map(item -> item.toChar().toString()).join("");
}

/**
 * Allows for the use of the '|' pipeline operator
 
    Example: 

        var arr = ['hey', 'how', 'are', 'you']; 

        var ans = new Pipe(arr)

            | (function(a:Array<String>) return a.join(' ') + "?")

            | (function(str:String) return str.charAt(0).toUpperCase() + str.substring(1))

            | (function(str:String) return str.replaceAll('you?', 'your) + ' parents doing?');

        trace(ans);

    Output: Hey how are your parents doing?
 */

abstract Pipe<T>(T) to T {
    public inline function new(s:T) {
        this = s;
    }

    @:op(A | B)
    public inline function pipe1<U>(fn:T->U):Pipe<U> {
        return new Pipe(fn(this));
    }

    @:op(A | B) 
    public inline function pipe2<A, B>(fn:T->A->B):Pipe<A->B> {
        return new Pipe(fn.bind(this));
    }

    @:op(A | B)
    public inline function pipe3<A, B, C>(fn:T->A->B->C):Pipe<A->B->C> {
        return new Pipe(fn.bind(this));
    }

    @:op(A | B)
    public inline function pipe4<A, B, C, D>(fn:T->A->B->C->D):Pipe<A->B->C->D> {
        return new Pipe(fn.bind(this));
    }

    @:op(A | B)
    public inline function pipe5<A, B, C, D, E>(fn:T->A->B->C->D->E):Pipe<A->B->C->D->E> {
        return new Pipe(fn.bind(this));
    }
    @:op(A | B)
    public inline function pipe6<A, B, C, D, E, F>(fn:T->A->B->C->D->E->F):Pipe<A->B->C->D->E->F> {
        return new Pipe(fn.bind(this));
    }
    @:op(A | B)
    public inline function pipe7<A, B, C, D, E, F, G>(fn:T->A->B->C->D->E->F->G):Pipe<A->B->C->D->E->F->G> {
        return new Pipe(fn.bind(this));
    }
    @:op(A | B)
    public inline function pipe8<A, B, C, D, E, F, G, H>(fn:T->A->B->C->D->E->F->G->H):Pipe<A->B->C->D->E->F->G->H> {
        return new Pipe(fn.bind(this));
    }
    @:op(A | B)
    public inline function pipe9<A, B, C, D, E, F, G, H, I>(fn:T->A->B->C->D->E->F->G->H->I):Pipe<A->B->C->D->E->F->G->H->I> {
        return new Pipe(fn.bind(this));
    }
    @:op(A | B)
    public inline function pipe10<A, B, C, D, E, F, G, H, I, J>(fn:T->A->B->C->D->E->F->G->H->I->J):Pipe<A->B->C->D->E->F->G->H->I->J> {
        return new Pipe(fn.bind(this));
    }
}
