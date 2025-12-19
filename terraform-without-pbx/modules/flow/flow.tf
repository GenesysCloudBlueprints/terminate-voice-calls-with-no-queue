resource "genesyscloud_flow" "terminate_outbound_call_missing_queue" {
  filepath          = "${path.module}/terminate-outbound-call-missing-queue.yaml"
  substitutions = {
    workflow_name                   = var.workflow_name
    data_action_category            = var.data_action_category
    disconnect_voice_call           = var.disconnect_voice_call
    put_conversation_tag            = var.put_conversation_tag
  }
}