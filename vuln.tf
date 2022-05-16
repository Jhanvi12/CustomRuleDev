resource "aws_iam_policy" "res-1-fail" {
   
   policy = 
 {
   "Version": "2012-10-17",
   "Statement": {
     "Effect": "Allow",
     "Action": "Configured",
     "Resource": "*"
   }
