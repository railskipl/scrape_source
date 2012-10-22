require 'minitest/spec'
require 'minitest/autorun'
require_relative '../job'
require_relative '../company'
require_relative '../job_database'

describe Company do


  before(:each) do
    JobDatabase.drop_database
    JobDatabase.create_database
  end

  
  it "exists" do
    Company.new.must_be_instance_of Company
  end

  it "should have a name attr" do
    company = Company.new
    company.name = "Google"
    assert_equal company.name, "Google"
  end

  it "should have a link attr" do
    company = Company.new
    company.link = "google.com"
    assert_equal company.link, "google.com"
  end

  it "should have a description attr" do
    company = Company.new
    company.description = "Google is the place to be"
    assert_equal company.description, "Google is the place to be"
  end

  it "should have a unique id attr" do
    company = Company.new
    company.id = 1
    assert_equal company.id, 1
  end

  it "should have method jobs that returns an array of all jobs from that company" do

    sample_job = Job.new({:title => "Senior dev", :company_id => 1})
    sample_job2 = Job.new({:title => "Junior dev", :company_id => 1})
    sample_job3 = Job.new({:title => "Customer support position", :company_id => 2})

    sample_job.save
    sample_job2.save
    sample_job3.save


    company = Company.new
    company.id = 1
    assert_equal company.jobs, [sample_job, sample_job2]
    
  end

end