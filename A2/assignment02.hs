import Data.Char
import Data.List
--Answer 1
factorial :: Int -> Int
factorial 0 = 1;
factorial n = n * factorial (n-1)

productFactorial :: Int -> Int
productFactorial 0 = factorial(0)
productFactorial n = factorial(n) * productFactorial(n-1)

--Answer 2
smallestFactor :: Int -> Int
smallestFactor n
	|length [f | f <- [2..(n-1)], n `mod` f == 0] > 0 = head [f | f <- [2..(n-1)], n `mod` f == 0]
	|otherwise = 1

--Answer 3
gameOddEven :: Int -> [Int]
gameOddEven 1 = [1]
gameOddEven x
    | x`rem`2==0 = x:gameOddEven(x `div` 2)
    | otherwise = x:gameOddEven(x*3 +1)

--Answer 4
isGoodPassword :: String -> Bool
isGoodPassword xs
    |length xs < 8 = False
	|((length(filter isDigit xs)== 0) || length(filter isLetter xs)== 0 ) = False
	|((length(filter isUpper xs)== 0) || length(filter isLower xs)== 0 ) = False
	|otherwise = True

--Answer 5
isPrime :: Int -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime x
	|length [y| y<-[2..x-1], x`rem`y == 0] == 0 = True
	|otherwise = False

--Answer 6
allDivisors :: Int -> [Int]
allDivisors 0 = [0]
allDivisors x = [y| y<-[1..x], x`rem`y ==0]

--Answer 7
matches :: Integer -> [Integer] ->[Integer]
matches _[] = []
matches x xs = [y| y<-xs, y == x] 

--Answer 8
solveQuadraticEquation :: Double -> Double -> Double -> (Double, Double)
solveQuadraticEquation a b c = (((-b) + sqrt(b^2-4*a*c))/(2*a), ((-b) - sqrt(b^2-4*a*c))/(2*a))

--Answer 9
occursIn ::(Eq a) => a -> [a] -> Bool
occursIn x xs
	|length [y| y<-xs, x == y] > 0 = True
	|otherwise = False

--Answer 10
allOccurIn :: (Eq a) => [a] -> [a] -> Bool
allOccurIn []_ = True
allOccurIn (x:xs) ys = occursIn x ys && allOccurIn xs ys 

--Answer 11
sameElements :: (Eq a) => [a] -> [a] -> Bool
sameElements xs ys = allOccurIn ys xs && allOccurIn xs ys

--Answer 12
numOccurrences :: (Eq a) => a -> [a] -> Int
numOccurrences x xs = length [y| y<-xs, x == y]

--Answer 13
allUrls :: String -> [String]
allUrls xs =  filter ("http://" `isPrefixOf`) (words xs) 

--Answer 14
sieve :: [Int] -> [Int]
sieve xs = process xs
	where
		process [] = []
		process (x:xs) = x : process (filter (\y -> y `rem` x /=0)xs)

--Answer 15
pascal :: Int -> [Int]
pascal 0 = [1]
pascal x = map (choose x) [0..x-1] ++ [1]
		where
			choose y z = (factorial y) `div` ((factorial z)*(factorial (y-z)))