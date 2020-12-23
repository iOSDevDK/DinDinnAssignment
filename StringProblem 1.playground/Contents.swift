/*
 
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
 
1.) What will the max length of the input string and max value of integer n?
Ans -> Input string length is less or equal to 100 , max value of integer is 2,147,483,647
 
2.) Can the value of n be negative or will always be greater than or equal to  0?
Ans -> The value of n will always be greater than 0.
 
3.) Can I provide playground file for the first problem or do I need to send 1 project file for both the questions.
Ans -> Kindly provide the code by gist.
 
4.) What will be output upon inserting symbol or number in the string. (Example: INPUT: str = “abc12#abc” n = 2 output = “cde34%cde" )
Ans -> Characters will only be between a to z or A to Z.
 
5.) What shall be the output in case of input: str=“xyz” and n = 2 ?
Ans -> OUTPUT => "zab".
 
6.) Do I need to consider input of other symbols or latin characters (Example: ÃǢƓǑℷℇ😀) in the input string?
Ans -> No you do not.
 
7.) Regarding the mini assignment. As I currently don’t have any api for the networking layer. Can I you any api from the open source or do I need to create api. Using Open source api it might be possible to not have appropriate data. Could you please provide api. Also, I’ve checked the delivery app. I would like to know how many screens I need to create 2 or 3, as I can see horizontal scroll along with buttons on top for the different menu options.
Ans -> Please be informed that you do not need to create an API, you have to mock API requests and responses. We need to see the implementation of network layers with mock responses.
 
 */

import UIKit

extension StringProtocol {
    var valueToAscii: [UInt8] { compactMap(\.asciiValue) }
}

func updateCharactedInString(inputString: String, nTimes: Int) -> String {
    //print(inputString.count)
    
    var dictSwapChar = [Character:String]()
    var resultString = ""
    
    if inputString.count <= 100 && nTimes <= 2147483647 {
        if nTimes == 0 || inputString.count == 0 {
            return inputString
        }
        
        for char in inputString {
            
            var incremetSize = nTimes
            
            if !char.isLetter {
                return "String must contain character between a to z or A to Z."
            }
                
            if let charValue = dictSwapChar[char] {
                resultString += charValue
                continue
            }
            
            if dictSwapChar[char] == nil {
                
                let asciiValueOfChar = Int("\(char)".valueToAscii.first!) + nTimes
                
                if asciiValueOfChar > 122 {
                    
                    incremetSize -= 122 - Int("\(char)".valueToAscii.first!)
                    
                    incremetSize = incremetSize%26
                                        
                    dictSwapChar[char] = "\(Character(UnicodeScalar(UInt8(96 + incremetSize))))"
                    
                    resultString += "\(Character(UnicodeScalar(UInt8(96 + incremetSize))))"
                    
                } else {
                    
                    dictSwapChar[char] = "\(Character(UnicodeScalar(asciiValueOfChar)!))"
                    
                    resultString += "\(Character(UnicodeScalar(asciiValueOfChar)!))"
                    
                }
                
            }
        }

        return resultString
    } else {
        return (inputString.count > 100 ? "String length more than 100 characters." : "nTimes value is greater than 2147483647.")
    }
    
}


print("OUTPUT = ", updateCharactedInString(inputString: "abc12#abc", nTimes: 2))
print("OUTPUT = ", updateCharactedInString(inputString: "#", nTimes: 2))
print("OUTPUT of 'SPACE' for 2 => ", updateCharactedInString(inputString: " ", nTimes: 2))
print("OUTPUT of xyz for 2     => ", updateCharactedInString(inputString: "Xyz", nTimes: 2))
print("OUTPUT of abc for 2     => ", updateCharactedInString(inputString: "abc", nTimes: 2))
print("OUTPUT of ABC for 28    => ", updateCharactedInString(inputString: "ABC", nTimes: 28))
print("OUTPUT of ABC for 228   => ", updateCharactedInString(inputString: "ABC", nTimes: 228))
print("OUTPUT of ABC for 3   => ", updateCharactedInString(inputString: "abc", nTimes: 3))
print("OUTPUT of ABC for 2   => ", updateCharactedInString(inputString: "abcd", nTimes: 2))
print("OUTPUT of abc for 2147483648   => ", updateCharactedInString(inputString: "abc", nTimes: 2147483648))
print("OUTPUT of ABC for 2147483647   => ", updateCharactedInString(inputString: "DgFFDOTCAddxzGrFabqwGGwBncpsKAZwpPAeIoVbQbaijihRFbNRjCfyNdUMXExIPQWXXnajQygkyWzxaPAMDvpBrcBXKrFGqSOJ", nTimes: 2147483647))
print("OUTPUT of DgFF for 2147483647   => ", updateCharactedInString(inputString: "DgFF", nTimes: 2147483647))


