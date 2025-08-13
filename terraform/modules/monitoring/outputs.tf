output "dashboard_url" {
  value = "https://console.aws.amazon.com/cloudwatch/home#dashboards:name=${aws_cloudwatch_dashboard.this.dashboard_name}"
}

output "apigw_5xx_alarm_name" {
  value = aws_cloudwatch_metric_alarm.apigw_5xx.alarm_name
}
