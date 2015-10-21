#reads the expected_data file and returns an array of requirements for each column

Requirement = Struct.new(:datatype, :required, :regex)

def get_requirements
  begin    
    req = Array.new{Requirement.new}  
    file = File.new('D:\Aptana\assignment2\test_data\module_1\expected_data','r')  
    while line = file.gets 
      unless line[0]=='#' || line.length<=1 
        arr = line.split(",")
        arr[0]=arr[0][8..arr[0].length-1]
        arr[2]=arr[2][0..arr[2].length-2]
        #puts arr
        req.push(:datatype => arr[0], :required => arr[1], :regex => arr[2])
      end
    end     
    file.close   
    return req  
   rescue => err
     puts err
   end
 end
