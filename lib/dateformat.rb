#checks date format and returns an error message
#returns nil if no error
#handles format, 30days month, february and leap years

def check_date_format(date,format)
  return "No date"  if date.nil?
  date_hash = Hash.new
  
  date_array = date.scan(/[\w]+/)
  format_array = format.scan(/[\w]+/)
  
  date_hash[format_array[0]] = date_array[0].to_i
  date_hash[format_array[1]] = date_array[1].to_i
  date_hash[format_array[2]] = date_array[2].to_i
  
  #p date_hash
  
  return "INVALID DATE. Must be in [1..31]" unless (1..31)===date_hash["dd"]
  return "INVALID MONTH. Must be in [1..12]" unless (1..12)===date_hash["mm"]
  return "YEAR MUST BE 4 DIGITS" unless date_hash["yyyy"].to_s.length ==4
  
  #feb
  if date_hash["mm"] ==2
    if date_hash["dd"] ==29 and date_hash["yyyy"]%4!=0
      return "NOT A LEAP YEAR"
    elsif (1..28)===date_hash["dd"]
      return "INVALID DATE. Must be in [1..28]"
    end
  end 
  
  #30days month
  unless [1,3,5,7,8,10,12].include?date_hash["mm"]
     return "INVALID DATE. Must be in [1..30]" if date_hash["dd"]==31
  end 
  return nil
end

#puts check_date_format("1931-2-29","yyyy-mm-dd")