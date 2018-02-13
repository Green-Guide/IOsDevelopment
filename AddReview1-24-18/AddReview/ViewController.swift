//
//  ViewController.swift
//  AddReview
//
//  Created by Matthew A. Wong on 11/22/17.
//  Copyright © 2017 Green Guide. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorMessage.text = ""
        // Do any additional setup after loading the view, typically from a nib.
        
        createPickers()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    //Company Information
    @IBOutlet weak var compName: UITextField!
    @IBOutlet weak var compAddress: UITextField!
    @IBOutlet weak var compCity: UITextField!
    @IBOutlet weak var compIndustry: UITextField!
    @IBOutlet weak var compProducts: UITextField!
    
    @IBOutlet weak var userRating: UISlider!
    
    @IBOutlet weak var envReview: UITextView!
    
    var name: String = ""
    var address: String = ""
    var city: String = ""
    var industry: String = ""
    var products: String = ""
    
    var rating: Float = 0.0
    
    var review: String = ""
    
    
    
    
    //Water Issue
    @IBOutlet weak var turbiditySlider: UISlider!
    
    var turbidity: Float = 0.0
    
    
    @IBOutlet weak var doMeasure: UITextField!
    @IBOutlet weak var phMeasure: UITextField!
    @IBOutlet weak var turbidityMeasure: UITextField!
    @IBOutlet weak var bodMeasure: UITextField!
    @IBOutlet weak var codMeasure: UITextField!
    @IBOutlet weak var tocMeasure: UITextField!
    @IBOutlet weak var tsMeasure: UITextField!
    @IBOutlet weak var nhfourMeasure: UITextField!
    @IBOutlet weak var tpMeasure: UITextField!
    @IBOutlet weak var hgMeasure: UITextField!
    @IBOutlet weak var pbMeasure: UITextField!
    @IBOutlet weak var cdMeasure: UITextField!
    @IBOutlet weak var asMeasure: UITextField!
    
    var doWater: String!
    var phWater: String!
    var turbidityWater: String!
    var bodWater: String!
    var codWater: String!
    var tocWater: String!
    var tsWater: String!
    var nhWater: String!
    var tpWater: String!
    var hgWater: String!
    var pbWater: String!
    var cdWater: String!
    var asWater: String!
    
    //AirIssue
    @IBOutlet weak var symptomsDescription: UITextField!
    
    @IBOutlet weak var pmtwofiveMeasure: UITextField!
    @IBOutlet weak var pmTenMeasure: UITextField!
    @IBOutlet weak var oThreeMeasure: UITextField!
    @IBOutlet weak var SOxMeasure: UITextField!
    @IBOutlet weak var NOxMeasure: UITextField!
    @IBOutlet weak var COMeasure: UITextField!
    
    var airSymptomsDescription: String?
    
    var pmTwoFiveAir: String?
    var pmTenAir: String?
    var oThreeAir: String?
    var SOxAir: String?
    var NOxAir: String?
    var COAir: String?
    
    //Solid Waste
    @IBOutlet weak var solidWasteAmount: UISlider!
    @IBOutlet weak var solidWasteMeasurement: UITextView!
    
    var solidWasteSlider: Float?
    var solidWasteDescription: String?
    
    
    //Pickers
    @IBOutlet weak var waterTypesPicker: UITextField!
    @IBOutlet weak var waterColorPicker: UITextField!
    @IBOutlet weak var waterOdorPicker: UITextField!
    @IBOutlet weak var waterFloatPicker: UITextField!
    
    let waterTypes = ["Lake", "Ocean", "River", "Other"]
    let waterColors = ["Green", "Blue", "Brown", "Black", "Yellow", "Red", "Other"]
    let waterOdors = ["No Smell", "Mild Smell", "Strong Smell"]
    let waterFloats = ["Domestic Wastes", "Dead Fish", "Algaes", "Aquatic Plants", "Others"]
    
    @IBOutlet weak var airVisibiltyPicker: UITextField!
    @IBOutlet weak var airOdorPicker: UITextField!
    @IBOutlet weak var smokeColorPicker: UITextField!
    @IBOutlet weak var airSymptomsPicker: UITextField!
    
    let airVisilty = ["<0.5 km", " 0.5-2 km", "2-10 km", ">10 km"]
    let airOdor = ["No Smell", "Mild Smell", "Strong Smell"]
    let smokeColors = ["No Smoke", "Yellow", "Red-Brown", "Black", "White", "Other"]
    let airSymptoms = ["No Symptoms", "Cough", "Difficult Breathing", "Eyes Pain", "Other (Please describe it)"]
    
    @IBOutlet weak var wasteTypePicker: UITextField!
    @IBOutlet weak var wasteOdorPicker: UITextField!
    
    let wasteType = ["Inustrial Waste", "Agricultural Waste", "Domestic Waste", "Other"]
    
    @IBOutlet weak var errorMessage: UITextField!
    
    @IBOutlet weak var myImg: UIImageView!
    
    @IBAction func pickPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImg.contentMode = .scaleToFill
            myImg.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func createPickers(){
        
        let picker1 = UIPickerView() //water types
        let picker2 = UIPickerView() // water colors
        let picker3 = UIPickerView() //water odors
        let picker4 = UIPickerView() //water floats
        
        let picker5 = UIPickerView() //air visbility
        let picker6 = UIPickerView() //air odor
        let picker7 = UIPickerView() // smoke color
        let picker8 = UIPickerView() // air symptoms
        
        let picker9 = UIPickerView() //wasteType
        let picker10 = UIPickerView() // Waste odor
        
        //water
        picker1.tag = 0
        picker2.tag = 1
        picker3.tag = 2
        picker4.tag = 3
        
        //air
        picker5.tag = 4
        picker6.tag = 5
        picker7.tag = 6
        picker8.tag = 7
        
        //waste
        picker9.tag = 8
        picker10.tag = 9
        
        //water
        picker1.delegate = self
        picker2.delegate = self
        picker3.delegate = self
        picker4.delegate = self
        
        //air
        picker5.delegate = self
        picker6.delegate = self
        picker7.delegate = self
        picker8.delegate = self
        
        //waste
        picker9.delegate = self
        picker10.delegate = self
        
        waterTypesPicker.inputView = picker1
        waterColorPicker.inputView = picker2
        waterOdorPicker.inputView = picker3
        waterFloatPicker.inputView = picker4
        
        airVisibiltyPicker.inputView = picker5
        airOdorPicker.inputView = picker6
        smokeColorPicker.inputView = picker7
        airSymptomsPicker.inputView = picker8
        
        wasteTypePicker.inputView = picker9
        wasteOdorPicker.inputView = picker10
    
    
    }
    
    

    
    @IBAction func SubmitPressed(_ sender: UIButton) {
        name = compName.text!
        address = compAddress.text!
        city = compCity.text!
        industry = compIndustry.text!
        products = compProducts.text!
        rating = userRating.value
        review = envReview.text!
        
        turbidity = turbiditySlider.value
        doWater = doMeasure.text!
        phWater = phMeasure.text!
        turbidityWater = turbidityMeasure.text!
        bodWater = bodMeasure.text!
        codWater = codMeasure.text!
        tocWater = tocMeasure.text!
        tsWater = tsMeasure.text!
        nhWater = nhfourMeasure.text!
        tpWater = tpMeasure.text!
        hgWater = hgMeasure.text!
        pbWater = pbMeasure.text!
        cdWater = cdMeasure.text!
        asWater = asMeasure.text!
        
        let waterTypeSelected = waterTypesPicker.text!
        let waterColorSelected = waterColorPicker.text!
        let waterOdorSelected = waterOdorPicker.text!
        let waterFloatSelected = waterFloatPicker.text!
        
        
        airSymptomsDescription = symptomsDescription.text!
        pmTwoFiveAir = pmtwofiveMeasure.text!
        pmTenAir = pmTenMeasure.text!
        oThreeAir = oThreeMeasure.text!
        SOxAir = SOxMeasure.text!
        NOxAir = NOxMeasure.text!
        COAir = COMeasure.text!
        let airVisbilitySelected = airVisibiltyPicker.text!
        let airOdorSelected = airOdorPicker.text!
        let smokeColorSelected = smokeColorPicker.text!
        let airSymptomsSelected = airSymptomsPicker.text!
        
        solidWasteSlider = solidWasteAmount.value
        solidWasteDescription = solidWasteMeasurement.text!
        let wasteTypeSelected = wasteTypePicker.text!
        let wasteOdorSelected = wasteOdorPicker.text!

        let postString1 = "company=\(name)&address=\(address)&city=\(city)&review=\(review)&lng=0&lat=0&rating=\(String(rating))&WaterType=\(waterTypeSelected)&WaterColor=\(waterColorSelected)&WaterOdor=\(waterOdorSelected)&turbRate=\(String(turbidity))&floatType=\(waterFloatSelected)"
        
        let postString2 = "&DO=\(doWater)&pH=\(phWater)&Turbidity=\(turbidityWater)&BOD=\(bodWater)&COD=\(codWater)&TOC=\(tocWater)&TS=\(tsWater)&NH4=\(nhWater)&TP=\(tpWater)&Hg=\(hgWater)&Pb=\(pbWater)&Cd=\(cdWater)&As=\(asWater)"
        
        let postString3 = "&Visibility=\(airVisbilitySelected)&AirOdor=\(airOdorSelected)&SmokeCheck=na&SmokeColor=\(smokeColorSelected)&Symptom=\(airSymptomsSelected)&symptomDescr=\(airSymptomsDescription)&PM2.5=\(pmTwoFiveAir)&PM10=\(pmTenAir)&O3=\(oThreeAir)"
        
        let postString4 = "&SOx=\(SOxAir)&NOx=\(NOxAir)&CO=\(COAir)&WasteType=\(wasteTypeSelected)&WasteAmount=\(String(describing: solidWasteSlider))&WasteOdor=\(wasteOdorSelected)&WasteMeasure=\(solidWasteDescription)"
        
        let postString = postString1 + postString2 + postString3 + postString4
        var request = URLRequest(url: URL(string: "http://www.lovegreenguide.com/savereview_app.php")!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            DispatchQueue.main.async {
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString!))")
                let responseMessage = String(describing: responseString!)
                self.errorMessage.text! = responseMessage
                print(self.errorMessage.text!)
            }
        }
        task.resume()
    }
 
}



//Extension to implement scroll wheel pickers
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return waterTypes.count
        } else if pickerView.tag == 1 {
            return waterColors.count
        } else if pickerView.tag == 2 {
            return waterOdors.count
        } else if pickerView.tag == 3 {
            return waterFloats.count
        } else if pickerView.tag == 4 {
            return airVisilty.count
        } else if pickerView.tag == 5 {
            return airOdor.count
        } else if pickerView.tag == 6 {
            return smokeColors.count
        } else if pickerView.tag == 7 {
            return airSymptoms.count
        } else if pickerView.tag == 8 {
            return wasteType.count
        } else if pickerView.tag == 9 {
            return airOdor.count
        } else {
            return 1
        }
    }
    
    func  pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return waterTypes[row]
        } else if pickerView.tag == 1 {
            return waterColors[row]
        } else if pickerView.tag == 2 {
            return waterOdors[row]
        } else if pickerView.tag == 3 {
            return waterFloats[row]
        } else if pickerView.tag == 4 {
            return airVisilty[row]
        } else if pickerView.tag == 5 {
            return airOdor[row]
        } else if pickerView.tag == 6 {
            return smokeColors[row]
        } else if pickerView.tag == 7 {
            return airSymptoms[row]
        } else if pickerView.tag == 8 {
            return wasteType[row]
        } else if pickerView.tag == 9 {
            return airOdor[row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            return waterTypesPicker.text = waterTypes[row]
        } else if pickerView.tag == 1 {
            return waterColorPicker.text = waterColors[row]
        } else if pickerView.tag == 2 {
            return waterOdorPicker.text = waterOdors[row]
        } else if pickerView.tag == 3 {
            return waterFloatPicker.text = waterFloats[row]
        } else if pickerView.tag == 4 {
            return airVisibiltyPicker.text = airVisilty[row]
        } else if pickerView.tag == 5 {
            return airOdorPicker.text = airOdor[row]
        } else if pickerView.tag == 6 {
            return smokeColorPicker.text = smokeColors[row]
        } else if pickerView.tag == 7 {
            return airSymptomsPicker.text = airSymptoms[row]
        } else if pickerView.tag == 8 {
            return wasteTypePicker.text = wasteType[row]
        } else if pickerView.tag == 9 {
            return wasteOdorPicker.text = airOdor[row]
        } else {
            return waterColorPicker.text = "error"
        }
    }
}
