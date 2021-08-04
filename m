Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0533DFCBC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhHDIYc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 04:24:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49362 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236279AbhHDIYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 04:24:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17487IBo019158;
        Wed, 4 Aug 2021 08:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sy+RXmyLfTEheKcz+GLPm9041PaEeUAKmmue9wq7K7M=;
 b=f6AfENfeLjJUBweydqfptGkNIaxT7ZbmV9F7pMjomhxpV/9K5PX6YDz8NI8KmotUFUDc
 S2MUPa0I7EXX6Vxf2qJ3TWtfdqYoZUWvXDfVNz9KFDAc7Ji19Cfd+dcHI6bGQa8QgbSM
 5qSieMEYEdfDDIJNU3hJ80Dt7vxoP2/xeASqMjVKRHC4zoMjJ2a+y5gLBQxSPoEoHi7J
 E9CHeHRCXQZM66zSrRIE+l14+FrMstpQexqEmSiZwkVo++sLSVMhYaSTdqwP3Bq9jYgj
 AOualKsxEWYhsONWOBpwomdmLMM8FbYk5zy9Bi+muCSUM8tryRSt84DhUTH6bfgcLpGf gQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=sy+RXmyLfTEheKcz+GLPm9041PaEeUAKmmue9wq7K7M=;
 b=Nj0Q41etFdhnicjNH8XwLmjvXf5mHm517E10HWeL7+RkOYJ9V4stwfNpILwwm4v/kwfT
 JjnGJrSBr7PG1pCSdtSUwAdE6/yfYy7Te8HwwDQMa/Q7Gphd40Ki4+x6A+Ay0DA52nrC
 LgUcicmatjQ5Q47A1kp6FW0sn0GmWOFi6OSWbW5rYEQwa3aYQoa94yiEuWDywW6Ujw16
 W3O62aNJDZkCWSjO0K8t4CZxZEx8TQQVgz9UKjN67U02SQhV7hEbZb79nZxtp1J9v48i
 OCLI08aREdhg4JO3FvSnUO5Ru0+x1i/PFkLwj3EOHpR1AljSlSf5vfpE5lXd93o4ybYL FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7cxn1036-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 08:24:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17485XDN005871;
        Wed, 4 Aug 2021 08:24:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3a4un18xw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 08:24:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml3Gn8z7xHFnPDh5D5pa/b6JpwHtMGH4JkVD/iq4uc7e1nmBZ8HXcAuG9sNfJ8hkwk1rTZ+X3fBpqdzGd7EXgC/MEY7kJRVSeGyndbJdWpdgVMIsP5Fgjs4nSsTps8kGtQSEl4PpCYmmx4nyFWbpeJ6mWYB9ZCi+tvRu1BC2U5y3CEf55V5YQTuoYIgV0QO1k4nFq7wKVCqK1bsk0ahfCxU8HeVBioxKNVZjb9AJAyzS9+Y0BeZg6JG/rxEdHFLZwr5/YUdUZ5pXsFPA+7DRWDdTVsjVsWPb42UCHjLZrjONNvl7x0L9GJocDTmEKHrKQWCMBMyLEwcWM+vyrAb9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy+RXmyLfTEheKcz+GLPm9041PaEeUAKmmue9wq7K7M=;
 b=gDbOh397Kr631V154aeR6Vshl21Wk+8L0wQMXvbn+navGGXRewoKavIWhvC+z9yFbXenZR9rCOzzR3HTFGB0EX3OrSuMVlvOVFXyZb6ScMAm0YDiqHFzh1dR4eccg+VoYLs8C1EReSw6e+/M3XIQyJWhv1rmbNBmh1w+om7+pk5rEhFeroSPCr1ta1BO0D1kDVwqLZm6BfrW9NyXxPpe62NjE5V4+dwF7tHdzsKP4JivMErxmXC0HXVdvRK03VRN66e0OFnuCGZ1aOgXRjs2igk9obOUwrU8QtaRuRzHL2bj8zRrFGp7J+HKe8agpsDVNhgd9BvG6uqfHJzJyM9mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy+RXmyLfTEheKcz+GLPm9041PaEeUAKmmue9wq7K7M=;
 b=mKfym4AWbKa0Mi3NUGz3IS7q+Xadyjl7jw7qV2MeveiAJ2zsLTUt7rs8oahmhhN2GwhBg1dyRmN7OiKpm8jU6GUPuZwUnIpC++EVd2s5pKaj5zUWKhZ+pN9KcBQMV2u9GoQWtHyAWLHn2lTNDAeVW85t21liK7Hs+mPZhMySXzM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5412.namprd10.prod.outlook.com
 (2603:10b6:303:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 08:24:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 08:24:03 +0000
Date:   Wed, 4 Aug 2021 11:23:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
Subject: [PATCH] brcmfmac: uninitialized variable in brcmf_fw_get_firmwares()
Message-ID: <20210804082348.GA32730@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Wed, 4 Aug 2021 08:23:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5a0501-1b8b-44e2-4fbc-08d9572137f7
X-MS-TrafficTypeDiagnostic: CO6PR10MB5412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5412A849AF8C3F0CB2A36AAF8EF19@CO6PR10MB5412.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXTstLZDlEwMj/YRIfNRi7GUwiGXkkZ9jk52qZ0svH9RQoH+hdKaLkYGJKmaU92tFAmCP6x8+hQWqsUFkrgNUVioT+Y9RsAY0jMTl19P1M+2cuwsDSrPxP7SXWMxdyfPY2CSz43rZhXQPMPoUj5s/snZIDihwhVo4ZDju8mchESN82xwpQFeh8Qbje+gluKQMG8rgK8BaSwxThxo4wumSQBYfTyGL8pIED269V2+jB9Kzep8ty6eA+3Mt7sRF39SIK3jEhgn7jVKW4wd3KY5ngt/z2fosjVJ6K8+ypdoe3PQgT/Yj4Dt2344sqBU31KZZo0ysYv02CzhsjmphoCzJzFXlVXihnESdjEuJxZFrBY1q/tzNNHAnevoN7wCRVP+VSgyUPerHEiqIq2vUk0bxFj0xi/jay12zAgGG84ZcM1XPpSFEtkycD6SXI3hCG+YGKSpe5J60arooB+25+AcQAnSimiZR9++LxlCqCVRefgTMNLcYy0t6+8IEtZMCdvB41ZAi2/VE2QhQwKKAypkvqzHKSWIxsPof+J1AkEgJBg5+//yraGvxN/0JMwGLvuGOoF6XsxJtHdJns/WJTP7MOJDYZA1uIJa7juf3enlR4oLyWP6oqe2JbwTgpqOil4qaBg94LigAC0FjEAjAQ27FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(86362001)(8676002)(8936002)(4326008)(6666004)(33656002)(9576002)(83380400001)(55016002)(5660300002)(54906003)(478600001)(44832011)(7416002)(9686003)(52116002)(316002)(1076003)(38100700002)(33716001)(4744005)(2906002)(6916009)(66476007)(6496006)(186003)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LMbn/bwYs/skSfIx/NZJRXYuDaGwWB7psQHNAFl+mYpLDZMj7YG2w9jZzj7/?=
 =?us-ascii?Q?SH+tlbP2cC4N2UeqZ5VqevFdFI/v/5SKNOaLe4Vx/L7GA632fWqxuZaKxh+6?=
 =?us-ascii?Q?sUFuFm1E3o2jZwROOrstvE2R3AxHiJtlkzdkb30zgfcDWXj/dDg1C/Pf3cyT?=
 =?us-ascii?Q?SSiVC6rfmBVe9FHWwc7gbgPkmMKIe37u+8fm1fSd3pdvX7GAEiI3ikXrXiMg?=
 =?us-ascii?Q?zv8lmHasmVrTpMhGtyN9vLcr/H35oj1jNam85gOUqZxzgYDc0LNk+rVC8vBE?=
 =?us-ascii?Q?o8tWwHHSFegswsk8DWcj64lWX+zRzV5z19VEKURAnyFbMqLQsLBDWOuOQTpG?=
 =?us-ascii?Q?2cNtmvIsE94Y4FI7g4Oyvg+ufEovL5bxlbH2KzRSsQcrXwLmVv3PAv67ifIq?=
 =?us-ascii?Q?WJEt2lNzusTtjL/EvHUabsUYfbUTzkdDiSADbCy68t+xUCGYrcqcJGof01CG?=
 =?us-ascii?Q?uZqXGz/ysE5biwIYybV6t5lXp74Zt9NgUJokH3PJoCCXKXSLVer5W4BaKLS0?=
 =?us-ascii?Q?HHOUtjCDs0+HfgWJJfgZai7yhihFUKSRJYBQbo4uBhGerjPNKzOATvJ4zmkB?=
 =?us-ascii?Q?H/1D9A+fz3YnGFv2nLymLUyFjPqqjfTYKg8urUgZKHElnEq2PNkMOo5OqoH6?=
 =?us-ascii?Q?Nk2fq5sDSuG2HfKYdXyQzu5dwE7Cl1yKnG/II9gyjZE97xlborAgelXYvaSi?=
 =?us-ascii?Q?a2bg8t6wrhHejc57kPJLoVsmEUtNV8iyyLVN97H9/y+d4OZ2UHMFD3K+10xX?=
 =?us-ascii?Q?n1CC8fCbw5my1NJd5Hopjef/43chis5YlBeZitKLV0xrwQpIS4zwm44Mg5Yy?=
 =?us-ascii?Q?zm5nE1JS3o2NZkgPIwVzUGSinwWSXKFrQFeae0CCwInSaHtChmrHqpJMtKNt?=
 =?us-ascii?Q?5t8P5B5U6zR1EYSXhDymmSortrBrTReMd6pcmwd0C8chcs2Sp0gk2afMg6PZ?=
 =?us-ascii?Q?AGwdhYtysxoJRDsd1TgKPUrbVWs1vsEfBGVobF5NAqHJwmPomUVaGV5LG9II?=
 =?us-ascii?Q?j5bGeuzX8duesRAtZJrHdkBR645qTCSCH1FJbS/7zvcg1EmHTPSUjUR8mHIg?=
 =?us-ascii?Q?UkcndSoY37UmK7wwtDDDX4RrT9+fKI3/Lo/X/xZsxA9IuT1zzRaJpLc0njY4?=
 =?us-ascii?Q?qgJO8ncT8qMn/qWNk5VoLs9jtp68x3SXARo6XbAKhQ6meUM7xMtH92AZeXlS?=
 =?us-ascii?Q?JBif5h1WZBGi1gAKQux3y1e0ikV+E7/iOqMJlDpTMgOexrepWcJ2gVt+vETI?=
 =?us-ascii?Q?qOjRE3EmXloFr3Ie7Umu8Tnd1xlYDyqkIG5jlTlcAPHxJ3aWdTc/APmeu7qp?=
 =?us-ascii?Q?oXJS59pzx6zZyjxuk/ACFK+E92xKo3SnoH2gj7cWUslAgS3abTrPBz/VNG6i?=
 =?us-ascii?Q?oMz9bkY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5a0501-1b8b-44e2-4fbc-08d9572137f7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 08:24:03.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckqPVldifmhQjyt8aZCL/VRSqYC80GSSvmO/J/l0n8qan5T8JjRQ2ziKhoYpI3S9fo8HeXWHBNf6EyGZNE7q8nRISZCf5izFz/qZm8F/AEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5412
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040041
X-Proofpoint-GUID: -kWrT9O1P3JnDF5NyinvmzftZUHwP3q1
X-Proofpoint-ORIG-GUID: -kWrT9O1P3JnDF5NyinvmzftZUHwP3q1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "ret" variable is used without being initialized when "alt_path" is
false.

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index adfdfc654b10..4f387e868120 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -680,7 +680,7 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	struct brcmf_fw_item *first = &req->items[0];
 	struct brcmf_fw *fwctx;
 	char *alt_path;
-	int ret;
+	int ret = 0;
 
 	brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
 	if (!fw_cb)
-- 
2.20.1

