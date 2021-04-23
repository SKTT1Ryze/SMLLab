fun assert_true(value : bool, comment : string): string = 
  if value then 
		"assert pass" ^ "\n"
	else 
		"Assertion is INVALID \"" ^ comment ^ "\"\r\n"

(* 将整数翻倍 *)
fun double(x) = x + x;

(* 编写函数 thenAddOne，要求： *)
(* 函数类型为：((int -> int) * int) -> int *)
(* 功能为将一个整数通过函数变换（翻倍，求平方或求阶乘）后再加 1 *)
fun thenAddOne(f: int -> int, x: int): int = f(x) + 1;

val x = 2;
val y = thenAddOne(double, x);
val res = assert_true(y = 5, "theAddOne error");
print(res);

(* 编写函数	maplist，要求 *)
(* 函数类型为：(('a -> 'b) * 'a list) -> 'b list *)
(* 功能为实现整数集的数学变换(翻倍，求平方或求阶乘) *)
fun maplist(f, []) = [] |
	maplist(f, x::L) = f(x)::maplist(f, L);

val v = [1, 2, 3];
val v' = maplist(double, v);
val res = assert_true(v' = [2, 4, 6], "maplist error");
print(res);

(* 编写函数 maplist'，要求 *)
(* 函数类型为：('a -> 'b) -> ('a list -> 'b list) *)
(* 功能为实现整数集的数学变换 *)
(* 比较 maplist 和 maplist'，分析体会有什么不同 *)
fun maplist'(f) =
	fn(L) => case L of
		[] => [] |
		x::L => f(x)::(maplist' f)L;

val v = [1, 2, 3];
val f = maplist'(double);
val v' = f(v);
val res = assert_true(v' = [2, 4, 6], "maplist' error");
print(res);

(* 编写函数 findOdd，要求 *)
(* 函数类型为 int list -> int option *)
(* 功能为：如果 x 为 L 中的第一个奇数，则返回 SOME x，否则返回 NONE *)
fun findOdd([]: int list): int option = NONE |
	findOdd(x::L) = if x mod 2 = 0 then findOdd(L) else SOME(x);

val v = [1, 2, 3];
val y = findOdd(v);
val res = assert_true(y = SOME(1), "findOdd error");
print(res);

(* 编写函数： *)
(* treeFilter: ('a -> bool) -> 'a tree -> 'a option tree *)
(* 将树中满足条件 p('a -> bool) 的节点封装成 option 类型保留，否则替换成 NONE *)

(* 树类型定义 *)
datatype 'a tree = Empty | Node of 'a tree * 'a * 'a tree

fun is_even(x) = x mod 2 = 0;

fun treeFilter(f: 'a -> bool): 'a tree -> 'a option tree =
	let
		fun res_f(Empty: 'a tree) = Empty |
			res_f(Node(s1, x, s2)) = Node(res_f(s1), if f(x) then SOME(x) else NONE, res_f(s2));
	in
		res_f
	end;

