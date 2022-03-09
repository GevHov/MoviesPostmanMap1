//
//  ViewController.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 30.10.21.
//

import UIKit

protocol MainViewControllerProtocol {
    
    func didSelectItemFromCollectionView(model: Models)
}

class ViewController: UIViewController {

    
    //MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    var models = [Models]()
    var imageView = UIImageView()
    var itemsPerRow = 2
    
    
    // MARK: - Segues
    let imageSegueIdentifier = "imageSegueIdentifier"
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let model = sender as? Models else { return }
        if segue.identifier == imageSegueIdentifier {
            
            if let vc = segue.destination as? NewViewController {
                
                vc.imageURL = model.imageURL
            }
        }
    }
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        models.append(Models(imageURL: "https://i.pinimg.com/564x/6f/f3/4c/6ff34c02d962a49f971886977b420701.jpg"))
        models.append(Models(imageURL: "https://i.pinimg.com/564x/a4/15/64/a41564fb6f1c4751e060d0d59bbf34f5.jpg"))
        models.append(Models(imageURL: "https://i.pinimg.com/564x/81/85/19/81851984fab3f2d48caece9ebaad0d26.jpg"))
        models.append(Models(imageURL: "https://i.pinimg.com/564x/ed/63/e5/ed63e562c53eccff1d1d1040e4a23dd2.jpg"))
        models.append(Models(imageURL: "https://i.pinimg.com/564x/e0/2c/eb/e02ceb5601012aa5a4017776fb6d185d.jpg"))
        models.append(Models(imageURL: "https://i.pinimg.com/564x/55/86/9b/55869b300852cfedb4f9aa1f9846533f.jpg"))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //MARK: - MyTableViewCell Register
   
        tableView.register(UINib(nibName: MyTableViewCell.id, bundle: nil), forCellReuseIdentifier: MyTableViewCell.id)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as! MyTableViewCell
        
        cell.configure(with: models)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

    let header = view as! UITableViewHeaderFooterView
         header.textLabel?.textColor = .systemYellow
        
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

         return "MOVIES"
    }
}

// MARK: - MainViewControllerProtocol
extension ViewController: MainViewControllerProtocol {
    
    func didSelectItemFromCollectionView(model: Models) {
        
        self.performSegue(withIdentifier: imageSegueIdentifier, sender: model)
    }
}
