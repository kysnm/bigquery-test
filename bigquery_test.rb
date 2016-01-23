#!/usr/bin/env ruby
require 'google/apis/bigquery_v2'
require 'google/api_client/auth/key_utils'
require 'dotenv'

Dotenv.load

client = Google::Apis::BigqueryV2::BigqueryService.new

key = Google::APIClient::KeyUtils.load_from_pem(ENV['KEY'], 'notasecret')

client.authorization = Signet::OAuth2::Client.new(
  token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
  audience: 'https://accounts.google.com/o/oauth2/token',
  scope: 'https://www.googleapis.com/auth/bigquery',
  issuer: ENV['SERVICE_EMAIL'],
  signing_key: key
)

puts ENV['SERVICE_EMAIL']

client.authorization.fetch_access_token!

project_id = ENV['PROJECT_ID']

dataset_object = {
  'datasetReference' => {
    'projectId' => project_id,
    'datasetId' => 'bigquery-test'
  }
}
client.insert_dataset(project_id, dataset_object)

puts response
