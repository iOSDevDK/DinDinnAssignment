# DinDinnAssignment

# 1.) Problem solving

Given a string str consisting of letters only and an integer n, the task is to replace every character of the given string by a character which is n times more than it. If the letter exceeds ‘z’, then start checking from ‘a’ in a cyclic manner.

Examples:
Input: str = “abc”, n = 2
Output: cde
a is moved by 2 times which results in character c
b is moved by 2 times which results in character d
c is moved by 2 times which results in character e

Input: str = “abc”, n= 28
Output: cde
a is moved 25 times, z is reached. Then the 26th character will be a, 27th b and 28th c.
b is moved 24 times, z is reached. 28-th is d.
c is moved 23 times, z is reached. 28-th is f.

Question: 
a/ Write an algorithm to solve the above issue. Please consider the complexity of the algorithm.
b/ What is the disadvantage of using the ASCII value of the letters to solve this problem?

# 2.) Mini assignment

Please replicate the below UI and animation flow, and send us your final assignment using GitHub.

https://dribbble.com/shots/6571883-Food-Delivery-App

Requirements:
You do not need to use exact images, so please use other suitable images. 
Write a networking layer to call the API and fetch data which you have to mock the data to display on the UI.
Use the following dependencies/libraries to implement:
Architecture VIPER
RxSwift + RxCocoa
Moya/RxMoya
ObjectMapper
Also, please do note that the best implementation methods/approaches you choose to use for completing the assignment is up to your discretion.
