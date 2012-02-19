# Ref: http://code.google.com/apis/chart/image/docs/gallery/pie_charts.html

module GoogleImageCharts
  class PieChart < ChartBase
    
    def initialize(chartOptionsHash)
      super(chartOptionsHash)
      
      @chartType = "p" # Pie chart
      
      @chartSpecificOptions << "&chds=a"      # Chart Scale (automatic scaling by Google)
      
    end
  private
    

  end
end