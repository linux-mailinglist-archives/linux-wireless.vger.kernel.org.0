Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3597430F9
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjF2XRE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:17:04 -0400
Received: from mail-yqbcan01on2054.outbound.protection.outlook.com ([40.107.116.54]:58502
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231267AbjF2XQ5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Ht/0C1H2q561p11K7ujbtcALcz8DD4I721vbcBX769k6znDX6wFab8k/iJ0C9CvadSYmXZz3hGqnMW5Kbmhi9lZkUboOYiNShODqQIbt9VeQa9n5MXMiabO0Up+atavtlRWqgNNGA9OG8Jw+N6OZ9yrue3kRbqvA1GyxuxDRfictmgYdbROPNKb2LECYSZhA3Nswhb0CxJp5a7sV0SNem2Oqr0ZHqHqMZLz9kq/x0SSnYmxUqZXxJB0oZQXO+xZIUFBh0d1VxZprnUtY2XRrpeUfnAg5HyJQMqfEzRT0/eyKxmZ3gfEYVGRlXoQQDKS+2wsUKgNtEaBt/Yt/youQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOEAeSKVDMHoqRvPI4iRloV7EoEaBBSrfsrrDleLzAg=;
 b=Gwqgd+JS0swJdPm3sDlkxLL8KLzQnqwR5ndPiP/JMdMq8VqINEtHtMYi2ZLKUizwCRKQM6cgRpgYSaZxbJuJmI8qYo8vApsPdEjsyT1TUFTfG58cwVEJFNjQvUMWXh2vN920iG+Dj7rZevSpo/JC5Dh8iE8Kq8Tyws+vtOEetWxtatgZESpq+2/l6tKjF/f8KPfJpBAwKwiZ7XmfECbHaTeFvYd0q/4c6Tn7LGqDJH9cq+AbRkKOTJG5Z2uTL1JwPKMyrSd9AWxd4JkJfLjJb9u4wSF4rnG/ni5KDBiK/dmcaaSovhQAyxVblxjm9BmTHjPTWM6VQyHgEWly53RNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT1PR01MB8473.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 23:16:53 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:53 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 09/11] wifi: ath9k: implement QCN550x tx
Date:   Thu, 29 Jun 2023 16:16:23 -0700
Message-Id: <20230629231625.951744-10-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT1PR01MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef77ccb-d26f-49e5-f205-08db78f6ecc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLobJkI3YPZYwA8xGwCtnTggQ66TAVa1d89OaMKaT/2/dscMlwwxM+OaMXWrlj1slorFJAaSaBCYKMQzCbR7pa5eUqlN5irv8fQL8/VKAd+z5LH+D9wMhdRpAMYwuL66DarBszkpwTwHJguS50zHRYI7RkWhwGdGnPJDYbbECTBNPQW6qypGi4Dv6nq2lep4NvpSOZPC0K96rbW575Es8Cvps0PYzdGF0rE8M/Lt6yDgcWf875+UASsfc3z9Uy3xcuE3lusdG/sZ0LarAFPDDGo4Eu6vl/jGbsvlb2NI3Ty5at9AEYjAkt0V39sM8tKDCAwzZi8fn0/owBfr6chJgYVnR1zbUppRIjcqbarKlL3ZklfpzX9j1yzu4/KPMPnctSMMxu+zeAPNlARR4ntYsU+t2aJUV7DQv/sVyJUgYDqDyrdaVlldD3RAiil4IoE5Vhy8pGPdYFGP9oF5ZnvgaWgrKiNYyuD46fYYJgiwTMVDzoPqdvSxg74ewId7eCy4Gvd93SRzVadFWUUadoaSypdBkQprSF6dWt8rQ90QoQmF5/3AqeAFl1ZvJsoI3yoF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(26005)(4326008)(66556008)(66946007)(786003)(316002)(66476007)(8936002)(36756003)(6916009)(478600001)(8676002)(5660300002)(2906002)(1076003)(86362001)(19627235002)(41300700001)(6486002)(2616005)(83380400001)(6506007)(6512007)(186003)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k5WaGhk4L6UoFUa5baFddyk30z9PzaRJqMS3XQyvFRP+qKQForawHsLUq6ag?=
 =?us-ascii?Q?oi3q0pSps4ox6VD07OXGhNhBlDdmnXjr7vWUCffbKwzMxXk46oK+U0N66XZb?=
 =?us-ascii?Q?s2R2ULMydKVkzLH2beZ97E9l1pTL20QHLkp2NE8pbYtDV7Ps6MWbH5oMSCgn?=
 =?us-ascii?Q?6RPpGFI7rvuC5oWVxCQVrknKC4kqYpBN2BCADPSs23B0QwyilM1oGw3z17+d?=
 =?us-ascii?Q?q9JnMiwtmdJrqhaZ6VlBx01Aufb1CNjoKFcVgjpTrQ/iQS8qKc6yRHv3u77O?=
 =?us-ascii?Q?RYHQE/pc5plIm6muyaLg3lRlEOmoepVXe1BnwOvAiNXq5Sz/qOv5vLT08hCn?=
 =?us-ascii?Q?sVCecBT0Zv5Tr77Q9Ihl8MU73UxlaE1SucVJkOI0TmAvkNH/9w3+bYy3t/aI?=
 =?us-ascii?Q?hBesKS5vzg0voDlEVwnOpkjGMtqryh370YzStCTXcHnYtOeIu8PY4hdTwq7y?=
 =?us-ascii?Q?uw+m7GHuzahhjGGc23+IieDyRaGCXFAbAxZUaFO54dci7s35IKdgFLd66oj1?=
 =?us-ascii?Q?/o+Xj1mKBg3qbp7DEUSNWX0+LBzMExwObgdiM9Y88EMzn/DKG0chOeUBTa7g?=
 =?us-ascii?Q?vJiIqp2ToA8wNmGt+0ZGeG2YcZqJpEJu5ffD0pnzQj6FMBV5bn7f9gx2hEzm?=
 =?us-ascii?Q?s4CDvyFxZwlc9Kyfcp9jQJVti7+3STd5NS39stiYUIlGdAvh5zen5XqLGFi8?=
 =?us-ascii?Q?wjbSCWTsT5F0Yt9CC3pUfBydRDhiYn4bVrMMSaBFcvJFA7SiwEcjGTAL9OiE?=
 =?us-ascii?Q?No8ECiHHlpSUJmRg5IzdZysjE5aeOAG8rIZ8BgWlW87Ogcork6vivtXxdm0g?=
 =?us-ascii?Q?tnA/fFOr0Bm1OkunZ3N5xI5a5+dr6M8DNnxNnFIPxPGNH0NLu22F5IP+ZD+g?=
 =?us-ascii?Q?O/s46ZysDeY589Tz4X++4E7z/d473FxpLN14gNPXTCzxfXVpWseRsKAR2Xi4?=
 =?us-ascii?Q?UdeMhdcl0oKoSQyV0azwyOu0h7UEcZF8Zdp3pEdsyQqHogvspaNlJCPlxLVD?=
 =?us-ascii?Q?Hep1KKp3uNXH1cIzzWkPNu3vOo4G24m6VuEISDdj26OgWRqcUwKknUs6yvTz?=
 =?us-ascii?Q?/kvPuBXfVAxbmtCtITGH/EhY6+mIQ1VSUGXgQ4S0LsUSldTzCMECGJBWqdqg?=
 =?us-ascii?Q?GFvvUHmLqdoW5k4tWOQI2JJresSGc9kab2VOJgH4dcNtAdP7Gg4TGslnW8RL?=
 =?us-ascii?Q?4zx3gvUgqzXLs78v7fXdWwb5FzShk+orX04LkZwIK+tPL8OhOQtwMW5Lrdmw?=
 =?us-ascii?Q?yjmP68gg90wOIi5cwkxNUkfy+aria3ydAKgeGxJETOKsCl0XMbKk7+WchcEh?=
 =?us-ascii?Q?PvkWb0daen6OXM5MSvkOhBeO9XiWiK2cAz3jGbBHwSSNAgxFuqYRqu2Gqu92?=
 =?us-ascii?Q?AHRYARl2U5QGy1cQYit1S2OyHzkMT07p1XcST5IGs5luxyQxoQcyX3MwVzoP?=
 =?us-ascii?Q?O39hNUyIIi0WukmzZxqdYYyJymyCBe6mTGyoFODAi1gsJFaQrCLodfInyVUj?=
 =?us-ascii?Q?tS+HTnjAHwgjZ+WgO1VbCdklxZggncs/QAmJAvdwGsEUOmKD8trVhxK2Pyz8?=
 =?us-ascii?Q?yZbA6z/z6kWV+G4Ps3n/NNylHSOpHG5swj84N897?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef77ccb-d26f-49e5-f205-08db78f6ecc9
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:53.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGjGYwTZNZslWFn9O+/OqYsAjuVSUDXw1GNnHYVOnyNMjLs9ZJK3Mv5+MjUc/ZQFGhoMCt5rtAQJbyq1lUQoOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8473
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Certain fields in ar9003_txc are slightly different, but overall this
device can be treated similar to other AR9003 devices.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_mac.c | 45 +++++++++++++++------
 drivers/net/wireless/ath/ath9k/ar9003_mac.h |  4 ++
 drivers/net/wireless/ath/ath9k/mac.h        | 13 ++++++
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index 3d512916a2..be80fd9263 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -26,9 +26,9 @@ static void ar9003_hw_rx_enable(struct ath_hw *hw)
 static void
 ar9003_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
 {
+	u32 val, ctl12, ctl17, ctl18;
 	struct ar9003_txc *ads = ds;
 	int checksum = 0;
-	u32 val, ctl12, ctl17;
 	u8 desc_len;
 
 	desc_len = ((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x18 : 0x17);
@@ -132,8 +132,21 @@ ar9003_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
 		break;
 	}
 
+	ctl18 = set11nRateFlags(i->rates, 0) |
+		set11nRateFlags(i->rates, 1) |
+		set11nRateFlags(i->rates, 2) |
+		set11nRateFlags(i->rates, 3) |
+		SM(i->rtscts_rate, AR_RTSCTSRate);
+
 	val = (i->flags & ATH9K_TXDESC_PAPRD) >> ATH9K_TXDESC_PAPRD_S;
-	ctl12 |= SM(val, AR_PAPRDChainMask);
+
+	if (!AR_SREV_5502(ah)) {
+		ctl12 |= SM(val, AR_PAPRDChainMask);
+		ctl18 |= set11nChainSel(i->rates, 0) |
+			 set11nChainSel(i->rates, 1) |
+			 set11nChainSel(i->rates, 2) |
+			 set11nChainSel(i->rates, 3);
+	}
 
 	WRITE_ONCE(ads->ctl12, ctl12);
 	WRITE_ONCE(ads->ctl17, ctl17);
@@ -144,18 +157,22 @@ ar9003_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
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
+	if (AR_SREV_5502(ah)) {
+		WRITE_ONCE(ads->ctl23,
+			   set11nChainSelQCN5502(i->rates, 0) |
+			   set11nChainSelQCN5502(i->rates, 1) |
+			   set11nChainSelQCN5502(i->rates, 2) |
+			   set11nChainSelQCN5502(i->rates, 3) |
+			   SM(val, QCN5502_PAPRDChainMask));
+	}
 }
 
 static u16 ar9003_calc_ptr_chksum(struct ar9003_txc *ads)
@@ -355,8 +372,8 @@ static bool ar9003_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 static int ar9003_hw_proc_txdesc(struct ath_hw *ah, void *ds,
 				 struct ath_tx_status *ts)
 {
+	u32 status, tx_ba_status;
 	struct ar9003_txs *ads;
-	u32 status;
 
 	ads = &ah->ts_ring[ah->ts_tail];
 
@@ -390,13 +407,17 @@ static int ar9003_hw_proc_txdesc(struct ath_hw *ah, void *ds,
 	ts->ts_rssi_ctl0 = MS(status, AR_TxRSSIAnt00);
 	ts->ts_rssi_ctl1 = MS(status, AR_TxRSSIAnt01);
 	ts->ts_rssi_ctl2 = MS(status, AR_TxRSSIAnt02);
-	if (status & AR_TxBaStatus) {
+	if (!AR_SREV_5502(ah))
+		tx_ba_status = status & AR_TxBaStatus;
+
+	status = READ_ONCE(ads->status3);
+	if (AR_SREV_5502(ah))
+		tx_ba_status = status & QCN5502_TxBaStatus;
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
index ec8f3fac67..11a67822fa 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.h
@@ -41,6 +41,10 @@
 #define AR_PAPRDChainMask	0x00000e00
 #define AR_PAPRDChainMask_S	9
 
+/* ctl 23 */
+#define QCN5502_PAPRDChainMask		0x0000f000
+#define QCN5502_PAPRDChainMask_S	16
+
 #define MAP_ISR_S2_CST          6
 #define MAP_ISR_S2_GTT          6
 #define MAP_ISR_S2_TIM          3
diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index af44b33814..81e1918ad4 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -40,6 +40,9 @@
 #define set11nChainSel(_series, _index)					\
 	(SM((_series)[_index].ChSel, AR_ChainSel##_index))
 
+#define set11nChainSelQCN5502(_series, _index)				\
+	(SM((_series)[_index].ChSel, QCN5502_ChainSel_##_index))
+
 #define CCK_SIFS_TIME        10
 #define CCK_PREAMBLE_BITS   144
 #define CCK_PLCP_BITS        48
@@ -458,6 +461,16 @@ struct ar5416_desc {
 #define AR_TxBaStatus       0x40000000
 #define AR_TxStatusRsvd01   0x80000000
 
+#define QCN5502_ChainSel_0   0x0000000f
+#define QCN5502_ChainSel_0_S 0
+#define QCN5502_ChainSel_1   0x000000f0
+#define QCN5502_ChainSel_1_S 4
+#define QCN5502_ChainSel_2   0x00000f00
+#define QCN5502_ChainSel_2_S 8
+#define QCN5502_ChainSel_3   0x0000f000
+#define QCN5502_ChainSel_3_S 12
+#define QCN5502_TxBaStatus   0x00200000
+
 /*
  * AR_FrmXmitOK - Frame transmission success flag. If set, the frame was
  * transmitted successfully. If clear, no ACK or BA was received to indicate
-- 
2.34.1

