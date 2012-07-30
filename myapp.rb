#
# Copyright 2012 CopperEgg Corporation.  All rights reserved.
#
require 'sinatra'
require 'json'

get '/' do
  "CopperEgg Webhook Handler Example"
end

post '/' do
  alert = Hash.new
  alert = JSON::parse(request.body.read)
  puts
  decode_post(alert)
  status 201
end


def decode_post(alert)
  issue_type = alert_text = alert_source = sys_name = probe_name = alert_desc = \
    alert_trigger = alert_id = ""
  alert.each do |key,value|
    if key.to_s == "alert_id"
      oidhash = Hash.new
      oidhash = value
      if oidhash.has_key?("$oid") == true
        alert_id = oidhash["$oid"]
      else
        puts "Error Decoding alert_id"
      end
    elsif key.to_s == "details"
      d = Array.new(alert["details"])
      puts "details array : "
      puts "\t" + d[0].to_s + " = " + d[1].to_s
      d1 = Array.new(d[2])
      d1.each_index { |i| puts "\t" + d1[i][0].to_s + " = " + d1[i][1].to_s }
    else
      if key.to_str == "alert_text"
        alert_text = value.to_str
      elsif key.to_str == "alert_source"
        alert_source = value.to_str
      elsif key.to_str == "issue_type"
        issue_type = value.to_str
      else
        puts  key.to_s + " = " + value.to_s
      end
    end
  end
  if issue_type == "active"
    mystr = Array.new(alert_text.split(': ',2))
    sys_name = mystr[0]
    mystr = Array.new(mystr[1].split('('))
    alert_desc = mystr[0]
    alert_trigger = mystr[1].delete(')')
  end
  if alert_source == "system"
    handle_system_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  elsif alert_source == "probe"
    handle_probe_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  else
    puts "Unknown alert source"
  end
end

###############################################
#
# system alert decoder / handler

def handle_system_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  if issue_type == "active"
    if alert_text.include? "Process List"
      handle_process_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "CPU Total Usage"
      handle_cpu_total_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "CPU Steal Usage"
      handle_cpu_steal_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "CPU IOWait sage"
      handle_cpu_iowait_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Active Memory Usage"
      handle_active_mem_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Filesystem Usage"
      handle_filesystem_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Load"
      handle_load_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Network Bytes Sent"
      handle_network_sent_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Network Bytes Received"
      handle_network_rcvd_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Health"
      handle_health_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "System Not Seen"
      handle_system_not_seen_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    else
      puts "Error decoding system alert_text"
    end
  else
    puts "system alert cleared:  id = " + alert_id
  end
end


###############################################
#
# Individual system alert handlers
# Insert code to be executed when the following alerts go active / inactive

def handle_process_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Process List alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_cpu_total_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "CPU Total Usage alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_cpu_steal_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "CPU Steal Usage alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_cpu_iowait_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "CPU IOWait Usage alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_active_mem_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Active Memory Usage alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_filesystem_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Filesystem Usage alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_load_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Load alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_network_sent_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Network Bytes Sent alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_network_rcvd_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Network Bytes Received alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_health_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Health alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_system_not_seen_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "System Not Seen alert:  id = " + alert_id + "\n\tsystem = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end



###############################################
#
# probe alert decoder / handler

def handle_probe_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
 if issue_type == "active"
    if alert_text.include? "Response Time"
      handle_response_time_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Response Status Code"
      handle_status_code_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Uptime"
      handle_uptime_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    elsif alert_text.include? "Health"
      handle_probe_health_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
    else
      puts "Error decoding probe alert_text"
    end
  else
    puts "probe alert cleared:  id = " + alert_id
  end
end


###############################################
#
# Individual probe alert handlers
# Insert code to be executed when the following probe alerts go active / inactive

def handle_response_time_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Response Time alert:  id = " + alert_id + "\n\tprobe = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_status_code_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Response Status Code alert:  id = " + alert_id + "\n\tprobe = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_uptime_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Uptime alert:  id = " + alert_id + "\n\tprobe = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end

def handle_probe_health_alert(issue_type,sys_name,alert_desc,alert_trigger,alert_text,alert_id)
  puts "Health alert:  id = " + alert_id + "\n\tprobe = " + sys_name + ", desc = " + alert_desc + ", trigger = " + alert_trigger
end
