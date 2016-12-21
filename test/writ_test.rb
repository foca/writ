require "ostruct"

User = Class.new(OpenStruct)

class LogIn < Writ
  attr_accessor :email
  attr_accessor :password

  def validate
    assert_email :email
    assert_equal :password, "password123" # such authentication
  end

  def run
    User.new(email: email)
  end
end

scope "with valid parameters" do
  setup do
    LogIn.run(email: "jane.doe@example.com", password: "password123")
  end

  test "returns a successful outcome" do |outcome|
    assert outcome.success?
  end

  test "uses the return value of #execute as the outcome's #value" do |outcome|
    assert_equal User.new(email: "jane.doe@example.com"), outcome.value
  end

  test "has an empty error hash" do |outcome|
    assert_equal Hash.new, outcome.errors
  end
end

scope "with invalid parameters" do
  setup do
    LogIn.run(email: "jane.doe@example.com", password: nil)
  end

  test "returns an unsuccessful outcome" do |outcome|
    assert !outcome.success?
  end

  test "returns a nil #value" do |outcome|
    assert_equal nil, outcome.value
  end

  test "returns the scrivener errors in the outcome" do |outcome|
    password_errors = outcome.errors[:password]
    assert password_errors.any?
  end

  test "exposes the original Writ to access user input" do |outcome|
    assert_equal "jane.doe@example.com", outcome.input.email
  end
end
