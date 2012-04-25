require 'uri'

module GoogleImageCharts  
  
  class ChartBase
    attr_accessor :chartTitle, :chartWidth, :chartHeight, :chartLabels, :chartColors, :additionalChartOptions, :usePost
    
    CHART_URI_BASE = "http://chart.apis.google.com/chart?"
    
    def initialize(chartOptionsHash)
      @chartSpecificOptions = ""  # Should be overridden by child-classes
      
      @chartWidth   = chartOptionsHash[:width]
      @chartHeight  = chartOptionsHash[:height]
      @chartTitle   = chartOptionsHash[:title]
      self.chartData=(chartOptionsHash[:data])  # Should be an array of data arrays
      
      @chartLabels  = chartOptionsHash[:labels]  # Should be an array of labels
      @chartLabelPosition  = "b" if chartOptionsHash[:labels].nil? == false
      
      @chartColors = chartOptionsHash[:colors]
      
      # These might be set by someone who knows what they are doing, perhaps after reading:
      # https://developers.google.com/chart/image/docs/chart_params
      @additionalChartOptions = chartOptionsHash[:additionalOptions]
      
      # Support the Google Image Charts POST method which allows up to 16K of chart data
      # https://developers.google.com/chart/image/docs/post_requests
      @usePost = chartOptionsHash[:usePost] #((chartOptionsHash[:usePost].nil? == true) || (@usePost != true)) ? false : true
         
    end
    
    def chartDataFlattened
      # Override in subclasses
      @chartData
    end
    
    def chartData=(data)
      # Take array of arrays and flatten to array of strings
      
      @chartData = Array.new
      data.each_index do |index|
        # Join the data only if it contains an array
        if data[index].class == Array
          @chartData.push data[index].join(",").to_s 
        else
          @chartData.push data[index]
        end
      end
      
    end
    
    def set_chart_label_position(position)
      @chartLabelPosition = case
                          when position == :top then "t"
                          when position == :left then "l"
                          when position == :right then "r"
                          when position == :bottom then "b"
                          else "b"
                          end
                            
    end
    
    def get_chart
      # returns a URL if usePost = false,
      # returns a PNG if usePost = true. Pass your encoding to the browser as appropriate.
      return @usePost == false ? chart_url : post_chart_data
    end
    
    def chart_url
      # Standard GET request
      chartURL = CHART_URI_BASE
      chartURL = chartURL + "cht="    + @chartType
      chartURL = chartURL + "&chs="   + @chartWidth.to_s + "x" + @chartHeight.to_s 
      chartURL = chartURL + "&chd=t:" + chartDataFlattened if @chartData.nil? == false # Simple text for now
      chartURL = chartURL + "&chdl="  + @chartLabels.join("|")  if @chartLabels.nil? == false
      chartURL = chartURL + "&chdlp="  + @chartLabelPosition    if @chartLabels.nil? == false
      chartURL = chartURL + "&chtt="  + @chartTitle             if @chartTitle.nil? == false
      chartURL = chartURL + "&chco="  + @chartColors.join(",")  if @chartColors.nil? == false
      
      chartURL = chartURL + @chartSpecificOptions + @additionalChartOptions
      
      return URI.escape(chartURL)
    end
    
    def post_chart_data
      # Used when you need to send more than 2K (up to 16K) of data to Google.
      require 'net/https'
      
      uri = URI.parse("https://chart.googleapis.com/chart")

      dataHash = {
        "cht" => @chartType,
        "chs" => @chartWidth.to_s + "x" + @chartHeight.to_s
      }
      
      dataHash.merge!( (@chartData.nil? == false) ? {"chd" => "t:#{chartDataFlattened.to_s}" } : {} )
      dataHash.merge!( (@chartLabels.nil? == false) ? {"chdl" => @chartLabels.join("|").to_s } : {} )
      dataHash.merge!( (@chartLabels.nil? == false) ? {"chdlp" => @chartLabelPosition } : {}        )
      dataHash.merge!( (@chartTitle.nil? == false) ? {"chtt" => @chartTitle } : {}                 )
      dataHash.merge!( (@chartColors.nil? == false) ? {"chco" => @chartColors.join(",").to_s } : {} )
      
      #For the remainder of these, we need to split on '&', then k,v on '='
      (@chartSpecificOptions.to_s + @additionalChartOptions.to_s).split('&').each do |option|
        pair = option.split('=')
        newElement = { pair[0].to_s => pair[1].to_s }
        dataHash.merge!( newElement )
      end

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(dataHash)

      response = http.request(request)
      return response.body
      
    end
    
    def html_img_tag
      return "<img src='#{chart_url}' alt='#{@chartTitle}' height='#{@chartHeight}' width='#{@chartWidth}' />"
    end
    
  end
  
  # Load all the chart types
  require 'GoogleImageCharts/line-graph.rb'
  require 'GoogleImageCharts/pie-chart.rb'
  
end

