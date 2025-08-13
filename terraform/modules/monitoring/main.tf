resource "aws_sns_topic" "alarm" {
  name = "${var.name_prefix}-alarms"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarm.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "apigw_5xx" {
  alarm_name          = "${var.name_prefix}-apigw-5xx"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "5xx"
  namespace           = "AWS/ApiGateway"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  dimensions          = { ApiId = var.api_id }
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_sns_topic.alarm.arn]
}

resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = "${var.name_prefix}-dashboard"

  dashboard_body = jsonencode({
    start          = "-PT6H"   # ultime 6 ore (opzionale)
    periodOverride = "inherit" # rispetta il periodo del widget
    widgets = [
      # Request count
      {
        "type" : "metric",
        "x" : 0, "y" : 0, "width" : 12, "height" : 6,
        "properties" : {
          "view" : "timeSeries",
          "stacked" : false,
          "metrics" : [
            ["AWS/ApiGateway", "Count", "ApiId", var.api_id]
          ],
          "region" : var.aws_region,
          "title" : "API Requests"
        }
      },

      # 4XX e 5XX
      {
        "type" : "metric",
        "x" : 12, "y" : 0, "width" : 12, "height" : 6,
        "properties" : {
          "view" : "timeSeries",
          "stacked" : false,
          "metrics" : [
            ["AWS/ApiGateway", "4xx", "ApiId", var.api_id],
            ["AWS/ApiGateway", "5xx", "ApiId", var.api_id]
          ],
          "region" : var.aws_region,
          "title" : "4XX / 5XX Errors"
        }
      },

      # Latency p95 (end-to-end) e IntegrationLatency p95 (backend)
      {
        "type" : "metric",
        "x" : 0, "y" : 6, "width" : 12, "height" : 6,
        "properties" : {
          "view" : "timeSeries",
          "stacked" : false,
          "metrics" : [
            ["AWS/ApiGateway", "Latency", "ApiId", var.api_id, { "stat" : "p95" }],
            ["AWS/ApiGateway", "IntegrationLatency", "ApiId", var.api_id, { "stat" : "p95" }]
          ],
          "region" : var.aws_region,
          "title" : "Latency p95 (API vs Integration)"
        }
      },

      # Stato allarme 5xx
      {
        "type" : "alarm",
        "x" : 12, "y" : 6, "width" : 12, "height" : 6,
        "properties" : {
          "alarms" : [aws_cloudwatch_metric_alarm.apigw_5xx.arn],
          "title" : "Alarm: API 5xx"
        }
      }
    ]
  })
}



