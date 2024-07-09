#Auto scaling launch config

resource "aws_launch_configuration" "levelup-launchconfig" {
  name_prefix = "levelup-launchconfig"
  image_id = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.levelup_key.key_name
}
resource "aws_key_pair" "levelup_key"{
  key_name = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Autoscaling group
resource "aws_autoscaling_group" "levelup-autoscaling" {
  name = "levelup-autoscaling"
  availability_zones = ["us-east-1a"]
  launch_configuration = aws_launch_configuration.levelup-launchconfig.name
  min_size = 1
  max_size = 2
  health_check_grace_period = 200
  health_check_type = "EC2"
  force_delete = true

  tag {
    key = "Name"
    value = "Levelup custom EC2 instance"
    propagate_at_launch = true
  }
}

#autoscaling configuration policy
resource "aws_autoscaling_policy" "levelup-cpu-policy" {
  name = "levelup-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.levelup-autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "200"
  policy_type = "SimpleScaling"
}

#Cloudwatch auto scaling monitor
resource "aws_cloudwatch_metric_alarm" "levelup-cpu-alarm" {
  alarm_name = "levelup-cpu-alarm"
  alarm_description = "Alarm once cpu increases"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.levelup-autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.levelup-cpu-policy.arn]
}

#Auto descaling policy
resource "aws_autoscaling_policy" "levelup-cpu-policy-scaledown" {
  name = "levelup-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.levelup-autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "200"
  policy_type = "SimpleScaling"
}

#Auto decaling cw
#Cloudwatch auto scaling monitor
resource "aws_cloudwatch_metric_alarm" "levelup-cpu-alarm-scaledown" {
  alarm_name = "levelup-cpu-alarm-scaledown"
  alarm_description = "Alarm once cpu decreases"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "10"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.levelup-autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.levelup-cpu-policy-scaledown.arn]
}