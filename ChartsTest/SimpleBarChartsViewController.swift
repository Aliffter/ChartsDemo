//
//  ViewController1.swift
//  ChartsTest
//
//  Created by 赵隆晓 on 2020/10/12.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

import UIKit
import Charts
class SimpleBarChartsViewController: UIViewController, ChartViewDelegate {
    
    //柱状图图
    var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        initChartView()
    }
    
    
    func initChartView()  {
        
        //创建柱状图组件对象
        chartView = BarChartView()
        chartView.delegate = self
        chartView.backgroundColor = UIColor.white
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
                                 height: 260)
        
//        chartView.zoom(scaleX: 1, scaleY: 1, x: 0, y: 0) //设置缩放倍数
//        chartView.setScaleEnabled(false)
        
        self.view.addSubview(chartView)
        
        let years = ["2001", "2002", "2003"]
        
        //生成10条随机数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<5 {
            let y = arc4random()%100
            let entry = BarChartDataEntry(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这20条数据作为柱状图的所有数据
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "图例1")
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        chartData.barWidth = 0.8
        chartDataSet.colors = [.blue
            , .orange, .red,.green,.purple] //三种颜色交替使用
        
        
        //设置X轴
        chartView.xAxis.centerAxisLabelsEnabled = false  //文字标签居中
        chartView.xAxis.granularity = 0.5                 //间隔尺寸
        chartView.xAxis.labelPosition = .bottom         //文字显示位置
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:years)
        
        //设置y轴范围
        chartView.leftAxis.axisMinimum = 0
        chartView.rightAxis.axisMinimum = 0
        
        //设置柱状图数据
        chartView.data = chartData
        
    }
    
    
    //点击选中柱形图时的代理方法
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected")
    }
    
    //没有选中柱形图时的代理方法
    func chartValueNothingSelected(_ chartView: ChartViewBase){
        print("chartValueNothingSelected")
    }
        
    //捏合放大或缩小柱形图时的代理方法
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat)
    {
        print("chartScaled")
    }
    
    //拖拽图表时的代理方法
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat)
    {
        print("chartTranslated")
    }
    
    
}


