Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D069457DA5E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jul 2022 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiGVGfa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiGVGf1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 02:35:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCEE27CE7;
        Thu, 21 Jul 2022 23:35:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M6Sptm002647;
        Fri, 22 Jul 2022 06:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=HsyqjK+NWJ8OY8YRkPjB2Rxi0LRYUmudTd2Lst+WheU=;
 b=Qi25qdCuU9Q51C9arxniz4Gu6AJrq6WaupqOBtOi1LRe/pqA0O8gm6YqbV+Br2cTN8Z6
 Olq7BBQKwAcoGbR/8DEmBNDPjF48QPfkDiCMofBaZD61us86D/QNhkhfSha9qJGWq9gU
 4e7v+Mjn14AK+wMmfZk9kQWQvkflEW2WkP8Kw7Yfl8Xwm4b9wEyGPshmkxjt7Pc1KfBC
 KMokgUDsKba9Y72ZzAkGFHDan8iJ12Fpc+OjSIEPqI2F16iXTXhek1GgR26uIAU8pd79
 nl29n1lC4el2/COYXZARLXeSHy4YhTUAo5O72O5R4q9UNee1LPjBdIzCMbs2QXRQNdBE dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42pjq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:35:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26M3L0A7039245;
        Fri, 22 Jul 2022 06:35:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k7hr0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 06:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h90koX4yLzxlK9G0RZLGwbyyoqMfVDKRzWMNG7l6iyUMmMcuqw2SiI9/X3hkDoNBrc5c1JSEynU9caH9j7NFvLc6FzrWQgsvcV1o2p9SIQNiiCvpeG3jLP1+UhgCa5HdIj5GTxnYhd51jrd70P59yiUdbHDaBihPEyf7ZpXpE6fHSGfhoztLtWuzh+uS4Ls7I6VwIXZ5HcSxLX8DdG14JXGm49NTMZyoJ67wkGaulYuRPAmnfI5Jcwm0wbDuyuiRRryqXOCE5Opq4fIAaPt0BwTmvsPQhJDb3sQb+q6fe9iGoqOzcrnxgosS7Ai0Qge9IXX359wVf4EiUrsx/bcvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsyqjK+NWJ8OY8YRkPjB2Rxi0LRYUmudTd2Lst+WheU=;
 b=Qc8qkzRq+BAOY2ar1/REqDbb37XTZ7xnb8fkhxsYEMmgKj1bfnDYfasvQK/63WfgLGu1CoFz4RO7TZqBq7a9vrt6iTYtaHcfUUOb3H6H+EPH2bVIDtR61Ay7aIhf3RW/kMZmAsENitwVLIx8t+NG5MRFUBg+ZIo73o3Gc5srjwmmXVoZiocty1VHjGUzdqPQ18OHtNwx5Il9XAO3ea7WrlDkFUQfbrHzeETmGNfUYVNBHJgpo3PWLC67ruVQlwxGkiSJQnl5TQ/FxLvYK8eLkUQF1Em+6rIQLlwmgwoGADMeEMRhg2jRQcbHFBCp4ZnzQdO8w1p2GkoAvqXPiLdxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsyqjK+NWJ8OY8YRkPjB2Rxi0LRYUmudTd2Lst+WheU=;
 b=AT1ZV+SaBtI4rpZyMWaZe/vRT+ObQZauQ5Oz+pCec4MEctEQRLL8PpEOs6YZIAJI8yI49blaCJp9E4aTddJJVrEIOSdduteg2hD3ziLOU1KKg41G9TFVVg+LvurzWLjmrNR8II+LwNyj09lgizaA30LwEVwEPWiMR0Lg1qiD7Q0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6196.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 06:35:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 06:35:07 +0000
Date:   Fri, 22 Jul 2022 09:34:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix an uninitialized variable bug
Message-ID: <YtpFD1kBU7TLG4fi@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0081.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60888a68-6235-4027-688f-08da6bac5170
X-MS-TrafficTypeDiagnostic: IA1PR10MB6196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpAJFqC9Z+FayGYGJMbK83MgnkPbbl4XhiD7t+Wb73INMGPvDZLL/idiC30nNgtQUyGpUr9ZMq+uKffe0XQHlC4orPZAcxrQam2Aw4gQ7MBqVLF6i+0L+ibp3dnI/Mg1SM+SyGdxBRIGihq0al9rqc/no+dRvpcS7RD4MxCPKCWiPCE8lJ6+lVJRaVUDqaKj5uYR14Tu+pbn23Up2KcC92l1hTK9pRguYSD28EHKANoLhxuHgsg+V00SJV5rrVQzsfavphUP3kdMjtDU4V5Y9jFVVglZQ8/GXGp99VAc4wTEeYxTlM1LgpAak2DcQYfrtKsb5UisTfuG5dfGOPMAavKDUDKjDSFiR1RJpLofQ2TGhNssOJ/MeD8OMdz9TXGQJqySrxaiUuGZlcey8Zvr8ig49nJOM/WRc1USJrKF6dnok0+whPWoG+q7z5dL51XcS3l+Qrwes8bLrcbgsoYBg3PVoADztBuri/kbYlU1N22HznQb28BksaD/m6AsX26BlF49Wc97gOc7pN/GXABvEmAfQtNBV+OB5fQBODWpL0eaInT5JbOVBv44ZgnCXUfXPwqVoDho4cAB9SpNvlPDJ9mzLjw4o9HTETIf+69UCi0Nwajhs5f/EA0lrBI8c2/rnXEfe4+htNz2eQpi3G2u2oZpEUTiZQHuyjYOuoB1jCwiXQFyXY709NEbd1L3xXwQxtBm5eUvS/sAlQSbKB601VSxHpTGhAwHhLsrNkPqX+q5kqs+Umh4JESNdhzqXtYHzYMImEnsmXc6PLjMXXczM7fJgxnljtTr9pqPW50QqbYHrWzvRy034jYas4MDD7jE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(8676002)(4326008)(66946007)(33716001)(8936002)(7416002)(66476007)(66556008)(44832011)(9686003)(5660300002)(6506007)(38350700002)(2906002)(110136005)(38100700002)(478600001)(26005)(6486002)(41300700001)(83380400001)(86362001)(54906003)(316002)(6666004)(186003)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jup8HEP3o/Kpzdd0wCRDXYPj9RJaOOpPWSWfnIWp4MK0k1y8fzopwqIWbAG0?=
 =?us-ascii?Q?AMZDBfm/7zweLePbUlCVMZiHPbGVpxsZ2IJ+1uLkeNO6QJhdK5wb3zMC774Q?=
 =?us-ascii?Q?qdLIcfts2+8svABRhPT8gXMfuDUzW03xwKTSqX1zeP194h4S9/x4FW0ja6J7?=
 =?us-ascii?Q?mfpcP53vL1MGBfb7cCQKl1UxrCDnKBONf6mdf0EE4nXUkOWobEoF4nlJmIGp?=
 =?us-ascii?Q?lCHSz0PuZWbmjoohUSg4ny/SBPt+p4GTUfHn7XQeWBjMSNdELmNTKTqTxaWf?=
 =?us-ascii?Q?tXusC5IQ+dR0boLQEfN7SCnLc1n9kCb5hw9PIJW8CVSn/K3vWQvX/HuioJtP?=
 =?us-ascii?Q?bWoUUDbN/5WA9Rmo86lBwldkwWHVSqxjiB3HNF1m9lW/Fs+Tf0LbGcEWx3HS?=
 =?us-ascii?Q?H5aWzMw2R2vdOedSRxyUS4WxJUXNW4qwr/PbbGFrU72pWA/JASilT7owDhlF?=
 =?us-ascii?Q?5f5ID17Ye4evpI++qnqKUkbAfDh7Vjq7PCtYgaPJcEALpWesGIdExqKn7em1?=
 =?us-ascii?Q?lX6LgsKH+Br2thdbgMVgRWCYdfbMWyBL6fREc23fLyB+CylW3dcL9WD4DBqI?=
 =?us-ascii?Q?uhhYlji3X21JufNLAqeaUYtf/XSqwhwkTG0m4yX98mOeqyBAbmhx3DLOefzh?=
 =?us-ascii?Q?vwU1Z9H3+7BK6j+fnG7Ez7WwDLeHZC9AMRPwle0eucEITo1QD4X3Ol7CUWi9?=
 =?us-ascii?Q?fM2FCLvrRhO95lqKyotIgPUPGjTMQcZbzQB72FTewsdzfGXvy+f8KWiSilSa?=
 =?us-ascii?Q?OJsQnTdl+aEwoXqPYbySOP3T1jf/f40gzmiNcy+W4CBol8y8I4VmEy6dLQ5Q?=
 =?us-ascii?Q?rHnLDTcm5sM2RXpUh9KRVTz6ddRCOW7EqKLOhWYkhJ1w11U8RrJA+YBKzjlt?=
 =?us-ascii?Q?4bV6wEIzYOkWY2QK7qllOdnHTztmHlYeNmEDWLxe/Sqq7cYBTh20rBlOksVH?=
 =?us-ascii?Q?Y2v/JDv7uCQ1zY/z2Bza4ZVCg9nH6qMjyimtKAJ1pXlrqQuDJEPnrAXi1bgK?=
 =?us-ascii?Q?96/zWztphMaC4JWfMpmtBjQ2bVi44EJ8UE/FrQpyY4/2m2G9MSIp+bQRvktx?=
 =?us-ascii?Q?o1Q98KR5wCeRirfpJazP4HsHuYzEugeVtNqNPqvpPfFq7+2D8pB6eAlz+Xf4?=
 =?us-ascii?Q?UofRjhCpUm8cNeqgacYN6U3KY13XE4/Evf99Eqh4sR5ORppVjmhoOu7eGukz?=
 =?us-ascii?Q?aM0Km6evjEGvEiTv/QYPEN7D5+cjGFCJoKQlEU986PeI6dnT3jUa91WZqd4+?=
 =?us-ascii?Q?S+GVU3QTRu+Z8qngjZBmR0oPHO+pjo/ffFFWMU5juKzR9g26ckHAOm91QNyL?=
 =?us-ascii?Q?Ffo12G3XlcwyyDAVyjuwS+irm+dz7v5VJxH4qV3H9SWA/nmsZsZ24fd8VWXo?=
 =?us-ascii?Q?U5ApUcXdZS7v+7mEJFVulRwDxtfYBRXOma5vGcLjUQ9THsWmzIGtOLRy337m?=
 =?us-ascii?Q?321lsDPAZpKuktbJLApZ3Fr/DW0/oA+W9UCRo6I38AH1vZOZ6d3PWrsHDaAL?=
 =?us-ascii?Q?8JgCWr2aTlwIVsQ4PuFI3RCkd91CuaQUWQdmi3z5kJIUpvPvcy41f6i34iTN?=
 =?us-ascii?Q?Y+GoJ57pmOhe4fTWdq6CVwdvr03DORgKJJF8yNvpX6IQe5YMhHcun0uj3KRx?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60888a68-6235-4027-688f-08da6bac5170
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 06:35:07.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbflE2x8j4t/xc1yM2yAPhmVXzdJJ3H49ZltdR3F6LQC99+ETRuKc0zQ9NB0w2t0gglvOAy4gxcfxa3xpDkwGAN5r/vlfxNb4bq0CgL5RwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220026
X-Proofpoint-ORIG-GUID: ngqJYVKxKja7-KZ3jRisjva9hvl8gYaE
X-Proofpoint-GUID: ngqJYVKxKja7-KZ3jRisjva9hvl8gYaE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Smatch complains that:

    drivers/net/wireless/mediatek/mt76/mt7915/mac.c:428 mt7915_mac_fill_rx()
    error: uninitialized symbol 'msta'.

It looks like this was supposed to be initialized to NULL.

Fixes: 0880d40871d1 ("mt76: connac: move mt76_connac2_reverse_frag0_hdr_trans in mt76-connac module")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 60ae834d95a6..4ddcd3afa428 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -232,7 +232,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	bool unicast, insert_ccmp_hdr = false;
 	u8 remove_pad, amsdu_info;
 	u8 mode = 0, qos_ctl = 0;
-	struct mt7915_sta *msta;
+	struct mt7915_sta *msta = NULL;
 	bool hdr_trans;
 	u16 hdr_gap;
 	u16 seq_ctrl = 0;
-- 
2.35.1

