Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FF3E9F2D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Aug 2021 09:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhHLHFV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Aug 2021 03:05:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34286 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230147AbhHLHFU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Aug 2021 03:05:20 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C721E5020347;
        Thu, 12 Aug 2021 07:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=TZ5DSYzh8zYRrliwcZqORlQ6v/S2ORhsa/Gx7YJhXNA=;
 b=RHbDuIYgFPhNGWzfZ+3J6akk0bnc+uz6+ZwPafP0eVGtdub3q9iwCULgZMgNoGpMzTg6
 tFesrVDMWFjblMbvybJAZHsULGYdBtXj7h0VvuipJflaBkJikJGAryqT4ScMB3MZQyz6
 2QAuiOYc8A+W9po9MYxQIIKEo608bs1iIkxUjEnwbUAgDyXamTe3ZAxlvAA4mIiAyyfa
 JSReWDq7tZ9svGrKX1gdPY4MXknQVdm9Bj04g1tVokLUz1iIq24XZTbheNyqsI9OWfzO
 xMF3eU8/Fpn8/jKX4/c/Pifh98C6FVsGnkp/ogeKQJ+sZxmGe7JVfJ6p1s34Zu1osTrc QQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=TZ5DSYzh8zYRrliwcZqORlQ6v/S2ORhsa/Gx7YJhXNA=;
 b=PnJsNmdaZ+Tr80Kq6ndh+nMrJ8c/mlaT3GDOJV65Aq2YvSzCP+O9gak87zBU28K6DqPf
 sCPf9PTznMGgq6DGC3J514M1bU8QCfVkfSK0+V73PPUg2ffnSWfv/byzfHEgpnEcfl9f
 mc3wHenyPLqxedpCKAWL0XwAm2uX6WCekWsXB+2Zzf043HcAMdQ+JHp2lckxtL/UtkPT
 swD0JcEZwypGhrGnW5mupQtFCq29JQKXWv9YgYPKHD9uqf7bD/03Bf9RT0xgujy48Y50
 kR7F7V8dovRcCVsAYZO57pxY4pMzBiABvJvYTOgojB9sZ6OLJF1qhQLlq8r/066lW/5r 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqgv44q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 07:04:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C70fdJ167466;
        Thu, 12 Aug 2021 07:04:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3abx3xapgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 07:04:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsnDX2ld293knjZqyLTRUQ7edTV8n1W0DD91Bzj4BqiZA/KNpBnJpqIWeKiuG0yffI7GP9VKWZ4WHNA64pV07XpP4O08l2j3eTIdy+H3+9sLKdXrR+BhALpgh4NFfKrn6BOmQZheDjzL3dzcObyB9y8rCtKOj8GZhA7tYTN2iWCwy0j16DtKGbDbmFDBItY+THMRLXmFRIxqPdBiFE0EtmqKMv1AlDw+GJyTG3rQRqHXe/xEynt8GUSJw14jUIKQbJ828qusqx+BOJB16ap5BlMJPJNIAX3R9e4WUZSpuoIh5uT4CZQ5YoEo3R5ew5DTTP51oLJHaDjMUep5JMsisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ5DSYzh8zYRrliwcZqORlQ6v/S2ORhsa/Gx7YJhXNA=;
 b=llq9j9gtLilReYTbDWyy/fpf4hcuWAicESYEgWecHt6QjT/HDp9z45OQgurLbJoebBom1eZuieWZxu9FkINUFiWmv9JcEyaktckmAKoK13HNwI+C8tVfwMysGkwU4bmlrgRwrJQisVmm0C4Z46Sc9BgES0262s5+0UCZn1KfLO0Wev5tOYZwiQo9jI14yfwGN5uypEy41DEeqSqotncWUXiUamPMgbZM4W+BDZKXyRmA/zwSpVOjRZSrRarXUpKrPeyj2S7ggeUCJr2CgYHAkO1slExsQtVgucUhOI+n3QkErk8fruGd1ZDhdh+88XIcVOz60fxU6FfBLORUORs/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ5DSYzh8zYRrliwcZqORlQ6v/S2ORhsa/Gx7YJhXNA=;
 b=zq/yYuFCHS4SAkDaG2U8wWiSolDEOb8BOOkl9AaeatZb1vUgMwHW8KRJa3Pkim/UkN98NAqIm11j0OWfO8lakHag+vAEGRZRX3jnANfxOsZpmT23s9VJez5xobj9j7FxD5B58dpwCKXJbEgnAHL3nxW80FpG5tm0CbJwNrhv4go=
Authentication-Results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1488.namprd10.prod.outlook.com
 (2603:10b6:300:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 07:04:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 07:04:45 +0000
Date:   Thu, 12 Aug 2021 10:04:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ath11k: fix some sleeping in atomic bugs
Message-ID: <20210812070434.GE31863@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 07:04:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90928358-b9b8-42b7-e6f1-08d95d5f7773
X-MS-TrafficTypeDiagnostic: MWHPR10MB1488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB14887A733FE1E32A1318E7DF8EF99@MWHPR10MB1488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrsUsJPlRLa7ZWTnFVIcL8gxemtHOZsVU9miii1dW4li+EtpHz26c0w39D4wK8Di4T/pIf+pw7wNY88bccyZI4GH6iUXZRqe4B4HILZ6uFUX8/FGOSNWP1dpq7R7nJpqRHnKr/ku0HAjg16UFBUfePhtnkO9ZQDI7cALQmwh/ZE4sPLiNDHJ4eva+PhVBuRKuKqasHwkhSCTEeYS2/r6K8vZkFyqrDZzVG+0Ov1JXLId87wZSapSHidG59wNsQQkavVTDhBD+mg92qOZHHjE1Zugx1ya+GED5sjoHKJZEJkIPS/PbRqMDlTsQyPYAHCjZndEgl9HQmOFvgBOUOOHk1EH3N5txiXPtbJU/fJRJGZWyXfI/DiL5Urm8NabrRDuPSXdSYsLy1BOMGPnSuIsWk7aolCpa/hXo1mhe4Xu++4uPxV2egOJkaHrOJXIYGpIJYB6TJl7oaIJz++by2tiElQdBu244n1SbHfB719+1Ih6WIPgFdAYuwvS9wzW3hud7jWB/3I9mwwhsVqCZ6MMUZMri97tEgNRzmLe6oE/wEIg5SElrdYuSNdEj2r0Gt23vZHQK0kVWAF5gasZdx3YEXJIZ4sXxw4xuI7mB4pJEPTp89z77+/HfeOyqqzjrd0CyP5J2rFj8mT/8PgRW6y9v0lyvqan06Q52dVnZimFEAPhQIgpywrHvUDlmi4gwmLlWG6YHd52xI1qMci5souZbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(4326008)(52116002)(9576002)(86362001)(33716001)(316002)(6666004)(33656002)(6496006)(8676002)(26005)(8936002)(110136005)(66476007)(38350700002)(66556008)(66946007)(38100700002)(478600001)(186003)(9686003)(1076003)(44832011)(956004)(55016002)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T1GBDiNvrGzLEWEFo77NbB05FDvAaK0d5QSZDCv5tOqHoo+vnvDXyoE83B/P?=
 =?us-ascii?Q?MLrbX/6tPKkY6catsjE0Y1OO7invN4bbfTE0xZCkyIFzW3q3zaljs5O65ztk?=
 =?us-ascii?Q?5YGt04ki5SOT2xmAV99fAY0XA0ib0egEUY3QNDweQrjiIVTQnoo9eurGUA7P?=
 =?us-ascii?Q?tfjy1Iw8u0AtnEnmkkQ9K/hgMt0YDxXDPW0L2iMJ69VPewd/LcZdnMPT3D22?=
 =?us-ascii?Q?oJNaCc1p6dyxgyIpj2qL9KiJDqc2RXtDOMUW9u7YD1ZIJGqMzS4qRb+2TSuC?=
 =?us-ascii?Q?QQZvO6slK4xe+wtWjj11BMOa3V/m+uq71VXqfk6uZJpt5g3QC739NTNANkAd?=
 =?us-ascii?Q?SaQnrCZ+TeW1on0t/UayR1Qiedo0n5p+1mt0w+1XdpIXXGd4fo+uIcl+z00/?=
 =?us-ascii?Q?PyTMF0pSzykJsPLN67zLEDYUyyNy81Psu2rVBoiDm4q36XTkrwNEHwFX54bl?=
 =?us-ascii?Q?JgdR/tGGn51oF7XeYxZPj4FqoE5XD/ORXstR5/SFirA5Qe8wgWps7/gYYwaE?=
 =?us-ascii?Q?XS/EshGY0f8dnzKmvPthovvE1MJrS+ipsrjR8t0KNqac2dD1pkf4Bh3sY+8g?=
 =?us-ascii?Q?whG1J5roi1h7BTeA77CgUXQfV0TWk1nPtdC26qAchP51xFEsuyNbWKENP/bO?=
 =?us-ascii?Q?UYGvmrLKnQ3LeQwP5kjseDbaca0x5KMtilB34JdHWQQQ0ylnOVV3zUGGHJyN?=
 =?us-ascii?Q?6vrjMPXs4K4bOhYJks6voTejhEltY+X0eH5+GthV2gPzG+DCwbHmoOUhK7j6?=
 =?us-ascii?Q?zJ+u4ti7eugd7dE+dA4vGTnRiRkIF8C3RJKKbmQ2y4rUHtGaLx7F3eRkCtxa?=
 =?us-ascii?Q?9cz28GKcU2XVS/d552GWWlzf4rIrdW6cmgFDKcQJjxa1fnYbUHfipVDShoQx?=
 =?us-ascii?Q?e+STwtLKdozqt+G5x8jJp69RuGwX6MPJ/TRFhXRmT3ej42DwP6+Iws0bmsL5?=
 =?us-ascii?Q?Ez34e0muqzdDkvlUULzM29v7HKWuR2LSc4KNVwBZly7etfZQgCHwuBL6lPSn?=
 =?us-ascii?Q?2wVqJXgcJvyOihwiAplkOU3GVTQAPtwlu85ZU8IUwQ1XszIpw2y/XMmlUi+0?=
 =?us-ascii?Q?fa4yEUkAmNsJobDLQIGk1z80TvVZKMSdHieV43hlXdu0oplrk5sZ8r8Sa6RU?=
 =?us-ascii?Q?z4YUySU5njkWQxYWI9RXfYM+p4v3I9Osh0SMLhnlslYR6H+Hwdka7j0tt/pg?=
 =?us-ascii?Q?C1XAA3Sx0xEv9d3iF3dFnTLZ3VnUZS357bET/Nnb65f5AbV/d3K3R36AXZq/?=
 =?us-ascii?Q?4UcWBVxrKvONINN+O7aAecfdb4fu9td1yT1z1m5u3DdTkDoTds2ujyiacrVx?=
 =?us-ascii?Q?gdJnUGc8JCFzEXRnE4Qn2izK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90928358-b9b8-42b7-e6f1-08d95d5f7773
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 07:04:45.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXDAtWVavdg+7bXvINmhTWl0MekKfA6Pkj4fky+v6hRCb3wW+Uearqwq0O2MSQMDlWyKEZNxC8NYvmHh8JaW+T1CVLRHKWwSjnobNsUbDa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1488
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108120045
X-Proofpoint-ORIG-GUID: KOmZNDPfb7AByaS-GKAq6xCduIrgqIyP
X-Proofpoint-GUID: KOmZNDPfb7AByaS-GKAq6xCduIrgqIyP
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ath11k_dbring_bufs_replenish() and ath11k_dbring_fill_bufs()
take a "gfp" parameter but they since they take spinlocks, the
allocations they do have to be atomic.  This causes a bug because
ath11k_dbring_buf_setup passes GFP_KERNEL for the gfp flags.

The fix is to use GFP_ATOMIC and remove the unused parameters.

Fixes: bd6478559e27 ("ath11k: Add direct buffer ring support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/dbring.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 5e1f5437b418..fd98ba5b1130 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -8,8 +8,7 @@
 
 static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 					struct ath11k_dbring *ring,
-					struct ath11k_dbring_element *buff,
-					gfp_t gfp)
+					struct ath11k_dbring_element *buff)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_srng *srng;
@@ -35,7 +34,7 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 		goto err;
 
 	spin_lock_bh(&ring->idr_lock);
-	buf_id = idr_alloc(&ring->bufs_idr, buff, 0, ring->bufs_max, gfp);
+	buf_id = idr_alloc(&ring->bufs_idr, buff, 0, ring->bufs_max, GFP_ATOMIC);
 	spin_unlock_bh(&ring->idr_lock);
 	if (buf_id < 0) {
 		ret = -ENOBUFS;
@@ -72,8 +71,7 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 }
 
 static int ath11k_dbring_fill_bufs(struct ath11k *ar,
-				   struct ath11k_dbring *ring,
-				   gfp_t gfp)
+				   struct ath11k_dbring *ring)
 {
 	struct ath11k_dbring_element *buff;
 	struct hal_srng *srng;
@@ -92,11 +90,11 @@ static int ath11k_dbring_fill_bufs(struct ath11k *ar,
 	size = sizeof(*buff) + ring->buf_sz + align - 1;
 
 	while (num_remain > 0) {
-		buff = kzalloc(size, gfp);
+		buff = kzalloc(size, GFP_ATOMIC);
 		if (!buff)
 			break;
 
-		ret = ath11k_dbring_bufs_replenish(ar, ring, buff, gfp);
+		ret = ath11k_dbring_bufs_replenish(ar, ring, buff);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to replenish db ring num_remain %d req_ent %d\n",
 				    num_remain, req_entries);
@@ -176,7 +174,7 @@ int ath11k_dbring_buf_setup(struct ath11k *ar,
 	ring->hp_addr = ath11k_hal_srng_get_hp_addr(ar->ab, srng);
 	ring->tp_addr = ath11k_hal_srng_get_tp_addr(ar->ab, srng);
 
-	ret = ath11k_dbring_fill_bufs(ar, ring, GFP_KERNEL);
+	ret = ath11k_dbring_fill_bufs(ar, ring);
 
 	return ret;
 }
@@ -322,7 +320,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 		}
 
 		memset(buff, 0, size);
-		ath11k_dbring_bufs_replenish(ar, ring, buff, GFP_ATOMIC);
+		ath11k_dbring_bufs_replenish(ar, ring, buff);
 	}
 
 	spin_unlock_bh(&srng->lock);
-- 
2.20.1

