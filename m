Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53056BB28
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiGHNuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbiGHNuD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 09:50:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71501193C5;
        Fri,  8 Jul 2022 06:50:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268B8OBj021399;
        Fri, 8 Jul 2022 13:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=EOx6wA33TLdmrqcnVfJgEVU7kRtrM7kjovuqITYYZFI=;
 b=f0eqGF2YBCkjzXqkYVukCIygMsp2qe6fpmZiM8kg92WX2y5tXDEiWbz7lzAssW2ZOSGO
 4MA4bOMPjwKo1fl5x4bNk5eZAqlxnSsLdDuDtoPq6SeX1XmflPs+SyPjBlHbcEhlv+rl
 BxeU0oLsyuxA7AwwC6OoWvYf4NMUZszZiwmFzrjqbhWuwpbOtaVm3Qy96P9MPDMm2E6r
 U8z813wS3f96VSwzVZyvBy2HMh3U2oy9NeEsqnylV3cWpt5BOJSRQfGo330BPPa0HNkz
 Hp4yr6rQyyh6tn8JAymcCa6A9rIiLLeMldGqGRhFlwjK4GjxmUdzHkkYBvUQWPs53Rg0 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyfsyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:49:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268De4A4026561;
        Fri, 8 Jul 2022 13:49:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud9y0qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0jyJPd7BMlqEcyhTvZSkpN5OO6g6CizRmrCKWhXOJcojP7kK+CUY0o8qO4gUUn6Yh8LDGGgTCK9X2HN3mdXDdAIL13+ATv7f6w8p5KYM1XZ6iUgCzKXy8R/RYooWabk9IJpGn7bBCtdrrzmTzGOSJ9ozYttt5DQ2oWB8G7TWBkKnAnZdsEF65v1hXPCyBkXgBasp7p7QKyCCQoCH2vqg4t6yjwsux6m/H2QxAlACysvHKU0y8jSeVQr8buTSnQxjzvFm4ASltEKBUvRJxngsG3W1f1olcgYTxh54g2sHc0gpDocQdBvFULUJ7DYmxROWuM6bLg2Os7seVv9zomLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOx6wA33TLdmrqcnVfJgEVU7kRtrM7kjovuqITYYZFI=;
 b=JWg8uPUvskoRv7dOYfmIiJROI2LL26BIrIrF1DqXSAQaHdVaTQCQd9tePhcFBr9W34m/R+0hiZmrANJgST5pv1UXPO6Hb9uWfNeMl+P3L3WYdxuLrSYMKIbx9bjSPMjqEbeIM5m+2qebOXpG8vjUf2Lv6FBD0phIMYm9znN7ndt0pePeIW2UVcs8oQYlEwc+S0oQGFOoPua6NWaB0Sgl6m15CPIlUOwasE4m17nUJt9rxM6B3p47WTeHZ7zSAo9rVKVVYbN6Dk4k59ES94zLtSHB8SgQBYHzQvX4+0DdiW00NqMfN/Q3GVqQHBGwF6MPgZpP69mQVd+5MeK+AM/VYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOx6wA33TLdmrqcnVfJgEVU7kRtrM7kjovuqITYYZFI=;
 b=RPeNEkwFWo8vWyAJPkcD0twofbMYfOW2FZGIH5Y2RvM/AgUUnqjDbbPSsNNyoTF8xYCCcMsHNOYH6rJlcDdzZogVrFJnvcyRa/UyaSN//mSRoN5mGUog697REpoUGUK7wQ4yeV0m+qb0ESCGRTLythKa+VM4RO1dovrwaDLOY5s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5796.namprd10.prod.outlook.com
 (2603:10b6:510:da::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 13:49:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 13:49:29 +0000
Date:   Fri, 8 Jul 2022 16:49:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vladimir Kondratiev <qca_vkondrat@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] wil6210: debugfs: fix info leak in wil_write_file_wmi()
Message-ID: <Ysg14NdKAZF/hcNG@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d41a11-7576-43d9-980a-08da60e8ae1d
X-MS-TrafficTypeDiagnostic: PH0PR10MB5796:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vgS5c1wVq9e8VUustrkkzfs66WtEORl+5s6a7DGM5U2fxO77AFNhMOrinZXjizhpV6rNDMbMYnU3M6J7XXytbuvJg7jM90oq180WPTMTHGxAyb+0iJoOHelzGwmB7OBnVolVh01kp/VmLGxgVd2xUDcg6rsFkXufbBUqgTKQUFB6QfelGaLAYm94Qejzfb7FZG36QExGzG+SP0oHSjzfRDYzjgS0vMjC/cxOGThVWrzziVfRcDE92J0BLemBpfjfDn/2yxthVHGABz3aWNymEMXb8pARL0xEzM1HYA9FrVcOthiIVwHmay/IGRi6nHU6w1B63xGJsU+uzasDIB/+WrT0bQfW2DzmBJh1K5Sye8/dhFkRjP3c6o4XGtYESP+0c9x+9Lg7hwDO2jEPiRR295DWGeNqg6DBvtMArAlhz1IiN9KwxU3BvwSz9YPR2gYuWhpBsX4L3pc3Ru9V426yRC04RTcqSDAJj+OeyiPdtFI3bTDTMNk7m0FzjXfYpcc9nZxQQOKYTwsxPFs387MX0ViSqDoqOw4byW5t55sh22HfIPOzEuW7r7mT6f+sJ+5KSUjBkn+nIZ8N6XacHoW5QVt3SePAAuopgbxJ+00p0DCyHZfNNtZXwVb05Zx7prKHd2t0VNL+sDyCy626ujkPkd8Yw8RLXhUs4epWvZChIUFi1Wxz7rTCuueRbWUqUdUKSYlTy8rC+JdE2Bg2vqE7fu393yHeD+LDQnIQ0izYD+4aK8JPpZfWKqPsjAR2C68KRv3WgNiE3adC7x13bVnAl3iPE9vPJ61QW79bIkYb0VVlalprD8iUl0vvbozRgxQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(366004)(136003)(39860400002)(376002)(86362001)(41300700001)(2906002)(9686003)(6512007)(6666004)(26005)(6486002)(52116002)(478600001)(8936002)(44832011)(5660300002)(6506007)(66556008)(186003)(83380400001)(38350700002)(38100700002)(66946007)(54906003)(33716001)(66476007)(8676002)(4326008)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8wrRrzvRjoBr13tdzQOZJsLXk5igNxn2O0O+bavDVj4XqJPUvwvhX6hBP6r?=
 =?us-ascii?Q?OIjub2+75JbUbQO2nONAr+FNdVtg3DgfXnpbCWcfsfHPGbztdgDbLO+4VW/m?=
 =?us-ascii?Q?QZvxd3SwFFjgrMjzHhgxzn0bX6bTH9QMPx1JiSMBMQh8MqKrNNo71SClR02y?=
 =?us-ascii?Q?dDUAguwiPgHoUbO4c/sIHYe8RbQ8N8nSlvfWAr9yrJAZDeVEpccVilmiOEFX?=
 =?us-ascii?Q?hpHNR5dZe0I+Q5AuffF0wipl9+17eNWtvppucFsFd1s60uohksqBrTWOx4iZ?=
 =?us-ascii?Q?DHDyDOTgvKAQmu+/hZg5dUzjf2jWi4WEKadU7jxYBSTSLBamzzoHvQb+MSa9?=
 =?us-ascii?Q?RNmJvmU1OHbjyUfQJbCOTIsSnYZPWygdLKOBHXN/QZDNLXjiGkuy5a2Ebi39?=
 =?us-ascii?Q?mzvryGwzpvRJTrAy5iTfLDbZitbNxzwzsum1xFcH3XJn3yx+dAJJQimnYr2W?=
 =?us-ascii?Q?lc76i3AIr2aQdM8IZ9F5jxt+W0MqwvXc+9ObWRDd3doGbYxNBNazZlNv7FRQ?=
 =?us-ascii?Q?iC0ctl3rB0drAw0fKXh682M94cnCl8KmEUJyaSZ9cPluy1zVFhUXzNF59ukO?=
 =?us-ascii?Q?2tsB6LZOTAhxacgokdOQgufAz1dZFW5ivoZO7/hPjAdatxLI1c78iQSRq3iE?=
 =?us-ascii?Q?dAz2oNnHLA89k8TuHCWhh03GdH2s+1SM4c4x1YqCEhtdex/lj1OckNuCr1s+?=
 =?us-ascii?Q?fSEXuNdBQ1ITrZhOqecj6jkpHi/z9lEvglLA6vn55qtk3CmOTi6zPz3AmikS?=
 =?us-ascii?Q?KV9/aq143uAi5HRsunm7ycVGAgoaSKH3HF23RuEdZDVdiHAkUx1AuEdfjYt2?=
 =?us-ascii?Q?oYf+HbSWbjgBy4+wN1k569P6e1JqQamzv195LzzEC9roCgMjnrPw2CXcrPDe?=
 =?us-ascii?Q?cXJXVyeKuPJQElt2j1xMowiKgeVIsXaTavzHKr3YD7i/2MfjI74VaAkG6pl3?=
 =?us-ascii?Q?d/Zv4iu80YQm97gR6KXUYVwSg4gXHsZrsDE2cxcBpTQfs13UouRhvns6vbng?=
 =?us-ascii?Q?J3lvPhJ53TgujfAQqEdlv2QcVsePIPWAsaMzlOX7xvUfh9tJCDWtt5Mex4Mc?=
 =?us-ascii?Q?3VZZHMz+3FEmJ2nCN/YtllutU0UY8a9WpnGdR2Xlw1CKBNfpWrmDnxUigrFT?=
 =?us-ascii?Q?lYSfM7ue+DGBwczME1R8oCA53QvCgWxRHBpmgaIYeUo5gQ7qnjlPXIx8lbEN?=
 =?us-ascii?Q?324Dfr0Rl4nu4+VWu9WQoTFOWElr+25Wy52GRfEgVs8Fe6T7c28tBV0oiAn9?=
 =?us-ascii?Q?bggmqQPDFzt+PMCFCa933Gap0a4Z1WeREx4p06wkMynUejDw1UKKjaILGcIU?=
 =?us-ascii?Q?iiJ+tDwoXMYSRo5tsEQ2N5eMIdD3I6yc3XsmYPDEzdMSBTYIcfwmZj2omrgr?=
 =?us-ascii?Q?Zc5xYUcUEYgRGodHsuMSqLKpl5QEaEpRrn9JTD/cX+8JFqSXnRclGBKwZELN?=
 =?us-ascii?Q?iawaD+XhnluozaleWGLjIkP7x4OnZFM1fjghL+01oCECtQn6aTr3i05IAAiK?=
 =?us-ascii?Q?MAfd4p0BK6Y7XmHgYDcUPvNSRN8LA8mKC0CJjZErxfOZUKUfDgrxK3jyJRwL?=
 =?us-ascii?Q?wnOdByk4s0SgttB2wSLsrIE/4Nbk2ar/LgVONaEDUDcr6rTjDYVucYkHbeku?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d41a11-7576-43d9-980a-08da60e8ae1d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 13:49:29.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oERp0+4N4Pt96kxZ+db8VgbabkoF2hPQf6YYoJq7BCVdZaKqi4RJk+fgTmp+gA64je8vAQMsX+Fo0zMEO1XWbawUfyhMcopj4+gSjmmzkhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_11:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080052
X-Proofpoint-GUID: cMxMQZI1GN6wGuTO_EatHax4Rfw0PreC
X-Proofpoint-ORIG-GUID: cMxMQZI1GN6wGuTO_EatHax4Rfw0PreC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The simple_write_to_buffer() function will succeed if even a single
byte is initialized.  However, we need to initialize the whole buffer
to prevent information leaks.  Just use memdup_user().

Fixes: ff974e408334 ("wil6210: debugfs interface to send raw WMI command")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2:  In v1 this was part of a two patch series.  The second patch was a
     cleanup path and it introduced a bug.  Just drop patch 2.

 drivers/net/wireless/ath/wil6210/debugfs.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 64d6c98174c8..fe84362718de 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1012,18 +1012,12 @@ static ssize_t wil_write_file_wmi(struct file *file, const char __user *buf,
 	u16 cmdid;
 	int rc, rc1;
 
-	if (cmdlen < 0)
+	if (cmdlen < 0 || *ppos != 0)
 		return -EINVAL;
 
-	wmi = kmalloc(len, GFP_KERNEL);
-	if (!wmi)
-		return -ENOMEM;
-
-	rc = simple_write_to_buffer(wmi, len, ppos, buf, len);
-	if (rc < 0) {
-		kfree(wmi);
-		return rc;
-	}
+	wmi = memdup_user(buf, len);
+	if (IS_ERR(wmi))
+		return PTR_ERR(wmi);
 
 	cmd = (cmdlen > 0) ? &wmi[1] : NULL;
 	cmdid = le16_to_cpu(wmi->command_id);
-- 
2.35.1

