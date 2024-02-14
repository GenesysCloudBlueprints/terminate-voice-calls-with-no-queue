resource "genesyscloud_flow" "terminate_outbound_call_missing_queue" {
  filepath          = "${path.module}/terminate-outbound-call-missing-queue-with-pstn-call-leg-check.yaml"
  file_content_hash = filesha256("${path.module}/terminate-outbound-call-missing-queue-with-pstn-call-leg-check.yaml")
  substitutions = {
    workflow_name                   = var.workflow_name
    data_action_category            = var.data_action_category
    disconnect_voice_call           = var.disconnect_voice_call
    put_conversation_tag            = var.put_conversation_tag
    check_conversation_for_ptsn_leg = var.check_conversation_for_ptsn_leg
  }
}