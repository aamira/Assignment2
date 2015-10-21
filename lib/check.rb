#checks if there is an error
#returns error message
#returns nil if no error

require 'date'
require_relative 'dateformat.rb'

def check_requirement(argument,expected)
   if (expected=="true" and argument.nil?)
     return "Value REQUIRED"
   else return nil
   end
 end
  
def check_type(argument,expected,value)
  argument.downcase!
  expected.downcase!
  
  if argument.eql?expected
    return nil
  else
    case argument
    when "float"
      if expected.eql?"number" 
        return nil
      elsif expected.eql?"integer" or expected.eql?"int"
        return nil if value.is_a?(Float) && value.denominator == 1
        return "INTEGER REQUIRED"
      else 
        if expected.eql?"string" 
          return "STRING REQUIRED"
        else return "BOOLEAN REQUIRED"
        end
      end
    when "string"
      if expected.eql?"boolean" or expected.eql?"bool"
        if value.eql?"true" or value.eql?"false"
           return nil
        else return "BOOLEAN REQUIRED"
        end
        elsif expected.eql?"date"
          begin
            date = Date.parse value
            return nil
            rescue => err
              return "DATE REQUIRED"
           end
         end
    else
      if expected.eql?"number"
        return "NUMBER REQUIRED"
      elsif expected.eql? "integer" or expected.eql? "int"
        return "INTEGER REQUIRED"
      elsif expected.eql?"date" 
        return "DATE REQUIRED"
      else "FLOAT REQUIRED"
      end
    end
    end
end

def check_regex(expectedtype,regex, value)
  pattern = Regexp.new("^"+regex+"+$")  
 if expectedtype.eql? "date"
   return check_date_format(value,regex)
 elsif expectedtype.eql? "number"
   unless regex.include? "."
     new_regex = regex[0..regex.length-2]
     new_regex << ".]" 
    #puts "new reg #{new_regex}"
    pat = Regexp.new("^"+new_regex+"+$")  
    return "INVALID PATTERN. Expected "+ regex if String(value)!~pat
   end   
  elsif expectedtype.eql? "integer" or expectedtype.eql? "int"
    value = value.to_i if value.is_a?(Float) && value.denominator == 1
    return "INVALID PATTERN. Expected "+ regex if String(value)!~pattern    
 else
   return "INVALID PATTERN. Expected "+ regex if String(value)!~pattern  
 end
  nil
end