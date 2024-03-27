//
//  ViewController.swift
//  TableStory
//
//  Created by Chase, Meadow D on 3/20/24.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "FoodHeads", neighborhood: "North University", desc:  "Cafe for housemade soups, sandwiches, ice teas & more from a converted home with yard seating. Great coffee and pastries!", lat: 30.301424424267477, long: -97.74027531811528, imageName: "foodheads"),

        Item(name: "The Pizza Press", neighborhood: "West Campus", desc: "Nostalgic restaurant doling out pizza, beer & more in casual, 1920s-style surroundings. Newsroom-themed joint.", lat: 30.291317848756094, long: -97.74195665321625, imageName: "ppress"),

        Item(name: "Dirty Martin’s Place", neighborhood: "West Campus", desc: "An Austin mainstay since 1926 with burgers, beer & American chow served in an old-school space. Right by UT-Austin.", lat: 30.294537730061418, long: -97.74224754641993, imageName: "dmartins"),

        Item(name: "Better Half Coffee & Cocktails", neighborhood: "Market District", desc: "Cafe with globally inspired fare, plus coffee, draft cocktails, wine, craft ciders, and beer. Great coffee and pastries!", lat: 30.271948125061364, long: -97.75854966383939, imageName: "betterhalf"),

        Item(name: "Uncle Nicky's", neighborhood: "Hyde Park", desc: "Airy, casual all-day cafe for Italian fare alongside coffee, pastries & cocktails plus patio seats. Happy Hour all week!", lat: 30.304890, long: -97.726220, imageName: "unclenickys")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      //Add image references
                    let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      
      return cell!
  }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
       
    // add this function to original ViewController
          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetailSegue" {
                if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                    // Pass the selected item to the detail view controller
                    detailViewController.item = selectedItem
                }
            }
        }
        
            
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //make sure to import MapKit at top of View Controller
        

            //add this code in viewDidLoad function in the original ViewController, below the self statements

            //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.059, longitudeDelta: 0.059))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }
        
    }


}

