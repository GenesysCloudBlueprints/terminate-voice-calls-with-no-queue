resource "genesyscloud_integration_action" "disconnect_voice_call" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "conversationId" = {
        "type" = "string"
      }
    },
	"additionalProperties": true
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {},
	"additionalProperties": true
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/conversations/$${input.conversationId}/disconnect"
    request_type         = "POST"
    request_template     = "$${input.rawRequest}"
    headers = {
		"Content-Type": "application/json",
        "UserAgent": "PureCloudIntegrations/1.0"
	}
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}