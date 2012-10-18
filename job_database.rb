class JobDatabase
  require 'sqlite3'

  attr_accessor :database

  def initialize
    @database = SQLite3::Database.new "job_database.db"

    rows = @database.execute <<-SQL
      create table jobs (
        id INTEGER PRIMARY KEY,
        title VARCHAR(255),
        source VARCHAR(255),
        job_url VARCHAR(255),
        company VARCHAR(255),
        location VARCHAR(255),
        job_type VARCHAR(255),
        telecommute BOOLEAN,
        description text
      );
    SQL
  end

  def insert_row(*args)
    self.database.execute("INSERT INTO jobs (title, source, job_url, company, location, job_type, telecommute, description) 
                                            VALUES (?, ?, ?, ?, ?, ?, ?, ?);", [args])
  end

  def self.drop_database
    File.delete('job_database.db') if File.exists?('job_database.db')
  end
end