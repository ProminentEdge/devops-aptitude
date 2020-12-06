#
# IAM
#

resource "aws_iam_user" "interviewer" {
  name = "interview_candidate"
  path = "/system/"
}

resource "aws_iam_access_key" "interviewer" {
  user = aws_iam_user.interviewer.name
}

resource "aws_iam_user_policy" "interview_ro" {
  name = "interview_candidate_policy"
  user = aws_iam_user.interviewer.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "tls_private_key" "interviewer" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "interviewer" {
  key_name    = "interviewer-key"
  public_key  = tls_private_key.interviewer.public_key_openssh
}

output "secret" {
  value = aws_iam_access_key.interviewer.encrypted_secret
}

output "password" {
  value = aws_iam_access_key.interviewer.ses_smtp_password_v4
}
