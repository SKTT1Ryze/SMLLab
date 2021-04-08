(* 课堂练习 *)
(* 1.在提示符下以此输入下列语句，观察并分析每次语句的执行结果 *)
(* 3 + 4；*)
(* val it = 7 : int *)
(* a + 8; *)
(* 报错，没有绑定的变量 a *)

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

(* 3.试写出与下列表述相对应的模式。如果没有模式与其对应，试说明原因 *)
(* list of length 3 *)
(* lists of length 2 or 3 *)
(* non-empty lists of pairs *)
(* Pairs with both components being non-empty lists *)

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
(* unzip: (string * int) list -> string list * int list *)

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
(* mult': int list -> int *)
(* REQUIRES: true *)
(* ENUSRES: mult'(L, a) evaluates to the product of all the integers in the list and interger of a *)
fun mult'([]: int list, a: int): int = a
    | mult'(x::L, a) = x * (mult' (L, a));

val v: int list = [1, 2, 3];
val a: int  = 2;
print(Int.toString(mult'(v, a)) ^ "\n");