//
//  DetailViewController.swift
//  Challenge - Picutres,tableView
//
//  Created by Ivan Stajcer on 09.08.2021..
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var imagePath : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnTap = true
        
        let url = getDocumentsDirectory().appendingPathComponent(imagePath)
        imageView.image = UIImage(contentsOfFile: url.path)
        
        
        // Do any additional setup after loading the view.
    }
    
    private func getDocumentsDirectory()->URL{
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
