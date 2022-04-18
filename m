Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FCA504D20
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiDRHXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiDRHXC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:23:02 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2055.outbound.protection.outlook.com [40.107.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1155B0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktZMVMHXyRDngggDMn0bl2Fq98Rn+1sfAJMH2fn3ixuglcWTn2qakX1zEn35hwaDwpg1agpy9IqPN8kPqPBKkB+aTRARbWuLwJ+L1ptzw/2NJQszGkF3GlqZTWvGWuJnt+2GEwsJSFE1glfDHZ8hvIpBUYtQrdfiCqtcKWKxYru5JqqBbjeK7Ii61xwdjWRGiNkGNz+x4xPkHtZ/TeMoVNvaIx3lcHXr0dOoon4/A90DweaULol05ArnOTGPLLlg6mhOTIQ14QWVMxvlamLUrxZkD+MGfhRv48Yd8/BVDTr5FQMowW6TwhWyEAN8MTy7hthbA3G/jOl1ypMBqvutAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4FI4vvopeIT7RoeSU3r65urXvJzvQY5ilH7ye8h6Gk=;
 b=L7XfmrFGsl1lGoi9YUJ/M0ewNrhPdk2Enu4XjZynsJLYfsLOBpLyCYpbhAi59wYO1LczU2qRxLchf2v2p0hXCHH8l8L3yJkOp+0EqEW+05ONgl683khqWtylmh4IcqPTiAFxCJpb3d0voYSRYMcMwWd2eP58jzNMUKNpO3NtnKgA0/kvvdPjpFfSH11PrQkRVaTb1l4JW1KxVzTSeb55uC4LJRQcOdcOQ+hnq2niUQOcm4mig4+J3XGKCTY6Og1ffe8bSS/yaYU13QCXbzt8B/TJLqmq06OD7EvCyvQiby57FMQ+++5xCowyl7lmkLZyi06EsPD9e5eip4MbJmlD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:20 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:20 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 5/9] ath9k: implement QCN550x tx
Date:   Mon, 18 Apr 2022 00:13:09 -0700
Message-Id: <20220418071313.882179-6-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418071313.882179-1-wlooi@ucalgary.ca>
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41382599-317d-4d15-a657-08da210be553
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB4363D5E89D872F3BD19B7E34B2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBcuOg6qmwwt0K21rPoyyLZyUo/geRdKujCTmDMx1434uUBSZXJ8PD14OzjfkhVjyBjAO+R9ZAwZZsmr4cgbk6GtNonNvlugGCpqo+F81isZRwa9A5r9g3VEPHIHGwkUDHwyFREnKfC9mOvy2Ntud+uBAEv+z2kL5s6pPuCFISDGYg+Y7wEsj6vrrzUDyFLkEqMLUgVJaO1F8H1SP6THDoNFCspOBTPJQJTuNt0B1tHtFEKj3RQq1QtYPU4paSJiv3oRjKm1b+k6ZGazLoRByjcL2gRwcAST5yRQttEn8CsHYX7q8cuUCpBDbrXbn+WIIxKvsb5sTDMKE96xhp38cmQEYgR8tz9W4WtRHipBJGJg/3zxkz64m7z+RWpkawKQX2TkweXsTL4LnYoFZN7wjWUKSPayoD4xCAxmTvME0qjQQjtwzcWR9hRS2W5jeLvxJo6ZbDCrEUUImue/2IVXxReqbHGPFjCOJnd5ZZTOFz6IEamIghU6+/7P+xcn45JaI1rDF4gmu/83uGhPzM+qT9sI/+Hy5jxtais6nOpksXOI2hLLAeNZtRwPqV0HGVydDnmN0sYTAZPugbiscFaVuP4xczyPVBAkE9j1Ds+c98nsbtSZ5eNl0aPuRs22VYjbUcT3TlkzLnBoZ7uLRJo9wsZhAY2NJEPyo2NwWqsf5Umah/pEuprIW9ScCarafRt57QMBavSdxV3N8jR4zfH6cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(66946007)(316002)(186003)(26005)(786003)(38350700002)(6486002)(38100700002)(19627235002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uf/VhHljqJ+J9QvjJXwxoO3BAmfR60Bqw4dY7jrtCht9gXisc+m2AnHe9R8i?=
 =?us-ascii?Q?M9OoneCzGICnLuTVFvgAyYNPnG6EaGkQJOly2kcyGPsCL/ywj5oadIx+Udka?=
 =?us-ascii?Q?xumvovqH952uIuIWBf0L8hNKlsc8mGakABg3ouI3RO9OjsAeqDZBU1UaDD8G?=
 =?us-ascii?Q?tsR4D72eBFeWDKB/eTgUmi5QwRks8e7Ju3loXqwU9hMuFJIFv9SHvqW01Rkf?=
 =?us-ascii?Q?SWSmlpXqHeMf+HVvGANh6Wg+VZCQEga+iIWB825Zca5B2pT4lidd8dQqgw4P?=
 =?us-ascii?Q?xqzfregeR8RHsbBHMdm/DAEhrw+gVw27S4Y7i+SO0sxAyvRwdG9eA6OprLk1?=
 =?us-ascii?Q?22/s/SDgpnNejzPpP9TLxLMRgf6ek4c83U1GCscgE3HWiNAY8NTCDKv+fo0k?=
 =?us-ascii?Q?myv5Nm5pYTRuAERpiSmyMZsEhqnCmbMQJjYWp5CAU/BlsIy+4LnJRqYSU/QM?=
 =?us-ascii?Q?I3UY+WxIDntFuPHFzNjaQaSWe7KrXxF1YHtKfKiEW/BfVDZV2HfQWbbz8PCy?=
 =?us-ascii?Q?54pjpAFeBAngmS2w/hI4csf+FEBUNB1MEoN5ISOx0r1JXXnCh3Wf0Z24D3pw?=
 =?us-ascii?Q?ocJeFb++KJLEbihA6BWAksPTjOz0Id0NM1fXc1OmDqv7ocWrQXY3bAwF4ntf?=
 =?us-ascii?Q?++zlkkYH8RekdHbOu5NYcGJcOXIcFJJt72Mr5Sap4kyLFwdAwgk1cVBWWrJg?=
 =?us-ascii?Q?kmh5AYYfVvYW6oEdSAh1iq4ZCc1NYWgCio+BJtJXjA4iLrYs2JhzXP/Eivdi?=
 =?us-ascii?Q?cGwqwAR61BRTbJvjSIu8LdvzU/LiuPzM3AAfdY/x/UyW19WEa9iMsOqpEswG?=
 =?us-ascii?Q?V3PnhSsaI3YhGCRM7P0qFCBwG0xekzWvpBiMVupvzk83MKZJakS4gkp9R/Z3?=
 =?us-ascii?Q?jmnHWs2EknSv5jOuxmu91DjAnZmnY2Habg974Y73XoEIdfhWL7fPrl+GNlX7?=
 =?us-ascii?Q?93nyCuHTkW/CViCauulLKEpVmza+y5jfKRbKAoFbTYoWH7Rtld318YxJvHtJ?=
 =?us-ascii?Q?hb6KpKBD1y8S9M8+npDuBkq3xmPTs+kYmfwMFH1/+wyi8bqhKOm3gTm+aDu3?=
 =?us-ascii?Q?nKsPXSZFGOw1Pa8Q4Z6KLpeG+RzwfwZjTSDy2PplIIcLskca/BXsagHCmr+q?=
 =?us-ascii?Q?MvuSM6pRALk4xvfpwGSOLTaE4/eT014uM4iZw9IznuM84C1BRrANtwZDso2q?=
 =?us-ascii?Q?SIPAWOnfYFne8K+eMaHobhbxcc3ZwyraMLmz33I7Mo0JLduM+qTivkKkNkCo?=
 =?us-ascii?Q?ImZbUZHyT9ubQIvjwMvlT/M2paywcCNW7Q7tNW/+Fuf7PNRtBhSbScCV1Wyn?=
 =?us-ascii?Q?XvZiNyulFV8heuZDpVhGG+Qm1ogUkMz3ub4ECi55xqMjQnbz7OLdVWoBZQLI?=
 =?us-ascii?Q?3Jeg5oGM7slD8aBSY9tu1FJW73QuwhDK0fyVKWhOVEwXv/oTIDhp4yBkCByy?=
 =?us-ascii?Q?E5t3eVVBxF3JUsmJxk7B+lsJX901w6TXD9i7EAm9zlp9mf/YEs2Rf5XNgOG9?=
 =?us-ascii?Q?Jit6P1SYftJGGPiDH1CfXG1MWrW4QD52ptYyg4Kyxl3cveUQTyyq+AYBxLeo?=
 =?us-ascii?Q?ouYR6jolWvc8WQocgfT2tH3S0VnRhxXUNTNmb6tXdt8f3bvtKZsonZNHIPcb?=
 =?us-ascii?Q?JMm7cdPstwhIy3c7iZ+R5DyBWZf7I9w9jic8+I1H5NUd5OcitfoV7hiJJjrc?=
 =?us-ascii?Q?111oGlHuFS/+I3VZzrfZcVvWILyNc6x3wLj9vd5uF/LXMZBMnwpkFkhdSMsV?=
 =?us-ascii?Q?6pLRDUJhnw=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 41382599-317d-4d15-a657-08da210be553
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:20.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqX46+YIS7ysvn381nRRV64UvgPPZbZYKYeZUG8JstY9u1mtanu+Apvedox0Szj0FOSqVesgBpHIBeexlCDz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

