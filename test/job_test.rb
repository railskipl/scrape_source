require 'minitest/spec'
require 'minitest/autorun'
require_relative '../job'
require_relative '../job_database'

describe Job do
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
    JobDatabase.drop_database
    JobDatabase.create_database
    db = JobDatabase.new
    db.insert_record(['title'],'?', [job2.title])
    db.insert_record(['description'],'?', [job.description])
    assert_equal Job.all.count, 2
  end

  # it "should save alinklink record to the database" do
  #   job = Job.new
  #   job.save
  #   assert_equal Job.all, [job]
  # end
end

