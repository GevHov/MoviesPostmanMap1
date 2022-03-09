//
//  PostmanViewController.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 20.12.21.
//

import Foundation
import UIKit
import Alamofire

 
final class PostmanViewController: UIViewController {
    
    private let url = "https://api.malls.team/api/General/MainPage"

        
    //MARK: - @IBOutlet tableWelcome
    @IBOutlet private weak var tableWelcome: UITableView!
    
    private var photo: [Ads] = []
    private var results: [AdsWithCategories] = []
    private var data = [String]()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableWelcome.dataSource = self
        tableWelcome.delegate = self
        self.tableWelcome.rowHeight = UITableView.automaticDimension
        self.tableWelcome.estimatedRowHeight = 44

        
        //MARK: - Register Cell
        self.tableWelcome.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    
    @IBAction func sendButtonTapped(sender: AnyObject) {
        
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTE0MDE4NjAsImlzcyI6Imh0dHA6Ly90cmFkZWxpc3QyLTAwMS1zaXRlMS5pdGVtcHVybC5jb20vIiwiYXVkIjoiTGlzdFRyYWRlIn0.bVgiJVd9ZUOKqAfxcyOPjdfUuyINEbO6LYUHZrt21o0"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]

        AF.request(self.url, method: .get, headers: headers).responseJSON { response in
            
            if let resposeData = response.data, let resposeJson = try? JSONSerialization.jsonObject(with: resposeData, options: []) {
                
                print(resposeJson)
            }
         
            switch response.result {
                
            case .success(_):
                do {
                    let responsee = try JSONDecoder().decode([AdsWithCategories].self, from: response.data!)
                    
//                    self.results = responsee.value ?? []
                    self.tableWelcome.reloadData()
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key \(key)not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value \(value) not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type \(type) mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
            case .failure(_):
                print("Error")
            }
        }
    }
}

extension PostmanViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            
//            cell.result = self.results[indexPath.row]
            cell.textLabel?.text = photo.last?.name
            cell.textLabel?.text = photo.last?.description

            return cell
            
        }
        return UITableViewCell()
    }
}
