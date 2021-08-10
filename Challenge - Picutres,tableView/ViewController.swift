//
//  ViewController.swift
//  Challenge - Picutres,tableView
//
//  Cre/Users/ivan/Desktop/Challenge - Picutres,tableView/Challenge - Picutres,tableView/ImageTableViewCell.swiftated by Ivan Stajcer on 09.08.2021..
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var images = [ImageTableCell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(showTitleChange))
        navigationController?.hidesBarsOnTap = false
        
        tableView.register(ImageCell.self, forCellReuseIdentifier: "Custom")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return images.count
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as? ImageCell else {
            fatalError("No cell 'Image' found")
        }
        
        
        let currentImageCell = images[indexPath.row]
        
       print("height of cell: \( cell.frame.size.height)")
       print("width of cell: \( cell.frame.size.width)")

        cell.customImageView.image = readImage(path: currentImageCell.imagePath)
        cell.label.text = currentImageCell.imageName
    
        return cell
    }
    
   @objc private func showTitleChange(){
        let ac = UIAlertController(title: "Input title", message: nil, preferredStyle: .alert)

        
        
        let changeAction = UIAlertAction(title: "Continue", style: .default) {
           [weak self, weak ac] _ in
            guard let text = ac?.textFields?.first?.text else {return}
            
            let newImage = ImageTableCell(imagePath: "", imageName: text)
            self?.images.insert(newImage, at: 0)
            self?.addNewImage()
            
        }
        
        ac.addTextField(configurationHandler: nil)
        
        ac.addAction(changeAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    
    
    
    private func readImage(path: String) -> UIImage{
        
        let url = getDocumentsDirectory().appendingPathComponent(path)
        
        guard let image = UIImage(contentsOfFile: url.path) else {
            fatalError("No image found for this path")
        }
        
        return image
        
    }
    
    private func saveImage(image : UIImage){
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            
            let imageName = UUID().uuidString
            let imageURL = getDocumentsDirectory().appendingPathComponent(imageName)
            
            guard let _ = try? jpegData.write(to: imageURL) else {
                images.remove(at: 0)
                return
                
            }
            
            images[0].imagePath = imageName
            
        }
        
    }
    
    
    private func addNewImage(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        258
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            
            vc.imagePath = images[indexPath.row].imagePath
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            
            saveImage(image: editedImage)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
           
        }
        
        dismiss(animated: true, completion: nil)
    
    }
    
    private func getDocumentsDirectory()->URL{
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }


}

