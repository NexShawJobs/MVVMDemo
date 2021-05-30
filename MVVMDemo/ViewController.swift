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
        titleValue.text = viewModel?.getHeaderTitle
        position1.text = viewModel?.getPositions[0].title
        //self.getData()
    }
}
//ViewModel
var mVVMDemoViewModel: MVVMDemoViewModel = MVVMDemoViewModel(positions: ps, header: h)
class MVVMDemoViewModel {
    
    private let positions:[Position]
    private let header: Header
    
    init (positions: [Position], header: Header){
        self.positions = positions
        self.header = header
    }
    public var getPositions: [Position] {
        return positions
    }
    public var getHeaderTitle: String {
        return header.title
    }

}
//End view model

//Model

public class Model {
    
}

struct Header {
    var title: String
}
struct details {
    var positins:[Position]
    var header:Header
}
struct Position {
    var position: Int
    var title: String
}

var ps:[Position] = []
let h:Header = Header(title: "")


//use codeble?
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
                    var p:Position = Position(position: 0, title: "")
                    p.position = position["position"] as! Int
                    p.title = position["title"] as! String
                    ps.append(p)
                }
            }
            if let headers = json["header"] as? Dictionary<String, Any>{
                print (headers)
                //h = Header(title: headers[0].title)
                for header in headers {
                    print (header)
                }
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
}
//End Model
