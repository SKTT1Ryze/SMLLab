# **华中科技大学函数式编程原理课程报告**
计科校交 1801  
车春池  

## 函数式语言家族成员调研
下面是函数式语言家族的几个主要成员：  
+ Lisp：表处理语言，适合于数学运算
+ ML：非纯函数式编程语言，强类型，允许副作用和指令式编程
+ Miranda：基于 ML 的惰性纯函数式语言，强类型
+ Erlang：多范式编程语言，支持函数式，并发式及分布式编程风格
+ Haskell：纯函数式语言，支持惰性求值，高阶，强类型，模式匹配，列表内包，类型类和类型多态
+ OCaml：非函数式编程语言，强静态类型
+ Scala：多范式编程语言，支持对象式和函数式编程的典型特性
+ F#：基于 OCaml 的非纯函数式编程语言，强静态类型，适合程序核心数据多线程处理
+ Clojure：针对 JVM 平台且基于 Lisp 的动态函数式编程语言，支持高阶函数和惰性计算
## 实验设计与实现
### 实验一
#### 问题
实现函数 sum 用于求解整数列表中所有整数的和，函数定义如下：  
```sml
(* sum: int list -> int *)
```
#### 思路
简单使用递归即可。  
#### 解答  
```sml
fun sum([]: int list): int = 0
    | sum(x::L) = x + (sum L);
```

#### 测试  
```sml
val v: int list = [1, 2, 3];
print(Int.toString(sum(v)) ^ "\n");
```

#### 问题
完成 mult 函数的编写，实现求解整数列表中所有整数的乘积，函数定义如下：  
```sml
(* mult: int list -> int *)
```

#### 思路
和上一题一样，通过递归来实现。  

#### 解答
```sml
fun mult([] : int list): int = 1
    | mult(x::L) = x * (mult L);
```
#### 测试
```sml
val v: int list list = [[1, 2, 3], [2, 3, 4]];
print(Int.toString(Mult(v)) ^ "\n");
```

#### 问题
函数 mult' 定义如下，补充其函数说明，指出该函数的功能：  
```sml
fun mult'([]: int list, a: int): int = a
    | mult'(x::L, a) = x * (mult' (L, a));
```
#### 思路
分析代码，发现函数每次从列表中取出一个元素，并递归下去，直到空表的时候返回常数参数。  
#### 解答
功能：对任意整数的列表 R 和整数 a，计算 a 与列表 R 中所有整数的乘积。  
#### 测试
```sml
val v: int list = [1, 2, 3];
val a: int  = 2;
print(Int.toString(mult'(v, a)) ^ "\n");
```

#### 问题
编写递归函数 square 实现整数平方的计算，要求程序中可调用函数 double，但不能使用整数乘法运算。  
#### 思路
n * n = (n - 1) * (n - 1) + 2 * (n - 1) + 1.  
#### 解答
```sml
fun double(0: int): int = 0
    | double(n) = 2 + double (n - 1);

fun square(0: int): int = 0
    | square(n) = square(n - 1) + double(n - 1) + 1;
```
#### 测试
```sml
val n: int = 3;
print(Int.toString(square(n)) ^ "\n");
```

#### 问题
编写函数 divisibleByTree，使当 n 为 3 的倍数时，divisiblelTree n 为 true，否则为 false。  
要求：程序不能使用求余函数 mod。  

#### 思路
利用模式匹配。  
#### 解答
```sml
fun divisibleByTree(0: int): bool = true
    | divisibleByTree(1) = false
    | divisibleByTree(2) = false
    | divisibleByTree(n) = divisibleByTree(n - 3);
```
#### 测试
```sml
val n: int = 3;
print(Bool.toString(divisibleByTree(n)) ^ "\n");
val n: int = 5;
print(Bool.toString(divisibleByTree(n)) ^ "\n");
```

#### 问题
编写偶数判断函数，当且仅当该数为偶数的时候返回 true。  
#### 思路
利用模式匹配和递归。  
#### 解答
```sml
fun evenP(0: int): bool = true
    | evenP(1) = false
    | evenP(n) = evenP(n - 2);
```
#### 测试
```sml
val n: int = 4;
print(Bool.toString(evenP(n)) ^ "\n");
val n: int = 5;
print(Bool.toString(evenP(n)) ^ "\n");
```

#### 问题
编写奇数判断函数，当且仅当该数为偶数的时候返回 true。  
#### 思路
利用模式匹配和递归。  
#### 解答
```sml
fun oddP(0: int): bool = false
    | oddP(1) = true
    | oddP(n) = oddP(n - 2);
```
#### 测试
```sml
val n: int = 4;
print(Bool.toString(oddP(n)) ^ "\n");
val n: int = 5;
print(Bool.toString(oddP(n)) ^ "\n");
```
### 实验二
#### 问题
编写函数 reverse 和 reverse'，要求功能均为实现输出表参数的逆序输出。  
reverse 不能借助任何帮助函数，reverse‘ 可以借助帮助函数，时间复杂度为O(n)  
#### 思路
通过递归解决。  
#### 解答
```sml
fun reverse([]: int list, R: int list): int list = R |
    reverse(x::L, R) = reverse(L, x::R);

fun reverse'([]: int list): int list = [] |
    reverse'(x::L) = reverse'(L)@[x];
```
#### 测试
```sml
val v: int list = [1, 2, 3];
val res = assert_true(reverse(v, []) = [3, 2, 1], "reverse error!");
print(res);

val v: int list = [1, 2, 3];
val res = assert_true(reverse'(v) = [3, 2, 1], "reverse' error!");
print(res);
```

#### 问题
编写函数 interleave: int list * int list -> int list.  
该函数实现两个 int list 数据的合并，并且两个 list 中的元素在结果中交替出现，直至其中一个 int list 数据结束。  
而另一个 int list 数据中的剩余元素则直接附加至结果数据的尾部。  
#### 思路
通过模式匹配和递归解决。  
#### 解答
```sml
fun interleave(([], []): int list * int list): int list = [] |
    interleave((x::L, y::R)) = [x, y]@interleave((L, R)) |
    interleave((x::L, [])) = x::interleave((L, [])) |
    interleave(([], y::R)) = y::interleave(([], R))
```
#### 测试
```sml
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
```

#### 问题
编写函数 listToTree: int list -> tree，将一个表转换成一棵平衡树。  
#### 思路
借助 PPT 里面的 split 函数。  
#### 解答
```sml
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
end;

fun listToTree([]: int list): tree = Empty |
    listToTree (L: int list)=
    let
        val (L, x, R) = split(L)
    in
        Node(listToTree(L), x , listToTree(R))
end;
```
#### 测试
```sml
val v: int list = [1, 2, 3, 4, 5]
val btree = listToTree(v)
val v = trav(btree)
val res = assert_true(v = [1, 2, 3, 4, 5], "listToTree error");
print(res);
```

#### 问题
编写函数 revT，对树进行反转。  
#### 思路
暴力递归。  
#### 解答
```sml
fun revT(Empty: tree): tree = Empty |
    revT(Node(s1, x, s2)) = Node(revT(s2), x, revT(s1))
```
#### 测试
```sml
val v: int list = [1, 2, 3, 4, 5]
val btree = listToTree(v)
val v = revT(btree)
val v = trav(v)
val res = assert_true(v = [5, 4, 3, 2, 1], "revT error");
print(res);
```

#### 问题
编写函数 binarySearch，在书中查找节点。  
#### 思路
对有序树进行二分查找。  
#### 解答
```sml
fun binarySearch(Empty: tree, _: int) = false |
    binarySearch(Node(s1, x, s2), value) =
        case compare(value, x) of
            LESS => binarySearch(s1, value) |
            EQUAL => true |
            GREATER => binarySearch(s2, value);
```

### 实验三
#### 问题
编写函数 thenAddOne，要求函数类型为 ((int ->int) * int) -> int.  


#### 解答
```sml
fun thenAddOne(f: int -> int, x: int): int = f(x) + 1;
```
#### 测试
```sml
val x = 2;
val y = thenAddOne(double, x);
val res = assert_true(y = 5, "theAddOne error");
print(res);
```

#### 问题
编写函数 maplist，要求函数类型为 (('a -> 'b) * 'a list) -> 'b list.  

#### 思路
参考课件 PPT 上 map 函数的实现。  
#### 解答
```sml
fun maplist(f, []) = [] |
	maplist(f, x::L) = f(x)::maplist(f, L);
```
#### 测试
```sml
val v = [1, 2, 3];
val v' = maplist(double, v);
val res = assert_true(v' = [2, 4, 6], "maplist error");
print(res);
```

#### 问题
编写函数 maplist'，要求函数类型为 ('a -> 'b) -> ('a list -> 'b list).  

#### 解答
```sml
fun maplist'(f) =
	fn(L) => case L of
		[] => [] |
		x::L => f(x)::(maplist' f)L;
```
#### 测试
```sml
val v = [1, 2, 3];
val f = maplist'(double);
val v' = f(v);
val res = assert_true(v' = [2, 4, 6], "maplist' error");
print(res);
```

#### 问题
编写函数 findOdd，要求函数类型为 int list -> int option.  

#### 解答
```sml
fun findOdd([]: int list): int option = NONE |
	findOdd(x::L) = if x mod 2 = 0 then findOdd(L) else SOME(x);
```
#### 测试
```sml
val v = [1, 2, 3];
val y = findOdd(v);
val res = assert_true(y = SOME(1), "findOdd error");
print(res);
```

#### 问题
编写函数 treeFilter: ('a -> bool) -> 'a tree -> 'a option tree.  
将树中满足条件 p('a -> bool) 的节点封装成 options 类型保留，否则替换成 NONE。  
#### 解答
```sml
datatype 'a tree = Empty | Node of 'a tree * 'a * 'a tree

fun treeFilter(f: 'a -> bool): 'a tree -> 'a option tree =
	let
		fun res_f(Empty: 'a tree) = Empty |
			res_f(Node(s1, x, s2)) = Node(res_f(s1), if f(x) then SOME(x) else NONE, res_f(s2));
	in
		res_f
	end;

```

## 实验心得与体会
四次实验课，三个实验，不知不觉就过去了。当检查完第三次实验的时候，还问老师，“下次实验能不能检查附加题呀？”，得来的是老师“没有下次实验啦”的回答，实在是令人唏嘘。  
在大学最后一个在校园的学期，还能选到函数式编程原理这样可以学到东西的课程，真的十分幸运。  
我是一名 Rust 语言爱好者，Rust 语言里面也有函数式编程的思想，在学习这门语言之前，我还对那些语法不甚理解，如今我知道了那些 .map() 方法和 Fn() 类型背后的含义。  
现代很多编程语言都收到函数式编程的影响，比如前面说到的 Rust，再比如 Scala，这两者中 Option 的设计也是借鉴了函数式编程的思想。  
在三个实验中，每一个实验都是我独立完成的，做实验过程中的思考和实现后的成就感，感觉非常棒。  
感谢我的任课老师顾琳老师和检查我第三次实验的郑然老师，为我解答了很多的问题，最重要的是陪伴了我几十个学时的课堂和 4 次实验课，非常感谢。  
