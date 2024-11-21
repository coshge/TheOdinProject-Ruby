require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

# Validate phone numbers
def clean_phone_number(phone_number)
  phone_number = phone_number.to_s.gsub(/\D/, '')  # Remove non-digit characters
  if phone_number.length < 10 || phone_number.length > 11
    return nil
  elsif phone_number.length == 10
    return phone_number
  elsif phone_number.length == 11 && phone_number[0] == '1'
    return phone_number[1..-1]  # Remove the leading '1'
  else
    return nil
  end
end

# Validate zipcode
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue Google::Apis::ClientError => e
    puts "Error fetching legislators for zip #{zip}: Invalid zipcode"
    return 'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')  # Create the output directory if it doesn't exist

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

# Track registration times and days
registration_hours = Hash.new(0)
registration_days = Hash.new(0)

puts 'EventManager initialized.'

# Reading CSV file and using ERB for letter template
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])  # Clean phone number
  
  # Skip this row if phone number is invalid
  next if phone_number.nil?

  begin
    registration_time = DateTime.strptime(row[:regdate], '%m/%d/%Y %H:%M')  # Convert registration time to DateTime
  rescue ArgumentError => e
    puts "Skipping row due to invalid registration date format: #{row[:regdate]}"
    next
  end

  # Track the hour and day of the week for each registration
  registration_hours[registration_time.hour] += 1
  registration_days[registration_time.wday] += 1

  legislators = legislators_by_zipcode(zipcode)

  # Generate the thank-you letter using ERB template
  form_letter = erb_template.result(binding)

  # Save the letter to the output directory
  save_thank_you_letter(id, form_letter)
end

# Output analysis
puts "Peak registration hours:"
registration_hours.sort_by { |hour, count| count }.reverse.each do |hour, count|
  puts "Hour: #{hour}, Registrations: #{count}"
end

puts "Peak registration days:"
registration_days.sort_by { |day, count| count }.reverse.each do |day, count|
  # Convert day number to day name
  day_name = Date::DAYNAMES[day]
  puts "Day: #{day_name}, Registrations: #{count}"
end
