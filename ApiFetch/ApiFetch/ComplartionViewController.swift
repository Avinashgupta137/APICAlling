//
//  ComplartionViewController.swift
//  ApiFetch
//
//  Created by IPS-149 on 03/01/23.
//

import UIKit

class ComplartionViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        indicator.startAnimating()
        
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=MAQxxHsOg5QcY7kwrnTezzjrz0PBvBzBkPH692lw")
        fatchApi(atURl: url!) { data, error in
           
            guard let data = data , error == nil else {
                            print("somthing else")
                            return
                        }
            
                       if error == nil {
                           DispatchQueue.main.async { [self] in
                        var result :  Json4Swift_Base?
                        do {
                            result = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                        } catch {
                            print("faild to \(error)")
                        }
                        guard let json = result else {
                            return
                        }
                       print(json.hdurl)
                       print(json.explanation)
                       print(json.title)
                               img.image = UIImage(url: URL(string: json.url!))
                               indicator.stopAnimating()
                               indicator.isHidden
                               self.lbldesc.text = json.explanation
                               self.lblTitle.text = json.title
                           }
                       } else {
                           print("Error")
                       }
        }
        
    }
    
    func fatchApi(atURl url: URL , completionHandler : @escaping  ( Data? , NSError?) ->  Void ) {
        let datatask = URLSession.shared.dataTask(with: url) { Data, URLResponse, Error in
            completionHandler(Data, nil)
        }
        datatask.resume()
    }
    
}

