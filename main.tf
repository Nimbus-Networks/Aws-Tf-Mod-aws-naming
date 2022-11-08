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

    validation = {
      autoscaling_group = {
        valid_name        = length(regexall(local.aws.autoscaling_group.regex, local.aws.autoscaling_group.name)) > 0 && length(local.aws.autoscaling_group.name) > local.aws.autoscaling_group.min_length
        valid_name_unique = length(regexall(local.aws.autoscaling_group.regex, local.aws.autoscaling_group.name_unique)) > 0
      }
      autoscaling_policy = {
        valid_name        = length(regexall(local.aws.autoscaling_policy.regex, local.aws.autoscaling_policy.name)) > 0 && length(local.aws.autoscaling_policy.name) > local.aws.autoscaling_policy.min_length
        valid_name_unique = length(regexall(local.aws.autoscaling_policy.regex, local.aws.autoscaling_policy.name_unique)) > 0
      }
      autoscaling_schedule = {
        valid_name        = length(regexall(local.aws.autoscaling_schedule.regex, local.aws.autoscaling_schedule.name)) > 0 && length(local.aws.autoscaling_schedule.name) > local.aws.autoscaling_schedule.min_length
        valid_name_unique = length(regexall(local.aws.autoscaling_schedule.regex, local.aws.autoscaling_schedule.name_unique)) > 0
      }
      cloudwatch_event_rule = {
        valid_name        = length(regexall(local.aws.cloudwatch_event_rule.regex, local.aws.cloudwatch_event_rule.name)) > 0 && length(local.aws.cloudwatch_event_rule.name) > local.aws.cloudwatch_event_rule.min_length
        valid_name_unique = length(regexall(local.aws.cloudwatch_event_rule.regex, local.aws.cloudwatch_event_rule.name_unique)) > 0
      }
      cloudwatch_log_group = {
        valid_name        = length(regexall(local.aws.cloudwatch_log_group.regex, local.aws.cloudwatch_log_group.name)) > 0 && length(local.aws.cloudwatch_log_group.name) > local.aws.cloudwatch_log_group.min_length
        valid_name_unique = length(regexall(local.aws.cloudwatch_log_group.regex, local.aws.cloudwatch_log_group.name_unique)) > 0
      }
      cloudwatch_metric_alarm = {
        valid_name        = length(regexall(local.aws.cloudwatch_metric_alarm.regex, local.aws.cloudwatch_metric_alarm.name)) > 0 && length(local.aws.cloudwatch_metric_alarm.name) > local.aws.cloudwatch_metric_alarm.min_length
        valid_name_unique = length(regexall(local.aws.cloudwatch_metric_alarm.regex, local.aws.cloudwatch_metric_alarm.name_unique)) > 0
      }
      cloudwatch_metric_stream = {
        valid_name        = length(regexall(local.aws.cloudwatch_metric_stream.regex, local.aws.cloudwatch_metric_stream.name)) > 0 && length(local.aws.cloudwatch_metric_stream.name) > local.aws.cloudwatch_metric_stream.min_length
        valid_name_unique = length(regexall(local.aws.cloudwatch_metric_stream.regex, local.aws.cloudwatch_metric_stream.name_unique)) > 0
      }
      codebuild_project = {
        valid_name        = length(regexall(local.aws.codebuild_project.regex, local.aws.codebuild_project.name)) > 0 && length(local.aws.codebuild_project.name) > local.aws.codebuild_project.min_length
        valid_name_unique = length(regexall(local.aws.codebuild_project.regex, local.aws.codebuild_project.name_unique)) > 0
      }
      codecommit_repository = {
        valid_name        = length(regexall(local.aws.codecommit_repository.regex, local.aws.codecommit_repository.name)) > 0 && length(local.aws.codecommit_repository.name) > local.aws.codecommit_repository.min_length
        valid_name_unique = length(regexall(local.aws.codecommit_repository.regex, local.aws.codecommit_repository.name_unique)) > 0
      }
      codepipeline = {
        valid_name        = length(regexall(local.aws.codepipeline.regex, local.aws.codepipeline.name)) > 0 && length(local.aws.codepipeline.name) > local.aws.codepipeline.min_length
        valid_name_unique = length(regexall(local.aws.codepipeline.regex, local.aws.codepipeline.name_unique)) > 0
      }
      db_instance = {
        valid_name        = length(regexall(local.aws.db_instance.regex, local.aws.db_instance.name)) > 0 && length(local.aws.db_instance.name) > local.aws.db_instance.min_length
        valid_name_unique = length(regexall(local.aws.db_instance.regex, local.aws.db_instance.name_unique)) > 0
      }
      db_parameter_group = {
        valid_name        = length(regexall(local.aws.db_parameter_group.regex, local.aws.db_parameter_group.name)) > 0 && length(local.aws.db_parameter_group.name) > local.aws.db_parameter_group.min_length
        valid_name_unique = length(regexall(local.aws.db_parameter_group.regex, local.aws.db_parameter_group.name_unique)) > 0
      }
      dms_endpoint = {
        valid_name        = length(regexall(local.aws.dms_endpoint.regex, local.aws.dms_endpoint.name)) > 0 && length(local.aws.dms_endpoint.name) > local.aws.dms_endpoint.min_length
        valid_name_unique = length(regexall(local.aws.dms_endpoint.regex, local.aws.dms_endpoint.name_unique)) > 0
      }
      dms_replication_instance = {
        valid_name        = length(regexall(local.aws.dms_replication_instance.regex, local.aws.dms_replication_instance.name)) > 0 && length(local.aws.dms_replication_instance.name) > local.aws.dms_replication_instance.min_length
        valid_name_unique = length(regexall(local.aws.dms_replication_instance.regex, local.aws.dms_replication_instance.name_unique)) > 0
      }
      dms_replication_task = {
        valid_name        = length(regexall(local.aws.dms_replication_task.regex, local.aws.dms_replication_task.name)) > 0 && length(local.aws.dms_replication_task.name) > local.aws.dms_replication_task.min_length
        valid_name_unique = length(regexall(local.aws.dms_replication_task.regex, local.aws.dms_replication_task.name_unique)) > 0
      }
      dynamodb_table = {
        valid_name        = length(regexall(local.aws.dynamodb_table.regex, local.aws.dynamodb_table.name)) > 0 && length(local.aws.dynamodb_table.name) > local.aws.dynamodb_table.min_length
        valid_name_unique = length(regexall(local.aws.dynamodb_table.regex, local.aws.dynamodb_table.name_unique)) > 0
      }
      ecr_repository = {
        valid_name        = length(regexall(local.aws.ecr_repository.regex, local.aws.ecr_repository.name)) > 0 && length(local.aws.ecr_repository.name) > local.aws.ecr_repository.min_length
        valid_name_unique = length(regexall(local.aws.ecr_repository.regex, local.aws.ecr_repository.name_unique)) > 0
      }
      ecs_cluster = {
        valid_name        = length(regexall(local.aws.ecs_cluster.regex, local.aws.ecs_cluster.name)) > 0 && length(local.aws.ecs_cluster.name) > local.aws.ecs_cluster.min_length
        valid_name_unique = length(regexall(local.aws.ecs_cluster.regex, local.aws.ecs_cluster.name_unique)) > 0
      }
      ecs_service = {
        valid_name        = length(regexall(local.aws.ecs_service.regex, local.aws.ecs_service.name)) > 0 && length(local.aws.ecs_service.name) > local.aws.ecs_service.min_length
        valid_name_unique = length(regexall(local.aws.ecs_service.regex, local.aws.ecs_service.name_unique)) > 0
      }
      ecs_task_definition = {
        valid_name        = length(regexall(local.aws.ecs_task_definition.regex, local.aws.ecs_task_definition.name)) > 0 && length(local.aws.ecs_task_definition.name) > local.aws.ecs_task_definition.min_length
        valid_name_unique = length(regexall(local.aws.ecs_task_definition.regex, local.aws.ecs_task_definition.name_unique)) > 0
      }
      elasticache_cluster = {
        valid_name        = length(regexall(local.aws.elasticache_cluster.regex, local.aws.elasticache_cluster.name)) > 0 && length(local.aws.elasticache_cluster.name) > local.aws.elasticache_cluster.min_length
        valid_name_unique = length(regexall(local.aws.elasticache_cluster.regex, local.aws.elasticache_cluster.name_unique)) > 0
      }
      elasticache_parameter_group = {
        valid_name        = length(regexall(local.aws.elasticache_parameter_group.regex, local.aws.elasticache_parameter_group.name)) > 0 && length(local.aws.elasticache_parameter_group.name) > local.aws.elasticache_parameter_group.min_length
        valid_name_unique = length(regexall(local.aws.elasticache_parameter_group.regex, local.aws.elasticache_parameter_group.name_unique)) > 0
      }
      elasticsearch_domain = {
        valid_name        = length(regexall(local.aws.elasticsearch_domain.regex, local.aws.elasticsearch_domain.name)) > 0 && length(local.aws.elasticsearch_domain.name) > local.aws.elasticsearch_domain.min_length
        valid_name_unique = length(regexall(local.aws.elasticsearch_domain.regex, local.aws.elasticsearch_domain.name_unique)) > 0
      }
      glue_job = {
        valid_name        = length(regexall(local.aws.glue_job.regex, local.aws.glue_job.name)) > 0 && length(local.aws.glue_job.name) > local.aws.glue_job.min_length
        valid_name_unique = length(regexall(local.aws.glue_job.regex, local.aws.glue_job.name_unique)) > 0
      }
      iam_instance_profile = {
        valid_name        = length(regexall(local.aws.iam_instance_profile.regex, local.aws.iam_instance_profile.name)) > 0 && length(local.aws.iam_instance_profile.name) > local.aws.iam_instance_profile.min_length
        valid_name_unique = length(regexall(local.aws.iam_instance_profile.regex, local.aws.iam_instance_profile.name_unique)) > 0
      }
      iam_role = {
        valid_name        = length(regexall(local.aws.iam_role.regex, local.aws.iam_role.name)) > 0 && length(local.aws.iam_role.name) > local.aws.iam_role.min_length
        valid_name_unique = length(regexall(local.aws.iam_role.regex, local.aws.iam_role.name_unique)) > 0
      }
      instance = {
        valid_name        = length(regexall(local.aws.instance.regex, local.aws.instance.name)) > 0 && length(local.aws.instance.name) > local.aws.instance.min_length
        valid_name_unique = length(regexall(local.aws.instance.regex, local.aws.instance.name_unique)) > 0
      }
      key_pair = {
        valid_name        = length(regexall(local.aws.key_pair.regex, local.aws.key_pair.name)) > 0 && length(local.aws.key_pair.name) > local.aws.key_pair.min_length
        valid_name_unique = length(regexall(local.aws.key_pair.regex, local.aws.key_pair.name_unique)) > 0
      }
      kinesis_firehose_delivery_stream = {
        valid_name        = length(regexall(local.aws.kinesis_firehose_delivery_stream.regex, local.aws.kinesis_firehose_delivery_stream.name)) > 0 && length(local.aws.kinesis_firehose_delivery_stream.name) > local.aws.kinesis_firehose_delivery_stream.min_length
        valid_name_unique = length(regexall(local.aws.kinesis_firehose_delivery_stream.regex, local.aws.kinesis_firehose_delivery_stream.name_unique)) > 0
      }
      lambda_function = {
        valid_name        = length(regexall(local.aws.lambda_function.regex, local.aws.lambda_function.name)) > 0 && length(local.aws.lambda_function.name) > local.aws.lambda_function.min_length
        valid_name_unique = length(regexall(local.aws.lambda_function.regex, local.aws.lambda_function.name_unique)) > 0
      }
      launch_configuration = {
        valid_name        = length(regexall(local.aws.launch_configuration.regex, local.aws.launch_configuration.name)) > 0 && length(local.aws.launch_configuration.name) > local.aws.launch_configuration.min_length
        valid_name_unique = length(regexall(local.aws.launch_configuration.regex, local.aws.launch_configuration.name_unique)) > 0
      }
      lb = {
        valid_name        = length(regexall(local.aws.lb.regex, local.aws.lb.name)) > 0 && length(local.aws.lb.name) > local.aws.lb.min_length
        valid_name_unique = length(regexall(local.aws.lb.regex, local.aws.lb.name_unique)) > 0
      }
      lb_target_group = {
        valid_name        = length(regexall(local.aws.lb_target_group.regex, local.aws.lb_target_group.name)) > 0 && length(local.aws.lb_target_group.name) > local.aws.lb_target_group.min_length
        valid_name_unique = length(regexall(local.aws.lb_target_group.regex, local.aws.lb_target_group.name_unique)) > 0
      }
      s3_bucket = {
        valid_name        = length(regexall(local.aws.s3_bucket.regex, local.aws.s3_bucket.name)) > 0 && length(local.aws.s3_bucket.name) > local.aws.s3_bucket.min_length
        valid_name_unique = length(regexall(local.aws.s3_bucket.regex, local.aws.s3_bucket.name_unique)) > 0
      }
      secretsmanager_secret = {
        valid_name        = length(regexall(local.aws.secretsmanager_secret.regex, local.aws.secretsmanager_secret.name)) > 0 && length(local.aws.secretsmanager_secret.name) > local.aws.secretsmanager_secret.min_length
        valid_name_unique = length(regexall(local.aws.secretsmanager_secret.regex, local.aws.secretsmanager_secret.name_unique)) > 0
      }
      security_group = {
        valid_name        = length(regexall(local.aws.security_group.regex, local.aws.security_group.name)) > 0 && length(local.aws.security_group.name) > local.aws.security_group.min_length
        valid_name_unique = length(regexall(local.aws.security_group.regex, local.aws.security_group.name_unique)) > 0
      }
      sns_topic = {
        valid_name        = length(regexall(local.aws.sns_topic.regex, local.aws.sns_topic.name)) > 0 && length(local.aws.sns_topic.name) > local.aws.sns_topic.min_length
        valid_name_unique = length(regexall(local.aws.sns_topic.regex, local.aws.sns_topic.name_unique)) > 0
      }
      sqs_queue = {
        valid_name        = length(regexall(local.aws.sqs_queue.regex, local.aws.sqs_queue.name)) > 0 && length(local.aws.sqs_queue.name) > local.aws.sqs_queue.min_length
        valid_name_unique = length(regexall(local.aws.sqs_queue.regex, local.aws.sqs_queue.name_unique)) > 0
      }
      step_function = {
        valid_name        = length(regexall(local.aws.step_function.regex, local.aws.step_function.name)) > 0 && length(local.aws.step_function.name) > local.aws.step_function.min_length
        valid_name_unique = length(regexall(local.aws.step_function.regex, local.aws.step_function.name_unique)) > 0
      }
      waf_byte_match_set = {
        valid_name        = length(regexall(local.aws.waf_byte_match_set.regex, local.aws.waf_byte_match_set.name)) > 0 && length(local.aws.waf_byte_match_set.name) > local.aws.waf_byte_match_set.min_length
        valid_name_unique = length(regexall(local.aws.waf_byte_match_set.regex, local.aws.waf_byte_match_set.name_unique)) > 0
      }
      waf_geo_match_set = {
        valid_name        = length(regexall(local.aws.waf_geo_match_set.regex, local.aws.waf_geo_match_set.name)) > 0 && length(local.aws.waf_geo_match_set.name) > local.aws.waf_geo_match_set.min_length
        valid_name_unique = length(regexall(local.aws.waf_geo_match_set.regex, local.aws.waf_geo_match_set.name_unique)) > 0
      }
      waf_ipset = {
        valid_name        = length(regexall(local.aws.waf_ipset.regex, local.aws.waf_ipset.name)) > 0 && length(local.aws.waf_ipset.name) > local.aws.waf_ipset.min_length
        valid_name_unique = length(regexall(local.aws.waf_ipset.regex, local.aws.waf_ipset.name_unique)) > 0
      }
      waf_rate_based_rule = {
        valid_name        = length(regexall(local.aws.waf_rate_based_rule.regex, local.aws.waf_rate_based_rule.name)) > 0 && length(local.aws.waf_rate_based_rule.name) > local.aws.waf_rate_based_rule.min_length
        valid_name_unique = length(regexall(local.aws.waf_rate_based_rule.regex, local.aws.waf_rate_based_rule.name_unique)) > 0
      }
      waf_regex_match_set = {
        valid_name        = length(regexall(local.aws.waf_regex_match_set.regex, local.aws.waf_regex_match_set.name)) > 0 && length(local.aws.waf_regex_match_set.name) > local.aws.waf_regex_match_set.min_length
        valid_name_unique = length(regexall(local.aws.waf_regex_match_set.regex, local.aws.waf_regex_match_set.name_unique)) > 0
      }
      waf_regex_pattern_set = {
        valid_name        = length(regexall(local.aws.waf_regex_pattern_set.regex, local.aws.waf_regex_pattern_set.name)) > 0 && length(local.aws.waf_regex_pattern_set.name) > local.aws.waf_regex_pattern_set.min_length
        valid_name_unique = length(regexall(local.aws.waf_regex_pattern_set.regex, local.aws.waf_regex_pattern_set.name_unique)) > 0
      }
      waf_rule = {
        valid_name        = length(regexall(local.aws.waf_rule.regex, local.aws.waf_rule.name)) > 0 && length(local.aws.waf_rule.name) > local.aws.waf_rule.min_length
        valid_name_unique = length(regexall(local.aws.waf_rule.regex, local.aws.waf_rule.name_unique)) > 0
      }
      waf_rule_group = {
        valid_name        = length(regexall(local.aws.waf_rule_group.regex, local.aws.waf_rule_group.name)) > 0 && length(local.aws.waf_rule_group.name) > local.aws.waf_rule_group.min_length
        valid_name_unique = length(regexall(local.aws.waf_rule_group.regex, local.aws.waf_rule_group.name_unique)) > 0
      }
      waf_size_constraint_set = {
        valid_name        = length(regexall(local.aws.waf_size_constraint_set.regex, local.aws.waf_size_constraint_set.name)) > 0 && length(local.aws.waf_size_constraint_set.name) > local.aws.waf_size_constraint_set.min_length
        valid_name_unique = length(regexall(local.aws.waf_size_constraint_set.regex, local.aws.waf_size_constraint_set.name_unique)) > 0
      }
      waf_sql_injection_match_set = {
        valid_name        = length(regexall(local.aws.waf_sql_injection_match_set.regex, local.aws.waf_sql_injection_match_set.name)) > 0 && length(local.aws.waf_sql_injection_match_set.name) > local.aws.waf_sql_injection_match_set.min_length
        valid_name_unique = length(regexall(local.aws.waf_sql_injection_match_set.regex, local.aws.waf_sql_injection_match_set.name_unique)) > 0
      }
      waf_web_acl = {
        valid_name        = length(regexall(local.aws.waf_web_acl.regex, local.aws.waf_web_acl.name)) > 0 && length(local.aws.waf_web_acl.name) > local.aws.waf_web_acl.min_length
        valid_name_unique = length(regexall(local.aws.waf_web_acl.regex, local.aws.waf_web_acl.name_unique)) > 0
      }
      waf_xss_match_set = {
        valid_name        = length(regexall(local.aws.waf_xss_match_set.regex, local.aws.waf_xss_match_set.name)) > 0 && length(local.aws.waf_xss_match_set.name) > local.aws.waf_xss_match_set.min_length
        valid_name_unique = length(regexall(local.aws.waf_xss_match_set.regex, local.aws.waf_xss_match_set.name_unique)) > 0
      }
      wafregional_byte_match_set = {
        valid_name        = length(regexall(local.aws.wafregional_byte_match_set.regex, local.aws.wafregional_byte_match_set.name)) > 0 && length(local.aws.wafregional_byte_match_set.name) > local.aws.wafregional_byte_match_set.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_byte_match_set.regex, local.aws.wafregional_byte_match_set.name_unique)) > 0
      }
      wafregional_geo_match_set = {
        valid_name        = length(regexall(local.aws.wafregional_geo_match_set.regex, local.aws.wafregional_geo_match_set.name)) > 0 && length(local.aws.wafregional_geo_match_set.name) > local.aws.wafregional_geo_match_set.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_geo_match_set.regex, local.aws.wafregional_geo_match_set.name_unique)) > 0
      }
      wafregional_ipset = {
        valid_name        = length(regexall(local.aws.wafregional_ipset.regex, local.aws.wafregional_ipset.name)) > 0 && length(local.aws.wafregional_ipset.name) > local.aws.wafregional_ipset.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_ipset.regex, local.aws.wafregional_ipset.name_unique)) > 0
      }
      wafregional_rate_based_rule = {
        valid_name        = length(regexall(local.aws.wafregional_rate_based_rule.regex, local.aws.wafregional_rate_based_rule.name)) > 0 && length(local.aws.wafregional_rate_based_rule.name) > local.aws.wafregional_rate_based_rule.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_rate_based_rule.regex, local.aws.wafregional_rate_based_rule.name_unique)) > 0
      }
      wafregional_regex_match_set = {
        valid_name        = length(regexall(local.aws.wafregional_regex_match_set.regex, local.aws.wafregional_regex_match_set.name)) > 0 && length(local.aws.wafregional_regex_match_set.name) > local.aws.wafregional_regex_match_set.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_regex_match_set.regex, local.aws.wafregional_regex_match_set.name_unique)) > 0
      }
      wafregional_regex_pattern_set = {
        valid_name        = length(regexall(local.aws.wafregional_regex_pattern_set.regex, local.aws.wafregional_regex_pattern_set.name)) > 0 && length(local.aws.wafregional_regex_pattern_set.name) > local.aws.wafregional_regex_pattern_set.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_regex_pattern_set.regex, local.aws.wafregional_regex_pattern_set.name_unique)) > 0
      }
      wafregional_rule = {
        valid_name        = length(regexall(local.aws.wafregional_rule.regex, local.aws.wafregional_rule.name)) > 0 && length(local.aws.wafregional_rule.name) > local.aws.wafregional_rule.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_rule.regex, local.aws.wafregional_rule.name_unique)) > 0
      }
      wafregional_rule_group = {
        valid_name        = length(regexall(local.aws.wafregional_rule_group.regex, local.aws.wafregional_rule_group.name)) > 0 && length(local.aws.wafregional_rule_group.name) > local.aws.wafregional_rule_group.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_rule_group.regex, local.aws.wafregional_rule_group.name_unique)) > 0
      }
      wafregional_size_constraint_set = {
        valid_name        = length(regexall(local.aws.wafregional_size_constraint_set.regex, local.aws.wafregional_size_constraint_set.name)) > 0 && length(local.aws.wafregional_size_constraint_set.name) > local.aws.wafregional_size_constraint_set.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_size_constraint_set.regex, local.aws.wafregional_size_constraint_set.name_unique)) > 0
      }
      wafregional_sql_injection_match_set = {
        valid_name        = length(regexall(local.aws.wafregional_sql_injection_match_set.regex, local.aws.wafregional_sql_injection_match_set.name)) > 0 && length(local.aws.wafregional_sql_injection_match_set.name) > local.aws.wafregional_sql_injection_match_set.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_sql_injection_match_set.regex, local.aws.wafregional_sql_injection_match_set.name_unique)) > 0
      }
      wafregional_web_acl = {
        valid_name        = length(regexall(local.aws.wafregional_web_acl.regex, local.aws.wafregional_web_acl.name)) > 0 && length(local.aws.wafregional_web_acl.name) > local.aws.wafregional_web_acl.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_web_acl.regex, local.aws.wafregional_web_acl.name_unique)) > 0
      }
      wafregional_xss_match_set = {
        valid_name        = length(regexall(local.aws.wafregional_xss_match_set.regex, local.aws.wafregional_xss_match_set.name)) > 0 && length(local.aws.wafregional_xss_match_set.name) > local.aws.wafregional_xss_match_set.min_length
        valid_name_unique = length(regexall(local.aws.wafregional_xss_match_set.regex, local.aws.wafregional_xss_match_set.name_unique)) > 0
      }
      global_accelerator = {
        valid_name        = length(regexall(local.aws.global_accelerator.regex, local.aws.global_accelerator.name)) > 0 && length(local.aws.global_accelerator.name) > local.aws.global_accelerator.min_length
        valid_name_unique = length(regexall(local.aws.global_accelerator.regex, local.aws.global_accelerator.name_unique)) > 0
      }
    }
  }
}
