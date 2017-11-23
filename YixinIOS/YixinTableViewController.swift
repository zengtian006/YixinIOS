//
//  YixinTableViewController.swift
//  YixinIOS
//
//  Created by zeng tim on 22/8/2017.
//  Copyright © 2017年 zeng tim. All rights reserved.
//

import UIKit

class YixinTableViewController: UITableViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var headerView: UIView!
    var newHeaderLayer :CAShapeLayer!
    private let headerHeight:CGFloat = 250.0
    
    lazy var feedListLine: ListFeedLine = {
        return ListFeedLine.yixinFeedLines()
    }()
    
    @IBAction func contactDoctor(_ sender: Any) {
        //自定义会话页面左上角返回按钮
        let leftBarButtonItemButton: UIButton = UIButton.init(frame: CGRect(x: 40, y: 0, width: 60, height: 40))
        leftBarButtonItemButton.setTitle("返回", for: UIControlState())
        leftBarButtonItemButton.setTitleColor(UIColor.blue, for: .normal)
        leftBarButtonItemButton.addTarget(self, action: #selector(leftBarButtonItemTouchUpInside(_:)), for: UIControlEvents.touchUpInside)
        
        //自定义会话界面titleView,如果不想自定义,请将对应参数设置为nill
        let titleView = UILabel.init(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleView.textColor = UIColor.black
        titleView.textAlignment = NSTextAlignment.center
        titleView.text = "在线医生"
        
        //自定义会话界面rightBarButtonItem,如果不想自定义,请将对应参数设置为nill
        let rightBarButtonItemButton = UIButton.init(frame: CGRect(x: 40, y: 0, width: 60, height: 40))
        rightBarButtonItemButton.setTitle("设置", for: UIControlState())
        rightBarButtonItemButton.setTitleColor(UIColor.blue, for: .normal)

//        rightBarButtonItemButton.addTarget(self, action: #selector(rightBarButtonItemTouchUpInside(_:)), for: UIControlEvents.touchUpInside)
        //默认机器人应答，亦可呼叫人工客服
        AppKeFuLib.sharedInstance().pushChatViewController(self.navigationController,
                                                           withWorkgroupName: "19871010",
                                                           hideRightBarButtonItem: false,
                                                           rightBarButtonItemCallback: nil,
                                                           showInputBarSwitchMenu: false,
                                                           withLeftBarButtonItem: leftBarButtonItemButton,
                                                           withTitleView: titleView,
                                                           withRightBarButtonItem: rightBarButtonItemButton,
                                                           withProductInfo: nil,
                                                           withLeftBarButtonItemColor: UIColor.blue,
                                                           hidesBottomBarWhenPushed: true,
                                                           showHistoryMessage: false,
                                                           defaultRobot: false,
                                                           mustRate: false,
                                                           withKefuAvatarImage: nil,
                                                           withUserAvatarImage: UIImage.init(named: "user_avatar"),
                                                           hideRateButton:true,
                                                           hideFAQButton:true,
                                                           shouldShowGoodsInfo: false,
                                                           withGoodsImageViewURL: nil,
                                                           withGoodsTitleDetail: nil,
                                                           withGoodsPrice: nil,
                                                           withGoodsURL: nil,
                                                           withGoodsCallbackID: nil,
                                                           goodsInfoClickedCallback: nil,
                                                           httpLinkURLClickedCallBack: { (url) in
                                                            
        },
                                                           faqButtonTouchUpInsideCallback: nil)
    }
    func notifyXmppStreamDisconnectWithError(_ notification: Notification) -> Void {
        
        self.title = "网络连接失败"
        
    }
    /**/
    func leftBarButtonItemTouchUpInside(_ sender: UIButton) -> Void {
        NSLog("leftBarButtonItemTouchUpInside")
    }
    /**/
    func rightBarButtonItemTouchUpInside(_ sender: UIButton) -> Void {
        
        let rightVC: KFRightButtonItemCallBackTableViewController = KFRightButtonItemCallBackTableViewController.init()
        self.navigationController?.pushViewController(rightVC, animated: true)
        
    }
    func updateView(){
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -headerHeight)
        
        newHeaderLayer = CAShapeLayer()
        newHeaderLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = newHeaderLayer
        
        setHeaderView()
    }
    
    func setHeaderView(){
        var getHeaderFrame = CGRect(x: 0, y: -headerHeight, width: tableView.bounds.width, height: headerHeight)
        if tableView.contentOffset.y < -headerHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y
        }
        headerView.frame = getHeaderFrame
        let cutDirection = UIBezierPath()
        cutDirection.move(to: CGPoint(x: 0, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: getHeaderFrame.height))
        cutDirection.addLine(to: CGPoint(x: 0, y: getHeaderFrame.height))
        newHeaderLayer?.path = cutDirection.cgPath
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        updateView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Text = \(searchBar.text)")
        searchBar.endEditing(true)
        performSegue(withIdentifier: "showWebsite1", sender: self)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        <#code#>
        //        print("Search Text = \(searchText)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedListLine.feedList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table Cell", for: indexPath) as! YixinTableViewCell
        let feed = feedListLine.feedList[indexPath.row]
        cell.titleLabel.text = feed.title
        cell.mainImage.image = feed.mainImage
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "showWebsite", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showWebsite1") {
            let destinationVC = segue.destination as! BrowserViewController
//            print("Row = \(tableView.indexPathForSelectedRow)")
            if tableView.indexPathForSelectedRow == nil && searchBar.text != nil{
                destinationVC.selected_title = "?s="+searchBar.text!;
            }else{
                destinationVC.selected_title = feedListLine.feedList[(tableView.indexPathForSelectedRow?.row)!].alias;
            }
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
