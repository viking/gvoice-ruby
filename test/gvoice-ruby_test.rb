# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../test/test_helper")
 
class GvoiceRubyTest < Test::Unit::TestCase
  
  def setup
    setup_config_fixture
  end
  
  should "have project root constant" do
    assert_equal(File.expand_path(File.dirname(__FILE__) + '/..'), GvoiceRuby.const_get(:PROJECT_ROOT))
  end
  
  should "load configuration file" do
    @config.each_pair do |k,v| 
      assert_equal(v, @config[k.to_sym])
    end
  end
  
  should "write configuration file" do
    @config[:foo] = 'bar'
    GvoiceRuby.write_config(@config, File.dirname(__FILE__) + '/fixtures/config_fixture.yml')
    newly_loaded_config = GvoiceRuby.load_config(File.dirname(__FILE__) + '/fixtures/config_fixture.yml')
    assert_equal('bar', newly_loaded_config[:foo].to_s)
    @config.delete(:foo)
    GvoiceRuby.write_config(@config, File.dirname(__FILE__) + '/fixtures/config_fixture.yml')
  end
  
  should "raise IOError when config file not loaded" do
    assert_raise(IOError) { GvoiceRuby.load_config('foo') }
  end
  
  should "raise IOError when config file not written" do
    assert_raise(IOError) { GvoiceRuby.write_config(@config, 'foo') }
  end
end