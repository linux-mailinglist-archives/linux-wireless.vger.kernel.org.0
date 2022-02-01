Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9FD4A5CB2
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 14:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbiBANAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 08:00:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51952 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238295AbiBANAB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 08:00:01 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211BJMY3003460;
        Tue, 1 Feb 2022 12:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=56YhKLrJk8afzXFtVmWAOr6drDiKcw7CghJmFBWKUjU=;
 b=Krsz0jOydJRcQAKCnjF5853OQiR1YCgkXqu6neVFNf/QMnjxgWOC1ulKAzb1s67CfdJV
 iDG39Zy8SR9oAm+WUrzdKJX/6W4PJnKgcecTGgCVpG1C7qANwzNkA9GOlEWGaPkL6uuS
 t54PW0f/tX8vZuH0M8FDdHO2ZKkmqU70Dh4Gkajx4Yaf5Bl8S8LsEjZ3Jh3rfF1/cPqS
 +QGJKOV6OLNwOb0obr7CFXdDx7bMHtuwxvdJG/jiYfmVP++7x3paMZA/AgYcKFCXwqUN
 5H88UggPWz146WO7NRszSCQsf8VcShTA+tg5HIWUOXxwHBlENMBmsZRkmn1gLF60zlJU FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2j7hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 12:59:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211Cp9db040743;
        Tue, 1 Feb 2022 12:59:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by aserp3020.oracle.com with ESMTP id 3dvwd668gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 12:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqsCSOsrt4pUDwD7MLxvXs2y4z/cFElv+SwXD+zqSl6mjcCnaz8BhSLvU0ZdcPoXUnNpqMUqbPxAeznSF8zpgw4XfsKMxiUTVyGxMoe8U5tNjQKdqi9xwOCabu0iwqCZdAQV/PEwyPpcuODJT2ST6nR8I5lqAhkhQ/7tb+9CYQwONl5Cb4g1wxaJKZgn+j9Dr9aQ1tYxUTy12foHnj902dRbbGwIhAIj8TVKKlk6x8VFl8Y5+n+UQadyOP4XfHIGVrYHvb81x7dCr1pOxOmelGwce+ehNMZElpJTuJhmZLqVjcUZ7vO4iLY5OLeUXw+Mlvs2DcfNCpQRXXC/fvC5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56YhKLrJk8afzXFtVmWAOr6drDiKcw7CghJmFBWKUjU=;
 b=h3q2QDs5SKvKAhgpxjZfN9RAe56ry/4ArKY8AcdaBKdt9Ylx6FLSBNu8F0+UrgZgmDpEjs0eZzGAnC70bnJkV1ddGulNMoPx/mXsstvckjLkCnOEcojdyxaTsHfIG7F0bUbn4NQYxCHiisrI6uy6RaeUtIwQ3MwKOOH6xQ4YMHHc1doH/oYpn0MsV/cqroeDCvkk4SBnyAXUVJYHAWGjnXf7+QzMbmguK9/8uLsXR7QxlWioqlBCTNkNC48+qRUZlHj5YmlZ/fQ8RTJAAEeZ8mvbLGUee7XqGDzKJcap5IOmcX9QgOMfRpmUZHec+LqQVr7pTs7J3JrxwmLNLWDS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56YhKLrJk8afzXFtVmWAOr6drDiKcw7CghJmFBWKUjU=;
 b=YaRYAWPdCryExCoYgrzC/RWi2D0e/y+5LagUjbv/2KtX+8e6dLUY34rfWLoipTWYsh9l3GWav1+JbT224oXkfCQZfACLTJeEStfFm/BNd0A+jRLu1FAxPnMxTyKN+977spB7O30AFhzuoVQKS6i2glmnXyJ0PiUKq+iu4ZB9nnw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2123.namprd10.prod.outlook.com
 (2603:10b6:4:2d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Tue, 1 Feb
 2022 12:59:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 12:59:52 +0000
Date:   Tue, 1 Feb 2022 15:59:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wcn36xx: Uninitialized variable in wcn36xx_change_opchannel()
Message-ID: <20220201125941.GA22458@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24343a3-6c1e-497d-3b9d-08d9e582bca1
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2123:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2123CA1A8394A234020928818E269@DM5PR1001MB2123.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQ+knggXOg93mto6FhOtiMeZa4lyzBD59Tdm0nAoLN59/Gl53Dfwnfn/CbEdbWE5x96wp3FfjjQvtZpDX9DfOYx/iWSoY6sUjB9CzDW17vdkcU3nxr1k9No7gjs8f0Wy0S62UFMUhPqqCivE/KqFwy2sHq+52aedd+Ajy1QgtcJOMxm5eas3q5x3OLs1ZN5blAVkOLAIba2z3LN/tv/8jEd2daehHPpxQeNF6r+BgwWA4r0JMLD53iSS3CRXzAPWNh2A1Cy54CGh7CTytdHFKVFm98j0/UWSh6cZyL9i7io6o+6bpuUxSt4z16nt+/J1VeOcgowxk7VVIZ0sjmyQRj1xh0HGEjDiC6qJEsbg64APhdhP8CsUbB8WcH5ZA3VbnEI55yuSwsw+NGI/KpIi03vV/m5VpUFLoFOXOWHvFyNj8t9Y5hdlDLIFQDXAE+57XTwoDA1XN88kU+yBl0x3g9ibzyokBNQ2Iuak5Y7v2F6AR4wiVgI1RV1ht+6GzWRgINxrwyIhw9SZ7iBbb1eX0xrecx0tMl9pA1N5I1vgnd+aDuIOT58kmONbs4+s432uayBBbSmsyY9gtUBNamOuPGzd/J/BH0FI53IP1Bt3b0pbCTivGel8fmSXjjJ0QfhY4BrnAk0E/o9UO9V7IlX9Lwc16OAea4MMGWQL59UPrhAhRZiA7dHEI+HItV7hQf5OenkYr5lxeTfFUJcza4iSfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(4326008)(44832011)(110136005)(83380400001)(2906002)(186003)(33656002)(1076003)(26005)(316002)(8676002)(8936002)(5660300002)(6666004)(6506007)(508600001)(86362001)(6486002)(9686003)(33716001)(66946007)(4744005)(6512007)(52116002)(66556008)(66476007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UcOsCMKGswvsXqLh2ExKUO8LDFf+E9bcGf1KTxZhHXOmfdq2H30sEmNHJMEW?=
 =?us-ascii?Q?9wELm7zrR4PMLpH6qUkYmkD4FSW25hfn9YKx6qHxAGVe6UsdXr0Nyv94waOZ?=
 =?us-ascii?Q?wNDnGLfFBvXIMxXjXrzex6cu2dSWgVMkSumUJ4AI/hVxf+JDCWxS73B0suMl?=
 =?us-ascii?Q?vjoavD2H/tX3aLkZQz8z2qZEfrfVEFe1l/HvGINZ8T9110G4c9QpnwZUEqS+?=
 =?us-ascii?Q?rRbI/isH+uT7s9HXgCrRvln1jZ9Fr1D3IYz0tudanaPcsjd1+LS09rx23l4N?=
 =?us-ascii?Q?aKEhHZ2od7uZK7RHiLuOUAHt5EspeEad8GAKZcvaDdiFo7QHdFmQpIdnvRXe?=
 =?us-ascii?Q?4VXWCbq1254x51ls0KXJnziu8Z4jM6b5HbfCPlRiQ1X7qFweOs1crNlwZpqr?=
 =?us-ascii?Q?6P/3/HC8TvI4wvpkRIThf3bU/y1vw/ekfqRFrL/yYOlTw5irB7+v9H0Nw2R8?=
 =?us-ascii?Q?70qS/0OCZqfAIqrL5vFVvfgW6aLpywBzUCr4n20k6/stsuPBQ9JrfiRWRdw6?=
 =?us-ascii?Q?fMJSdX/RJ2VvRdrOGgfUaEYA7zjMCxh7nDlmWsbzlGLTIpHpbJGXslijH/VE?=
 =?us-ascii?Q?ZXNgy3wbP/cc+oA+aVRnDcPVDDFThcs9JWlM4O1qgZoOuRcad5SlBErSKCx0?=
 =?us-ascii?Q?NCsDIRGlo3vs68BVJ/Z66onjO+JTFDMPxyNxYtEGhxUmOWG446XsEW8gmrb/?=
 =?us-ascii?Q?m1d0IgVQVeeZmKBizbOBxW/AdbVSCxkTW3dykN3l4/StRaPUJMj5PUx/HzD8?=
 =?us-ascii?Q?cAmboJMaBem2ZGfG2CmlY3/CRk/JjilyQmjtbQz8h2eac+c8z1RrRNCsfCNi?=
 =?us-ascii?Q?lz+NxLxoM7PpQMR7Fgfp4ds+5Y8PMyP288Az1tbT66Ozro7lUxvmLynsuo3e?=
 =?us-ascii?Q?2JA/bnXx7XUK1IqIBHzA9pp1M8kdbyWIadFqOdNd82PE6teCNOBKalyiW3/O?=
 =?us-ascii?Q?Gl759Ko9QdV0uQnsxfhNjDqi4j+ygXFs+Jjnt9OhiVcryL4gflk+P33fzTK1?=
 =?us-ascii?Q?hk4py/cnpIgvyGmda45fgs3Hz7vJtv//GvT0yQ9nnJAXPJ5InJon4Uovx/Cp?=
 =?us-ascii?Q?4gliZBpEKsm0i0fIftdYXMU/B1QTI2v1mcHl/KWyCgWXt6ZLO0PtrwUT979V?=
 =?us-ascii?Q?lnAyz1obHInQPxw14hQCspCHhaPP2n9GPIsdyimUIRzgHa/1jehNUfFfP34j?=
 =?us-ascii?Q?+ZCIQK9L9Mfp0bxjlao5feC4ngNo7A7AwBzBZRXEkyb51RlflkuZYtEoYNyb?=
 =?us-ascii?Q?MDTGkw4uQbDPgVPIPQ/35cwtM31b9lomxny2e8Hwl+SO+HaTA5L3c4+fwMWd?=
 =?us-ascii?Q?mzbkYyYVm9GuH8btB5QZ/yWoObuKS8xxvUQrazUhMBXS/SU3iBO2KMin2QGI?=
 =?us-ascii?Q?i1UBioZYpd2IlRyo2SvKg2bJtVRhjNq+zslTdSJ1t+uXJELUrEEf42/azG7I?=
 =?us-ascii?Q?9nZvnViXzqzoTMFqYx9K+tGQVy2gRG5NBQTz4OZJNxvhS19wYOqnpB/awIwK?=
 =?us-ascii?Q?Sv5Mgt98AlN5R/Fn7jZFJ+nRD/j+3ion2sFbFQERj7MLkY6RXAlKiupH0EQJ?=
 =?us-ascii?Q?l4zlW0TJs97a6A3vHd5VVw4JDWUSSWW0R99afaetC2KMGnT8E6u6oSilJrI5?=
 =?us-ascii?Q?P7DBmH08Zlwe3IIDAfOyX4FkI9TCVakj0hA0XAicOVdqhT03UUg81KisquRO?=
 =?us-ascii?Q?0VuRIM1bdf6nawDj/YfrFz3nrBE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24343a3-6c1e-497d-3b9d-08d9e582bca1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 12:59:52.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhRq9zJ02wkB3qEfm0ZebnZgHhC2XT9EaTW2Fwjlb35IeDDtSPju0hBQSGE6NAntMpfsCLTngGvcGeIQaiaa7lebVZ345GsovUpwIWtCSJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2123
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010071
X-Proofpoint-GUID: VHHRCKnHYr11Emy-ltxzgMZ__VPuSzwb
X-Proofpoint-ORIG-GUID: VHHRCKnHYr11Emy-ltxzgMZ__VPuSzwb
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code needs "channel" to be initialized to NULL for it to work
correctly.

Fixes: d6f2746691cb ("wcn36xx: Track the band and channel we are tuned to")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 75661d449712..1a06eff07107 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -394,7 +394,7 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
 	struct ieee80211_vif *vif = NULL;
 	struct wcn36xx_vif *tmp;
 	struct ieee80211_supported_band *band;
-	struct ieee80211_channel *channel;
+	struct ieee80211_channel *channel = NULL;
 	unsigned long flags;
 	int i, j;
 
-- 
2.20.1

