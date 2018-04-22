def load_conversation(fixture_file)
  YAML.load_file("fixtures/#{fixture_file}.yaml")
end

def run_simulation(request_response)
  test_String = "../../simulate simulate-skill -t \"#{request_response["Bob"]}\" -l en-GB -s #{SKILL_ID}"
  in_progress, @stderr, @status = Open3.capture3(test_String)
  JSON.parse(in_progress)
end

def is_simulation_not_finished(in_progress_json)
  "IN_PROGRESS" == in_progress_json["status"]
end

def get_simulation_result(in_progress_json)
  test_String_result = "../../simulate get-simulation -i #{in_progress_json["id"]} -s #{SKILL_ID}"
  result, @stderr, @status = Open3.capture3(test_String_result)
  JSON.parse(result)
end

def talk_to_alexa(request_response)
  in_progress_json = run_simulation(request_response)
  in_progress_json = get_simulation_result(in_progress_json) while is_simulation_not_finished(in_progress_json)
  ap in_progress_json["result"]["skillExecutionInfo"]["invocationResponse"]["body"]
  in_progress_json["result"]["skillExecutionInfo"].nil? ?
      'fail' :
  in_progress_json["result"]["skillExecutionInfo"]["invocationResponse"]["body"]["response"]["outputSpeech"]["text"]
end

def expect_correct_response(request_response)
  expect(talk_to_alexa(request_response)).to eq(request_response["Alexa"])
end


When(/^(.*) called$/) do |conversation|
  @dialog = load_conversation(conversation)
end


Then(/^skill response appropriately for each point in context$/) do
  @dialog.map do |request_response|
    expect_correct_response(request_response)
  end
end