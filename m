Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10934525617
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 21:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358211AbiELTy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 15:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358212AbiELTy2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 15:54:28 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2070.outbound.protection.outlook.com [40.107.66.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6842701B7
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 12:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z503Su4LD8hsurQrR2ox1OPGYMSk74SydGulAMO5wlCpZB2GFJgroQ0sIFzRK50iwJ5QTf0Th8dpJ+WWxvbL8oc1Oe4wvnQJZJKZNgoV2Y8s5DPXPS6uV+am++S/9tsbBRh2HLx7ue+4t+9xb+3ahUZgG+Jx06/RTCw5EkHVasFW/1opcWje6mD0iJTJWtMdUXPJOsZazn278H1EaWgbGh/b5kKUddjpW/CXvGdOb33lNSzzoF+7iLxDJ7rN91ClFnc8pNUdcesS5p78tP/teM9PCvuPg67WR1vzDWeJrAphpPHXQgEzl7LNSkzYG6uvYxM5hOqZZOkwT5mGO8u2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXjgMjcZ6QqKiPmek8VoOU1H+fwoJf3CrCF7fYuYLZY=;
 b=nN9GDAN8DFCiJ69+e8ZEg7xvBQyQGz4qnRd9XbSxdaMuVO6uJ+eHFlacNi8432seKcpDeiI8aXN/TLZgq1SHbxgEHqDCvtuuzxRnqLVdReFcY9XCytjfe8R+qH+mCrC0n2bjCAKiH3qMVBwsU3DzMXkgGRkjU7GIo2bJ6DpuZTKw43zzsQwCgsmcXc0ml87xUsoE9ThYzcne8v3w92Lln23GS5RBdXHY8/fkAnbf2QJzJjM79Hzlq+aDaeXLMWDYOHiPNYLWPRdyvjOekc/93gZ/GCPSrLIDEY7cdJT0f6JDbhG2J4An1QinH8MXL72hJNWkwhT/I6tZHDg1K0Nhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 19:54:22 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:54:22 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2 5/9] ath9k: implement QCN550x tx
Date:   Thu, 12 May 2022 12:53:15 -0700
Message-Id: <20220512195319.14635-6-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512195319.14635-1-wlooi@ucalgary.ca>
References: <20220512195319.14635-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a81e505-787e-4020-7bf7-08da3451359d
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9515:EE_
X-Microsoft-Antispam-PRVS: <YQBPR0101MB951586A0A7C81C978E364D8AB2CB9@YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcLmhQAF+l7u+G8tRKgifrdcEmawbvKhRvIKr8jTjNJ0mKpgBL8UZYpjeRyJ1g20DkVgyTA/eZBhsD8XUOg4bDd5pBpN++ghjlkpuQmig4mt2kTkKppfZsQDn0yXRIPNMMk3VLctENGWi3anRg9XJ2RM+Wbtl6LxZFI/o8LVx2KGcs7wCrGynz4oOU2NLR9YXVC2Cvp9eqtR8WvaP/ayv3Qn8KUSwYqmIGinu05maJMLYnxWNU3RPh/Dogje1YYMt9Sg0iQf01HsFD3PRpM3TEQbO1VPlE4OPUQcJAqQtIvpdK3OXWJa7psWBqFs2T77rS6ewpZWNlXCU0Jz4+h4bYekC9IweTNAztdXkoYH8KIK9/GZk2ANRUjvljMf78S+uX2PsCp6LYnaA4xx/hRt3ApN+YmDpDcy/lPdoJpHq/fI2+kfXIxpjD58GOEXZGEZu0hWa68viJ9CQ5UdNUC2LRvw70vAm3NKS1faLvIbKHn5X0sX1qAb7b2rr3JBL4GkrW8GU89ft0o5zH0WopGxCFxO41vXIVczOmbIfYaQCDpyc9POMLnRnezvY6bnhmIP+RhQXsU162V1icyJ5inYgs5gk3KlPUt81XeLkQprqSNvAx/IBbHGwwUmdjAqNJn9sj9GLfF+Dn4Sw2yxQlQm5tnlRy7NAR0cGfK8+yn//YLroAbPKy9l5kC5IZDRB01xN/wZpE90noPOv7EJzC6spw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(6506007)(5660300002)(1076003)(107886003)(83380400001)(8676002)(4326008)(6666004)(26005)(186003)(66476007)(52116002)(2906002)(6512007)(86362001)(2616005)(6486002)(8936002)(508600001)(6916009)(54906003)(19627235002)(36756003)(786003)(316002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yc3PGfzEybjtu2Utg8N0+KRubPJb78Gxs6gSu77HJDsyYHDOimV5miR9OLKl?=
 =?us-ascii?Q?xkzFSnm8pdU2EpYk0NncSlvLjVCXdRNAneZomNInIb3XoH5YUPDago3+Ai0L?=
 =?us-ascii?Q?UtPDsbKXa/cZQ0oD11xJmW45RrYu+tEq65Eejh61WOIDrxRbO2MiQI7Z2XKN?=
 =?us-ascii?Q?rYNlRmAXVbQIeRlg3hID62vMk4cdYcb9mlY4iKbZCVGR+N/3Z7Ikrkq2jqFD?=
 =?us-ascii?Q?cMI45bUXv2JN7sy2l1T6Cl0XxAaFAgwLvijS277VvkRbJ174r6IpErurKJln?=
 =?us-ascii?Q?DOp3xc3I4keAOuurDwFweReRcbe8k12meXo4L5L5AGD9+aCCYYT6swKT7HGr?=
 =?us-ascii?Q?kXd9yb0Hg9V3NyElXPiD25haolgK5bF3xovMgHyqpKxHG66StSO7EVYvTKb6?=
 =?us-ascii?Q?TxxCd8RIrJ7pddg9geFt7D4dVo1br/oM2giLfSlwoOV8QJpgiebo7U00TJEx?=
 =?us-ascii?Q?7a58985H5pq6VdRvXNRX7gkcXg1F4GX92EbxyEF6vChCTP5tse8czfyX/XT3?=
 =?us-ascii?Q?CJk3P9secoF9dKO5w+vhKitPkVCPZrlG2jZjQhzB9izY0siN1g3uoOC143zA?=
 =?us-ascii?Q?Nv7jJNrsysCns94nUs74CsjHzUv+9Q24EeXk5dk+7vzLsHaYrf7xBMfMBjZu?=
 =?us-ascii?Q?UMFGwR4bH+uky7XtCPRDnFWaj+cXl4Om749BTYamb5k/zz3tEBFi2/5LFBmP?=
 =?us-ascii?Q?1a6cS06bL10wahyaA3veVrUIzQ7zdh+E9VOFQra3z2FPpzM4lkJihG7Z9h9z?=
 =?us-ascii?Q?GwPfOhH7nfpnu6RzPw3IMqaVdtNfDoS6YdJqea9S29sUsbJd0uK9xj5ZCk/k?=
 =?us-ascii?Q?ZkRd2q4O0QtYxlXg/TA5ptg+oqG3ZcPoKmW/iYLgejCvqD/4txnt0E6nNr9P?=
 =?us-ascii?Q?FnkbNTRSx6+nKRt7QbTRXc7jFJCG8TbGsBPYIYN7lQt1e5FuqaUSVQ5UaXQ1?=
 =?us-ascii?Q?IBpA2SAUjzoLm9Aq93UvEadZvE8SjAGJIrC34tpiH/38PdpLeev//LaUtZUq?=
 =?us-ascii?Q?AWPGJ/1PXHk1JwG29ggrZ7/VXRBByx+p8Hr6QnCV12IrpQkv5yPX3MOAnLQG?=
 =?us-ascii?Q?3lFLOmr5Bpao9ley6n3a+UsnewPKybPgxwAWaTwl5xt6NpFNvfnJOD/q0EEb?=
 =?us-ascii?Q?sAL5xTL7S5A31cnMM7jI/P8xFpXc/4T+D8QqvcdjHxS2RWUL1UKMfJROk2NZ?=
 =?us-ascii?Q?SwdjlLkYRV2cqgvHjIyEVWuCqSJF1rwmIv1RTbyic2r1+cYwajWUjkcPMEzg?=
 =?us-ascii?Q?W6G0ZCXbYRMdk+yatDKMp3Sayeo7Sz0EWMY5pwVpVnyqnApLe2lo6Cb/ujHV?=
 =?us-ascii?Q?CBFXleXeD5+Eqg7LrJWaK3FkH4pOpMsJ38+fzZKsdbnOMtAQE0ZD7xeSEA4w?=
 =?us-ascii?Q?yvPY5ch1wDAf2rIpjJuPGilkWSdLGpKtE7oYU3ZMTDpbUUbyQhbGW92DojML?=
 =?us-ascii?Q?pRsQF5DjH5K4SRRcIK0A/oso9HOXl5xWRQ2pH3xtP7o7QK8MsincldxDWbp7?=
 =?us-ascii?Q?t03uLtnbX09BhDymK6oCwzN4THSSdutNYXhFx6O/mGdI1aB+o5qS2+6skO8A?=
 =?us-ascii?Q?5F2MZCazL8X1FxCZorvLC5wljxkN83dSGGCncv1BVvJIoWMr9kP6+Hf8Z7B5?=
 =?us-ascii?Q?YD7g+KzPVY/EJHWc9Xj5fU5Yj9EQvIzR3fravy5Vb/i9oW7YOIHERBvkPZeH?=
 =?us-ascii?Q?ZOkTZfcMP01AggXewBhqeeTqIzdCxESnMEPBFPvVew00pV/JEjbqtJEkcxIz?=
 =?us-ascii?Q?CzACEmglPA=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a81e505-787e-4020-7bf7-08da3451359d
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:54:22.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n2Fsn1lUrnZF6oZVMJ56esPZUHqoTX1aKEQj/niLUOdosY/COTm/XKPuAU2jPozQMIzvFv1DrtbHJJ0bnc34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Certain fields in ar9003_txc are slightly different, but overall this
device can be treated similar to other AR9003 devices.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_mac.c | 42 +++++++++++++++------
 drivers/net/wireless/ath/ath9k/ar9003_mac.h |  4 ++
 drivers/net/wireless/ath/ath9k/mac.h        | 12 ++++++
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index 059e4bfce..6f63dc940 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -28,7 +28,7 @@ ar9003_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
 {
 	struct ar9003_txc *ads = ds;
 	int checksum = 0;
-	u32 val, ctl12, ctl17;
+	u32 val, ctl12, ctl17, ctl18;
 	u8 desc_len;
 
 	desc_len = ((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x18 : 0x17);
@@ -132,8 +132,21 @@ ar9003_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
 		break;
 	}
 
+	ctl18 = set11nRateFlags(i->rates, 0)
+		| set11nRateFlags(i->rates, 1)
+		| set11nRateFlags(i->rates, 2)
+		| set11nRateFlags(i->rates, 3)
+		| SM(i->rtscts_rate, AR_RTSCTSRate);
+
 	val = (i->flags & ATH9K_TXDESC_PAPRD) >> ATH9K_TXDESC_PAPRD_S;
-	ctl12 |= SM(val, AR_PAPRDChainMask);
+
+	if (!AR_SREV_5502(ah)) {
+		ctl12 |= SM(val, AR_PAPRDChainMask);
+		ctl18 |= set11nChainSel(i->rates, 0)
+			| set11nChainSel(i->rates, 1)
+			| set11nChainSel(i->rates, 2)
+			| set11nChainSel(i->rates, 3);
+	}
 
 	WRITE_ONCE(ads->ctl12, ctl12);
 	WRITE_ONCE(ads->ctl17, ctl17);
@@ -144,18 +157,20 @@ ar9003_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
 	WRITE_ONCE(ads->ctl16, set11nPktDurRTSCTS(i->rates, 2)
 		| set11nPktDurRTSCTS(i->rates, 3));
 
-	WRITE_ONCE(ads->ctl18,
-		  set11nRateFlags(i->rates, 0) | set11nChainSel(i->rates, 0)
-		| set11nRateFlags(i->rates, 1) | set11nChainSel(i->rates, 1)
-		| set11nRateFlags(i->rates, 2) | set11nChainSel(i->rates, 2)
-		| set11nRateFlags(i->rates, 3) | set11nChainSel(i->rates, 3)
-		| SM(i->rtscts_rate, AR_RTSCTSRate));
+	WRITE_ONCE(ads->ctl18, ctl18);
 
 	WRITE_ONCE(ads->ctl19, AR_Not_Sounding);
 
 	WRITE_ONCE(ads->ctl20, SM(i->txpower[1], AR_XmitPower1));
 	WRITE_ONCE(ads->ctl21, SM(i->txpower[2], AR_XmitPower2));
 	WRITE_ONCE(ads->ctl22, SM(i->txpower[3], AR_XmitPower3));
+
+	if (AR_SREV_5502(ah))
+		WRITE_ONCE(ads->ctl23, set11nChainSelV2(i->rates, 0)
+			| set11nChainSelV2(i->rates, 1)
+			| set11nChainSelV2(i->rates, 2)
+			| set11nChainSelV2(i->rates, 3)
+			| SM(val, AR_PAPRDChainMaskV2));
 }
 
 static u16 ar9003_calc_ptr_chksum(struct ar9003_txc *ads)
@@ -357,6 +372,7 @@ static int ar9003_hw_proc_txdesc(struct ath_hw *ah, void *ds,
 {
 	struct ar9003_txs *ads;
 	u32 status;
+	bool tx_ba_status;
 
 	ads = &ah->ts_ring[ah->ts_tail];
 
@@ -390,13 +406,17 @@ static int ar9003_hw_proc_txdesc(struct ath_hw *ah, void *ds,
 	ts->ts_rssi_ctl0 = MS(status, AR_TxRSSIAnt00);
 	ts->ts_rssi_ctl1 = MS(status, AR_TxRSSIAnt01);
 	ts->ts_rssi_ctl2 = MS(status, AR_TxRSSIAnt02);
-	if (status & AR_TxBaStatus) {
+	if (!AR_SREV_5502(ah))
+		tx_ba_status = (status & AR_TxBaStatus) != 0;
+
+	status = READ_ONCE(ads->status3);
+	if (AR_SREV_5502(ah))
+		tx_ba_status = (status & AR_TxBaStatusV2) != 0;
+	if (tx_ba_status) {
 		ts->ts_flags |= ATH9K_TX_BA;
 		ts->ba_low = ads->status5;
 		ts->ba_high = ads->status6;
 	}
-
-	status = READ_ONCE(ads->status3);
 	if (status & AR_ExcessiveRetries)
 		ts->ts_status |= ATH9K_TXERR_XRETRY;
 	if (status & AR_Filtered)
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.h b/drivers/net/wireless/ath/ath9k/ar9003_mac.h
index 07f073821..23614b4ce 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.h
@@ -41,6 +41,10 @@
 #define AR_PAPRDChainMask	0x00000e00
 #define AR_PAPRDChainMask_S	9
 
+/* ctl 23 */
+#define AR_PAPRDChainMaskV2	0x0000f000
+#define AR_PAPRDChainMaskV2_S	16
+
 #define MAP_ISR_S2_CST          6
 #define MAP_ISR_S2_GTT          6
 #define MAP_ISR_S2_TIM          3
diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index af44b3381..fb4318dd2 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -40,6 +40,9 @@
 #define set11nChainSel(_series, _index)					\
 	(SM((_series)[_index].ChSel, AR_ChainSel##_index))
 
+#define set11nChainSelV2(_series, _index)				\
+	(SM((_series)[_index].ChSel, AR_ChainSelV2_##_index))
+
 #define CCK_SIFS_TIME        10
 #define CCK_PREAMBLE_BITS   144
 #define CCK_PLCP_BITS        48
@@ -429,18 +432,26 @@ struct ar5416_desc {
 #define AR_GI0              0x00000002
 #define AR_ChainSel0        0x0000001c
 #define AR_ChainSel0_S      2
+#define AR_ChainSelV2_0     0x0000000f
+#define AR_ChainSelV2_0_S   0
 #define AR_2040_1           0x00000020
 #define AR_GI1              0x00000040
 #define AR_ChainSel1        0x00000380
 #define AR_ChainSel1_S      7
+#define AR_ChainSelV2_1     0x000000f0
+#define AR_ChainSelV2_1_S   4
 #define AR_2040_2           0x00000400
 #define AR_GI2              0x00000800
 #define AR_ChainSel2        0x00007000
 #define AR_ChainSel2_S      12
+#define AR_ChainSelV2_2     0x00000f00
+#define AR_ChainSelV2_2_S   8
 #define AR_2040_3           0x00008000
 #define AR_GI3              0x00010000
 #define AR_ChainSel3        0x000e0000
 #define AR_ChainSel3_S      17
+#define AR_ChainSelV2_3     0x0000f000
+#define AR_ChainSelV2_3_S   12
 #define AR_RTSCTSRate       0x0ff00000
 #define AR_RTSCTSRate_S     20
 #define AR_STBC0            0x10000000
@@ -477,6 +488,7 @@ struct ar5416_desc {
 #define AR_TxDataUnderrun       0x00020000
 #define AR_DescCfgErr           0x00040000
 #define AR_TxTimerExpired       0x00080000
+#define AR_TxBaStatusV2         0x00200000
 #define AR_TxStatusRsvd10       0xfff00000
 
 #define AR_SendTimestamp    ds_txstatus2
-- 
2.25.1

