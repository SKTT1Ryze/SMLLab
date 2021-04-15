fun assert_true(value : bool, comment : string): string = 
  if value then 
		"assert pass" ^ "\n"
	else 
		"Assertion is INVALID \"" ^ comment ^ "\"\r\n"

(* 函数式编程实验二 *)
(* 分析以下函数或表达式的类型 *)
fun all(your, base) =
    case your of
        0 => base |
        _ => "are belong to us"::all(your - 1, base)

fun funny(f, []) = 0 |
    funny(f, x::xs) = f(x, funny(f, xs))

(fn x => (fn y => x)) "Hello, World"

(* 参看 ppt page 4-7 的提示，用归纳法证明 ins 函数和 isort 函数的正确性*)
datatype order = LESS | EQUAL | GREATER;
fun compare(x: int, y: int): order =
    if x < y then LESS else
    if y < x then GREATER else EQUAL

(* 对任一整数 x 和有序整数序列 L，函数 ins(x, L) 计算结果为 x 和 L 中所有元素构成的一个有序序列 *)
fun ins(x, []) = [x] |
    ins(x, y::L) = case compare(x, y) of
        GREATER => y::ins(x, L) |
        _ => x::y::L

(* 对所有整数序列 L，isort L 计算得到 L 中所有元素的一个有序排列 *)
fun isort [] = [] |
    isort (x::L) = ins(x, isort L)

(* 分析下面斐波拉契函数的时间复杂度 *)
fun fib n = if n <=2 then 1 else fib(n - 1) + fib(n - 2);
fun fibber(0: int): int * int = (1, 1) |
    fibber(n :int): int * int =
        let val (x: int, y: int) = fibber(n - 1)
        in (y, x + y)
        end

(* 正式实验内容 *)
(* 编写函数 reverse 和 reverse'，要求 *)
(* 函数类型均为：int list -> int list，功能均为实现输出表参数的逆序输出 *)
(* 函数 reverse 不能借助任何帮助函数；函数 reverse' 可以借助帮助函数，时间复杂度为0(n) *)
fun reverse([]: int list, R: int list): int list = R |
    reverse(x::L, R) = reverse(L, x::R)

val v: int list = [1, 2, 3];
val res = assert_true(reverse(v, []) = [3, 2, 1], "reverse error!");
print(res);

fun reverse'([]: int list): int list = [] |
    reverse'(x::L) = reverse'(L)@[x]

val v: int list = [1, 2, 3];
val res = assert_true(reverse'(v) = [3, 2, 1], "reverse' error!");
print(res);

(* 编写函数 interleave: int list * int list -> int list *)
(* 该函数能实现两个 int list 数据的合并，并且两个 list 中的元素在结果中交替出现，直至其中一个 int list 数据结束 *)
(* 而另一个 int list 数据中的剩余元素则直接附加至结果数据的尾部 *)
fun interleave(([], []): int list * int list): int list = [] |
    interleave((x::L, y::R)) = [x, y]@interleave((L, R)) |
    interleave((x::L, [])) = x::interleave((L, [])) |
    interleave(([], y::R)) = y::interleave(([], R))

val v_1: int list = [1, 2, 3];
val v_2: int list = [4, 5, 6, 7, 8];
val res = assert_true(interleave((v_1, v_2)) = [1, 4, 2, 5, 3, 6, 7, 8], "reverse' error!");
print(res);

val v_1: int list = [];
val v_2: int list = [4, 5, 6, 7];
val res = assert_true(interleave((v_1, v_2)) = [4, 5, 6, 7], "reverse' error!");
print(res);

val v_1: int list = [1, 2, 3];
val v_2: int list = [];
val res = assert_true(interleave((v_1, v_2)) = [1, 2, 3], "reverse' error!");
print(res);

(* 编写函数 listToTree: int list -> tree *)
(* 将一个表转换成一棵平衡树 *)
