//
//  ViewController.swift
//  Charts_Demo
//
//  Created by 이상윤 on 2021/04/27.
//



import UIKit
import Charts




class ViewController: UIViewController {

    
    @IBOutlet weak var chart: RadarChartView!
    let activities = ["고사리", "고구마", "호박", "고등어", "멸치"]
    var originalBarBgColor: UIColor!
    var originalBarTintColor: UIColor!
    var originalBarStyle: UIBarStyle!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chart.backgroundColor = UIColor(red: 60/255.0, green: 65/255.0, blue: 82/255.0, alpha: 1.0)
        chart.webColor = UIColor.lightGray
        chart.innerWebColor = UIColor.lightGray
        chart.webAlpha = 100
        
        var marker : MarkerView = RadarMarkerView.viewFromXib()!
        marker.chartView = chart
        chart.marker = marker
        
        setData()
        chart.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
        
        let xAxis = chart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .white
        
        let yAxis = chart.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight:.light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        yAxis.drawLabelsEnabled = false
        
        let l = chart.legend
        l.verticalAlignment = Legend.VerticalAlignment.top
        l.horizontalAlignment = Legend.HorizontalAlignment.center
        l.orientation = Legend.Orientation.horizontal
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 5
        l.textColor = UIColor.white
    
    }

    func setData(){

        let mult: UInt32 = 80
        let min: UInt32 = 20
        let cnt = 5
        
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        let entries2 = (0..<cnt).map(block)
        
        let set1 = RadarChartDataSet(entries: entries1, label: "Data 1")
        set1.setColor(UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1))
        set1.fillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 2
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        let set2 = RadarChartDataSet(entries: entries2, label: "Data 2")
        set2.setColor(UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1))
        set2.fillColor = UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.7
        set2.lineWidth = 2
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        
//        let data: RadarChartData = [set1, set2]
        let data = RadarChartData(dataSets: [set1, set2])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(false)
        data.setValueTextColor(.white)
        
        chart.data = data
    }


}







extension ViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}

