class Database
  require 'sqlite3'

  attr_accessor :database

  def initialize
    @database = SQLite3::Database.new "job_database.db"
    self.database.results_as_hash = true
  end

  def find_obj_by_id(id, table)
    @database.execute("SELECT * FROM #{table} WHERE id = (?)", id).first
  end

  def find_jobs_by_company_id(company_id)
    @database.execute("SELECT * FROM jobs WHERE company_id = (?)", [company_id])
  end

  def insert_record(columns, args, table)
    markers = Array.new(columns.size, "?").join(",")
    self.database.execute("INSERT INTO #{table} (#{columns.join(",")}) VALUES (#{markers});", [args])
  end

  def all_rows(table)
    self.database.execute("SELECT * FROM #{table}")
  end

  def self.create_database
    @database = SQLite3::Database.new "job_database.db"
    create_jobs_table
    create_companies_table
  end

  def self.create_jobs_table
    @database.execute <<-SQL
      create table jobs (
        id INTEGER PRIMARY KEY,
        title VARCHAR(255),
        source VARCHAR(255),
        link VARCHAR(255),
        company_id INT,
        location VARCHAR(255),
        type VARCHAR(255),
        telecommute BOOLEAN,
        description text
      );
    SQL
  end

  def self.create_companies_table
    @database.execute <<-SQL
      create table companies (
        id INTEGER PRIMARY KEY,
        name VARCHAR(255),
        link VARCHAR(255),
        description TEXT
      );
    SQL
  end

  def self.drop_database
    File.delete('job_database.db') if File.exists?('job_database.db')
  end
end