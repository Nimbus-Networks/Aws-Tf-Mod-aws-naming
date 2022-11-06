terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.3.2"
    }
  }
}

resource "random_string" "main" {
  length  = 60
  special = false
  upper   = false
  numeric = var.unique-include-numbers
}

resource "random_string" "first_letter" {
  length  = 1
  special = false
  upper   = false
  numeric = false
}

locals {
  // adding a first letter to guarantee that you always start with a letter
  random_safe_generation = join("", [random_string.first_letter.result, random_string.main.result])
  random                 = substr(coalesce(var.unique-seed, local.random_safe_generation), 0, var.unique-length)
  prefix                 = join("-", var.prefix)
  prefix_safe            = lower(join("", var.prefix))
  suffix                 = join("-", var.suffix)
  suffix_unique          = join("-", concat(var.suffix, [local.random]))
  suffix_safe            = lower(join("", var.suffix))
  suffix_unique_safe     = lower(join("", concat(var.suffix, [local.random])))
  iteration              = join("-", var.iteration)
  iteration_unique       = join("-", concat(var.iteration, [local.random]))
  iteration_safe         = lower(join("", var.iteration))
  iteration_unique_safe  = lower(join("", concat(var.iteration, [local.random])))

  aws = {
    autoscaling_group = {
      name        = substr(join("", compact([local.prefix_safe, "asg", local.iteration_safe, local.suffix_safe])), 0, 63)
      name_unique = substr(join("", compact([local.prefix_safe, "asg", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 63)
      dashes      = true
      slug        = "asg"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-z0-9]+$"
    }
    autoscaling_policy = {
      name        = substr(join("", compact([local.prefix_safe, "asp", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "asp", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "asp"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    autoscaling_schedule = {
      name        = substr(join("", compact([local.prefix_safe, "ass", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ass", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ass"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    cloudwatch_event_rule = {
      name        = substr(join("", compact([local.prefix_safe, "cer", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "cer", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "cer"
      min_length  = 1
      max_length  = 64
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    cloudwatch_log_group = {
      name        = substr(join("", compact([local.prefix_safe, "clg", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "clg", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "clg"
      min_length  = 1
      max_length  = 512
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    cloudwatch_metric_alarm = {
      name        = substr(join("", compact([local.prefix_safe, "cma", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "cma", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "cma"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    cloudwatch_metric_stream = {
      name        = substr(join("", compact([local.prefix_safe, "cms", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "cms", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "cms"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    codebuild_project = {
      name        = substr(join("", compact([local.prefix_safe, "cbp", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "cbp", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "cbp"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    codecommit_repository = {
      name        = substr(join("", compact([local.prefix_safe, "ccr", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ccr", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ccr"
      min_length  = 1
      max_length  = 100
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    codepipeline = {
      name        = substr(join("", compact([local.prefix_safe, "cpl", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "cpl", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "cpl"
      min_length  = 1
      max_length  = 100
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    db_instance = {
      name        = substr(join("", compact([local.prefix_safe, "dbi", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "dbi", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "dbi"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    db_parameter_group = {
      name        = substr(join("", compact([local.prefix_safe, "dpg", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "dpg", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "dpg"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    dms_endpoint = {
      name        = substr(join("", compact([local.prefix_safe, "dep", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "dep", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "dep"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    dms_replication_instance = {
      name        = substr(join("", compact([local.prefix_safe, "dri", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "dri", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "dri"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    dms_replication_task = {
      name        = substr(join("", compact([local.prefix_safe, "drt", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "drt", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "drt"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    dynamodb_table = {
      name        = substr(join("", compact([local.prefix_safe, "ddt", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ddt", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ddt"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    ecr_repository = {
      name        = substr(join("", compact([local.prefix_safe, "ecr", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ecr", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ecr"
      min_length  = 1
      max_length  = 256
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    ecs_cluster = {
      name        = substr(join("", compact([local.prefix_safe, "ecc", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ecc", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ecc"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    ecs_service = {
      name        = substr(join("", compact([local.prefix_safe, "ecs", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ecs", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ecs"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    ecs_task_definition = {
      name        = substr(join("", compact([local.prefix_safe, "etd", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "etd", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "etd"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    elasticache_cluster = {
      name        = substr(join("", compact([local.prefix_safe, "elc", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "elc", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "elc"
      min_length  = 1
      max_length  = 40
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    elasticache_parameter_group = {
      name        = substr(join("", compact([local.prefix_safe, "epg", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "epg", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "epg"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    elasticsearch_domain = {
      name        = substr(join("", compact([local.prefix_safe, "esd", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "esd", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "esd"
      min_length  = 1
      max_length  = 28
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    glue_job = {
      name        = substr(join("", compact([local.prefix_safe, "glj", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "glj", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "glj"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    iam_instance_profile = {
      name        = substr(join("", compact([local.prefix_safe, "iip", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "iip", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "iip"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    iam_role = {
      name        = substr(join("", compact([local.prefix_safe, "iar", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "iar", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "iar"
      min_length  = 1
      max_length  = 64
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    instance = {
      name        = substr(join("", compact([local.prefix_safe, "ins", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ins", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ins"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    key_pair = {
      name        = substr(join("", compact([local.prefix_safe, "kpr", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "kpr", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "kpr"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    kinesis_firehose_delivery_stream = {
      name        = substr(join("", compact([local.prefix_safe, "kfd", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "kfd", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "kfd"
      min_length  = 1
      max_length  = 64
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    lambda_function = {
      name        = substr(join("", compact([local.prefix_safe, "lfn", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "lfn", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "lfn"
      min_length  = 1
      max_length  = 140
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    launch_configuration = {
      name        = substr(join("", compact([local.prefix_safe, "lcf", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "lcf", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "lcf"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    lb = {
      name        = substr(join("", compact([local.prefix_safe, "lba", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "lba", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "lba"
      min_length  = 1
      max_length  = 32
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    lb_target_group = {
      name        = substr(join("", compact([local.prefix_safe, "ltg", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "ltg", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "ltg"
      min_length  = 1
      max_length  = 32
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    s3_bucket = {
      name        = substr(join("", compact([local.prefix_safe, "s3b", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "s3b", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "s3b"
      min_length  = 1
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    secretsmanager_secret = {
      name        = substr(join("", compact([local.prefix_safe, "sms", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "sms", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "sms"
      min_length  = 1
      max_length  = 256
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    security_group = {
      name        = substr(join("", compact([local.prefix_safe, "sgr", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "sgr", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "sgr"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    sns_topic = {
      name        = substr(join("", compact([local.prefix_safe, "snt", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "snt", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "snt"
      min_length  = 1
      max_length  = 256
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    sqs_queue = {
      name        = substr(join("", compact([local.prefix_safe, "sqq", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "sqq", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "sqq"
      min_length  = 1
      max_length  = 80
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    step_function = {
      name        = substr(join("", compact([local.prefix_safe, "sfn", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "sfn", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "sfn"
      min_length  = 1
      max_length  = 80
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_byte_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wbs", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wbs", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wbm"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_geo_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wgs", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wgs", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wgs"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_ipset = {
      name        = substr(join("", compact([local.prefix_safe, "wis", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wis", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wis"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_rate_based_rule = {
      name        = substr(join("", compact([local.prefix_safe, "wrr", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrr", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrr"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_regex_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrm", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrm", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrm"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_regex_pattern_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrp", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrp", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrp"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_rule = {
      name        = substr(join("", compact([local.prefix_safe, "wrl", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrl", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrl"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_rule_group = {
      name        = substr(join("", compact([local.prefix_safe, "wrg", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrg", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrg"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_size_constraint_set = {
      name        = substr(join("", compact([local.prefix_safe, "wsc", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wsc", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wsc"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_sql_injection_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wsi", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wsi", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wsi"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_web_acl = {
      name        = substr(join("", compact([local.prefix_safe, "wwa", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wwa", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wwa"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    waf_xss_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wxm", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wxm", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wxm"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_byte_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrbs", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrbs", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrbs"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_geo_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrgs", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrgs", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrgs"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_ipset = {
      name        = substr(join("", compact([local.prefix_safe, "wris", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wris", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wris"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_rate_based_rule = {
      name        = substr(join("", compact([local.prefix_safe, "wrrr", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrrr", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrrr"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_regex_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrrm", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrrm", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrrm"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_regex_pattern_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrrp", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrrp", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrrp"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_rule = {
      name        = substr(join("", compact([local.prefix_safe, "wrrl", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrrl", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrrl"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_rule_group = {
      name        = substr(join("", compact([local.prefix_safe, "wrrg", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrrg", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrrg"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_size_constraint_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrsc", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrsc", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrsc"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_sql_injection_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrsi", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrsi", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrsi"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_web_acl = {
      name        = substr(join("", compact([local.prefix_safe, "wrwa", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrwa", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrwa"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    wafregional_xss_match_set = {
      name        = substr(join("", compact([local.prefix_safe, "wrxm", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "wrxm", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "wrxm"
      min_length  = 1
      max_length  = 128
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
    global_accelerator = {
      name        = substr(join("", compact([local.prefix_safe, "gac", local.iteration_safe, local.suffix_safe])), 0, 50)
      name_unique = substr(join("", compact([local.prefix_safe, "gac", local.iteration_unique_safe, local.suffix_unique_safe])), 0, 50)
      dashes      = true
      slug        = "gac"
      min_length  = 1
      max_length  = 255
      scope       = "global"
      regex       = "^[a-z][a-zA-Z0-9]+$"
    }
  }
}
