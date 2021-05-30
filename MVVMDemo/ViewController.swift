//
//  ViewController.swift
//  test
//
//  Created by NebSha on 5/20/21.
//

import UIKit

//ViewController
class ViewController: UIViewController {
    @IBOutlet weak var titleValue: UILabel!
    @IBOutlet weak var position1: UILabel!
    @IBOutlet weak var position2: UILabel!
    @IBOutlet weak var position3: UILabel!
    
    var viewModel:MVVMDemoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = mVVMDemoViewModel
        titleValue.text = viewModel?.headerTitle
        position1.text = viewModel?.positionTitle
        self.getData()
    }
    // work on dynamic binding 
    func getData(){
        var str = "{\"header\":{\"title\":\"This is your header title\"},\"details\":[{\"title\":\"1. This is your first subtitle.\",\"position\":\"1\"},{\"title\":\"2. This is your second subtitle.\",\"position\":\"2\"},{\"title\":\"3. This is your third subtitle\",\"position\":\"3\"}]}"
        let data = Data(str.utf8)

        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // try to read out a string array
                if let positions = json["details"] as? [Dictionary<String, Any>] {
                    print(json)
                    for position in positions {
                        print(position)
                    }
                }
                if let headers = json["header"] as? Dictionary<String, Any>{
                    print (headers)
                    for header in headers {
                        print (header)
                    }
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}

//ViewModel
var mVVMDemoViewModel: MVVMDemoViewModel = MVVMDemoViewModel(position: p, header: h)

class MVVMDemoViewModel {
    
    private let position:Position
    private let header: Header
    
    init (position: Position, header: Header){
        self.position = position
        self.header = header
    }
    public var positionTitle: String {
        return position.title
    }
    public var positionPosition: Int {
        return position.position
    }
    public var headerTitle: String {
        return header.title
    }

}
//End view model

//Model
struct Header {
    var title: String
}
struct details {
    var positins:[Position]
}
struct Position {
    var position: Int
    var title: String
}

let p:Position = Position(position: 1, title: "title1")
let h:Header = Header(title: "header title")
//End Model
