//
//  ViewController.swift
//  ApiFetch
//
//  Created by IPS-149 on 02/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var thisImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        indicator.startAnimating()
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=MAQxxHsOg5QcY7kwrnTezzjrz0PBvBzBkPH692lw")
        func APIData(data: Data?, response: URLResponse?, error: Error?) {
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
            
                       print(json.url)
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
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: APIData)
        task.resume()
     
    }
    }
extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}


