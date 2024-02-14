resource "genesyscloud_integration_action" "check_conversation_for_ptsn_leg" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "CONVERSATION_ID" = {
        "type" = "string"
      }
    },
	"additionalProperties": true
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
		"externalSegment": {
			"type": "array",
			"items": {
				"title": "externalSegment",
				"type": "string"
			}
		}
	}
	"additionalProperties": true
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/analytics/conversations/$${input.CONVERSATION_ID}/details"
    request_type         = "GET"
    request_template     = "$${input.rawRequest}"
    headers = {}
  }
  config_response {
    translation_map = {
		externalSegment  = "['participants'][?(@.purpose=='external')]['sessions'][?(@.direction=='outbound')].direction"
	}
    translation_map_defaults = {}
    success_template = "{\"externalSegment\": $${externalSegment}}"
  }
}