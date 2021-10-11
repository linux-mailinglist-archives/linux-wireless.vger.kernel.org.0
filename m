Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BBB428D23
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhJKMhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 08:37:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37128 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234738AbhJKMhu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 08:37:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BCTrXG015271;
        Mon, 11 Oct 2021 12:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=IeNTmpOfmBolGWW0HHJx8XVpZT1TQtPO21lVUvgt8Zs=;
 b=RKtNmWVGvwKuYuSSIEmLyHQ+be9oy5UU4g55xvdM9XnvOa38kacFyaog6MnmrGuR0wRR
 ZAPCpy/pzPLm9yzGigPlM802IRWi2EFtZNzqsHc6iAeKkivCAYUBRMDRj46JibYOpeE7
 38YezeceRfwg1GqtKZkSQ7CsT5LwyaTMGdJUhUq9cusgLaON8ZdyAybBtW3qNrT9W3nE
 0fk2sso4+SAX8u9E00cpNwI1RVXg7TdIJS5cB3oMmmkg8q9QuDsD4UWcIaDPshHQKtCr
 vvjejxoMRtXP7GC+7A5VKM0ezz1ZV3+FQq9pUgU9HOHfiRX8EbnrHub+Dk/fEoPefS4f zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkwxh3w1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:35:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BCVKV6006678;
        Mon, 11 Oct 2021 12:35:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3020.oracle.com with ESMTP id 3bkyv861qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKTShy0ZZxa5jtDEIyjn/tmPYc7kWJFpJ9kyxmh0halwdQnf1eCEPxTPO/Po1G4T2eg0b6Bul52R592r+NQVR8Mj+2cI0Tt78UiY6UoHdFIT4nelwnjwIAHDmTh2o4TRqbOWKfx9MJDw09H0zOnLyIpm5UWu4e3aFBCpFcOpvOC8sCk62uQB3EKzSwKkSpqOpraa/mCeFPcTUU/l4S8yuFQZHJZJok0jr2PgvA56IYxqnp3c/EBd4awDnRtmGjSW//PUqLCiwrYTidT3oY0ArXcLL6G1HClSvvooI+JRz8opbz2XYlONUR5grGU4nAwWl2QW8uZs3Xb1vKyvCHOQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeNTmpOfmBolGWW0HHJx8XVpZT1TQtPO21lVUvgt8Zs=;
 b=A2SFZiu8PhPscP4rhDR0XO4zBpNmGuEFyi/ESk2hIJ7WcGhcgrK32w61hRNeeTcv3k5CFSUsdieuzHrXpqeFDb7TM++P66m7DFChY4MbPbGX4YSLsrO6n1rx6GnnbVpsiS+HzQJ6VuUR1tJP/tGm7kBmOxEF2OT3pnjPW80MYM40qtoQX2uX2wO3+oBPeUy6csI/ezN8PJWEX9FEYATcVbp57C+/qx+65M4elMT+roE2cMzBYjIq7YN18iKlL4LpBNEHNaMZyJj2UQp9TN5E+pUOBsyyUAPBPTVX4IjolY5ACYYlEmgegaIwU+a8MXtP5vBIVtTNmgECmTQhRZo/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeNTmpOfmBolGWW0HHJx8XVpZT1TQtPO21lVUvgt8Zs=;
 b=eTIoiSjmTvDweJq2PoULlMqodaLyPycnlCnQMzoNCnIpUJPxKt8/33eugNT4Uq5iOIyFUrr7oKjLrdmEwZdGCnUWHgiulMMg8VS8oj4dkBY57/zPuGYVu2LPu1L4ChK6b3aamizeZI5EXMvV2+AJe5qx8+Bks+xT9JX0uBE8P4M=
Authentication-Results: qca.qualcomm.com; dkim=none (message not signed)
 header.d=none;qca.qualcomm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1822.namprd10.prod.outlook.com
 (2603:10b6:300:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 12:35:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:35:44 +0000
Date:   Mon, 11 Oct 2021 15:35:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ath9k-devel@qca.qualcomm.com,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ath9k: fix an IS_ERR() vs NULL check
Message-ID: <20211011123533.GA15188@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.26 via Frontend Transport; Mon, 11 Oct 2021 12:35:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61315ca-baf4-4150-a1de-08d98cb3a49c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18228C60619BCAFD3993A5038EB59@MWHPR10MB1822.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /48s3NZack/BOM1I14TrHlprom076BieHMBzT/37z8iFBvS6DVO71SA4+/BDYsLsSUIDHPPHhki1pKQCbWz0ybBYLnmjJZ/kUldJhMnhnVuwc9vl9MDALI7534zan+8xVq0f/vPOUd7x7qN91a+X4RGsqIJeLgX34NdoYSeApytcR78VvZWu/Nj9xP1ZGXwiz64Q1D7qOgQ867GgWyeu++7Icg8ivmIGwc6A8R4umEWRmby3SdtTfL0HSZVE5UwucVrZqeCPVIyUZeP3WKP6VKcDEqCtBvyVNhQUFldxwfRaZqy5tj/xRb4FTwE/9v2ou0BvD5vHl5UCKSYO7tjHVgH2teE6US3X+nZ6hgDMjv2nYkTjQPbLzbYUVHhQRf6KvTBgny64QXM6nqrTc9SImdCyPbxUdDvMTsnDCbEULtLgtchpEc2DZp7JsMTrEcU/XQGErkSEkXWpPj3XxjYx2AN93DJNbmjpvFU8gLfP4Zmi29se15QU00DtCGPUoFHJ9PGkkMkmy97oFCUc2ZJOPcrP97jzXEmBMRGR1uMbEO1vTts8Ep+1aLj/QVToX5Cw12C9BQnw9XuaC55MLvhhHA4yuHzP9q/AOSm5geE9Bh0s1O1pyXibj3oS0yECmgaUaJg1Rry/N0QSJJrRDrXVHmWHIrAjbVPPKcW0fVMupZj2V3BbQFekjgZGZkOJYhfVf+wzc9UhZss40El5UkKiIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(9576002)(186003)(9686003)(55016002)(44832011)(83380400001)(4326008)(26005)(33716001)(5660300002)(33656002)(38350700002)(316002)(508600001)(66476007)(2906002)(66556008)(66946007)(1076003)(38100700002)(52116002)(4744005)(956004)(86362001)(8676002)(6496006)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3U/qXNtFMbayOOoQlZkee+iIi/S9psDVQxvR2JjB5CctSiwFYO9xOMUYHVt?=
 =?us-ascii?Q?FI6C1JqyjWc9cgS4SbteQQsttmHzoS0D4uYtDTkZPZ/pk8VM9Wi6V0OEY5kV?=
 =?us-ascii?Q?DeaZw4CXmIFN7l6L0T8YAmV3EZ+j7+xzfZ6DQFK840PIFwCLdQrnHH7UuF6m?=
 =?us-ascii?Q?+aWWxZ/HzmqXybpTIvWKZeJa1+lyyk9v6XFAnh3B4/ye1gI3v6j/ubyZiXxg?=
 =?us-ascii?Q?q7sSuhCchz7rTzUvVO35sVUfdyjNr8oxov2AhpVP7yrkNQaI7uEsmifJpMaU?=
 =?us-ascii?Q?LNAtNVe2cToh1vfalLkRSeI1DPUQxkpi7p/E+FVyfj57uB4HwEq96qMSuNDN?=
 =?us-ascii?Q?0nSaSSYSoQcD9ZyELGxU7j4pDOG2iDqOulzYOlKOd5pQW0SSviL2iUg4X9zu?=
 =?us-ascii?Q?DMJC5o7XtGuI+wxK5qxHpo1016aH0V9RUR8LMW1RvHMNgO16kSZcHwi57fBh?=
 =?us-ascii?Q?GNIFv2dLkps9c4wDcNwFS26hiDuUj8DiFYbZRns4y8V8TZ5M+Q3ooRxHrkAc?=
 =?us-ascii?Q?NHmCJuTZ2zQelWrPXqEb8OGRKErbBp/28n2K9tmot68XAvhA45/zRPmIWLG8?=
 =?us-ascii?Q?CspI7eNmHBdHK0lMixCQS/a6PoNHWx2DTp1SSX4UDKhcOA93hm+EX34QxtIX?=
 =?us-ascii?Q?GDLxTM2RLO8RIk9HPsaks6LEl+e5xfSFKxvEp+M5DUveVIT48sj9o1lzkAXv?=
 =?us-ascii?Q?pDUkQScNf7KfROlTWjP49quZZW8YIkn6qPzZ/kSz26NJOUFpTywTr7Q9EA1R?=
 =?us-ascii?Q?mfnsAactO8lh8X0VCf4XU9JbkVIR2YvKNIen5uQ6F4836WQIYixxr+7K3ljb?=
 =?us-ascii?Q?aq+PXRT/CETtfkmZjpiC3RtAsbE65+jNJ8WkxuySnc+WLrDWzg6U0WcNIqAh?=
 =?us-ascii?Q?Gk5lNEXBCtGljS2Ty9LaZO9PTJx/8gul/jrNYCTgJ36lQJOkkmePkxAMpZ3G?=
 =?us-ascii?Q?RCThQeOj94lKnfwVX160qnwRKrp/WnzT6kXYMhVSD+b6j76RqzBvBqVXB9OS?=
 =?us-ascii?Q?8US5hIue83LVWhwZnsaweK9/yXTwaDrK4IZa2Iz35ndrYpATeMMXB7A3bqB8?=
 =?us-ascii?Q?yTBdj2yGXfN/edO193mGBS0UvIUf7EyrZeDOIeX2TnbzkIvG5BVBsovRPaYx?=
 =?us-ascii?Q?EEh0z4WpKbdASaBobwLT6+OG7NHpKQlTooCMP8bBmPNkjtoMdDcFIZRxHMJu?=
 =?us-ascii?Q?kOFnbbIjgydCrBlcEoiioW9ZI94FSaVfkLlF6ffGNI+lmVUn12VbpHz4/h+G?=
 =?us-ascii?Q?LyDd4tSFfI32bQagC0gJ75frbbq3VkuyOPu4/EcGvgoI28xZs3lTwndIF0x7?=
 =?us-ascii?Q?2LDCKFdQHy/d+Ng6zreo0Hz7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61315ca-baf4-4150-a1de-08d98cb3a49c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:35:43.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MY9XANBD8b4pDJ3L3RE+bVAFd8NRUiSs4Uk6TMAMP5WbmOC8ykOuFap7Xxp6YJsXuTtoYwTA9J1Adx/vSXlFYiu9GujWn2ghbu3D1yQxLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1822
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110072
X-Proofpoint-ORIG-GUID: EvF5ptNrHK-R9ECtylQgA6dhpgni0X0h
X-Proofpoint-GUID: EvF5ptNrHK-R9ECtylQgA6dhpgni0X0h
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The devm_kmemdup() function doesn't return error pointers, it returns
NULL on error.

Fixes: eb3a97a69be8 ("ath9k: fetch calibration data via nvmem subsystem")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 1568730fc01e..335e10133926 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -610,8 +610,8 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 	/* devres manages the calibration values release on shutdown */
 	ah->nvmem_blob = (u16 *)devm_kmemdup(sc->dev, buf, len, GFP_KERNEL);
 	kfree(buf);
-	if (IS_ERR(ah->nvmem_blob))
-		return PTR_ERR(ah->nvmem_blob);
+	if (!ah->nvmem_blob)
+		return -ENOMEM;
 
 	ah->nvmem_blob_len = len;
 	ah->ah_flags &= ~AH_USE_EEPROM;
-- 
2.20.1

