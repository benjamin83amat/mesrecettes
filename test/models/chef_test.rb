require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "jonica", email: "joni@acasa.eu")
  end
  
  test "chef shoud be valid" do
    assert @chef.valid?
  end
  
  test "chef shoud be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email shoud be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email shoud be whithin bounds" do
    @chef.email = "a" * 101 + "@acasa.eu"
    assert_not @chef.valid?
  end
  
  test "email shoud be unique" do
    dup_chef = @chef.dup 
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation shoud accept valid addres" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@acasa.eu user@bunica.uk user@example.com first.last@eem.eu laura+joe@monk.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "email validation shoud reject invalid addres" do
    invalid_addresses = %w[user@eee,com  user_at_ee.org user@acasa user.name@example. first.last@e_e_m.com laura@mo+nk.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end
  
end