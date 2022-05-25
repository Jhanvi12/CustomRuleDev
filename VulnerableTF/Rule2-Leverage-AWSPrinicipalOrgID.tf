resource "aws_iam_policy" "theRealTestCase" {
    name        = "${random_pet.pet_name.id}-policy"
    description = "My test policy"
  
    policy = <<EOT
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "DenyS3AccessOutsideMyBoundary",
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": "arn:aws:s3:::*/*",
        "Condition": {
            "StringEquals": { 
                "aws:ResourceOrgID":"${aws:PrincipalOrgID}"
                },
            "StringNotEquals": {
            "aws:ResourceOrgID": "val1" 
          
        }
        }
      }
    ]
   
  
  }
  EOT
  }



  resource "aws_iam_policy" "theShouldNotFailTestCase" {
    name        = "${random_pet.pet_name.id}-policy"
    description = "My test policy"
  
    policy = <<EOT
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "DenyS3AccessOutsideMyBoundary",
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": "arn:aws:s3:::*/*",
        "Condition": {
            "StringEquals": { 
                "aws:ResourceOrgID":"val1"
                },
            "StringNotEquals": {
            "aws:ResourceOrgID": "${aws:PrincipalOrgID}" 
          
        }
        }
      }
    ]
   
  
  }
  EOT
  }




