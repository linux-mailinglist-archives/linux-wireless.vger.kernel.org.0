Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05043E12BD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbhHEKiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:38:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15318 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240491AbhHEKiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:38:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175AWNl9007829;
        Thu, 5 Aug 2021 10:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+1ShjtYou2RA27VxrZYat7qWjMSIwu0XxgCfGXWGcp4=;
 b=jo0D8XZ0SCHXJD5/uh0o4oPqfsE6sPfxzcVxqQt7t2ilCoHGbac8PwcWYXD2P76EKR3x
 /1tD3rHiR0cXneH/byopt6iLseeYOTRPqW/U6plUSSDBCtGlZl6nO3l6tkZSxVdz1UjD
 S8CemOajpBNmkm9kMt11OndC2R9NV/4lWDrTIz7ew2Ux/dDYwtf+1SXu64gQpJOiJkKF
 R39qeFUbK6hffA0j+EDLR3mGOgSgIXgreSKn93483oJxauukQo1qyoFcRWlsPgjLRFZY
 8oW/ZTUibSD48WR3YfjLJjswn2CytJTvJ7s0osNLYlTWTMSmzxkfm0u1YAzEHz44WtAb mA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=+1ShjtYou2RA27VxrZYat7qWjMSIwu0XxgCfGXWGcp4=;
 b=x+5d8ZqHOcsooaKtAGjV2z1SxMgFncngbFlqjf/QvesLPwjBTzR8Gc8TWvfINlZQYf2h
 2faof3kKlkJlz8Q0lsrNVEuGvFnx1Ir+s/h91lHwTTzBumebROyPhKGCy5oSZjWLe1di
 g2uYDgjACSnf7pMS7u2SaS17xv0Kv+eLzlviXPvoo2+0vt6URFCpvQ9rShwEkgWqptVo
 x5rZ0L6oBeEjsJZf1EJTwkip47QWm9etzCNAEvYpQedwgCGhKDqaNxJx25Yi+7t8yj14
 Bo7I5quZktZfqoqqMa6Q6vcYrIM9Z4IiDIyA3oN1JpdLnAgozY+nAplt8OGulo8NQc2+ uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a843p92fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 10:38:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175AaTq1189245;
        Thu, 5 Aug 2021 10:38:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3a78d8ct4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 10:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoPGNNRpCwAYWhUFJGwbDJcTYIkXWftPUE+Uiy4WBIL2CsU8YRmZ8n+LNdNFG2LdzAe6JlIGRK8OeLBV8BDcDhkHPMNTw+hh9GvUKVPHNuQqRyLq382yrKrnB4dx89I3kousFc70dJW4U13rvKFj4hGNK8NKJFrW7K8EG+TjjDphBJMKJBo8Nzc1jyJ9RpBb/7zBH+LuLDxPpQA9Iz9xF2avNA5TzOmE3UREKLTJoeJV4gMxXVYOCEwK9hpEgLK6QGVhR1uP9/hKcRl2gDa4TmskJaBert3qm/9buh2/edg2+LET+LmggbNYOJ+9hk4e6z24Iwlm59cIVNTGGLu2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1ShjtYou2RA27VxrZYat7qWjMSIwu0XxgCfGXWGcp4=;
 b=MdbrY78oT60ybSc73we8kBEwEap9wMHmHFVL2blV8hEn2a8WW6xaMS0ZGktkHkXToC94k7bkTQWIq+NlWrI2dtopoKzNMv1Z4S5aDElvhaVDdcJOD4KninDOhL8to0Htkp0zUDy6cBlSCwPpfpyv7g+ikJEoTyGtXl8ziIjPJygk13hQl0mxmIBacu1m8VB/tLWfCIoaPowJhJHTA8WPIb045MV+scU3GnzK8dsEGH1b8SD6qkmVkGo5F6JEkgKZH39N7N/P9XM0X+SMoTG3nCz8EFjKhR+FM+ZSIPd3AatYy4NxQh+++pFe21pH/ORFMZ9EtELWttzq2rGR8opreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1ShjtYou2RA27VxrZYat7qWjMSIwu0XxgCfGXWGcp4=;
 b=rjCjluVw+m59lqjqu7LeYNooA64Y2jcJjqn0GLr8bjSCVhO2QvEdKesSW905EqUSq1bfDVi5SQP1/aP12hOiOh3l0NfMfo+jRwj0HlSSYSLeNMMzMCoF+ycRD/XoIov3Pf4g6qL5SbR1POCJWuDC6c0pmPbRW3wlot2QPM7DAWU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2318.namprd10.prod.outlook.com
 (2603:10b6:301:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 10:37:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 10:37:59 +0000
Date:   Thu, 5 Aug 2021 13:37:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rsi: fix error code in rsi_load_9116_firmware()
Message-ID: <20210805103746.GA26417@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 10:37:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92587ad4-af90-4fa7-47ec-08d957fd1839
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2318C1CE7D79195500853C078EF29@MWHPR1001MB2318.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +g454sBEJhisZaZIXJQQeSV2p+d/HhPSb8ZutzRPsoixgDOyGKBzcCAymK42Q0updXHo/ZcMvyXL2HwL9KSGf9O//DOr+GrWiYaa52jHgtB+FevZgKNpemM0LSJk3O1EcuxK3TbkaG+mgA6nMXlyBZTA0hW1xaK2YW15u/X2hNWnJvPdiXPO/fPdzNx4P8HiVc5YW1m6dF5tjfg+YNtyd1/7pytuUqMl40RS0xht47zf1R20D5bAEiYB9MDgLA6uJTgMASgMKqeilprPmLErMv7Uj/EDJYoeTzB6zLtCtsKj/rANyqT7mqxDri/3sDwXY8lXQO2bq/N2T57yxhZKJ09iZc7hz92zre3sD8eCiAFC7n3c8aOZWUue+0N5llifRfTxUhYCJq+7ZnifFt1vWwKB+QSeqbqZqc0MUf8rtTo2u1huV5qcY2HjJw05VKvlkjDlnjPrWq5qXr8+UXDFnUbNZzZNuwgi4MuHk8+RUIGRUDRplT83LhYJz1W2ceqUe6h9yM3EPhLQasIPFE6/QoOhh4NhGr65BtPAmOE5IqeMwETQkwJmUfuxDBr/VSiLdsnQZ8WFVtOuQ4GK1Pvd7GrYLohnKiWWZs/kVqcoGs2gfuqYZWzVapVSlRZAy9m2uFFlAr2mXIeksiNW8WyEShm1xZ0+qBWGbzyyApmcIaUNviw2y3zxiziVAMTpaDbTj2OxD7uKDgX/Sc6PQT96SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(38100700002)(66946007)(33656002)(66476007)(956004)(9686003)(110136005)(8936002)(55016002)(2906002)(66556008)(86362001)(44832011)(6666004)(38350700002)(4326008)(52116002)(9576002)(6496006)(316002)(8676002)(83380400001)(33716001)(4744005)(478600001)(26005)(1076003)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQ+Efv+R3/Um2o82NSVJ2Wj0pawW/LEa6rHb6P1cTz7TNPHTFHNj/pi6MSzz?=
 =?us-ascii?Q?OwyBwylH3n+l9gK2oq13z+sYy/j36egCdDQUp9gcOXAPSsWyWoZ3zl2N/OCm?=
 =?us-ascii?Q?UfxdcX2v2T5CI8RmKfy+94m0KBtG/zEEvOQ6GzVD5Jxx7PjZRpe9M899MNCc?=
 =?us-ascii?Q?f2F8y7462e6i33aubiLG5GlF1elPDuztI7kczNDh8nd0dwKBPTADivDsIoTu?=
 =?us-ascii?Q?4MF/54prOw9CFzU73K7fLiP6BLk0DyImiv8Yy9pdIn67jqUG59eukDzqwe4Y?=
 =?us-ascii?Q?q4ujqRnIGZigSqmfjaesdD67y9f7DnUtDOA+G5aWoEcauO4ZXC1mqRz9H6xK?=
 =?us-ascii?Q?GF5nRI2MwavS+zKs5ukS/OiwEpPdpzdL6KCm3r95bXb+jbar4yTiUg9DJnXK?=
 =?us-ascii?Q?jK5a+WY/lH7uH+4br9Ni1+qHigvuo++u+BLzC2UV77e6y8/MDv0EnR3zqVxQ?=
 =?us-ascii?Q?uyBe7oTkbptGxas/RRmNYjPXYEJUGNpMu/AmrL3L9IdqIzYM3d/nvgcogCGs?=
 =?us-ascii?Q?ZIGM4SiljyVngcH2YmbmE59dX+z3fEaVmxvQol3EmBrYVOGWx2NfJ9fDWvUj?=
 =?us-ascii?Q?GA63MFl9VGh7+2rQ4fkeA2ZLm9YhyB7vPrgI7UPb51pMtz5Sn+WIaW3kGpf1?=
 =?us-ascii?Q?zszJ/uo9R9UpciMBk4VCRUxeKODZO7Bbrbq+En7sT0Gliq/2ysupcffKhBQc?=
 =?us-ascii?Q?Xws9V/eaRe5BmHAvknO1lWDYUTuqkURaFJNcffgjwmpvBrjkVNOF+Mb+4riS?=
 =?us-ascii?Q?NwoIQoCetPCr4yc4QyDWfTH+qOZxmi4sxLZFXw1CT8tdQZvocF2PSlH6yLhZ?=
 =?us-ascii?Q?KH1/XGlg+Mlhl/Q9FGU7C8RFgb272FvNf/UzAWJQb89n24IbxLL85JE1TWoH?=
 =?us-ascii?Q?CJjJYQiGoWrdqxPUxEPo/rOyV/HSfW7y84h0Qvmj/YFAV1IQiT7JFT+Nf1HB?=
 =?us-ascii?Q?yYhSurg5/WyOQmZBufAI+Sqt4XeXDIVQcZZl3BWWtMIA0rIzqh3tfujNtAd/?=
 =?us-ascii?Q?JzFXMJj/7F0eD4wALFq2J2L1OOytZO8r5R/H3T1sEnD1MKwDLVm2GQ+7biXl?=
 =?us-ascii?Q?wxHkJ+G1jQThdPUOFdHLx3bH4mrLAwcUUlUydIjgKZO4qC+B+vjCZvqMR2PE?=
 =?us-ascii?Q?Y1tNIST3fYcuXRxp+4wESf84N6PKGPKetRio7PM5YzImr0+oB/EqO2SFSB7n?=
 =?us-ascii?Q?Ct0NlpT7OfMBL/u9hG+cX1j8+VLNng2fUUeNo7rDzYkP6euuoVNrZtAzrToa?=
 =?us-ascii?Q?w/Z7q/5xPxbEruiByIpGvEE/KIX2lccGFEvQrKTSUYFlP10D4L4ECOH2Gs37?=
 =?us-ascii?Q?a22MeZje/RkLMSF6DyOV+3YI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92587ad4-af90-4fa7-47ec-08d957fd1839
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 10:37:59.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmyUi+5JlsBt3ZnmrnHKx3nco8yrS0JnsunOYf9oH1nHcXAPRp1ibX+1DyEVIa8R5o/KCJc4lUYV2tumELktJAv4pRzvbDHc3m+eibD6AIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2318
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 adultscore=18 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050063
X-Proofpoint-ORIG-GUID: UGZgY2Oq14kHP0j25qtffx3DSiemboVf
X-Proofpoint-GUID: UGZgY2Oq14kHP0j25qtffx3DSiemboVf
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code returns success if the kmemdup() fails, but obviously it
should return -ENOMEM instead.

Fixes: e5a1ecc97e5f ("rsi: add firmware loading for 9116 device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/rsi/rsi_91x_hal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 99b21a2c8386..f4a26f16f00f 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -1038,8 +1038,10 @@ static int rsi_load_9116_firmware(struct rsi_hw *adapter)
 	}
 
 	ta_firmware = kmemdup(fw_entry->data, fw_entry->size, GFP_KERNEL);
-	if (!ta_firmware)
+	if (!ta_firmware) {
+		status = -ENOMEM;
 		goto fail_release_fw;
+	}
 	fw_p = ta_firmware;
 	instructions_sz = fw_entry->size;
 	rsi_dbg(INFO_ZONE, "FW Length = %d bytes\n", instructions_sz);
-- 
2.20.1

