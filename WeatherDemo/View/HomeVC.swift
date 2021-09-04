//
//  HomeVC.swift
//  WeatherDemo
//
//  Created by MacBook Pro on 9/3/21.
//

import UIKit 
class HomeVC: BaseVC {

    // Define all UI properties
    var citiesTv:UITableView!
    var plusBu:UIButton!
    var headerlb:UILabel!
    var addTexF:UITextField!
    var textContentView:UIView!
    var doneBu:UIButton!
    var cancelBu:UIButton!
    var emptylb:UILabel!
    var themeSeg:UISegmentedControl!
    
    // Define all data related properties
    let res = WeatherVM()
    let homeViewModel = HomeVM()
    var allCities = [City]()
    
    // Set empty view for programmatic vc
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = viewThemeColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Get all cities stored in coredata
        allCities = homeViewModel.getCities()
        // Add no cities label if cities has no data
        addEmptylb() 
        configUI()
    }
    // Add all ui elements
    func configUI() {
        addHeader()
        addPlusBu() 
        addBottomStyling(CGPoint(x: 1.0, y:0.55))
        addTable()
        addTextContentView()
        addThemeSegment()
    }
    // Add top header label
    func addHeader() {
        headerlb = UILabel()
        headerlb.text = "CITIES"
        headerlb.textColor = otherThemeColor
        headerlb.font = UIFont(name: "SFProText-Bold", size: 21)
        headerlb.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerlb)
        NSLayoutConstraint.activate([
            headerlb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            headerlb.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    // Add top plus button
    func addPlusBu() {
        plusBu = UIButton(type: .system)
        plusBu.setTitle("+", for: .normal)
        plusBu.titleLabel!.font = UIFont.systemFont(ofSize: 30)
        plusBu.contentHorizontalAlignment = .right
        plusBu.contentVerticalAlignment = .top
        plusBu.titleEdgeInsets = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 0.0, right: 20.0)
        plusBu.setBackgroundImage(UIImage(named: "Button_right".themed), for: .normal)
        plusBu.setTitleColor(currentThemeColor, for: .normal)
        plusBu.addTarget(self, action: #selector(self.addButtonClicked(_:)), for:.touchUpInside)
        plusBu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plusBu)
        NSLayoutConstraint.activate([
            plusBu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            plusBu.centerYAnchor.constraint(equalTo: headerlb.centerYAnchor,constant: 16),
            plusBu.widthAnchor.constraint(equalToConstant: 101),
            plusBu.heightAnchor.constraint(equalToConstant: 113)
        ])
    }
    // Add cities table
    func addTable() {
        citiesTv = UITableView(frame: CGRect.zero, style: .plain)
        citiesTv.translatesAutoresizingMaskIntoConstraints = false
        citiesTv.delegate = self
        citiesTv.dataSource = self
        citiesTv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        citiesTv.backgroundColor = .clear
        let back = UIView()
        back.backgroundColor = .clear
        citiesTv.tableFooterView = back
        view.addSubview(citiesTv)
        NSLayoutConstraint.activate([
            citiesTv.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            citiesTv.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            citiesTv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            citiesTv.topAnchor.constraint(equalTo: plusBu.bottomAnchor,constant: 20)
        ])
        
    }
    
    // Add text container view and hide it initially
    func addTextContentView() {
          

        textContentView = UIView()
        textContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textContentView)
  
        cancelBu = UIButton(type: .system)
        cancelBu.tintColor = otherThemeColor
        cancelBu.setTitleColor(otherThemeColor, for: .normal)
        cancelBu.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        cancelBu.addTarget(self, action: #selector(self.cancelButtonClicked(_:)), for:.touchUpInside)
        cancelBu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelBu)
        
        NSLayoutConstraint.activate([
            cancelBu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            cancelBu.centerYAnchor.constraint(equalTo: textContentView.centerYAnchor),
            cancelBu.widthAnchor.constraint(equalToConstant: 50),
            cancelBu.heightAnchor.constraint(equalToConstant: 50)
       ])
        

        NSLayoutConstraint.activate([
            textContentView.centerYAnchor.constraint(equalTo: headerlb.centerYAnchor),
            textContentView.leadingAnchor.constraint(equalTo: cancelBu.trailingAnchor,constant:5),
            textContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            textContentView.heightAnchor.constraint(equalToConstant: 60)
        ])
         
        doneBu = UIButton(type: .system)
        doneBu.setTitle("Add", for: .normal)
        doneBu.titleLabel!.font = UIFont.systemFont(ofSize: 20)
        doneBu.setTitleColor(otherThemeColor, for: .normal)
        doneBu.addTarget(self, action: #selector(self.doneButtonClicked(_:)), for:.touchUpInside)
        doneBu.translatesAutoresizingMaskIntoConstraints = false
        textContentView.addSubview(doneBu)
        NSLayoutConstraint.activate([
            doneBu.trailingAnchor.constraint(equalTo: textContentView.trailingAnchor,constant: -10),
            doneBu.centerYAnchor.constraint(equalTo: textContentView.centerYAnchor),
            doneBu.widthAnchor.constraint(equalToConstant: 40),
        ])
         
        addTexF = UITextField()
        addTexF.addPlaceholder("Enter city name")
        addTexF.textColor = otherThemeColor
        addTexF.font = UIFont(name: "SFProText-Bold", size: 21)
        addTexF.translatesAutoresizingMaskIntoConstraints = false
        textContentView.addSubview(addTexF)
        NSLayoutConstraint.activate([
            addTexF.leadingAnchor.constraint(equalTo: textContentView.leadingAnchor,constant: 10),
            addTexF.trailingAnchor.constraint(equalTo: doneBu.leadingAnchor,constant: -10),
            addTexF.centerYAnchor.constraint(equalTo: textContentView.centerYAnchor),
        ])
        
        textContentView.layer.cornerRadius = 15
        textContentView.layer.borderColor = otherThemeColor.cgColor
        textContentView.layer.borderWidth = 1
        textContentView.isHidden = true
        cancelBu.isHidden = true
        
    }
    // Add no cities label
    func addEmptylb() {
        guard allCities.isEmpty else { return }
        emptylb = UILabel()
        emptylb.text = "There is no data to show , click above + to add a city"
        emptylb.textColor = otherThemeColor
        emptylb.textAlignment = .center
        emptylb.numberOfLines = 0
        emptylb.font = UIFont(name: "SFProText-Bold", size: 21)
        emptylb.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptylb)
        NSLayoutConstraint.activate([
            emptylb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            emptylb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptylb.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    // Add switch for theme change
    func addThemeSegment() {
        themeSeg = UISegmentedControl(items: ["Light","Dark"])
        themeSeg.selectedSegmentTintColor = getAppThemeColor()
        themeSeg.selectedSegmentIndex = isLight ? 0 : 1
        themeSeg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : otherThemeColor], for: .normal)
        themeSeg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : currentThemeColor], for: .selected)
        themeSeg.translatesAutoresizingMaskIntoConstraints = false
        themeSeg.addTarget(self, action: #selector(self.segChanged(_:)), for:.valueChanged)
        view.addSubview(themeSeg)
        NSLayoutConstraint.activate([
            themeSeg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeSeg.centerYAnchor.constraint(equalTo: headerlb.centerYAnchor)
        ])
    }
    // Remove no cities label
    func removeEmptylb() {
        emptylb?.removeFromSuperview()
    }
    // Add done button tapped when user adds a city
    @objc func doneButtonClicked(_ sender:UIButton) {
        // remove white spaces from around the entered text
        let cityName = addTexF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if cityName != "" {
            // Start getting city weather info
            startSearchWith(cityName)
            // Hide text container view
            showTextCon(false)
        }
        else {
            // Show error when user enters invalid city name
            showToast(message: "Invalid city name")
        }
        
    }
    
    @objc func cancelButtonClicked(_ sender:UIButton) {
        showTextCon(false)
    }
    
    @objc func segChanged(_ sender:UISegmentedControl) {
        isLight.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = HomeVC()
        }
    }
   
    // Start getting weather info for a city
    func startSearchWith(_ name:String) {
        res.getWeatherData(for:name) { [weak self] res in
            if res != nil {
                // Save response to coredata
                self?.homeViewModel.saveWeatherData(name,res)
                self?.allCities = self?.homeViewModel.getCities() ?? []
                // Refresh the tableView after data changed
                self?.citiesTv.reloadData()
                // Remove empty label if exists
                self?.removeEmptylb()
            }
            else {
                // Show error message when there is a problem with api call
                self?.showToast(message: "Problem getting weather info, please try again with correct city name")
            }
        }
    }
    // Action of plus button to add a new city
    @objc func addButtonClicked(_ sender:UIButton) {
            showTextCon(sender.tag == 0)
    }
    // manage textfield container show/hide
    func showTextCon(_ show:Bool) {
        textContentView.isHidden = !show
        cancelBu.isHidden = !show
        headerlb.isHidden = show
        plusBu.isHidden = show
        themeSeg.isHidden = show
        addTexF.text = ""
        plusBu.tag = show ? 1 : 0
        let _ = show ? addTexF.becomeFirstResponder() : addTexF.resignFirstResponder()
    }
    // handle table accessory click to navigate to history data for a specific city
    @objc func accessoryClicked(_ sender:UITapGestureRecognizer) {
        let vc = HistoryVC()
        vc.city = allCities[sender.view!.tag]
        self.present(vc, animated: true, completion: nil)
    }

}
  
extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! 
        let item = allCities[indexPath.row]
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.textLabel?.textColor = otherThemeColor
        cell.textLabel?.text = item.name
        cell.textLabel?.font = UIFont(name: "SFProText-Bold", size: 19)
        cell.selectionStyle = .none
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.isUserInteractionEnabled = true
        imgView.tag = indexPath.row
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accessoryClicked)))
        imgView.image = UIImage(systemName: "chevron.right")!
        imgView.tintColor = getAppThemeColor()
        cell.accessoryView = imgView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Display city latest weather data
        let vc = ShowCityVC()
        vc.city = allCities[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Enable editing for delete
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = allCities[indexPath.row]
            // Delete city when user swips
            homeViewModel.deleteCity(item)
            // Update table dataSource array
            allCities.remove(at: indexPath.row)
            // Remove empty label if exists
            addEmptylb()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
  
}
