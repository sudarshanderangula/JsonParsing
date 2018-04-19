//
//  ViewController.swift
//  JsonParsing
//
//  Created by Sundir Talari on 01/04/18.
//  Copyright © 2018 Sundir Talari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var json = [Int: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.delegate = self
        table.dataSource = self
        
        let url = URL(string: "https://trell.co.in/expresso/interestCategories.php")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data else {return}
            
            do {
                
               
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print("message is \(json["message"]!)")
                print("status is \(json["status"]!)")
                print("category first object is \((json["categoriesArray"]! as! [Any])[0])")
                print("categories array count is \((json["categoriesArray"] as! [Any]).count)")
                
               // print(json)
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                
            }catch {
                
                print("json error: \(error.localizedDescription)")
            }
            
        }.resume()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")
    cell?.textLabel?.text = ((json[indexPath.row] as![String: Any])[""] as! String)
        return cell!
    }

}

