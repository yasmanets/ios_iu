//
//  DetailViewController.swift
//  MisTenedores
//
//  Created by Yaser  on 01/12/2020.
//  Copyright © 2020 Yaser . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var infoTableView: UITableView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.restaurant.name
        self.restaurantImage!.image = self.restaurant.image
        
        self.infoTableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.infoTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.infoTableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func close(segue: UIStoryboardSegue) {
        if let reviewViewController = segue.source as? ReviewViewController {
            if let rating = reviewViewController.ratingSelected {
                self.restaurant.rating = rating
                print(self.restaurant.rating)
                self.infoTableView.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            if let bestPlates = restaurant.bestPlates?.count {
                return bestPlates
            }
            else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                case 0:
                    cell.keyLabel.text = "Tipo"
                    cell.valueLabel.text = self.restaurant.type
                case 1:
                    cell.keyLabel.text = "Valoración"
                    if self.restaurant.rating == "rating" {
                        cell.valueLabel.text = "Sin valorar"
                    }
                    else {
                        cell.valueLabel.text = self.restaurant.rating
                    }
                case 2:
                    cell.keyLabel.text = "Dirección"
                    cell.valueLabel.text = self.restaurant.location
                default:
                    break
                }
        case 1:
            if indexPath.row == 0 {
                cell.keyLabel.text = "Mejores platos"
            }
            else {
                cell.keyLabel.text = ""
            }
            cell.valueLabel.text = self.restaurant.bestPlates[indexPath.row]
        default:
            break
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 0:
            title = "Información general"
        case 1:
            title = "Platos estrella"
        default:
            break
        }
        return title
    }
    
}
