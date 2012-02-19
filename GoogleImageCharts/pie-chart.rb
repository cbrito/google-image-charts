# Ref: http://code.google.com/apis/chart/image/docs/gallery/pie_charts.html

module GoogleImageCharts
  class PieChart < ChartBase
    
    def initialize(chartOptionsHash)
      super(chartOptionsHash)
      
      @chartType = "p" # Pie chart
      
      @chartSpecificOptions << "&chds=a"      # Chart Scale (automatic scaling by Google)
      
    end
    
    def chartDataFlattened
      # Pie Charts are simple data numbers seperated by commas
      @chartData.join(",")
    end

  end
end