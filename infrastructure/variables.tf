variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "chatapp"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "openai_location" {
  description = "Azure region for OpenAI service (not all regions support OpenAI)"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Project   = "ChatApp"
    ManagedBy = "Terraform"
  }
}

# AKS Configuration
variable "aks_node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
  default     = 1

  validation {
    condition     = var.aks_node_count >= 1 && var.aks_node_count <= 10
    error_message = "Node count must be between 1 and 10."
  }
}

variable "aks_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

# PostgreSQL Configuration
variable "postgres_admin_username" {
  description = "PostgreSQL administrator username"
  type        = string
  default     = "pgadmin"

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9_]{2,62}$", var.postgres_admin_username))
    error_message = "Username must start with a letter and contain only alphanumeric characters and underscores (3-63 chars)."
  }
}

variable "postgres_database_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "chat_db"
}

# Azure OpenAI Configuration
variable "openai_deployment_name" {
  description = "Name for the OpenAI model deployment"
  type        = string
  default     = "gpt-4o"
}

variable "openai_model_name" {
  description = "OpenAI model name"
  type        = string
  default     = "gpt-4o"
}

variable "openai_model_version" {
  description = "OpenAI model version"
  type        = string
  default     = "2024-08-06"
}

variable "openai_capacity" {
  description = "Token capacity for OpenAI deployment (in thousands)"
  type        = number
  default     = 10

  validation {
    condition     = var.openai_capacity >= 1 && var.openai_capacity <= 1000
    error_message = "Capacity must be between 1 and 1000."
  }
}

# PostgreSQL Configuration
variable "postgres_location" {
  description = "Azure region for PostgreSQL (can be different from main location if needed)"
  type        = string
  default     = "" # Empty string means use var.location
}

variable "resource_group_name" {
  description = "Target resource group"
  type        = string
}



