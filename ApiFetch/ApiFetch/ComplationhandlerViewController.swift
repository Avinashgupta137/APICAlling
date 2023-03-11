//
//  ComplationhandlerViewController.swift
//  ApiFetch
//
//  Created by IPS-149 on 03/01/23.
//

import UIKit

class ComplationhandlerViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        getJson() { (json) in
            print("ID: \(json.explanation) \(json.title)")
            print(json.url)
            DispatchQueue.main.async {
                self.img.image = UIImage(url: URL(string: json.url!))
                self.indicator.stopAnimating()
                self.indicator.isHidden
                self.lbltitle.text = json.title
                self.lbldesc.text = json.explanation
            }
            //
        }
    }
    
    func getJson(completion: @escaping (Json4Swift_Base)-> ()) {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=MAQxxHsOg5QcY7kwrnTezzjrz0PBvBzBkPH692lw"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {data, res, err in
                if let data = data {
                    do {
                        let json: Json4Swift_Base = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                        completion(json)
                    }catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }

  

}
