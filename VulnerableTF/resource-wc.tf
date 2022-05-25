resource "aws_iam_policy" "res-1-fail-type1" {
   
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

resource "aws_iam_policy" "res-1-fail-type2" {
   
   policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": 
    {
      "Action": "Configured" ,
      "Effect": "Allow",
      "Resource": "*"
    }
  
}
EOF
}

resource "aws_internet_gateway" "gateway-1"{
  
}



resource "aws_iam_policy" "policy" {
  name        = "${random_pet.pet_name.id}-policy"
  description = "My test policy"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.bucket.arn}"
    }
  ]

}
EOT
}
