Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBE7430F7
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjF2XRB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:17:01 -0400
Received: from mail-yqbcan01on2069.outbound.protection.outlook.com ([40.107.116.69]:57870
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230525AbjF2XQ4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeuburPOUdO2l17NFsjfEkyHq6U0y3bAiZFxyD6Kh7oRQkOPNhmIqUIoCq4l9K+DXqJVrEW6M8d3vo3CVBAV61YI8peRtB49w3QpyF9mCEKDtVG02q2KrDl0apnPnK2So5y6X/impZkHnG25++K/7KVLIDoPzCe2Zq2zZ4ngtdvm9q9MBQ85BELYDKi764o84+GJmjWeE/ZUMNAdha+TWNP3qEucc2DbZxdBNsym4urkdgSumWXp/+E0PBAdM8TwtGf/K5q/ItEN0WT98B9Fj7T+fr2mz7xPBGXEmFaBGV9tz7WkBTpT95Ykd3dV+0U2EUS6gieKrfaBTbbN0LgYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqP3pm51b5VHOkDreDVTbQ8ysjy/89aHP0Xp3k/xvOo=;
 b=ZLZV3jfbGaeyC1eGFTkgMS8R96shXEpECeURmeb1IQwmf7kZiV9obN/UWaoEMa0FItlVqnxcXBJybOn2k38bWt+LDhWyliyFIBogcifZFVBaynViYdf17aNfseBT/ytfa+whjxuhWnX9RIkLcW2TmvNhmEeaJKhjrXqh1lh0hCsMHoHKDCUorvE+KOWFRqkqv9q+INiRL3mHKHjuLaj0VoWa8PTRaV5vz/5kNdR+xUI8FZSiVq5STyRR6kof/dKadcV0GtS/HIXMd+0EFx0q8vy+W8rBTFG0+STs0TJn+/QWB++avVOa9EdtBQ9Iq0bG3/0cBsnWd0HGZV8l718FAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT3PR01MB6082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 23:16:51 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:51 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 06/11] wifi: ath9k: basic support for QCN550x
Date:   Thu, 29 Jun 2023 16:16:20 -0700
Message-Id: <20230629231625.951744-7-wlooi@ucalgary.ca>
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
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT3PR01MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a2ea5d-e6b3-41a0-2be6-08db78f6eb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmHyEKI5nLEhQZbIZgtZvjK11gF3FaRF9fTMs/RzOmdyh/0bbT+i985yGz7M0GpRkGqyW+tw/41P3cDBFFxptag0LB7t+48beldC7jZNHw/ozk52cTWwQ0jgvA972tzl1gNyuWL4n7Rfw6OpIz2ZQHGByjBHoMM/ZLqS+28hsB193QBCH5W2RE9FKF76ZxWPTS2ZDh9P1I/EzZFx8YxygI/WYxDCmzdwpZI+bqH+q0JNu/nSZ31DZT79RPaaw/vGfkVrDp/kpLVFmXq9X3eKcQkTXPtJomft/V63s1Lzor9db77KfRKiGePguyVJ05K3mJSdeNE6ZwhYxSM7xuavwdZCS/ztyVQGy7IKTNzJErU61xQ58RJzPJwBq0wSpSWG+eBnGr3Gl3pvcYx8szXTcptAbChRIKE+pvX/h4xMDYaQx8prxv3FhkwzIDixsKD1CnuqAp9cxW8C3UhbeC58SLytgz+1b9xbLiq9e4rxc+aFqV7mLUmtA2lOe+sAufCUOfCNUPGTFXb+p5/+vYXvJhGNjGa1ApWUnS7Ak6zxGoleaU32b1whadhXPOQ5heXA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(6506007)(1076003)(36756003)(8676002)(2906002)(6512007)(6486002)(478600001)(83380400001)(6666004)(2616005)(186003)(26005)(5660300002)(30864003)(316002)(86362001)(6916009)(41300700001)(66476007)(8936002)(4326008)(38100700002)(786003)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0oI+NAfRq+SMytFGLajObTQNg6jOEbK5ivI55D38e7O874VHay+owK3acmQr?=
 =?us-ascii?Q?3EqF5coujJPlqZQqHd5WQXsjSUFOhhGuRJAQq1/Kmv2LklOIUTeFPwOS+Sx0?=
 =?us-ascii?Q?xsw49xz9UiXU0SEDGeUyTDjrQOfrTnJoV4ysJb8Gk3mBJu+xIFETGfIg7RmZ?=
 =?us-ascii?Q?wCRvt8jueYUEbBndeXF5xMc1SIadgFywAc6eSITG16VJD70KYnEKx5DBieMd?=
 =?us-ascii?Q?hnEcarvJktNwIcvKXnYfn5bq/BKbOTYOgAS4ADo4mNeA7ni3+nKl8/aG5SXe?=
 =?us-ascii?Q?5rmke0fMMMXG8oMBUGSLuaBPL8h7dNgJGKCCenR0g8S9imw7tvyRA3HFL1rp?=
 =?us-ascii?Q?cFcOdHsXYit60C+c8M3sD0/zb8Wn/uhzv4D4lBY258bNguwa/a3JEr0rCbby?=
 =?us-ascii?Q?pmpR68BckqdDtjx4Tjm47JF41cmWfJSda2CIyh0T2j/VHtVJrUrzTsU9aXma?=
 =?us-ascii?Q?0jnt9/BuCcK3Pe0ZRqBI9VrwXnqPaaTvMQ+gA2wunaO2swE3a4KgBi6fj7Ah?=
 =?us-ascii?Q?kt+vGbzL4ijQprdscdcd3vU8VDb9khaiBnd2dqJgUBVj0fwdyXqRPe6lP4Rz?=
 =?us-ascii?Q?6OBBfN6oJaP1a49l3jeRfk8OxAboCviidGr/OssgUebeEkxF8B0bf8LZOlcs?=
 =?us-ascii?Q?PtTtiAa1xuAY5jcB+RJUDhaWLJcoA0ZU/AsPqmQCGgoGnmM18GzDjENXnvL5?=
 =?us-ascii?Q?V4tgshQlTUsCl3RuSO62M+Pot0SjyJWSQCn9sq4I+qeiIRBpXOh4Xiic+ssn?=
 =?us-ascii?Q?1FbQXQMwF4M/yuM4VGYHxtZSRAb9uKH+uvLk4gY1XXLloLszas32gBj7xlVQ?=
 =?us-ascii?Q?PFJGZrGd907xfsF6xkzN6NI9wfFKNT078hQnVwCvSKIj4TqCAHgVddrHDLLS?=
 =?us-ascii?Q?NCSgX0rEE1OnL8jds0+b6UvNJO5AXkN57z6fXlQv9oC4QuAqHUUswEPDLM5u?=
 =?us-ascii?Q?oD0gSCCXXFJZuThQEOZbrFi/NOO4N7i+Orazh+JisGKGErADAw2l+WZzVlPy?=
 =?us-ascii?Q?9v6I0vFRMc9sOfoPcP27c5Z9BSViJgFv4JB6m483QqaKXr6y/GYEGZIblOcr?=
 =?us-ascii?Q?QF9u3BB1wAYdlJn7FYspbtsNdjGcQIskrC3ngcipk4qTnv/HFpHk6CzuH5Pv?=
 =?us-ascii?Q?iGT3spk5p+BZcu/MRenH/t6X7RadKHkme0h/oRa0D7pp86fu3swG/m33UaMv?=
 =?us-ascii?Q?pNNayZItFY/Ds/+PXLASmAa0ulbitWdxn6I6M50RjagYUYv1YmOprQArC2mN?=
 =?us-ascii?Q?CWoZ80/maAUYBZV2ORSMnNTjpe5vk7RLADAJwxNxuH4Wm4IBbQFx09xMy7gx?=
 =?us-ascii?Q?pNDZm52uh8xwE7w88NTwII0pEK1p5d1KRXqiiUcPtQ2Cjec/RodFpy2aKTvA?=
 =?us-ascii?Q?27EymxwckpS7zjYfTQwixTYIcSOmPM6G6Y2gRhmXOAMa7Kr4pkrpCCzl3qD9?=
 =?us-ascii?Q?aJI5nAu01z+JXxwUQ/0R/NUiXg03cguQJ5hWlsObO0+BVTfoOMQ+NkKBfUXI?=
 =?us-ascii?Q?GwhP8OE9lvks72YcsRvb5REOOo5rITWK/6J4kV9ifIcAtNxFZ6Jyxp1dl/mk?=
 =?us-ascii?Q?DP56AYR9Ge5aMo/XLMr4iCQfuPxO4mKxRM4W3rp2?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a2ea5d-e6b3-41a0-2be6-08db78f6eb9b
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:51.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WLF1w/bYs84AsF4dvyhmafpkLSs+h0TZbc/SAcUH9EooISl6tgSrSWXpg4eB8OgZeXblIeErHb/SJsXRQQjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6082
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCN550x is very similar to QCA956x. Note that AR_CH0_XTAL is
intentionally unchanged.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ani.c          |  2 +-
 drivers/net/wireless/ath/ath9k/ar9003_calib.c |  4 +-
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 37 ++++++--
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c |  4 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c   | 48 ++++++----
 drivers/net/wireless/ath/ath9k/ar9003_phy.h   | 91 +++++++++++++------
 drivers/net/wireless/ath/ath9k/hw.c           | 33 ++++---
 drivers/net/wireless/ath/ath9k/mac.c          |  2 +-
 drivers/net/wireless/ath/ath9k/recv.c         |  2 +-
 drivers/net/wireless/ath/ath9k/reg.h          |  4 +-
 10 files changed, 149 insertions(+), 78 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ani.c b/drivers/net/wireless/ath/ath9k/ani.c
index 41d192709e..281103865d 100644
--- a/drivers/net/wireless/ath/ath9k/ani.c
+++ b/drivers/net/wireless/ath/ath9k/ani.c
@@ -261,7 +261,7 @@ static void ath9k_hw_set_cck_nil(struct ath_hw *ah, u_int8_t immunityLevel,
 
 	/* Skip MRC CCK for pre AR9003 families */
 	if (!AR_SREV_9300_20_OR_LATER(ah) || AR_SREV_9485(ah) ||
-	    AR_SREV_9565(ah) || AR_SREV_9561(ah))
+	    AR_SREV_9565(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		return;
 
 	if (aniState->mrcCCK != entry_cck->mrc_cck_on)
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
index 6d1f1242e6..95475e02af 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
@@ -201,7 +201,7 @@ static void ar9003_hw_iqcalibrate(struct ath_hw *ah, u8 numChains)
 	u32 qCoffDenom, iCoffDenom;
 	int32_t qCoff, iCoff;
 	int iqCorrNeg, i;
-	static const u_int32_t offset_array[3] = {
+	const u_int32_t offset_array[3] = {
 		AR_PHY_RX_IQCAL_CORR_B0(ah),
 		AR_PHY_RX_IQCAL_CORR_B1(ah),
 		AR_PHY_RX_IQCAL_CORR_B2(ah),
@@ -1202,7 +1202,7 @@ static void ar9003_hw_manual_peak_cal(struct ath_hw *ah, u8 chain, bool is_2g)
 
 	if (AR_SREV_9550(ah) || AR_SREV_9531(ah))
 		peak_detect_threshold = 8;
-	else if (AR_SREV_9561(ah))
+	else if (AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		peak_detect_threshold = 11;
 
 	/*
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 0f8af8c958..810d75f553 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3619,6 +3619,8 @@ static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
 	if (AR_SREV_9485(ah) || AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
 	    AR_SREV_9531(ah) || AR_SREV_9561(ah))
 		REG_RMW_FIELD(ah, AR_CH0_TOP2(ah), AR_CH0_TOP2_XPABIASLVL, bias);
+	else if (AR_SREV_5502(ah))
+		REG_RMW_FIELD(ah, AR_CH0_TOP3, AR_CH0_TOP3_XPABIASLVL, bias);
 	else if (AR_SREV_9462(ah) || AR_SREV_9550(ah) || AR_SREV_9565(ah))
 		REG_RMW_FIELD(ah, AR_CH0_TOP(ah), AR_CH0_TOP_XPABIASLVL, bias);
 	else {
@@ -3637,7 +3639,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 	struct ath9k_hw_capabilities *pCap = &ah->caps;
 	int chain;
 	u32 regval, value, gpio;
-	static const u32 switch_chain_reg[AR9300_MAX_CHAINS] = {
+	const u32 switch_chain_reg[AR9300_MAX_CHAINS] = {
 			AR_PHY_SWITCH_CHAIN_0(ah),
 			AR_PHY_SWITCH_CHAIN_1(ah),
 			AR_PHY_SWITCH_CHAIN_2(ah),
@@ -3658,7 +3660,8 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 	if (AR_SREV_9462(ah) || AR_SREV_9565(ah)) {
 		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM(ah),
 				AR_SWITCH_TABLE_COM_AR9462_ALL, value);
-	} else if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
+	} else if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+		   AR_SREV_5502(ah)) {
 		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM(ah),
 				AR_SWITCH_TABLE_COM_AR9550_ALL, value);
 	} else
@@ -3989,11 +3992,11 @@ void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 			if (!is_pmu_set(ah, AR_PHY_PMU2(ah), reg_pmu_set))
 				return;
 		} else if (AR_SREV_9462(ah) || AR_SREV_9565(ah) ||
-			   AR_SREV_9561(ah)) {
+			   AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 			reg_val = le32_to_cpu(pBase->swreg);
 			REG_WRITE(ah, AR_PHY_PMU1(ah), reg_val);
 
-			if (AR_SREV_9561(ah))
+			if (AR_SREV_9561(ah) || AR_SREV_5502(ah))
 				REG_WRITE(ah, AR_PHY_PMU2(ah), 0x10200000);
 		} else {
 			/* Internal regulator is ON. Write swreg register. */
@@ -4037,17 +4040,23 @@ void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 static void ar9003_hw_apply_tuning_caps(struct ath_hw *ah)
 {
 	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	u8 tuning_caps_param = eep->baseEepHeader.params_for_tuning_caps[0];
+	u8 param_0, param_1;
 
 	if (AR_SREV_9340(ah) || AR_SREV_9531(ah))
 		return;
 
 	if (eep->baseEepHeader.featureEnable & 0x40) {
-		tuning_caps_param &= 0x7f;
+		param_0 = eep->baseEepHeader.params_for_tuning_caps[0];
+		if (AR_SREV_5502(ah)) {
+			param_1 = eep->baseEepHeader.params_for_tuning_caps[1];
+		} else {
+			param_0 &= 0x7f;
+			param_1 = param_0;
+		}
 		REG_RMW_FIELD(ah, AR_CH0_XTAL(ah), AR_CH0_XTAL_CAPINDAC,
-			      tuning_caps_param);
+			      param_0);
 		REG_RMW_FIELD(ah, AR_CH0_XTAL(ah), AR_CH0_XTAL_CAPOUTDAC,
-			      tuning_caps_param);
+			      param_1);
 	}
 }
 
@@ -4098,7 +4107,8 @@ static void ar9003_hw_xpa_timing_control_apply(struct ath_hw *ah, bool is2ghz)
 	    !AR_SREV_9340(ah) &&
 	    !AR_SREV_9580(ah) &&
 	    !AR_SREV_9531(ah) &&
-	    !AR_SREV_9561(ah))
+	    !AR_SREV_9561(ah) &&
+	    !AR_SREV_5502(ah))
 		return;
 
 	xpa_ctl = ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
@@ -4878,7 +4888,8 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 	}
 
 tempslope:
-	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
+	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+	    AR_SREV_5502(ah)) {
 		u8 txmask = (eep->baseEepHeader.txrxMask & 0xf0) >> 4;
 
 		/*
@@ -4940,6 +4951,12 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 
 	REG_RMW_FIELD(ah, AR_PHY_TPC_18(ah), AR_PHY_TPC_18_THERM_CAL_VALUE,
 		      temperature[0]);
+	if (AR_SREV_5502(ah)) {
+		REG_RMW_FIELD(ah, AR_PHY_TPC_18_B1(ah),
+			      AR_PHY_TPC_18_THERM_CAL_VALUE, temperature[1]);
+		REG_RMW_FIELD(ah, AR_PHY_TPC_18_B2(ah),
+			      AR_PHY_TPC_18_THERM_CAL_VALUE, temperature[2]);
+	}
 }
 
 /* Apply the recorded correction values. */
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
index 28192df046..ec2d38f13d 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
@@ -138,12 +138,12 @@ static int ar9003_get_training_power_5g(struct ath_hw *ah)
 static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	static const u32 ctrl0[3] = {
+	const u32 ctrl0[3] = {
 		AR_PHY_PAPRD_CTRL0_B0(ah),
 		AR_PHY_PAPRD_CTRL0_B1(ah),
 		AR_PHY_PAPRD_CTRL0_B2(ah)
 	};
-	static const u32 ctrl1[3] = {
+	const u32 ctrl1[3] = {
 		AR_PHY_PAPRD_CTRL1_B0(ah),
 		AR_PHY_PAPRD_CTRL1_B1(ah),
 		AR_PHY_PAPRD_CTRL1_B2(ah)
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index 7944d12f2e..1009739f0d 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -146,6 +146,7 @@ static const u8 mcs2pwr_ht40[] = {
  * Channel Frequency = (3/2) * freq_ref * (chansel[8:0] + chanfrac[16:0]/2^17)
  * (freq_ref = 40MHz)
  */
+
 static int ar9003_hw_set_channel(struct ath_hw *ah, struct ath9k_channel *chan)
 {
 	u16 bMode, fracMode = 0, aModeRefSel = 0;
@@ -157,14 +158,17 @@ static int ar9003_hw_set_channel(struct ath_hw *ah, struct ath9k_channel *chan)
 	freq = centers.synth_center;
 
 	if (freq < 4800) {     /* 2 GHz, fractional mode */
-		if (AR_SREV_9330(ah) || AR_SREV_9485(ah) ||
-		    AR_SREV_9531(ah) || AR_SREV_9550(ah) ||
-		    AR_SREV_9561(ah) || AR_SREV_9565(ah)) {
+		if (AR_SREV_9330(ah) || AR_SREV_9485(ah) || AR_SREV_9531(ah) ||
+		    AR_SREV_9550(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah) ||
+		    AR_SREV_9565(ah)) {
 			if (ah->is_clk_25mhz)
 				div = 75;
 			else
 				div = 120;
 
+			/* Clock doubler is on for QCN5502. */
+			if (AR_SREV_5502(ah)) div <<= 1;
+
 			channelSel = (freq * 4) / div;
 			chan_frac = (((freq * 4) % div) * 0x20000) / div;
 			channelSel = (channelSel << 17) | chan_frac;
@@ -182,11 +186,16 @@ static int ar9003_hw_set_channel(struct ath_hw *ah, struct ath9k_channel *chan)
 		/* Set to 2G mode */
 		bMode = 1;
 	} else {
-		if ((AR_SREV_9340(ah) || AR_SREV_9550(ah) ||
-		     AR_SREV_9531(ah) || AR_SREV_9561(ah)) &&
+		if ((AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
+		     AR_SREV_9561(ah) || AR_SREV_5502(ah)) &&
 		    ah->is_clk_25mhz) {
-			channelSel = freq / 75;
-			chan_frac = ((freq % 75) * 0x20000) / 75;
+			div = 75;
+
+			/* Clock doubler is on for QCN5502. */
+			if (AR_SREV_5502(ah)) div <<= 1;
+
+			channelSel = freq / div;
+			chan_frac = ((freq % div) * 0x20000) / div;
 			channelSel = (channelSel << 17) | chan_frac;
 		} else {
 			channelSel = CHANSEL_5G(freq);
@@ -250,7 +259,7 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 	 */
 
 	if (AR_SREV_9485(ah) || AR_SREV_9340(ah) || AR_SREV_9330(ah) ||
-	    AR_SREV_9550(ah) || AR_SREV_9561(ah)) {
+	    AR_SREV_9550(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 		if (spur_fbin_ptr[0] == 0) /* No spur */
 			return;
 		max_spur_cnts = 5;
@@ -277,7 +286,7 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 
 		negative = 0;
 		if (AR_SREV_9485(ah) || AR_SREV_9340(ah) || AR_SREV_9330(ah) ||
-		    AR_SREV_9550(ah) || AR_SREV_9561(ah))
+		    AR_SREV_9550(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah))
 			cur_bb_spur = ath9k_hw_fbin2freq(spur_fbin_ptr[i],
 							 IS_CHAN_2GHZ(chan));
 		else
@@ -619,7 +628,7 @@ static void ar9003_hw_set_channel_regs(struct ath_hw *ah,
 	/* Enable 11n HT, 20 MHz */
 	phymode = AR_PHY_GC_HT_EN | AR_PHY_GC_SHORT_GI_40 | enableDacFifo;
 
-	if (!AR_SREV_9561(ah))
+	if (!(AR_SREV_9561(ah) || AR_SREV_5502(ah)))
 		phymode |= AR_PHY_GC_SINGLE_HT_LTF1;
 
 	/* Configure baseband for dynamic 20/40 operation */
@@ -724,7 +733,7 @@ static void ar9003_hw_override_ini(struct ath_hw *ah)
 		ah->enabled_cals &= ~TX_CL_CAL;
 
 	if (AR_SREV_9340(ah) || AR_SREV_9531(ah) || AR_SREV_9550(ah) ||
-	    AR_SREV_9561(ah)) {
+	    AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 		if (ah->is_clk_25mhz) {
 			REG_WRITE(ah, AR_RTC_DERIVED_CLK(ah), 0x17c << 1);
 			REG_WRITE(ah, AR_SLP32_MODE, 0x0010f3d7);
@@ -905,23 +914,25 @@ static int ar9003_hw_process_ini(struct ath_hw *ah,
 		}
 	}
 
-	if (AR_SREV_9550(ah) || AR_SREV_9561(ah))
+	if (AR_SREV_9550(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		REG_WRITE_ARRAY(&ah->ini_modes_rx_gain_bounds, modesIndex,
 				regWrites);
 
-	if (AR_SREV_9561(ah) && (ar9003_hw_get_rx_gain_idx(ah) == 0))
+	if ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) &&
+	    (ar9003_hw_get_rx_gain_idx(ah) == 0))
 		REG_WRITE_ARRAY(&ah->ini_modes_rxgain_xlna,
 				modesIndex, regWrites);
 	/*
 	 * TXGAIN initvals.
 	 */
-	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
+	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+	    AR_SREV_5502(ah)) {
 		int modes_txgain_index = 1;
 
 		if (AR_SREV_9550(ah))
 			modes_txgain_index = ar9550_hw_get_modes_txgain_index(ah, chan);
 
-		if (AR_SREV_9561(ah))
+		if (AR_SREV_9561(ah) || AR_SREV_5502(ah))
 			modes_txgain_index =
 				ar9561_hw_get_modes_txgain_index(ah, chan);
 
@@ -1922,7 +1933,7 @@ void ar9003_hw_attach_phy_ops(struct ath_hw *ah)
 {
 	struct ath_hw_private_ops *priv_ops = ath9k_hw_private_ops(ah);
 	struct ath_hw_ops *ops = ath9k_hw_ops(ah);
-	static const u32 ar9300_cca_regs[6] = {
+	const u32 ar9300_cca_regs[6] = {
 		AR_PHY_CCA_0(ah),
 		AR_PHY_CCA_1(ah),
 		AR_PHY_CCA_2(ah),
@@ -1935,7 +1946,7 @@ void ar9003_hw_attach_phy_ops(struct ath_hw *ah)
 	priv_ops->spur_mitigate_freq = ar9003_hw_spur_mitigate;
 
 	if (AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-	    AR_SREV_9561(ah))
+	    AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		priv_ops->compute_pll_control = ar9003_hw_compute_pll_control_soc;
 	else
 		priv_ops->compute_pll_control = ar9003_hw_compute_pll_control;
@@ -2021,7 +2032,8 @@ bool ar9003_hw_bb_watchdog_check(struct ath_hw *ah)
 	case 0x04000b09:
 		return true;
 	case 0x04000409:
-		if (AR_SREV_9340(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah))
+		if (AR_SREV_9340(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+		    AR_SREV_5502(ah))
 			return false;
 		else
 			return true;
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index ce7c398b8c..8bc62ca483 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -20,7 +20,7 @@
 /*
  * Channel Register Map
  */
-#define AR_CHAN_BASE(_ah)	0x9800
+#define AR_CHAN_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x29800 : 0x9800)
 
 #define AR_PHY_TIMING1(_ah)      (AR_CHAN_BASE(_ah) + 0x0)
 #define AR_PHY_TIMING2(_ah)      (AR_CHAN_BASE(_ah) + 0x4)
@@ -214,7 +214,7 @@
 /*
  * MRC Register Map
  */
-#define AR_MRC_BASE(_ah)	0x9c00
+#define AR_MRC_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x29c00 : 0x9c00)
 
 #define AR_PHY_TIMING_3A(_ah)       (AR_MRC_BASE(_ah) + 0x0)
 #define AR_PHY_LDPC_CNTL1(_ah)      (AR_MRC_BASE(_ah) + 0x4)
@@ -255,12 +255,12 @@
 /*
  * BBB Register Map
  */
-#define AR_BBB_BASE(_ah)	0x9d00
+#define AR_BBB_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x29d00 : 0x9d00)
 
 /*
  * AGC Register Map
  */
-#define AR_AGC_BASE(_ah)	0x9e00
+#define AR_AGC_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x29e00 : 0x9e00)
 
 #define AR_PHY_SETTLING(_ah)         (AR_AGC_BASE(_ah) + 0x0)
 #define AR_PHY_FORCEMAX_GAINS_0(_ah) (AR_AGC_BASE(_ah) + 0x4)
@@ -448,14 +448,18 @@
 /*
  * SM Register Map
  */
-#define AR_SM_BASE(_ah)	0xa200
+#define AR_SM_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x2a200 : 0xa200)
 
 #define AR_PHY_D2_CHIP_ID(_ah)        (AR_SM_BASE(_ah) + 0x0)
 #define AR_PHY_GEN_CTRL(_ah)          (AR_SM_BASE(_ah) + 0x4)
 #define AR_PHY_MODE(_ah)              (AR_SM_BASE(_ah) + 0x8)
 #define AR_PHY_ACTIVE(_ah)            (AR_SM_BASE(_ah) + 0xc)
-#define AR_PHY_SPUR_MASK_A(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x18 : 0x20))
-#define AR_PHY_SPUR_MASK_B(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x1c : 0x24))
+#define AR_PHY_SPUR_MASK_A(_ah) \
+	(AR_SM_BASE(_ah) +      \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x18 : 0x20))
+#define AR_PHY_SPUR_MASK_B(_ah) \
+	(AR_SM_BASE(_ah) +      \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x1c : 0x24))
 #define AR_PHY_SPECTRAL_SCAN(_ah)     (AR_SM_BASE(_ah) + 0x28)
 #define AR_PHY_RADAR_BW_FILTER(_ah)   (AR_SM_BASE(_ah) + 0x2c)
 #define AR_PHY_SEARCH_START_DELAY(_ah) (AR_SM_BASE(_ah) + 0x30)
@@ -498,7 +502,9 @@
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A                       0x3FF
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A_S                     0
 
-#define AR_PHY_TEST(_ah)         (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x15c : 0x160))
+#define AR_PHY_TEST(_ah)   \
+	(AR_SM_BASE(_ah) + \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x15c : 0x160))
 
 #define AR_PHY_TEST_BBB_OBS_SEL       0x780000
 #define AR_PHY_TEST_BBB_OBS_SEL_S     19
@@ -509,7 +515,9 @@
 #define AR_PHY_TEST_CHAIN_SEL      0xC0000000
 #define AR_PHY_TEST_CHAIN_SEL_S    30
 
-#define AR_PHY_TEST_CTL_STATUS(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x160 : 0x164))
+#define AR_PHY_TEST_CTL_STATUS(_ah) \
+	(AR_SM_BASE(_ah) +          \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x160 : 0x164))
 #define AR_PHY_TEST_CTL_TSTDAC_EN         0x1
 #define AR_PHY_TEST_CTL_TSTDAC_EN_S       0
 #define AR_PHY_TEST_CTL_TX_OBS_SEL        0x1C
@@ -523,23 +531,42 @@
 #define AR_PHY_TEST_CTL_DEBUGPORT_SEL	  0xe0000000
 #define AR_PHY_TEST_CTL_DEBUGPORT_SEL_S	  29
 
+#define AR_PHY_TSTDAC(_ah) \
+	(AR_SM_BASE(_ah) + \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x164 : 0x168))
 
-#define AR_PHY_TSTDAC(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x164 : 0x168))
+#define AR_PHY_CHAN_STATUS(_ah) \
+	(AR_SM_BASE(_ah) +      \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x168 : 0x16c))
 
-#define AR_PHY_CHAN_STATUS(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x168 : 0x16c))
-
-#define AR_PHY_CHAN_INFO_MEMORY(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x16c : 0x170))
+#define AR_PHY_CHAN_INFO_MEMORY(_ah) \
+	(AR_SM_BASE(_ah) +           \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x16c : 0x170))
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ	0x00000008
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ_S	3
 
-#define AR_PHY_CHNINFO_NOISEPWR(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x170 : 0x174))
-#define AR_PHY_CHNINFO_GAINDIFF(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x174 : 0x178))
-#define AR_PHY_CHNINFO_FINETIM(_ah)   (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x178 : 0x17c))
-#define AR_PHY_CHAN_INFO_GAIN_0(_ah)  (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x17c : 0x180))
-#define AR_PHY_SCRAMBLER_SEED(_ah)    (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x184 : 0x190))
-#define AR_PHY_CCK_TX_CTRL(_ah)       (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x188 : 0x194))
-
-#define AR_PHY_HEAVYCLIP_CTL(_ah) (AR_SM_BASE(_ah) + (AR_SREV_9561(_ah) ? 0x198 : 0x1a4))
+#define AR_PHY_CHNINFO_NOISEPWR(_ah) \
+	(AR_SM_BASE(_ah) +           \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x170 : 0x174))
+#define AR_PHY_CHNINFO_GAINDIFF(_ah) \
+	(AR_SM_BASE(_ah) +           \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x174 : 0x178))
+#define AR_PHY_CHNINFO_FINETIM(_ah) \
+	(AR_SM_BASE(_ah) +          \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x178 : 0x17c))
+#define AR_PHY_CHAN_INFO_GAIN_0(_ah) \
+	(AR_SM_BASE(_ah) +           \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x17c : 0x180))
+#define AR_PHY_SCRAMBLER_SEED(_ah) \
+	(AR_SM_BASE(_ah) +         \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x184 : 0x190))
+#define AR_PHY_CCK_TX_CTRL(_ah) \
+	(AR_SM_BASE(_ah) +      \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x188 : 0x194))
+
+#define AR_PHY_HEAVYCLIP_CTL(_ah) \
+	(AR_SM_BASE(_ah) +        \
+	 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x198 : 0x1a4))
 #define AR_PHY_HEAVYCLIP_20(_ah)      (AR_SM_BASE(_ah) + 0x1a8)
 #define AR_PHY_HEAVYCLIP_40(_ah)      (AR_SM_BASE(_ah) + 0x1ac)
 #define AR_PHY_HEAVYCLIP_1(_ah)	 (AR_SM_BASE(_ah) + 0x19c)
@@ -575,6 +602,8 @@
 #define AR_PHY_TPC_12_DESIRED_SCALE_HT40_5_S	25
 
 #define AR_PHY_TPC_18(_ah)			(AR_SM_BASE(_ah) + 0x23c)
+#define AR_PHY_TPC_18_B1(_ah)			(AR_SM1_BASE(_ah) + 0x23c)
+#define AR_PHY_TPC_18_B2(_ah)			(AR_SM2_BASE(_ah) + 0x23c)
 #define AR_PHY_TPC_18_THERM_CAL_VALUE           0x000000ff
 #define AR_PHY_TPC_18_THERM_CAL_VALUE_S         0
 #define AR_PHY_TPC_18_VOLT_CAL_VALUE		0x0000ff00
@@ -722,6 +751,10 @@
 #define AR_CH0_TOP2_XPABIASLVL		(AR_SREV_9561(ah) ? 0x1e00 : 0xf000)
 #define AR_CH0_TOP2_XPABIASLVL_S	(AR_SREV_9561(ah) ? 9 : 12)
 
+#define AR_CH0_TOP3		0x16288
+#define AR_CH0_TOP3_XPABIASLVL		0xf0000
+#define AR_CH0_TOP3_XPABIASLVL_S	16
+
 #define AR_CH0_XTAL(_ah)	(AR_SREV_9300(_ah) ? 0x16294 : \
 				 ((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x16298 : \
 				  (AR_SREV_9561(_ah) ? 0x162c0 : 0x16290)))
@@ -731,12 +764,12 @@
 #define AR_CH0_XTAL_CAPOUTDAC_S	17
 
 #define AR_PHY_PMU1(_ah)	((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x16340 : \
-				 (AR_SREV_9561(_ah) ? 0x16cc0 : 0x16c40))
+				 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x16cc0 : 0x16c40))
 #define AR_PHY_PMU1_PWD		0x1
 #define AR_PHY_PMU1_PWD_S	0
 
 #define AR_PHY_PMU2(_ah)	((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x16344 : \
-				 (AR_SREV_9561(_ah) ? 0x16cc4 : 0x16c44))
+				 ((AR_SREV_9561(_ah) || AR_SREV_5502(_ah)) ? 0x16cc4 : 0x16c44))
 #define AR_PHY_PMU2_PGM		0x00200000
 #define AR_PHY_PMU2_PGM_S	21
 
@@ -923,7 +956,7 @@
 /*
  * Channel 1 Register Map
  */
-#define AR_CHAN1_BASE(_ah)	0xa800
+#define AR_CHAN1_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x2a800 : 0xa800)
 
 #define AR_PHY_EXT_CCA_1(_ah)            (AR_CHAN1_BASE(_ah) + 0x30)
 #define AR_PHY_TX_PHASE_RAMP_1(_ah)      (AR_CHAN1_BASE(_ah) + 0xd0)
@@ -942,7 +975,7 @@
 /*
  * AGC 1 Register Map
  */
-#define AR_AGC1_BASE(_ah)	0xae00
+#define AR_AGC1_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x2ae00 : 0xae00)
 
 #define AR_PHY_FORCEMAX_GAINS_1(_ah)      (AR_AGC1_BASE(_ah) + 0x4)
 #define AR_PHY_EXT_ATTEN_CTL_1(_ah)       (AR_AGC1_BASE(_ah) + 0x18)
@@ -961,7 +994,7 @@
 /*
  * SM 1 Register Map
  */
-#define AR_SM1_BASE(_ah)	0xb200
+#define AR_SM1_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x2b200 : 0xb200)
 
 #define AR_PHY_SWITCH_CHAIN_1(_ah)   (AR_SM1_BASE(_ah) + 0x84)
 #define AR_PHY_FCAL_2_1(_ah)         (AR_SM1_BASE(_ah) + 0xd0)
@@ -987,7 +1020,7 @@
 /*
  * Channel 2 Register Map
  */
-#define AR_CHAN2_BASE(_ah)	0xb800
+#define AR_CHAN2_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x2b800 : 0xb800)
 
 #define AR_PHY_EXT_CCA_2(_ah)            (AR_CHAN2_BASE(_ah) + 0x30)
 #define AR_PHY_TX_PHASE_RAMP_2(_ah)      (AR_CHAN2_BASE(_ah) + 0xd0)
@@ -1005,7 +1038,7 @@
 /*
  * AGC 2 Register Map
  */
-#define AR_AGC2_BASE(_ah)	0xbe00
+#define AR_AGC2_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x2be00 : 0xbe00)
 
 #define AR_PHY_FORCEMAX_GAINS_2(_ah)      (AR_AGC2_BASE(_ah) + 0x4)
 #define AR_PHY_EXT_ATTEN_CTL_2(_ah)       (AR_AGC2_BASE(_ah) + 0x18)
@@ -1022,7 +1055,7 @@
 /*
  * SM 2 Register Map
  */
-#define AR_SM2_BASE(_ah)	0xc200
+#define AR_SM2_BASE(_ah)	(AR_SREV_5502(_ah) ? 0x2c200 : 0xc200)
 
 #define AR_PHY_SWITCH_CHAIN_2(_ah)    (AR_SM2_BASE(_ah) + 0x84)
 #define AR_PHY_FCAL_2_2(_ah)          (AR_SM2_BASE(_ah) + 0xd0)
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index e63314544a..f572fca3e6 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -834,7 +834,7 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 		REG_RMW_FIELD(ah, AR_CH0_BB_DPLL3,
 			      AR_CH0_BB_DPLL3_PHASE_SHIFT, 0x1);
 	} else if (AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-		   AR_SREV_9561(ah)) {
+		   AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 		u32 regval, pll2_divint, pll2_divfrac, refdiv;
 
 		REG_WRITE(ah, AR_RTC_PLL_CONTROL(ah),
@@ -845,7 +845,8 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 		udelay(100);
 
 		if (ah->is_clk_25mhz) {
-			if (AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
+			if (AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+			    AR_SREV_5502(ah)) {
 				pll2_divint = 0x1c;
 				pll2_divfrac = 0xa3d2;
 				refdiv = 1;
@@ -861,15 +862,16 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 				refdiv = 5;
 			} else {
 				pll2_divint = 0x11;
-				pll2_divfrac = (AR_SREV_9531(ah) ||
-						AR_SREV_9561(ah)) ?
+				pll2_divfrac =
+					(AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+					 AR_SREV_5502(ah)) ?
 						0x26665 : 0x26666;
 				refdiv = 1;
 			}
 		}
 
 		regval = REG_READ(ah, AR_PHY_PLL_MODE);
-		if (AR_SREV_9531(ah) || AR_SREV_9561(ah))
+		if (AR_SREV_9531(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah))
 			regval |= (0x1 << 22);
 		else
 			regval |= (0x1 << 16);
@@ -887,7 +889,8 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 				(0x1 << 13) |
 				(0x4 << 26) |
 				(0x18 << 19);
-		else if (AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
+		else if (AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+			 AR_SREV_5502(ah)) {
 			regval = (regval & 0x01c00fff) |
 				(0x1 << 31) |
 				(0x2 << 29) |
@@ -904,7 +907,7 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 				(0x60 << 19);
 		REG_WRITE(ah, AR_PHY_PLL_MODE, regval);
 
-		if (AR_SREV_9531(ah) || AR_SREV_9561(ah))
+		if (AR_SREV_9531(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah))
 			REG_WRITE(ah, AR_PHY_PLL_MODE,
 				  REG_READ(ah, AR_PHY_PLL_MODE) & 0xffbfffff);
 		else
@@ -945,7 +948,7 @@ static void ath9k_hw_init_interrupt_masks(struct ath_hw *ah,
 	u32 msi_cfg = 0;
 
 	if (AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-	    AR_SREV_9561(ah))
+	    AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		sync_default &= ~AR_INTR_SYNC_HOST1_FATAL;
 
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
@@ -1235,8 +1238,9 @@ static inline void ath9k_hw_set_dma(struct ath_hw *ah)
 	REG_WRITE(ah, AR_RXFIFO_CFG, 0x200);
 
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
-		REG_RMW_FIELD(ah, AR_RXBP_THRESH, AR_RXBP_THRESH_HP, 0x1);
-		REG_RMW_FIELD(ah, AR_RXBP_THRESH, AR_RXBP_THRESH_LP, 0x1);
+		u8 rxbp = AR_SREV_5502(ah) ? 0x3 : 0x1;
+		REG_RMW_FIELD(ah, AR_RXBP_THRESH, AR_RXBP_THRESH_HP, rxbp);
+		REG_RMW_FIELD(ah, AR_RXBP_THRESH, AR_RXBP_THRESH_LP, rxbp);
 
 		ath9k_hw_set_rx_bufsize(ah, common->rx_bufsize -
 			ah->caps.rx_status_len);
@@ -1777,7 +1781,7 @@ static void ath9k_hw_init_desc(struct ath_hw *ah)
 #ifdef __BIG_ENDIAN
 		else if (AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
 			 AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-			 AR_SREV_9561(ah))
+			 AR_SREV_9561(ah) || AR_SREV_5502(ah))
 			REG_RMW(ah, AR_CFG, AR_CFG_SWRB | AR_CFG_SWTB, 0);
 		else
 			REG_WRITE(ah, AR_CFG, AR_CFG_SWTD | AR_CFG_SWRD);
@@ -2474,6 +2478,9 @@ static void ath9k_gpio_cap_init(struct ath_hw *ah)
 	} else if (AR_SREV_9561(ah)) {
 		pCap->num_gpio_pins = AR9561_NUM_GPIO;
 		pCap->gpio_mask = AR9561_GPIO_MASK;
+	} else if (AR_SREV_5502(ah)) {
+		pCap->num_gpio_pins = AR5502_NUM_GPIO;
+		pCap->gpio_mask = AR5502_GPIO_MASK;
 	} else if (AR_SREV_9565(ah)) {
 		pCap->num_gpio_pins = AR9565_NUM_GPIO;
 		pCap->gpio_mask = AR9565_GPIO_MASK;
@@ -2610,7 +2617,7 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
 		pCap->hw_caps |= ATH9K_HW_CAP_EDMA | ATH9K_HW_CAP_FASTCLOCK;
 		if (!AR_SREV_9330(ah) && !AR_SREV_9485(ah) &&
-		    !AR_SREV_9561(ah) && !AR_SREV_9565(ah))
+		    !AR_SREV_9561(ah) && !AR_SREV_5502(ah) && !AR_SREV_9565(ah))
 			pCap->hw_caps |= ATH9K_HW_CAP_LDPC;
 
 		pCap->rx_hp_qdepth = ATH9K_HW_RX_HP_QDEPTH;
@@ -2627,7 +2634,7 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 	if (AR_SREV_9300_20_OR_LATER(ah))
 		pCap->hw_caps |= ATH9K_HW_CAP_RAC_SUPPORTED;
 
-	if (AR_SREV_9561(ah))
+	if (AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		ah->ent_mode = 0x3BDA000;
 	else if (AR_SREV_9300_20_OR_LATER(ah))
 		ah->ent_mode = REG_READ(ah, AR_ENT_OTP);
diff --git a/drivers/net/wireless/ath/ath9k/mac.c b/drivers/net/wireless/ath/ath9k/mac.c
index b070403e08..b18c437ca4 100644
--- a/drivers/net/wireless/ath/ath9k/mac.c
+++ b/drivers/net/wireless/ath/ath9k/mac.c
@@ -813,7 +813,7 @@ static void __ath9k_hw_enable_interrupts(struct ath_hw *ah)
 	u32 async_mask;
 
 	if (AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-	    AR_SREV_9561(ah))
+	    AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		sync_default &= ~AR_INTR_SYNC_HOST1_FATAL;
 
 	async_mask = AR_INTR_MAC_IRQ;
diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 0c0624a3b4..3299aef65e 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -422,7 +422,7 @@ u32 ath_calcrxfilter(struct ath_softc *sc)
 	}
 
 	if (AR_SREV_9550(sc->sc_ah) || AR_SREV_9531(sc->sc_ah) ||
-	    AR_SREV_9561(sc->sc_ah))
+	    AR_SREV_9561(sc->sc_ah) || AR_SREV_5502(sc->sc_ah))
 		rfilt |= ATH9K_RX_FILTER_4ADDRESS;
 
 	if (AR_SREV_9462(sc->sc_ah) || AR_SREV_9565(sc->sc_ah))
diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index 75a9651983..1809217264 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -1138,6 +1138,7 @@ enum {
 #define AR9531_NUM_GPIO				 18
 #define AR9550_NUM_GPIO				 24
 #define AR9561_NUM_GPIO				 23
+#define AR5502_NUM_GPIO				 20
 #define AR9565_NUM_GPIO				 14
 #define AR9580_NUM_GPIO				 16
 #define AR7010_NUM_GPIO                          16
@@ -1155,6 +1156,7 @@ enum {
 #define AR9531_GPIO_MASK			 0x0000000F
 #define AR9550_GPIO_MASK			 0x0000000F
 #define AR9561_GPIO_MASK			 0x0000000F
+#define AR5502_GPIO_MASK			 0x0000000F
 #define AR9565_GPIO_MASK			 0x00003FFF
 #define AR9580_GPIO_MASK			 0x0000F4FF
 #define AR7010_GPIO_MASK			 0x0000FFFF
@@ -2114,7 +2116,7 @@ enum {
 						     * pcu_txsm.
 						     */
 
-#define AR9300_SM_BASE(_ah)			0xa200
+#define AR9300_SM_BASE(_ah)			(AR_SREV_5502(_ah) ? 0x2a200 : 0xa200)
 #define AR9002_PHY_AGC_CONTROL			0x9860
 #define AR9003_PHY_AGC_CONTROL(_ah)		(AR9300_SM_BASE(_ah) + 0xc4)
 #define AR_PHY_AGC_CONTROL(_ah)			(AR_SREV_9300_20_OR_LATER(_ah) ? AR9003_PHY_AGC_CONTROL(_ah) : AR9002_PHY_AGC_CONTROL)
-- 
2.34.1

