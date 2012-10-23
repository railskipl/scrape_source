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
    sample_job = Job.new({id: 1, title: "Senior dev", company_id: 1, source: "ruby now", link: "test.com",
                          location: "NY", type: "part time", telecommute: "yest", description: "here is description"})
    sample_job2 = Job.new({id: 2, title: "test dev", company_id: 1, source: "ruby now", link: "test.com",
                          location: "NY", type: "part time", telecommute: "yest", description: "here is description"})
    sample_job3 = Job.new({id: 3, title: "tear dev", company_id: 2, source: "ruby now", link: "test.com",
                          location: "NY", type: "part time", telecommute: "yest", description: "here is description"})

    sample_job.save
    sample_job2.save
    sample_job3.save

    #Weird error message about Array#== method
    company = Company.new
    company.id = 1
    jobs = company.jobs
    # assert_equal [1,1], [sample_job2.company_id, sample_job.company_id]
    assert_equal jobs, [sample_job, sample_job2]
  end



end