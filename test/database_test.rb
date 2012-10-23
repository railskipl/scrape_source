require 'minitest/spec'
require 'minitest/autorun'
require_relative '../job'
require_relative '../company'
require_relative '../database'


describe Database do


  before(:each) do
    Database.drop_database
    Database.create_database
  end

  it "should have class method create_database that creates jobs and company tables" do
    assert_equal File.exists?('job_database.db'), true
  end

  it "should have a jobs table" do
    assert_equal Database.new.all_rows('jobs').is_a?(Array), true
  end

  it "should have a companies table" do
    assert_equal Database.new.all_rows('companies').is_a?(Array), true
  end


  
  # it "exists" do
  #   Company.new.must_be_instance_of Company
  # end

  # it "should have a name attr" do
  #   company = Company.new
  #   company.name = "Google"
  #   assert_equal company.name, "Google"
  # end


end