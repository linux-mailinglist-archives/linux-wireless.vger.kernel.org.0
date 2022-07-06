Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6C567F26
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jul 2022 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiGFG6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jul 2022 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGFG6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jul 2022 02:58:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636371EEE8;
        Tue,  5 Jul 2022 23:58:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26663xAd017792;
        Wed, 6 Jul 2022 06:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=tR3jzeOMJt9anu1IGdXT541N5aQ1c8Mpot8gUs2hobg=;
 b=rI+v0cCtTKXhIXDd+jxuVYk13E3PyM1lFZRW0b71V6lipDBI4hLzeZGtitiasHkuRzox
 TROKO8s70DAbPPByAQ0cG6bNB67bG2Yd+49/aBAtGkAqqOZhKWmxXOTOd5Y5V30Wz9O8
 feKIEWNYtbgJVLVLKM5oIA/5xxxRpQK0tbliM0P1ioOjnhtR5xA8G95nLu1OICtNsT6v
 TmrfmZGimq57fgFzCvKq6dgg0SCzkxrKVWSmSBHyFk8bFM3jzP8/UhMKhUEtp5b5+svq
 opQcLGCYSEviWhy1KpD+RZNCoq4leExvrwjJyhXn1cOvYr2FJCvz/Vdsxt3lSpARE3li Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyh2hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 06:58:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2666g5QH025481;
        Wed, 6 Jul 2022 06:58:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udeah2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 06:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgCBen1X+NsBd3BACt17/CXTldZOBU1dbPL41VoZzx5El/7gMfA1YSPEJQPf4/U1vXnK9CdhCy27sxleKDiKcIWHU8p6oe8eGxk4eGb/MfFrrtfTEHE3mPRJHSR9CFV9BXcwl/nwcdCXwG+CSYDnDVChgPh+CQ7HAlRJJcu/+g76G00U994dgctQAqmg9YsjJYWnbTOvy9Vh5c6cO9x3qugmD+JNCMXINrbY98Oti0dJM3f3+YSmkbnsNJs4fgRyLv5qsspl5/waR6VPorROlUdI7REmkZM5BELr/el9rVTMH/EYiDEBJpF9LobbTlMJoK9o7rAQL8oiV6CTGYQq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR3jzeOMJt9anu1IGdXT541N5aQ1c8Mpot8gUs2hobg=;
 b=C+7G61ZZjtI2yScrkex1/zq25BBUzni+XFiplbA3moGDKOLOC9lufMTFmLzLZhIPEdzhTZXHLUum0eHE6tq98uSCgc2fMwP9qf1u6ES22dndci5TgEjcKrJY5SzvIRcEydH7bZzXXsn+VevT2bfCptxUxSie0IHM6ga5RUeSCHZ+bK3cUNrnz06Ecq1lHnRToSbnyLtFu31sTHWapN9+aKjwlV75Ejbyna2xqvzmzQLckKcgd5bVt2elcyDuXyqu/K2DMg6kVs34XlewSPcdE6GJNa6Z16LkDI+WtNle+2PmpvD58SrKEewooF0Np/6bdan0OxzfuSc87eGbxVHTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR3jzeOMJt9anu1IGdXT541N5aQ1c8Mpot8gUs2hobg=;
 b=MVDEnwIApGxndSdSHZWO/8EBE7Ukoqjsab98Rf4eRR4M+V5LNiGMXvrZpZGZd1QEpJLbxw5kwjOZYIlAXspyCnLfE2RB0RMTmkMLCNiHiD+YGffWNUd6thEapuUoYFjwcdcguFhV31SXwGRIZQzBD9cE8bjWypMBOb3CxRyM8cc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4642.namprd10.prod.outlook.com
 (2603:10b6:303:6f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 06:58:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:58:08 +0000
Date:   Wed, 6 Jul 2022 09:57:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] wil6210: debugfs: replace in wil_link_stats_write() in
 wil_link_stats_write()
Message-ID: <YsUydUx6FEz1ETq5@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsUx6tbR5jhJc/UH@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcbe0844-3f7d-4380-5ff2-08da5f1ce1fe
X-MS-TrafficTypeDiagnostic: CO1PR10MB4642:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S27EbYr6LiV6GNd8XovPuY5JKltVG3FPTfHdoRjcD2ifDH6yWFGi4nIh+Vnf0F476rfxS15IjUVKUPrkRJYt7FBuW4s709P/2lLLOxmpIt3Gdg/LLmQ138vUHQJwbyJHazpkmovVNB1Mhdgs1wpDAcsyfajyx01DPPeaipdyxYDY32si9XbRts7TaLOxBRr7zzVxbrRo+T3ZsNE4k20mMEp+ZU2ekW9t9iRo85Www6wvdm+GOV5RWRjqzYXsI+b8WQMTReZ2SEBhyYH3pgLxSlbwqP2wmIKGs3nq/ZnGPUKzJMqoNRsU7tuJBkaFeWvgFw4lBgk81OpGPUrg/Rsm3Tzh/qq4FnyOp3djhsYHY69hwNj7yqo4xL4cZLTxNPSBe6/oHEvvJd9iL3+pb3KO0QVYQ1LmM9RmKutzDU54ny4ZtPVsS2s2p2Gr0SuyHieHnbZHlZSj9/pNSIRdValr2zoQqubCgqbXyzXGG7A5ad4KjrcK1t0vFGU/KJbqiTtDiv71pCf5RlQHbvj5O41JUfBF9sWrlS/Y/JOYzKd1FD37BxILMvZBjms61z0t36kq3gIsZZjfRUrJArryyGgLv3upsEHGVNQnDvkH93qQvNfdRAlLJLsaWQMrxMc7F8sEWYa7tvFOq18eGXicx7KYenjN8w8TZ0JN490+jOkj7JG/+xEYpssPYhF5hNWp4yls826ZKxBWgLYa3QJaLPIH7dO3+yxvfXR/fVot5HgUoocTvU5wvVAH1Rg2Lbfmy/7CucB26bPR6kPthZyXTswdOBQl0LHfi3Mq6CbwcnvZKbbxT4U+TDr9uFYn3dJ1YgpQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(38350700002)(6486002)(186003)(6506007)(41300700001)(6666004)(52116002)(110136005)(2906002)(66556008)(316002)(54906003)(8936002)(5660300002)(44832011)(86362001)(6512007)(26005)(9686003)(83380400001)(66946007)(66476007)(33716001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Y20s1pD3HRollCNhG9V/2gEtnKI+X7j/bOM1r67+HurkX1POGJvzdD2D/kQ?=
 =?us-ascii?Q?USLJV8w8maC2VIr7wOpJEzmC7ZPy/idnJV6X/vPmQoiP4c1K0Zpb1WyJyZH0?=
 =?us-ascii?Q?3tXilMu6+J6rKeuH46Lh0MaWskWdrgWqlS0WRXUjP/cBSAevwoI25Q1gk1GH?=
 =?us-ascii?Q?M3HH4ygPZJVBdaAVZh+qpyBTLCWkUKSSyRd4MGYIxPb6WKwMYLEa6vraIajx?=
 =?us-ascii?Q?i4D9ukyiPoCQ4ts809AIbU7NK8mr+fvduL+q2DbU6yyvBv3qihCnoMc8vBbV?=
 =?us-ascii?Q?ij5YZg9kUm9RvC/iz5hG0Sib2rc85YvCXJ6eBOkBV49lxp0aHpwnf6U475tj?=
 =?us-ascii?Q?JienoMol6brCoLKn1VQ7FQ8Nr3LuEzqPZWeL8dd1yb1GfmAgRS5YaQAB2jKR?=
 =?us-ascii?Q?SkY/ZzUXkIPDqrx6CVFiZCuA1Zxhtdcmlol5AOI+ooJj+6LJFT/cIz2A0Gud?=
 =?us-ascii?Q?JwUzf9S0KofTZlsHRB8HKmlYFtbWoD28SUXNJwGS4r6KvmT2nCyQYHmjtrqE?=
 =?us-ascii?Q?fpXkQcP92VB1B9hsI51cWrmh7uiG1bZtoGAFztcLdJ2WT4Y/AIbvWfSbCLJr?=
 =?us-ascii?Q?dXbsCjBIwQv0CV72P4j3ee8QDK6a4LMNVVnW75GGF7hwLXXsMMytmxh0Uc8F?=
 =?us-ascii?Q?iuqUXhWnKK9L3B3CAKZGCQ9LSIYNCwLslajAE9XVj5063wtqA/32FR0fvFbG?=
 =?us-ascii?Q?Cd8Za6HpkAbteLQh4/2XYQftSGNdHfNWuA2wPxVvgXTXss1g9lYw5zI5Orlr?=
 =?us-ascii?Q?U0vOkwnsvV94/5Sz7M/GEet3yeMlFASl26vJRjMfa788NdlnbYUjB+aaZIdK?=
 =?us-ascii?Q?MApwkngiZIvjQhoMhfqtLpeRoKrhQefXwuMd73pS5DE0ERPTxWkVK8BfHET+?=
 =?us-ascii?Q?9SledW+LVVB35az6ZAA+IPKp/41+bWbdwLI0nKhw57RZ4do6qmWXuuI6Y2Oj?=
 =?us-ascii?Q?k7cpI9Xn5d9QatrfJXxgMOLnrucjMuyGcSvaZJZA/vWnnhLFhlkgX0V+liJH?=
 =?us-ascii?Q?bTZCGnpfoePSSCl4L61yUz9GMms+7ExT8KmIOu4RZU021EjJZuNHcKRkiEFs?=
 =?us-ascii?Q?Td6f3rMkJbaofBDuBl5nVkUexj5jhFKdU+FauIuHqSEJj8K6jB+4U3jlKbBs?=
 =?us-ascii?Q?o51GTfvHqn3nlTfMW86FH35YctfHU/m3m4Y/K37rmAhrHTGIr914oaGZQgpW?=
 =?us-ascii?Q?NIkNRKsqj0g2UNPCIOD77eI2eTPsl28fxy1AuKxQ/+fP9EOM9+vDXaQkL57m?=
 =?us-ascii?Q?I6GGJ9ckjZ8JRcmeuJSkGwAonZCqmrfxIR3ZKbgvKLvIMdMla98Vs+oJC8PU?=
 =?us-ascii?Q?pttXDxzt3Bj2QWpTwytJLFvdgkugwlEVxPowwQ3Nof0fqicVhzSUH47URADq?=
 =?us-ascii?Q?LItkVbM3YQCTk/qMkOpJWwagyQt3rQ39/p1tmv5+9vfCXet6gbkk/WuSz/bL?=
 =?us-ascii?Q?kW99mhj9yMn0L+ABSkbYIQltT2VqcndBr20z66pHz1RGrKsI2OtDBePXJkm0?=
 =?us-ascii?Q?+sxLs9Xv59CwOFn8NicM1WaAzUbFciYZkEPM6AiO7l8UEfUgUBM+2WWhffm6?=
 =?us-ascii?Q?rsa4zB5W6jy9JBEzOBP5SxSP7Kq4dAXDe+sSkwbcx8YRfKf8ifdLUNuzmrym?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe0844-3f7d-4380-5ff2-08da5f1ce1fe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:58:08.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIORvfkbc0qyuLdEPT/n/m8POMIwCwYFmPGUCIdNHpEOsijyZdPlZPCjUWPx1hOdqCNf7VvQrRsRZ8i8RnQlzpvSNtKMQHazGC1CyiGcwFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_03:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060025
X-Proofpoint-GUID: fjgPrhgI3g-SXbHHNOFJj2AVIR1t702i
X-Proofpoint-ORIG-GUID: fjgPrhgI3g-SXbHHNOFJj2AVIR1t702i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code has a check for "if (rc != len) {" so it will fail if the
simple_write_to_buffer() does not completely fill the buffer.  In
particular it will fail if "*ppos != 0". Although this code works, it is
more complicated than necessary.  Just use strndup_user() instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/wil6210/debugfs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index fe84362718de..591ba7f61c64 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1937,18 +1937,15 @@ static ssize_t wil_link_stats_write(struct file *file, const char __user *buf,
 	struct wil6210_priv *wil = s->private;
 	int cid, interval, rc, i;
 	struct wil6210_vif *vif;
-	char *kbuf = kmalloc(len + 1, GFP_KERNEL);
+	char *kbuf;
 
-	if (!kbuf)
-		return -ENOMEM;
+	if (*ppos != 0)
+		return -EINVAL;
 
-	rc = simple_write_to_buffer(kbuf, len, ppos, buf, len);
-	if (rc != len) {
-		kfree(kbuf);
-		return rc >= 0 ? -EIO : rc;
-	}
+	kbuf = strndup_user(buf, len + 1);
+	if (IS_ERR(kbuf))
+		return -ENOMEM;
 
-	kbuf[len] = '\0';
 	/* specify cid (use -1 for all cids) and snapshot interval in ms */
 	rc = sscanf(kbuf, "%d %d", &cid, &interval);
 	kfree(kbuf);
-- 
2.35.1

