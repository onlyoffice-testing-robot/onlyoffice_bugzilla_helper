require 'spec_helper'

RSpec.describe OnlyofficeBugzillaHelper::BugzillaHelper do
  let(:bugzilla) { described_class.new }

  it 'check status of bug' do
    expect(bugzilla.bug_status(10)).to eq('CLOSED')
  end

  it 'check bugzilla url is not nil' do
    expect(bugzilla.url).not_to be_nil
  end

  it 'bug_id_from_string correct url' do
    string = "#{bugzilla.url}/show_bug.cgi?id=32296"
    expect(bugzilla.bug_id_from_string(string)).to eq(32_296)
  end

  it 'bug_id_from_string that looks like correct bugzilla bug url' do
    string = "#{bugzilla.url}/test?id=32296"
    expect(bugzilla.bug_id_from_string(string)).to be_nil
  end

  it 'bug_id_from_string that looks like correct bugzilla bug param' do
    string = "#{bugzilla.url}/show_bug.cgi?test=32296"
    expect(bugzilla.bug_id_from_string(string)).to be_nil
  end

  it 'bug_id_from_string without digits' do
    expect(bugzilla.bug_id_from_string('test')).to be_nil
  end

  it 'bug_id_from_string with spaces' do
    expect(bugzilla.bug_id_from_string('test test')).to be_nil
  end

  it 'bug_id_from_string with digits but another url' do
    string = 'http://bugzserver/show_bug.cgi?id=31427'
    expect(bugzilla.bug_id_from_string(string)).to be_nil
  end
end