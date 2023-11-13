require 'rspec'
require_relative '../tcgenerator.rb'


RSpec.configure do |config|
  config.before(:each) do
    File.delete('T&C-Document.txt') if File.exist?('T&C-Document.txt')
  end
end

RSpec.describe 'Template Replacement' do

  it 'replaces placeholders in the template' do

    template_file = 'template.txt'
    json_data_file = 'dataset.json'
    
    modified_template = `ruby tcgenerator.rb -t #{template_file} -d #{json_data_file}`
    result = File.read('T&C-Document.txt')

    expect(modified_template).to be_truthy
    expect(result).to include("A T&C Document")
    expect(result).to include("This document is made of plaintext")
    expect(result).to include("Is made of The quick brown fox")
    expect(result).to include("Is made of And dies.")
    expect(result).to include("Your legals.")
  end

  it 'does not find the file' do 

    template_file = 'template.txt'
    json_data_file = 'dataset1.json'

    modified_template = `ruby tcgenerator.rb -t #{template_file} -d #{json_data_file}`
    expect(modified_template).to include("No such file")
  end

  it 'tags are not correct' do 
    template_file = 'template.txt'
    json_data_file = 'dataset.json'

    modified_template = `ruby tcgenerator.rb -t #{template_file} -u #{json_data_file}`
    expect(modified_template).to include("Tags are used incorrectly")
  end

  it 'Data file does not contain clause ID' do
    template_file = 'template_with_no_clause_id.txt'
    json_data_file = 'dataset.json'

    modified_template = `ruby tcgenerator.rb -t #{template_file} -d #{json_data_file}`
    
    result = File.read('T&C-Document.txt')
    expect(result).to include("Hello this is [CLAUSE-].")
  end

  it 'Data is not present in the dataset File' do
    template_file = 'template.txt'
    json_data_file = 'dataset_empty.json'

    modified_template = `ruby tcgenerator.rb -t #{template_file} -d #{json_data_file}`
    
    expect(modified_template).to include("Data File does not contain any data")
  end
end