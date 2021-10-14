module F1 where

import Data.Char ( isAlpha )
import Data.List ( genericLength )
import Debug.Trace ()

-- Fibonacci 
myButLast :: [a] -> a
myButLast [x, _] = x 
myButLast (_ : xs) = myButLast xs

calcfib :: Num a => [a] -> Int -> [a]
calcfib x s
    | s == 0 = [0]
    | length x == s + 1 = x
    | length x < 2 = calcfib [0, 1] s 
    | otherwise = calcfib (x ++ [myButLast x + last x]) s

fib :: Num a => Int -> a
fib s = last (calcfib [] s)

-- Rövarspråk 
isVowel :: Char -> Bool
isVowel = flip elem "aeiouy"

isConsonant :: Char -> Bool
isConsonant x = not (isVowel x)

rovarsprak :: Foldable t => t Char -> [Char]
rovarsprak s = concatMap (\y -> if isConsonant y 
    then [y, 'o', y]
    else [y]) s

karpsravor :: [Char] -> [Char]
karpsravor [] = []
-- Pattern matching iterating through the list. x is the head, xs the tail. 
karpsravor (x:xs) 
    | isConsonant x = x:karpsravor (drop 2 xs) 
    | otherwise = x:karpsravor xs

-- Medellängd 

calcmed :: (Eq a, Num a) => [Char] -> [a] -> a -> [a]
calcmed str wordlengths lastwordlength
    | null str = if lastwordlength /= 0 
          then wordlengths ++ [lastwordlength] 
          else wordlengths
    | isAlpha (head str) = calcmed (tail str) wordlengths (lastwordlength +1) 
    | otherwise = calcmed (tail str) (
          if lastwordlength /= 0 
                then wordlengths ++ [lastwordlength] 
                else wordlengths) 0

avg :: Fractional a => [a] -> a
avg ls = sum ls / genericLength ls

list :: (Eq a, Num a) => [Char] -> [a]
list s = calcmed s [] 0

medellangd :: (Fractional a, Eq a) => [Char] -> a
medellangd s = avg (list s)

-- Skyffla 

odds xs = map fst $ filter (odd . snd) $ zip xs [1..]
evens xs = map fst $ filter (even . snd) $ zip xs [1..]

calcalc xs ss = if not (null xs) then calcalc (evens xs) (ss ++ odds xs) else ss

skyffla s = calcalc s []