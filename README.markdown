#Scraping website for information

I am working with patterns and objects to create a scraper class that can handle any site.

The Scraper object is an abstraction of the two original scrapers that I built to get jobs from Ruby Inside and Ruby Now. The original versions of them are can be found in these files: ruby_inside_scraper.rb and ruby_now_scraper.rb

To jump right in, check out the scraper.rb file and how I initialize it in app.rb.

##Creating a scraper object:

Initialize a Scraper instance and pass in a name (this is just for you), the index url, the base URL for the individual pages you want to get information from and a database connection

```
ruby_now = Scraper.new('Ruby Now', 'http://jobs.rubynow.com/', 
                      'http://jobs.rubynow.com', job_database)
  
```
Tell the scraper object you want it to compile all of the URLs you will need to visit from the index page, pass in the css selector:

```
ruby_now.compile_job_url_collection('ul.jobs li h2 a:first')

```
Tell the object you want it to begin scraping. The ```.scrape_away``` method accepts a hash. **The convention for naming keys is the database column name, followed by an underscore and the type of attribute you want.** The example shows text, but eventually you will be able to select href, data attributes, etc.

```
ruby_now.scrape_away({
  :title_text => 'h2#headline',
  :company_text => 'h2#headline a',
  :location_text => 'h3#location',
  :type_text => 'strong:last',
  :description_text => 'div#info'
})
```

That's it!

## Anatomy of a scraper

[http://kcurtin.github.com/blog/2012/10/17/the-anatomy-of-a-scraper/](http://kcurtin.github.com/blog/2012/10/17/the-anatomy-of-a-scraper/)