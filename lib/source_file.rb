#this method reads the conf file and returns a hash with necessary information

def get_file_spec  
  begin
    conf = File.new("D:\\Aptana\\assignment2\\test_data\\module_1\\conf",'r')
    spec = Hash.new
    
    while line = conf.gets 
      unless line[0]=='#' || line.length<=1 
        arr = line.split("=")
        spec[arr[0]] = arr[1][0..arr[1].length-2]
      end
    end
    #p spec
    conf.close
    return spec
  rescue => err
    puts err   
  end  
end

#p get_file_spec