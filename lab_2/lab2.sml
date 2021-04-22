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

(* fn: int * string list -> string list *)

fun funny(f, []) = 0 |
    funny(f, x::xs) = f(x, funny(f, xs))

(* fn: ('a * int -> int) * 'a list -> int *)

(fn x => (fn y => x)) "Hello, World"

(* fn: ?.x1 -> string *)

(* 参看 ppt page 4-7 的提示，用归纳法证明 ins 函数和 isort 函数的正确性*)
datatype order = LESS | EQUAL | GREATER;
fun compare(x: int, y: int): order =
    if x < y then LESS else
    if y < x then GREATER else EQUAL

(* 对任一整数 x 和有序整数序列 L，函数 ins(x, L) 计算结果为 x 和 L 中所有元素构成的一个有序序列 *)
fun ins(x, []) = [x] |
    ins(x, y::R) = case compare(x, y) of
        GREATER => y::ins(x, R) |
        _ => x::y::R

(* 证明： *)
(* 当 L 长度为 0 的时候，ins(x, L) 为 [x]，很明显为有序表 *)
(* 假设对所有长度小于 k 的有序表 A，ins(x, A) 为有序表 *)
(* 则对于长度为 k 的有序表 L，ins(x, L) 模式匹配到函数定义中的第二种情况 *)
(* 由于上一条假设，可以知道 ins(x, R) 为有序表，y::R 也是有序表 *)
(* 因此在 x, 大小比较的两种情况得出的结果 y::ins(x, R) 和 x::y::R 都是有序表 *)
(* 得证 *)

(* 对所有整数序列 L，isort L 计算得到 L 中所有元素的一个有序排列 *)
fun isort [] = [] |
    isort (x::L) = ins(x, isort L)

(* 当 L 长度为 0 是，结果明显是有序的 *)
(* 假设对于所有长度小于 k 的列表 L，isort(A) 为有序表 *)
(* 则对于长度为 k 的有序表 R，x::L = R, isort(L) 为有序表（因为 L 长度小于 k） *)
(* 而前面证明了 ins(x, L) 函数的正确性，因此 ins(x, isort L) 是有序的 *)
(* 得证 *)

(* 分析下面斐波拉契函数的时间复杂度 *)
fun fib n = if n <=2 then 1 else fib(n - 1) + fib(n - 2);
(* O(2^n) *)
fun fibber(0: int): int * int = (1, 1) |
    fibber(n :int): int * int =
        let val (x: int, y: int) = fibber(n - 1)
        in (y, x + y)
        end
(* O(n) *)

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
(*树类型定义*)
datatype tree = Empty | Node of tree * int * tree;

(*树的中序遍历*)
fun trav(Empty: tree): int list = [] |
    trav(Node(t1, x, t2)) = trav(t1)@(x::trav(t2));

(* int list -> int list * int * int list *)
(* 将 list 拆分成长度相差小于 1 的两个 list *)
fun split([]: int list): (int list * int * int list) = raise Fail "cannot split empty list" |
    split(L: int list) =
    let
        val mid = (length L) div 2
        val M = (List.take(L, mid))
        fun help([]: int list): int * int list = (0, []) |
            help(x::L) = (x, L)
        val (y, R) = help(List.drop(L, mid))
    in
        (M, y, R)
end

(* listToTree: int list -> tree *)
fun listToTree([]: int list): tree = Empty |
    listToTree (L: int list)=
    let
        val (L, x, R) = split(L)
    in
        Node(listToTree(L), x , listToTree(R))
end

val v: int list = [1, 2, 3, 4, 5]
val btree = listToTree(v)
val v = trav(btree)
val res = assert_true(v = [1, 2, 3, 4, 5], "listToTree error");
print(res);

(* 对树进行反转 *)
(* tree -> tree *)
fun revT(Empty: tree): tree = Empty |
    revT(Node(s1, x, s2)) = Node(revT(s2), x, revT(s1))

val v: int list = [1, 2, 3, 4, 5]
val btree = listToTree(v)
val v = revT(btree)
val v = trav(v)
val res = assert_true(v = [5, 4, 3, 2, 1], "revT error");
print(res);
(* 验证程序正确性： *)
(* 当 node 为空结点时，revT 结果也为空结点，显然结果正确 *)
(* 当 node 为叶子结点时，revT 结果也为叶子结点，显然结果正确 *)
(* 假设对所有深度小于 h 的非叶子结点 N，revT(N) 的结果正确 *)
(* 则对于深度为 k 的非叶子结点 R，R = Node(s1, x, s2)，则 s1, s2 深度都小于 k *)
(* 因此 revT(s1) 和 revT(s2) 的结果都正确，进而 revT(R) 的结果正确 *)
(* work: O(n) *)
(* span: 最坏情况下树的 n 个结点呈线性排列，span(n) = O(xn)；最好情况下树为完全二叉树，span(N) = O(logN) *)

(* tree * int -> bool *)
fun binarySearch(Empty: tree, _: int) = false |
    binarySearch(Node(s1, x, s2), value) =
        case compare(value, x) of
            LESS => binarySearch(s1, value) |
            EQUAL => true |
            GREATER => binarySearch(s2, value)
