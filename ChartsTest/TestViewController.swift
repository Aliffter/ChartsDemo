//
//  TestViewController.swift
//  ChartsTest
//
//  Created by 赵隆晓 on 2020/10/18.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

import UIKit
import Charts

class TestViewController: UIViewController , ChartViewDelegate{
    //柱状图图
    var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //创建柱状图组件对象
        chartView = BarChartView()
        chartView.delegate = self
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
                                 height: 260)
        //立柱数值文字显示在内部
        chartView.drawValueAboveBarEnabled = true
        
        //显示图例
        chartView.legend.enabled = true
        
        //设置x轴缩放倍数
        chartView.zoom(scaleX: 2, scaleY: 1, x: 0, y: 0) //
        chartView.setScaleEnabled(false)
        
        //barChartView的交互设置
        chartView.scaleYEnabled = false  //取消Y轴缩放
        chartView.doubleTapToZoomEnabled = false   //取消双击缩放
        chartView.dragEnabled = true  //启用拖拽图表
        chartView.dragDecelerationEnabled = false  //拖拽后是否有惯性效果
        chartView.dragDecelerationFrictionCoef = 0 //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        chartView.rightAxis.enabled = false  //不绘制右边轴
        
        
        
        let years = ["上海分公司", "北京分公司", "河南分公司","","","","","","","",""]
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:years)
        
        
        
        addXAxisType()
        addYAxisType()
        
        addLimmitLine()
        
        self.view.addSubview(chartView)
        
        //生成10条随机数据
        var dataEntries = [BarChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            // 生成显示的数据
            //            let entry = BarChartDataEntry(x: Double(i), y: Double(y))
            //            let entry = BarChartDataEntry(x: Double(i), y: Double(y), icon: nil)
            let entry = BarChartDataEntry.init(x: Double(i), y: Double(y), data: ["key":"hahahha"])
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
    
    func addXAxisType()  {
        //设置barChartView的X轴样式
        let xAxis = self.chartView.xAxis
        xAxis.axisLineWidth = 1  //设置X轴线宽
        xAxis.labelPosition = .bottom  //X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = true   //不绘制网格线
        //xAxis.l = 4  //设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.labelTextColor = UIColor.brown //label文字颜色
        xAxis.labelCount = 5
        //
        //x轴显示在左侧
        xAxis.labelPosition = .bottom

    }
    
    func addYAxisType() {
        //设置左侧Y轴的样式
        let leftAxis = chartView.leftAxis
        leftAxis.forceLabelsEnabled = false   //不强制绘制制定数量的label
        //leftAxis = false  //是否只显示最大值和最小值
        leftAxis.axisMinimum = 0  //设置Y轴的最小值
        leftAxis.axisMaximum = 105   //设置Y轴的最大值

        leftAxis.drawZeroLineEnabled = true   //从0开始绘制
        leftAxis.inverted = false   //是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5    //Y轴线宽
        leftAxis.axisLineColor =  UIColor.black  //Y轴颜色
        leftAxis.labelCount = 5
        leftAxis.forceLabelsEnabled = false
        
        
        //设置Y轴上标签的样式
        leftAxis.labelPosition = .outsideChart   //label位置
        leftAxis.labelTextColor = UIColor.brown   //文字颜色
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)  //文字字体
        
        //设置Y轴上标签显示数字的格式
        let  leftFormatter = NumberFormatter()  //自定义格式
        leftFormatter.positiveSuffix = " $"  //数字后缀单位
        chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftFormatter)
    }
    
    // 设置限制线
    func addLimmitLine()  {
        let leftAxis = chartView.leftAxis
        
        //设置Y轴上网格线的样式
        leftAxis.gridLineDashLengths = [3.0, 3.0]   //设置虚线样式的网格线
        leftAxis.gridColor = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)  //网格线颜色
        leftAxis.gridAntialiasEnabled = true   //开启抗锯齿

        
        let limitLine = ChartLimitLine(limit: 20, label: "限制线")
        limitLine.lineWidth = 2
        limitLine.lineColor = UIColor.green
        limitLine.lineDashLengths = [5.0, 5.0]   //虚线样式
        limitLine.labelPosition = .topRight  //位置
        leftAxis.addLimitLine(limitLine)  //添加到Y轴上
        leftAxis.drawLimitLinesBehindDataEnabled = true  //设置限制线绘制在柱形图的后面

    }
    
    
    //点击选中柱形图时的代理方法
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected_entry : ",entry.data ?? "" )
        print("--------------------------")
        print("chartValueSelected_highlight : ", highlight)
        print("--------------------------")
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
