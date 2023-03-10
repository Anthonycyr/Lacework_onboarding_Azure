provider "azuread" {}

provider "azurerm" {
  features {}
}

module "az_ad_application" {
  source  = "lacework/ad-application/azure"
  version = "~> 1.0"
}

module "az_config" {
  source  = "lacework/config/azure"
  version = "~> 1.0"

  all_subscriptions = true
  use_existing_ad_application = true
  application_id              = module.az_ad_application.application_id
  application_password        = module.az_ad_application.application_password
  service_principal_id        = module.az_ad_application.service_principal_id
}

module "az_activity_log" {
  source  = "lacework/activity-log/azure"
  version = "~> 1.0"
  location = "canadacentral"
  all_subscriptions = true 

  
  use_existing_ad_application = true
  application_id              = module.az_ad_application.application_id
  application_password        = module.az_ad_application.application_password
  service_principal_id        = module.az_ad_application.service_principal_id
}
