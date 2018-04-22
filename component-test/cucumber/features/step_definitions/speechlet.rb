

When(/^player receives a "([^"]*)" intent$/) do |intentName|
  result, @stderr, @status = Open3.capture3("../../run -e #{PATH_TO_LAUNCH_INTENTS}/#{intentName}.json -t #{PATH_TO_SAM_TEMPLATE_YAML}")
  @result = JSON.parse(result)
  ap @result
  puts "\n"
  puts @stderr
  puts @status
  @result = JSON.parse(result)
end

Then(/^player should give response from a "([^"]*)" response/) do |intentNameResponse|
  expected = File.read("#{PATH_TO_LAUNCH_INTENTS}/#{intentNameResponse}.json")
  # ap expected
  @expected = JSON.parse(expected)
  # ap @result
  expect(@result['response']['outputSpeech']['text']).to eq(@expected['response']['outputSpeech']['text'])
end


When(/^player receives a "([^"]*)" playAnything intent$/) do |intentName|
  result, @stderr, @status = Open3.capture3("../../run -e #{PATH_TO_PLAYANYTHING_INTENTS}/#{intentName}.json -t #{PATH_TO_SAM_TEMPLATE_YAML}")
  @result = JSON.parse(result)
  ap @result
  puts "\n"
  puts @stderr
  puts @status
end

Then(/^player should give response from a "([^"]*)" playAnythingresponse and output speech "([^"]*)"$/) do |intentNameResponse, output|
  expected = File.read("#{PATH_TO_PLAYANYTHING_INTENTS}/#{intentNameResponse}.json")
  # ap expected
  @expected = JSON.parse(expected)
  expect(@result['response']['directives'][0]['audioItem']['stream']['url']).to eq(@expected['response']['directives'][0]['audioItem']['stream']['url'])
  expect(@result['response']['outputSpeech']['text']).to eq(output)
end
