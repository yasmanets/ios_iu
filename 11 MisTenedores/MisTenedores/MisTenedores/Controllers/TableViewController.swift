//
//  TableViewController.swift
//  MisTenedores
//
//  Created by Yaser  on 30/11/2020.
//  Copyright © 2020 Yaser . All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var restaurants = [Restaurant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                
        var restaurant = Restaurant(name: "Pizzeria Tito's", type: "Pizzería", image: UIImage(named: "titos")!, bestPlates: nil, location: "Calle de prueba")
        restaurants.append(restaurant)
        restaurant = Restaurant(name: "La Tía Juana", type: "Mexicano", image: UIImage(named: "tia-juana")!, bestPlates: ["Ensaladilla rusa", "Huevos rotos", "Croquetas", "Pizza Margarita"], location: "Calle de prueba 2")
        restaurants.append(restaurant)
        restaurant = Restaurant(name: "Casa Yong", type: "Chino", image: UIImage(named: "casa-yong")!, bestPlates: nil, location: "Calle de pruebas 3")
        restaurants.append(restaurant)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        cell.restaurantName?.text = restaurants[indexPath.row].name
        cell.restaurantType?.text = restaurants[indexPath.row].type
        cell.restaurantImage?.image = restaurants[indexPath.row].image
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil, handler: {(action, view, completeionHander) in
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        let shareAction = UIContextualAction(style: .normal, title: nil, handler: {(action, view, completeionHander) in
            let defaultText = "Creo que esta noche iré a cenar a \(self.restaurants[indexPath.row].name)"
            let activityController = UIActivityViewController(activityItems: [defaultText, self.restaurants[indexPath.row].image!], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
        
        deleteAction.image = UIImage(named: "trash.png")
        deleteAction.backgroundColor = UIColor.red
        shareAction.image = UIImage(named: "share.png")
        shareAction.backgroundColor = UIColor.systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return configuration
    }
    
    // MARK: - UITableViewDelegate
        


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let restaurant = self.restaurants[indexPath.row]
                let detailController = segue.destination as! DetailViewController
                detailController.restaurant = restaurant
            }
        }
    }
}
