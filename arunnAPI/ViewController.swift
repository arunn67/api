//
//  ViewController.swift
//  arunnAPI
//
//  Created by BYOT on 25/01/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
   
    
    @IBOutlet weak var apitbl: UITableView!
    var data = [[String:Any]]()
    
    
    var jsonersult = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.arun()
        self.apitbl.delegate = self
        self.apitbl.dataSource = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myapiTableViewCell", for: indexPath) as! myapiTableViewCell
        cell.nameLbl.text = "\(self.data[indexPath.row]["soc_name"]!)"
        cell.idlbl.text = "\(self.data[indexPath.row]["soc_id"]!)"
        
        let urlstring = URL(string: "\(self.data[indexPath.row]["soc_image"]!)")
       
        let findingurl = "\(self.data[indexPath.row]["soc_image"]!)"
        if findingurl.contains(".jpg") || findingurl.contains(".gif"){
            print("yes")
        }else{
            print("no, the index is " , indexPath.row)
        }
        
        let imgdata = NSData(contentsOf: urlstring!)
        cell.picImg.image = UIImage.init(data: imgdata! as Data)
        
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    
    
    
    func arun () {
        let url = URL(string: "http://www.elitedoctorsonline.com/api_mob/browser/society/society.aspx?lang=en&cou_id=211")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest){data, response , error in
            if let err = error{
                print(err.localizedDescription)
                return
            }
            if let resp = response as? HTTPURLResponse{
                print(resp.statusCode)
                
            }
            do{
                self.jsonersult = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
//                print (self .jsonersult)
                self.data = self.jsonersult["society_data"] as! [[String:Any]]
                print(self.data)
                
                
            }
            catch let err as NSError{
                print(err.localizedDescription)
            }
            DispatchQueue.main.async {
                self.apitbl.reloadData()
            }
        
            
            
        }
        task.resume()
        
        
        
    }


}

