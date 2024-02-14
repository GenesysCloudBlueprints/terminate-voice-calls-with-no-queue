variable "workflow_name" {
  description = "The flow name to assign to the workflow in Architect"
}

variable "data_action_category" {
  type        = string
  description = "The Data Action that is to be used in the flow."
}

variable "disconnect_voice_call" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}

variable "put_conversation_tag" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}

variable "check_conversation_for_ptsn_leg" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}
