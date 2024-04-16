#create a topic 
resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}

##subscribe the topic
resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = "gopal@gmail.com"
}

###notification for autoscaling

resource "aws_autoscaling_notification" "example_notifications" {
  group_names = [aws_autoscaling_group.autoscaling_group.name]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.user_updates.arn
}

