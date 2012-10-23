require 'minitest/spec'
require 'minitest/autorun'
require_relative '../job'
require_relative '../database'

describe Job do

  before(:each) do
    Database.drop_database
    Database.create_database
  end

  it "exists" do
    Job.new.must_be_instance_of Job
  end

  it "should have a title attr" do
    job = Job.new
    job.title = "cool"
    assert_equal job.title, "cool"
  end

  it "should have a description attr" do
    job = Job.new
    job.description = "cool"
    assert_equal job.description, "cool"
  end

  it "should have a link attr" do
    job = Job.new
    job.link = "cool"
    assert_equal job.link, "cool"
  end
  
  it "should have a company_id attr" do
    job = Job.new
    job.company_id = 1
    assert_equal job.company_id, 1
  end

  it "should have a location attr" do
    job = Job.new
    job.location = "cool"
    assert_equal job.location, "cool"
  end

  it "accepts a hash as arguments" do
    job = Job.new({:title => "Kevin"})
    assert_equal job.title, "Kevin"
  end

  it "#all should return all records in the database" do
    job = Job.new(:id => 1, :description => "My desc")
    job2 = Job.new(:id => 2, :title => "my title")
    db = Database.new
    db.insert_record(['title'], [job2.title], "jobs")
    db.insert_record(['description'], [job.description], "jobs")
    assert_equal Job.all.count, 2
  end

  it "should save to the database" do
    job = Job.new(:id => 1, :description => "My desc")
    job.save
    assert_equal Job.all.count, 1
  end

  it "should find jobs from the database using the job ID" do
    job = Job.new(:id => 10, :description => "Job #10")
    job.save
    assert_equal Job.find(10), job
  end



  # it "should save alinklink record to the database" do
  #   job = Job.new
  #   job.save
  #   assert_equal Job.all, [job]
  # end
end

