--Answer 1
data Season = Fall | Winter | Summer | Spring
	deriving(Eq, Show)
data Month = January | February | March | April | May | June | July | August | September | October | November | December
	deriving(Eq, Show)

months :: Season -> (Month, Month, Month)
months Fall = (October, November, December)
months Spring = (April, May, June)
months Summer = (July, August, December)
months Winter = (January, February, March)

--Answer 2
data Form = And Form Form | Or Form Form | Not Form | Val Bool
	deriving(Eq, Show)
	
eval :: Form -> Bool
eval (Val True) = True
eval (Val False) = False 
eval (And (x) (y)) = ((eval (x)) && (eval (y)))
eval (Or (x) (y)) = ((eval (x)) || (eval (y)))	
eval (Not (x)) = not (eval (x)) 

--Answer 3
data NTree = Leaf Int | Node NTree Int NTree
	deriving(Eq, Show)
	
collapse :: NTree -> [Int]
collapse  (Leaf x) = [x]
collapse (Node x y z) = collapse x ++ [y] ++ collapse z

--Answer 4 
data PTree a = PLeaf | PNode a (PTree a) (PTree a)
	deriving (Show)
	
countLeaves :: PTree a -> Integer
countLeaves (PLeaf) = 1
countLeaves (PNode a b c) = countLeaves b + countLeaves c 

--Answer 5
data Store = Empty | Join Int Store Store

maxStore :: Store -> Int
maxStore Empty = 0
maxStore (Join x y z) = max x ( max(maxStore y) (maxStore z))

--Answer 6
data Expr = Num Integer| BinOp Op Expr Expr 
	deriving (Eq,Show)
data Op = Add | Mul
	deriving (Eq,Show)
	
countOp :: Op -> Expr -> Int
countOp x (BinOp y xs ys)
	|x == y = 1 + countOp x xs + countOp x ys
	|otherwise = countOp x xs + countOp x ys
countOp x _ = 0

--Answer 7
data Tree a = Nil | Value a (Tree a) (Tree a)
	deriving Show

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree _ Nil = Nil
mapTree f (Value x y z) = Value (f x) (mapTree f y) (mapTree f z) 

countChars :: String -> Integer
countChars x = toInteger (length x)

--Answer 8
foldTree :: (a -> a -> a) -> a -> Tree a -> a
foldTree _ x Nil = x
foldTree f x (Value n t1 t2) = f n (foldTree f (foldTree f x t1) t2)

--Answer 9
data Road = City String  | Fork Road Road
	deriving (Show)
	
reachable :: String -> Road -> Bool
reachable c (City r) = (c==r)
reachable c (Fork x y) = (reachable c x) || (reachable c y)

--Answer 10
data LR = L | R

insertRoad :: (Road, LR) -> String -> Road -> Road
insertRoad (City dest, L) src (City c)
	|src == c = (Fork (City dest) (City c))
	|otherwise = (City c)
insertRoad (City dest, R) src (City c)
	|src == c = (Fork (City c) (City dest))
	|otherwise = (City c)
insertRoad (City dest, d) src (Fork x y) = (Fork (insertRoad (City dest, d) src x) (insertRoad (City dest, d) src y))

--Additional Challenge
data Instruction = FORW Int|BACKW Int|LEFT|RIGHT
	deriving(Show, Eq)
	
data Direction = E|N|W|S
	deriving(Show, Eq, Enum)

destination :: [Instruction] -> (Int,Int)
destination i = alpha i N
	
alpha :: [Instruction] -> Direction -> (Int,Int)
alpha ((FORW k):xs) d
	|(length xs /= 0) = ezsum (advance k d) (alpha(xs) d)
	|otherwise = advance k d
alpha ((BACKW k):xs)d
	|(length xs /= 0) = ezsum (advance (-k) d) (alpha(xs) d)
	|otherwise = advance (-k) d
alpha (x:xs) d
	|(x == LEFT) && (length xs /= 0) = alpha (xs) (turnLeft(d))
	|(x == RIGHT) && (length xs /= 0)= alpha (xs) (turnRight(d))
	|otherwise = (0,0)
		
turnLeft :: Direction -> Direction
turnLeft d = succ d 

turnRight :: Direction -> Direction
turnRight d = pred d

advance :: Int -> Direction -> (Int, Int)
advance k d 
	|d == E = (k,0)
	|d == N = (0, k)
	|d == W = ((-k), 0)
	|d == S = (0, (-k))
	
ezsum :: (Int, Int) -> (Int, Int) -> (Int, Int)
ezsum (x,y) (w,z) = (x+w, y+z)