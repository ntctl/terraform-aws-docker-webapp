resource "aws_iam_role" "ec2_ecr_pulls" {
  name = "allow_pulls_from_ecr_for_ec2"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "inline_policy" {
  role = aws_iam_role.ec2_ecr_pulls.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchImportUpstreamImage"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_ecr_pulls" {
  name = "ec2_ecr_pulls"
  role = aws_iam_role.ec2_ecr_pulls.name
}