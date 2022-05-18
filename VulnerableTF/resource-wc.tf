resource "aws_iam_policy" "res-1-fail" {
   
   policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "Configured" ,
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_internet_gateway" "gateway-1"{
  
}
