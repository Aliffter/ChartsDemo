//
//  TestViewController.swift
//  ChartsTest
//
//  Created by 赵隆晓 on 2020/10/18.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

import UIKit
import Charts

class TestViewController: UIViewController {
    //柱状图图
    var chartView: BarChartView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //创建柱状图组件对象
        chartView = BarChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
                                 height: 260)
        //立柱数值文字显示在内部
        chartView.drawValueAboveBarEnabled = true

        //显示图例
        chartView.legend.enabled = true
        
        //x轴显示在左侧
        chartView.xAxis.labelPosition = .bottom
        
        //y轴起始刻度为0
        chartView.leftAxis.axisMinimum = 10
        chartView.rightAxis.axisMinimum = 20
        
        //设置x轴缩放倍数
        chartView.zoom(scaleX: 2, scaleY: 1, x: 0, y: 0) //
        chartView.setScaleEnabled(false)

        //barChartView的交互设置
        chartView.scaleYEnabled = false  //取消Y轴缩放
        chartView.doubleTapToZoomEnabled = false   //取消双击缩放
        chartView.dragEnabled = true  //启用拖拽图表
        chartView.dragDecelerationEnabled = false  //拖拽后是否有惯性效果
        chartView.dragDecelerationFrictionCoef = 0 //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显

        let years = ["上海分公司", "北京分公司", "河南分公司","","","","","","","",""]

        //设置barChartView的X轴样式
        let xAxis = self.chartView.xAxis
        xAxis.axisLineWidth = 1  //设置X轴线宽
        xAxis.labelPosition = .bottom  //X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = true   //不绘制网格线
        //xAxis.l = 4  //设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.labelTextColor = UIColor.brown //label文字颜色
        xAxis.labelCount = 5
//        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:years)
        
        self.view.addSubview(chartView)
         
        //生成10条随机数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            // 生成显示的数据
//            let entry = BarChartDataEntry(x: Double(i), y: Double(y))
            let entry = BarChartDataEntry(x: Double(i), y: Double(y), icon: nil)
            
            dataEntries.append(entry)
        }
        

        //这20条数据作为柱状图的所有数据
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "图例1")
        chartDataSet.colors = [.red, .blue, .green] //三种颜色交替使用
       
        /**
         *   chartDataSet  style
         */
        //立柱的边框颜色、线宽
        chartDataSet.barBorderWidth = 3
        chartDataSet.barBorderColor = .orange
        //不显示立柱数值文字标签
        chartDataSet.drawValuesEnabled = true
        
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        

        //默认情况下柱状图中每根柱子占其所处刻度区域宽度的 85%，我们可以修改它所占的宽度比例。
         //设置柱子宽度为刻度区域的一半
         chartData.barWidth = 0.5
        

        //设置柱状图数据
        chartView.data = chartData
        
        // 会重新刷新数据 伸缩比会失效
//        chartView.fitScreen()
        
        //绘制间隔
//        chartView.animate(xAxisDuration: 1)

    }
    

}
