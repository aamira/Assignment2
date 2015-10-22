#checks a spreadsheet for errors and shows result in HTML

require 'roo'
require_relative 'source_file'
require_relative 'col_requirements'
require_relative 'check'

begin
  req = get_requirements
  file_source = get_file_spec
  
  #spreadsheet input
  xlsx = Roo::Excelx.new(file_source["source_file_path"])
  #output file (.html)
  output = File.new("output.html",'w')
  
  #html code
  output.write("<head>
  <meta charset=\"utf-8\">
  <title>Output</title>
  <style>
 

table { border-collapse:collapse;color:black; }
 th { font:bold 18px/1.1em ;text-shadow: 1px 1px 4px black;letter-spacing:0.3em;background-color:#BDB76B;color:white; }
 td, th { padding:0.5rem;border:1px solid #BDB76B;   text-align: center;}
 td { background-color:#FFFFE0; }
   
  </style>
</head>
<table align=\"center\">
<thead>
<tr>
<th>No.</th>")

  myexcel = xlsx.sheet 0
  counter = file_source["start_from_line_no"].to_i
  rows = counter-1
  myexcel.each do |row|
    
  if rows==counter-1
    row.length.times do |cols|
      #html
      output.write("<th>#{row[cols]}</th>")
    end
    
    #html
    output.write("</tr>
</thead>
<tbody>");
    
  end
  
  unless rows==counter-1
    #html
    output.write("<tr>
      <td>#{rows}</td>")
      
    row.length.times do |cols|
      req_check = check_requirement(row[cols],req[cols][:required]) 
      type_check = check_type(row[cols].class.to_s,req[cols][:datatype],row[cols])
      regex_check = check_regex(req[cols][:datatype],req[cols][:regex], row[cols])
    
      if req_check.nil? && type_check.nil? && regex_check.nil?
        #html
        output.write("<td><font color = 'green'>OK!</font></td>")
      else
        #html
        output.write("<td><font color = 'red'>#{req_check}\n#{type_check}\n#{regex_check}\n</font></td>")
      end 
    end
          
  end
  
    rows = rows.next
    output.write("</tr>")
  
  end
#html
  output.write("</tbody>
  </table>")
  output.close
  xlsx.close
  rescue => err
    puts err
  end
