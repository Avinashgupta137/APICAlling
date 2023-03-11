//
//  ComplationHandler.swift
//  ApiFetch
//
//  Created by IPS-149 on 02/01/23.
//

import UIKit

class ComplationHandler: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
             
            print("Watching movie")
             
            orderPizza { wasItSuccessfull in
                if(wasItSuccessfull) {
                    print("Received pizza")
                    print("Eating pizza and watching movie")
                } else {
                    print("Oh no!!!. Eating bread!!! Watching movie")
                }
            }

            print("Watching movie after ordering pizza")
        
        
       
        }
     
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        
        }
         
         
        let pizzaProcessingQue = DispatchQueue(label: "com.swiftwithsadiq.pizzaque")
         
        func orderPizza(completionHandler : @escaping (_ success : Bool) -> Void) {
            pizzaProcessingQue.async {
                print("Preparing pizza")
                sleep(5)
                print("Ting tong!!! Your order is at your door step")
                let randomNumber = arc4random() % 2
                if(randomNumber == 0){
                 completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
            print("Order placed successfully!!")
        }

}
