//
//  ViewController.swift
//  VeryLargeMultiplier2
//
//  Created by Stephen Sarewitz on 3/28/16.
//  Copyright © 2016 Stephen Sarewitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) { //to hide keyboard when touching outside of keyboard
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//variables
    
    var arr1 = [Int]()  //arrays of integers created from the strings inputted by the user
    var arr2 = [Int]()
    var productArr = [[Int]]()  //a 2D array that simulates the columns in a multiplication problem done manually (ex. 25 x 567) that are added up to get the final product
    var summedProductArr = [Int]()  //an array that gives the sums of the digits in each simulated column (which = the product)
    var power = 1  // the exponent
    
    
    
//outlets
    @IBOutlet weak var inputOne: UITextView!
    
    @IBOutlet weak var inputTwo: UITextView!

    @IBOutlet weak var result: UITextView!
    
//functions

    
    func EnterFirstNumber() {
        if inputOne.text != "" {
            inputTwo.text = inputOne.text
            arr1 = ConvertToIntegerArrayFromString(inputTwo.text)

            print("arr1: \(arr1)")
            inputOne.text = ""
        }
    }
    
    func ClearAllVariables() {
    inputOne.text = "0"
    inputTwo.text = "0"
    result.text = "0"
    
    arr1 = [Int]()
    arr2 = [Int]()
    
    }
    
    func ConvertToIntegerArrayFromInteger(number: Int) -> [Int] {
        let strNum = String(number)
        let arrStrNum = Array(strNum.characters)
        
        var arrOfInts = [Int]()
        for item in arrStrNum {
            let strItem = String(item)
            let intItem = Int(strItem)
            arrOfInts.append(intItem!)
        }
        return arrOfInts
    }
    
    func ConvertToIntegerArrayFromString(strNumber: String) -> [Int] {
        let arrStrNum = Array(strNumber.characters)
        var arrOfInts = [Int]()
        print("array of stringNumber characters = \(arrStrNum)")
        for item in arrStrNum {
            let strItem = String(item)
            print("strItem = \(strItem)")
            let intItem = Int(strItem)
            print("intItem = \(intItem)")
            arrOfInts.append(intItem!)
        }
        
        return arrOfInts
    }
    
    func CreateCorrectNumberOfColumns(firstMultiplier: [Int], secondMultiplier: [Int]) {
        for var i =  0; i < firstMultiplier.count + secondMultiplier.count - 1; i++ {
            productArr.append([])
            
            
        }
        print("no. of columns: \(productArr.count)")
    }
    
    func PutProductOfEachDigits(firstMultiplier: [Int], secondMultiplier: [Int]) {
        for var i = 0; i < firstMultiplier.count; i++ {
            for var j = 0; j < secondMultiplier.count; j++ {
                productArr[j + i].append(firstMultiplier[i] * secondMultiplier[j])
                //print("stepwise productArr = \(productArr)")
            }
        }
        
    }
    
    func AddDigitsInEachColumn(multiArray: [[Int]]) -> [Int] {
        for var i = 0; i < multiArray.count; i++ {
            var sum = 0
            for item in multiArray[i] {
                sum += item
            }
            summedProductArr.append(sum)
        }
        return summedProductArr
    }
    
//        
    func CarryToNextColumn(arrOfInts: [Int]) {
        
        summedProductArr.insert(0, atIndex: 0)
        for var i = summedProductArr.count - 1; i > 0; i-- {
            let carry = summedProductArr[i] / 10
            summedProductArr[i] = summedProductArr[i] % 10
            summedProductArr[i - 1] = carry + summedProductArr[i - 1]
        }
        
    }
    
    
    func CreateArr2() {      //generate the second number in the operation (either multiplication or exponentiation)
        if inputOne.text != "" {
            arr2 = ConvertToIntegerArrayFromString(inputOne.text)
            print("arr2: \(arr2)")
        }
    }
    
    func multiplication() {
        
        
            CreateCorrectNumberOfColumns(arr1, secondMultiplier: arr2) //creates correct no. of columns in 2D-array productArr
            
            PutProductOfEachDigits(arr1, secondMultiplier: arr2)  //puts products of multiplication in each column in productArr
            
            AddDigitsInEachColumn(productArr)
            
            CarryToNextColumn(summedProductArr)
        
    }
    
    func ReportMultiplicationResult() {
        
            var strResult = ""
        
        //remove leading zeros
        for item in summedProductArr {
            if item != 0 {
                break
            } else {
                summedProductArr.removeFirst()
            }
        }
        
        
        //to convert the summedProductArr array into a string for display in the results textbox:
            for item in summedProductArr {
                let strOne = String(item)
                strResult += strOne
            }
            result.text = strResult
            
        
            productArr = [[Int]]() //zero out the arrays used in the multiplication calculation
            summedProductArr = [Int]()
        
    }
    
    func UseLastProductAsMultiplier() {
        let tempStr = result.text
        ClearAllVariables()
        inputOne.text = tempStr
        EnterFirstNumber()
    }
    
//buttons
    
    
    @IBAction func enter(sender: AnyObject) {
        EnterFirstNumber()
    }
    
    
    @IBAction func multiply(sender: AnyObject) {
        CreateArr2()
    
        multiplication()
        ReportMultiplicationResult()
        
        self.view.endEditing(true)
        print(result.text)
        
    }
    
    
    @IBAction func clearLastEntry(sender: AnyObject) {
        inputOne.text = "0"
    }
   
    
    @IBAction func clearAll(sender: AnyObject) {
        ClearAllVariables()
    }
    
   
    @IBAction func productToMultiplier(sender: AnyObject) {  //to use the last result as a multiplier
       UseLastProductAsMultiplier()
    }
    
    @IBAction func exponent(sender: AnyObject) {
        if inputOne.text != "" {
            power = Int(inputOne.text)!
            arr2 = [1]
            var i = 1
            while i <= power {
               multiplication()
                print("exp result is \(summedProductArr)")
               
                arr2 = summedProductArr
                productArr = [[Int]]() //zero out the arrays used in the multiplication calculation
                summedProductArr = [Int]()
                i++
            }
            summedProductArr = arr2
            ReportMultiplicationResult()
            print(result.text)
            self.view.endEditing(true)
    }
    
    }
    
    
}

