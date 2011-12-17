# load the right csv library
if RUBY_VERSION >= '1.9'
  require 'csv'
  CSV_HANDLER = CSV
else
  begin
    # try faster csv
    require 'fastercsv'
    CSV_HANDLER = FasterCSV
  rescue Exception => e
    fail_message = "FasterCSV not installed, please `gem install fastercsv` for faster processing"
    if defined? Rails
      Rails.logger.info fail_message
    else
      puts fail_message
    end
    require 'csv'
    CSV_HANDLER = CSV
  end
end

if defined? Rails and (Rails.version.split('.').map(&:to_i).first < 3)
  raise "Error - This Comma version only supports Rails 3. Please use an older version for use with earlier rails versions."
end

require 'active_support/core_ext/class/inheritable_attributes'
require 'comma/relation' if defined?(ActiveRecord::Relation)

require 'comma/extractors'
require 'comma/generator'
require 'comma/array'
require 'comma/object'
require 'comma/render_as_csv'

if defined?(RenderAsCSV) && defined?(ActionController)
  ActionController::Base.send :include, RenderAsCSV
end
