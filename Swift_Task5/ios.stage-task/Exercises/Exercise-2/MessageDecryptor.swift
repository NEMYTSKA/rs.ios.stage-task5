import UIKit

class MessageDecryptor: NSObject {
       
       func decryptMessage(_ message: String) -> String {
           
           if !message.contains("[") { return message }
           guard message.count > 0 else { return "" }
           
           var tempMessage1 = message
           
           while tempMessage1.contains("[") {
               changeString(value: &tempMessage1)
           }
    

           return tempMessage1
       }
       
       func changeString(value: inout String) {
           let testMessage = value
           let indexStart = testMessage.index(after: testMessage.firstIndex(of: "[")!)
           
           
           var flag: Bool = true
           var count1 = 1
           for i in testMessage {
               
               
               if i == "[" {
                   count1 += 1
               }
               if i == "]" {
                   count1 -= 2
               }
               if count1 == 3 {
                   flag = true
                   break
               }
               if count1 == 0 {
                   flag = false
                   break
               }
           }
           
           
           var indexEnd : String.Index
           if flag {
               indexEnd = testMessage.index(before: testMessage.lastIndex(of: "]")!)
           } else {
               indexEnd = testMessage.index(before: testMessage.firstIndex(of: "]")!)
           }
           

           
           var resultString = ""

           let middleString = testMessage[indexStart...indexEnd]
           
           var endMiddleString = ""

           var firstString = ""
           var lastString = ""
           var countString = ""
           
           for i in testMessage {
               if i != "[" && Int(String(i)) == nil {
                   firstString.append(i)
               } else if i != "[" && Int(String(i)) != nil {
                   countString.append(i)
               } else {
                   break
               }
           }
           if flag {
               for i in testMessage.reversed() {
                   if i != "]" {
                       lastString.insert(i, at: lastString.startIndex)
                   } else {
                       break
                   }
               }
           } else {
               var temp = testMessage
               for i in testMessage {
                       if i != "]" {
                           temp.remove(at: temp.startIndex)
                       } else if i == "]" {
                           temp.remove(at: temp.startIndex)
                           break
                       }
               }
               lastString = temp
           }


           if let i = Int(countString) {

               if i >= 1 {
                   for _ in 1...i {
                      endMiddleString += String(middleString)
                   }
               }
               resultString = String(firstString) + endMiddleString + String(lastString)
           } else {
               resultString = String(firstString) + String(middleString) + String(lastString)
           }

           value = resultString
       }
}
