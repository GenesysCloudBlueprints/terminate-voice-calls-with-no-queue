/*
  Create a Data Action integration
*/
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Terminate Outbound Conversations with no Queue"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

/*
  Create a Disconnect Voice Call Data Action
*/
module "disconnect_voice_call_data_action" {
  source             = "./modules/actions/disconnect-voice-call"
  action_name        = "Disconnect Voice Call"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
  depends_on         = [module.data_action]
}

/*
  Create a Put Conversation Tag Data Action
*/
module "put_conversation_tag_data_action" {
  source             = "./modules/actions/put-conversation-tag"
  action_name        = "Put Conversation Tag"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
  depends_on         = [module.data_action]
}

/*   
   Configures the architect flow
*/
module "archy_flow" {
  source                          = "./modules/flow"
  workflow_name                   = "Terminate Outbound Call Missing Queue"
  data_action_category            = module.data_action.integration_name
  disconnect_voice_call           = module.disconnect_voice_call_data_action.action_name
  put_conversation_tag            = module.put_conversation_tag_data_action.action_name

  depends_on        = [
    module.data_action, 
    module.disconnect_voice_call_data_action, 
    module.put_conversation_tag_data_action
  ]
}

/*   
   Configures the process automation trigger
*/
resource "genesyscloud_processautomation_trigger" "terminate_outbound_call_trigger" {
  name           = "Terminate Outbound Call Missing Queue"
  topic_name     = "v2.detail.events.conversation.{id}.user.start"
  enabled        = true
  match_criteria = jsonencode([
    {
      "jsonPath" : "queueId",
      "operator" : "Exists",
      "value" : false
    }
  ])
  target {
    id   = module.archy_flow.workflow_id
    type = "Workflow"
  }
  depends_on     = [module.archy_flow]
}