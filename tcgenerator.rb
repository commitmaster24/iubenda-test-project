require 'json'
require 'pry'

begin
	template_file = nil
	dataset = nil
	output_file = 'T&C-Document.txt'
	
	ARGV.each_with_index do |arg, index|
		if (arg == '-t' && index+1 <= ARGV.length)
			template_file = ARGV[index + 1]
		elsif (arg == "-d" && index+1 <= ARGV.length)
			dataset = ARGV[index + 1]
		end
	end
	
	raise StandardError, "Files or Tags are used incorrectly" if template_file.to_s.empty? || dataset.to_s.empty?

	file_data = File.read(dataset)
	raise StandardError, "Data File does not contain any data" if file_data.to_s.empty?
	
	parsed_data = JSON.parse(file_data)
	clauses_hash = parsed_data["clauses"].map { |clause| [clause["id"], clause["text"]] }.to_h
	sections_hash = parsed_data["sections"].map { |section| [section["id"], section["clauses_ids"]] }.to_h

	template = File.read(template_file)

	placeholder_regex = /\[CLAUSE-(\d+)\]|\[SECTION-(\d+)\]/

	modified_template = template.gsub(placeholder_regex) do
		clause_id = $1 || $2
		if $1
			clauses_hash[clause_id.to_i]
		else
			sections_hash[clause_id.to_i].map {|id| clauses_hash[id]}.join(';')
		end
	end

	File.open(output_file, 'w') do |file|
		file.write(modified_template)
	end
rescue => err
	puts err.message
end