fun assert_true(value : bool, comment : string) = 
  if value then 
		""(*"Assertion is valid \"" ^ comment ^ "\"\r\n"*)
	else 
		"Assertion is INVALID \"" ^ comment ^ "\"\r\n";
(* 课堂练习 *)
(* 1.在提示符下以此输入下列语句，观察并分析每次语句的执行结果 *)
(* 3 + 4；*)
(* val it = 7 : int *)
(* a + 8; *)
(* 报错，没有绑定的变量 a *)
(* todo *)

(* 2.下列模式能否与类型为 int list 的 L 匹配成功？如果匹配不成功，指出该模式的类型（假设 x 为 int 类型） *)
(* x::L *)
(* 可以 *)
(* _::_ *)
(* 可以 *)
(* x::(y::L) *)
(* 可以 *)
(* (x::y)::L *)
(* 不可以， int list list 类型 *)
(* [x, y] *)
(* 如果 L 的大小为 2 的话可以匹配 *)

(* 3.试写出与下列表述相对应的模式。如果没有模式与其对应，试说明原因 *)
(* list of length 3 *)
(* [x, y, z] *)
(* x::L *)
(* lists of length 2 or 3 *)
(* 没有可以匹配的模式，表里面的元素大小必须一致 *)
(* non-empty lists of pairs *)
(* (x, y)::L *)
(* Pairs with both components being non-empty lists *)
(* (x::L, r::R) *)

(* 4.分析下述程序段 *)
val x: int = 3;
val temp: int = x + 1;
fun assemble(x: int, y: real): int =
    let val g: real = let val x: int = 2
            val m: real = 6.2 * (real x)
            val x: int = 9001
            val y: real = m * y
        in y - m
        end
    in
        x + (trunc g)
    end

val z = assemble(x, 3.0);
print(Int.toString(z) ^ "\n");
(* 第四行中的 x， 第五行中的 m 和第六行中的 x 的声明绑定的类型和值分别是什么？ *)
(* 第 14 行表达式 assemble(x, 3.0) 计算的结果是什么？ *)
(* 第四行的 x 绑定的类型是 Int， 值是 2 *)
(* 第五行的 m 绑定的类型是 real，值是 12.4 *)
(* 第六行的 x 绑定的类型是 int， 值是 9001 *)
(* 27 *)

(* 5.编写函数实现下列功能 *)
(* zip: string list * int list -> (string * int) list *)
fun zip([]: string list, []: int list): (string * int) list = []
    | zip(x::S, y::I) = (x, y)::zip(S, I)
    | zip(x::S, []) = []
    | zip([], y::I) = [];


val s: string list = ["hello", "world"];
val i: int list = [1, 2];
val res: (string * int) list = zip(s, i);
assert_true(res = [("hello", 1), ("world", 2)], "zip error!");

(* unzip: (string * int) list -> string list * int list *)
fun unzip([]: (string * int) list): string list * int list = ([], [])
    | unzip((x, y)::L) =
        let val (M, N) = unzip(L)
        in (x::M, y::N)
        end;

assert_true((s, i) = unzip(res), "unzip error!");

(* 正式实验内容 *)
(* 函数 sum 用于求解整数列表中所有整数的和，函数定义如下 *)
(* sum: int list -> int *)
(* REQUIRES: true *)
(* ENSURES: sum(L) evaluates to the sum of the integers in L *)
fun sum([]: int list): int = 0
    | sum(x::L) = x + (sum L);

val v: int list = [1, 2, 3];
print(Int.toString(sum(v)) ^ "\n");

(* 完成函数 mult 的编写，实现求解整数列表中所有整数的乘积 *)
(* mult: int list -> int *)
(* REQUIRES: true *)
(* ENSURES: mult(L) evaluates to the product of the integers in L. *)
fun mult([] : int list): int = 1
    | mult(x::L) = x * (mult L);

val v: int list = v @ [4, 5];
print(Int.toString(mult(v)) ^ "\n");

(* 完成 Mult: int list list -> int 的编写，该函数调用 mult 实现 int list list 中所有整数乘积的求解 *)
(* Mult: int list list -> int *)
(* REQUIRESL true *)
(* ENSURES: Mult(R) evaluates to the product of all the integers in the lists of R *)
fun Mult([]: int list list): int = 1
    | Mult(r::R) = (mult r) * (Mult R);

val v: int list list = [[1, 2, 3], [2, 3, 4]];
print(Int.toString(Mult(v)) ^ "\n");

(* 函数 mult' 定义如下，试补充其函数说明，指出该函数的功能 *)
(* 功能：对任意整数的列表 R 和整数 a，计算 a 与列表 R 中所有整数的乘积 *)
(* mult': int list -> int *)
(* REQUIRES: true *)
(* ENUSRES: mult'(L, a) evaluates to the product of all the integers in the list and interger of a *)
fun mult'([]: int list, a: int): int = a
    | mult'(x::L, a) = x * (mult' (L, a));

val v: int list = [1, 2, 3];
val a: int  = 2;
print(Int.toString(mult'(v, a)) ^ "\n");

(* 利用 mult' 定义函数 Mult': int list list * int -> int， *)
(* 使对任意整数列表的列表 R 和整数 a，该函数用于计算 a 与列表 R 中所有整数的乘积 *)
fun Mult'([]: int list list,  a: int): int = a
    | Mult'(r::R, a) = (mult' (r, 1)) * (Mult' (R, a));

val v: int list list = [[1, 2, 3], [2, 3, 4]];
print(Int.toString(Mult'(v, 2)) ^ "\n");

(* 编写递归函数 square 实现整数平方的计算，既 square n = n * n *)
(* 要求程序中可调用函数 double，但不能使用整数乘法运算 *)
(* double: int -> int *)
(* REQUIRES: n >= 0 *)
(* ENSURES: double n evaluates to 2 * n *)
fun double(0: int): int = 0
    | double(n) = 2 + double (n - 1)

val n: int = 2;
print(Int.toString(double(n)) ^ "\n");

(* square: int -> int *)
(* REQUIRES: n>= 0 *)
(* ENUSERS: square n evaluates to n * n *)
(* n * n = (n - 1) * (n - 1) + 2 * (n - 1) + 1 *)
fun square(0: int): int = 0
    | square(n) = square(n - 1) + double(n - 1) + 1;

val n: int = 3;
print(Int.toString(square(n)) ^ "\n");

(* 定义函数 divisibleByTree: int -> bool *)
(* 使当 n 为 3 的倍数时，divisibleTree n 为 true, 否则为 false *)
(* 程序中不能使用求余函数 mod *)
(* divisibleByTree: int -> bool *)
(* REQUIRES: true *)
(* ENUSRES: divisibleByTree n evaluates to true if n is a multiple of 3 and to false otherwise *)
fun divisibleByTree(0: int): bool = true
    | divisibleByTree(1) = false
    | divisibleByTree(2) = false
    | divisibleByTree(n) = divisibleByTree(n - 3);

val n: int = 3;
print(Bool.toString(divisibleByTree(n)) ^ "\n");
val n: int = 5;
print(Bool.toString(divisibleByTree(n)) ^ "\n");

(* 函数 evenP 为偶函数判断函数，当且仅当该数为偶数的时候返回 true *)
(* evenP: int -> bool *)
(* REQUIRES: n >= 0 *)
(* ENUSRES: evenP n evaluates to true iff n is even *)
fun evenP(0: int): bool = true
    | evenP(1) = false
    | evenP(n) = evenP(n - 2);

val n: int = 4;
print(Bool.toString(evenP(n)) ^ "\n");
val n: int = 5;
print(Bool.toString(evenP(n)) ^ "\n");

(* oddP: int -> bool *)
(* REQUIRES: n >= 0 *)
(* ENUSRES: oddP n evaluates to true iff n is odd *)
fun oddP(0: int): bool = false
    | oddP(1) = true
    | oddP(n) = oddP(n - 2);

val n: int = 4;
print(Bool.toString(oddP(n)) ^ "\n");
val n: int = 5;
print(Bool.toString(oddP(n)) ^ "\n");
