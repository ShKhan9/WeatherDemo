//
//  ViewController.swift
//  WeatherDemo
//
//  Created by MacBook Pro on 9/3/21.
//

import UIKit 
class HomeVC: BaseVC {

    var citiesTv:UITableView!
    var plusBu:UIButton!
    var headerlb:UILabel!
    var addTexF:UITextField!
    var textContentView:UIView!
    var doneBu:UIButton!
    var emptylb:UILabel!
    
    let res = WeatherVM()
    let homeViewModel = HomeVM()
    var allCities = [City]()
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = viewThemeColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        allCities = homeViewModel.getCities()
        addEmptylb()
        print(allCities.count)
        configUI()
    }
    func configUI() {
        addHeader()
        addPlusBu() 
        addBottomStyling(CGPoint(x: 1.0, y:0.55))
        addTable()
        addTextContentView()
    }
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
    
    func addTextContentView() {
         
        textContentView = UIView()
        textContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textContentView)
        NSLayoutConstraint.activate([
            textContentView.centerYAnchor.constraint(equalTo: headerlb.centerYAnchor),
            textContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
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
    }
    
    func addEmptylb() {
        guard allCities.isEmpty else { return }
        emptylb = UILabel()
        emptylb.text = "There is no data to show , click above + and add a city name"
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
    
    func removeEmptylb() {
        emptylb?.removeFromSuperview()
    }
   
    @objc func doneButtonClicked(_ sender:UIButton) {
        
        let cityName = addTexF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if cityName != "" {
            startSearchWith(cityName)
            showTextCon(false)
        }
        else {
            showToast(message: "Invalid city name")
        }
        
    }
   
    func startSearchWith(_ name:String) {
        res.getWeatherData(for:name) { [weak self] res in
            if res != nil {
                self?.homeViewModel.saveWeatherData(name,res)
                self?.allCities = self?.homeViewModel.getCities() ?? []
                self?.citiesTv.reloadData()
                self?.removeEmptylb()
            }
            else {
                self?.showToast(message: "Problem getting weather info, please try again with correct city name")
            }
        }
    }
    @objc func addButtonClicked(_ sender:UIButton) {
            showTextCon(sender.tag == 0)
    }
    
    func showTextCon(_ show:Bool) {
        textContentView.isHidden = !show
        headerlb.isHidden = show
        plusBu.isHidden = show
        addTexF.text = ""
        plusBu.tag = show ? 1 : 0
        let _ = show ? addTexF.becomeFirstResponder() : addTexF.resignFirstResponder()
    }
     
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
        let vc = ShowCityVC()
        vc.city = allCities[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = allCities[indexPath.row]
            homeViewModel.deleteCity(item)
            allCities.remove(at: indexPath.row)
            addEmptylb()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
  
}
