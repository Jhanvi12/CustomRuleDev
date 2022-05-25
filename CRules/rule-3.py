from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.common.util.type_forcers import force_list, extract_policy_dict
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck
from typing import List
import pprint


class IAMStarResourceOrgIDPolicyRule2(BaseResourceCheck):

    def __init__(self):
        name = "Ensure all IAM policies leverage Resource ORG ID rule2"
        id = "CKV_AWS_3012"
        supported_resources = ['aws_iam_role_policy', 'aws_iam_user_policy', 'aws_iam_group_policy', 'aws_iam_policy','aws_ssoadmin_permission_set_inline_policy']
        
        categories = [CheckCategories.IAM]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        
        
        try:
            policy_block = None
            if 'policy' in conf.keys():
                policy_block = extract_policy_dict(conf['policy'][0])
                
            elif 'inline_policy' in conf.keys():
                policy_block = extract_policy_dict(conf['inline_policy'][0])
            if policy_block and 'Statement' in policy_block.keys():
                 for statement in force_list(policy_block['Statement']):    
                   
                    if not statement.get('Condition')  or statement.get('Condition') == "*" in force_list(statement['Condition']):
                         pprint.pprint('after line 31')
                         return CheckResult.FAILED
                    elif statement and 'Condition' in statement.keys():
                        # pprint.pprint('here after line 33')
                        if 'StringNotEquals' in statement['Condition'].keys():
                            pprint.pprint('here after at 35')
                            val = statement['Condition']['StringNotEquals'].keys()
                            val_values = statement['Condition']['StringNotEquals'].values()
                            # pprint.pprint(val)
                            pprint.pprint(val_values)
                            if "aws:ResourceOrgID" in val:
                                pprint.pprint('inside first if loop')
                                if "${aws:PrincipalOrgID}" in val_values:
                                    return CheckResult.PASSED
        except Exception:  # nosec
            pass    
        return CheckResult.FAILED

    def get_evaluated_keys(self) -> List[str]:
        return ['policy', 'inline_policy']


check = IAMStarResourceOrgIDPolicyRule2()


#https://github.com/abhi06991/checkov-custom-rules/blob/main/IAMPolicyActionCustomizedCheck.py - helpful for second rule