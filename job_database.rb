class JobDatabase
  require 'sqlite3'

  attr_accessor :database

  def initialize
    @database = SQLite3::Database.new "job_database.db"
  end

  def insert_record(columns, markers, args)
    sql = "INSERT INTO jobs (#{columns.join(",")}) VALUES (#{markers});"
    self.database.execute(sql, [args])
  end

  def self.create_database
    @database = SQLite3::Database.new "job_database.db"
    @database.execute <<-SQL
      create table jobs (
        id INTEGER PRIMARY KEY,
        title VARCHAR(255),
        source VARCHAR(255),
        job_url VARCHAR(255),
        company VARCHAR(255),
        location VARCHAR(255),
        type VARCHAR(255),
        telecommute BOOLEAN,
        description text
      );
    SQL
  end

  def self.drop_database
    File.delete('job_database.db') if File.exists?('job_database.db')
  end
end