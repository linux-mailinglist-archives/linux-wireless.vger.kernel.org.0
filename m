Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB1E504D1E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiDRHW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiDRHW4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:22:56 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2054.outbound.protection.outlook.com [40.107.115.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F53013CD3
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKyH22cXNvYK9AKnUHcROYowhCPvCcSr4z+/Jgdm2ZABXkDzKfFm8oXfYhXfTU+vFNU8XBaBmDXDpDxbnIBHzruwz23SQMhV60y6BE3G9Pu1kjGkK9B1fHOgLO/+n2mHHhXn/hcKu//Oq4YnVwcsuCMO9XaRwNuWVWfWnAk1xjKTirN/OJVu3zv14L/wv849vU0YSX/ugYroM5/IuMlzFv584Zr8mE6BqiqzDTa3z0Dr4EnAoMfh9zRgRcXfDdwCL6BYzdYEIrQ5h+P2yZMkpmxH0GFhSqrjdnV5pxzBaH3/RavxCTzEFV3+HmcbZQN3lHjwAbGHiGbVOIGtBZ2pQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmNRY5jhxImhOUkxEYTktAz9GACh2TKxIj1JsfdcF8c=;
 b=Y0eee1kdst09cJer4nHydq/6jzO8NjLk7EXhvlqkrSsT9Q6nRExSqi5gQi4lEG9UnvpvMTJIY3r6YewFOxfHUG9eQ2X+pA2aZPPfq2hmz+bBVntLEdRRKok1dOyYddXnpUgSWdqIjyyUNlU4zTeamOmhDatZzQ5KOeL10soe4WcpXKz8GYpvuRL0KMlrpcEcqgjNPDIklS3xuSla/Mrfm9OvkLMgu5sW/jxWQ7iaiekBPVBDqgSUX60lK+2Ca48mBYpmf5AywYpDibiHreWuMGxTInPcSq5k0WS3vc5OgjD2S3X+aLmq+YVxDdAdYFfZJAaooKFgYEQTJ+OgTOUHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:15 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:15 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 2/9] ath9k: basic support for QCN550x
Date:   Mon, 18 Apr 2022 00:13:06 -0700
Message-Id: <20220418071313.882179-3-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 12a2d416-2f6c-41db-888c-08da210be25d
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB43632B999BDAEACF3F97F594B2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qY9voQ+7kpjccUb/u7sOyVWwV+RUqIHu4Spzsyy4qITbsl9/qM9e/GpqInx0V5HhRyB/13+pZQcZzfn1zy42LB+ic+gLMcYyoq9Kpj5BkqzLmL5SZIkqHdnwUokbS2drndOAkMGiwWgV3q8781ai3JsmMmuNF36inFcq+8pRmjXZbC+V+n+UcqYCnY6B0pkcbXtzguXQ0vrYYzeCwm+ewPYz1B5VwwW8ZjADUF3ekkEhbrOUAu4M85wXjDpS+MhmSAdI6w6D5E9PJyqc6YuHEeNKvwEiJBstocTi4xu9e7DU9YDubeyiTbFkyBVALlN2H1VRanS2KJ30mnCCgiHiO6irONOBqBGy+FNLyZEGRA1LqjeKE9snSE58m/1tS/sG6GMQvnYO6rmuxsHCfLqyi+THdp04z6r13Kd0BRjaqZfnxR4G0RlmXFzy5AgBNUi73RtAFUbvffM0Dd378nCiA/p2ZTC9LE3x1re9ckZhCsBdsNzAsKA7BMBz2xAeZ1EOAQDz9Ykoxa3acaxINojGvgyhxD/FEYKh/PduZgCAHHpUTnCIGZgBFmws5o5P3dTplYqHtw301euRWq6MTsshmCpjjKX1GrM4pzynTOl9dDjmatzLWTzR/ce6GSw1hzWVdoRO1Mi0zMlfHI2+7W3WD1xX6oQYdE4wlre3ORS2ke3ZFjPDP8D79KP/ZjoVgyK5rUxaanchksJYbTAkEterjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(66946007)(316002)(186003)(30864003)(26005)(786003)(38350700002)(6486002)(38100700002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnPlM/3+cfxmkQ/+OpPzWzISHa4lcAquoPdFBnhpWvWEDqqTbbatYPIgFlhx?=
 =?us-ascii?Q?WXWT0Pdz2VsFauAOAnmprKE0HxiC+ANLnmL3HXCtpUdkNE5jG6bcz5xvEhS2?=
 =?us-ascii?Q?iUpKNY5EEZNFnHu5gP6c4pb+uVzh+m9iIUEEzBy3qpxBfKL2Pjc7o594N3v6?=
 =?us-ascii?Q?dqUuWzkDjFawH7f2dQczHrMgPFzYJMO5UEvqHI0rgP1w8isra0/4AXQgF64Q?=
 =?us-ascii?Q?Su3vbfuSdKeL97ZRydUFu7SQWsb6M7NhMQIbdkddZmJUcCHkHoQvVWumq853?=
 =?us-ascii?Q?k0kYCwe/NJ0Jl1xTk3U2Tcj7m2DJqLuDM4j6URo4R2VkdLb9352uTUZZ+QV0?=
 =?us-ascii?Q?L510c9M4hS0z153r3NB4wpAyna0O0MTFmyDIRFAtDx+fAr8tlKkZmN8FQ/Ly?=
 =?us-ascii?Q?eeb/mSCaN8q5uOHAgLygnviOa+ViRLTmgB6Jn2nir9L/rNRVp8C/+rY4heML?=
 =?us-ascii?Q?yLnpKOsr5TDXcc2z4Y3/UOD5Wvs9sl54YUod003JLwR16uVp0fxilH6+wnc7?=
 =?us-ascii?Q?xr7wa3G/fRFer9dFgf+mDYLaAQVgS9p8svnT4LWwLVAX1/2OFT2BzfH3y+hE?=
 =?us-ascii?Q?ECX4tT+9zkOCAbbOFEc9I/xedfAvB/zU+Mnyv6jFiRMeExFTDc5VNmT2Vbcm?=
 =?us-ascii?Q?5wv1pVVJAgo/a0IbVSKOxHcveUZl5h+zRgF1jeJw1xM62mtTaCtTY0uYNc2O?=
 =?us-ascii?Q?edsLvylpCs06cNiXDvc8e5HZKcfc4/UwJksu4MvB89H5sJWdyL8P/niLM2za?=
 =?us-ascii?Q?9bV5wRK6zSsM6hbanjTydosiN+CJjvRda1zZ/2/p1+4Kkr0BsWcpLYL2IKkW?=
 =?us-ascii?Q?AI7gmVst7CxdRsb4Xd/lkxJ12kF5pwntKfnKQ6cGHRzJN8CweEBx7KXjYWNN?=
 =?us-ascii?Q?tGGHIf2VxM2NkxVorIGqlaDxEsFDjhwAOjrNDCuXELSVSXq6uW3f+uRWrLh5?=
 =?us-ascii?Q?siU0fXzY/bvj/fT9Tn079S4zzsUNnRJ3+FOMETNNg5pGSIFl0nqKs5b8+kjn?=
 =?us-ascii?Q?Z8G2Y501LYYNpgrzOqEgA9p7hdgL9C6Balrn5NGkTWrqiAGEKuWj7y3q9aVV?=
 =?us-ascii?Q?IkeKdhhlbQatafCEGTy0vDkQE1vOmuWeCwze8c8UtUY8c6a02lEk+rXWg64V?=
 =?us-ascii?Q?l0sC4pRtq+qA0LDHxuEjUwYcCmKLd3YfFyia5pTiYEWbgCIp9UxrXowz5G5v?=
 =?us-ascii?Q?PQhjOK0EDkxCZRB11+fgNpKJFCAO8k2reyN4MfocghJEaHAu5xcqJ8D8Gd9r?=
 =?us-ascii?Q?rpvQv4abGRUGsXLnyGlrzfc8/3ajaka4MNFBC7MsAJf71FSx/R5KmTeaaK0L?=
 =?us-ascii?Q?Y0LPoZ/CoMQaATTL8v8r5knehkwbJHKRfZHILkqajPNIDs5SQWOZpPqYvhAN?=
 =?us-ascii?Q?7wB/pThv5pCAPjMckD3ddvb/Gm/ZN4qaAbg/OSk76IaxuJWz7CKv35YBTZeZ?=
 =?us-ascii?Q?PkTTV3oKR8Z6o61ckFvD2YRulm8mioe+8n61AHUjdWhlWQObh3mfNIg0l7FB?=
 =?us-ascii?Q?916Trt1XJvuhOaJWuQi4bCJitbMhiY8K8JULZE+ag5BGKxpH4vp1H1yB8Rba?=
 =?us-ascii?Q?1beK/tmWSO7Sf+rqDCIMlSDS8gG4z/YuY0BS5jlScA9ytzg9nywHE4F7rwZe?=
 =?us-ascii?Q?/EESklFsREIQGUQTjMOyX5b9/fjoNS1dxjpOgNXvJzJ5UIBU60SkuLYnjTOY?=
 =?us-ascii?Q?IB0oT2SBVjNPkoqmz5dJ/fJ7kBIbfkxDup8S/uEmNbt0ygX4gZ/wZY7aTnQN?=
 =?us-ascii?Q?hqLKjias3A=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a2d416-2f6c-41db-888c-08da210be25d
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:15.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80pj1o1lKoeFPyiIa2hXhF0wUkG6k77m7pVuMUkQr168vVc6rVM+qj3VzcRGlBGK9JnaB9NBERCoGXAHu0JlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCN550x is very similar to QCA956x. Note that AR_CH0_XTAL is
intentionally unchanged. Certain arrays are no longer static because
they are no longer constant.
---
 drivers/net/wireless/ath/ath9k/ani.c          |  2 +-
 drivers/net/wireless/ath/ath9k/ar9003_calib.c |  4 +-
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 17 ++--
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c |  4 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c   | 35 ++++----
 drivers/net/wireless/ath/ath9k/ar9003_phy.h   | 83 ++++++++++++-------
 drivers/net/wireless/ath/ath9k/hw.c           | 28 ++++---
 drivers/net/wireless/ath/ath9k/mac.c          |  2 +-
 drivers/net/wireless/ath/ath9k/recv.c         |  2 +-
 drivers/net/wireless/ath/ath9k/reg.h          |  4 +-
 drivers/net/wireless/ath/ath9k/reg_aic.h      |  6 +-
 11 files changed, 112 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ani.c b/drivers/net/wireless/ath/ath9k/ani.c
index 41d192709..281103865 100644
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
index 6ca089f15..e2cf4b733 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
@@ -201,7 +201,7 @@ static void ar9003_hw_iqcalibrate(struct ath_hw *ah, u8 numChains)
 	u32 qCoffDenom, iCoffDenom;
 	int32_t qCoff, iCoff;
 	int iqCorrNeg, i;
-	static const u_int32_t offset_array[3] = {
+	const u_int32_t offset_array[3] = {
 		AR_PHY_RX_IQCAL_CORR_B0,
 		AR_PHY_RX_IQCAL_CORR_B1,
 		AR_PHY_RX_IQCAL_CORR_B2,
@@ -1202,7 +1202,7 @@ static void ar9003_hw_manual_peak_cal(struct ath_hw *ah, u8 chain, bool is_2g)
 
 	if (AR_SREV_9550(ah) || AR_SREV_9531(ah))
 		peak_detect_threshold = 8;
-	else if (AR_SREV_9561(ah))
+	else if (AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		peak_detect_threshold = 11;
 
 	/*
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 16bfcd0a1..49be3a315 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3608,6 +3608,8 @@ static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
 	if (AR_SREV_9485(ah) || AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
 	    AR_SREV_9531(ah) || AR_SREV_9561(ah))
 		REG_RMW_FIELD(ah, AR_CH0_TOP2, AR_CH0_TOP2_XPABIASLVL, bias);
+	else if (AR_SREV_5502(ah))
+		REG_RMW_FIELD(ah, AR_CH0_TOP3, AR_CH0_TOP3_XPABIASLVL, bias);
 	else if (AR_SREV_9462(ah) || AR_SREV_9550(ah) || AR_SREV_9565(ah))
 		REG_RMW_FIELD(ah, AR_CH0_TOP, AR_CH0_TOP_XPABIASLVL, bias);
 	else {
@@ -3648,7 +3650,7 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 	struct ath9k_hw_capabilities *pCap = &ah->caps;
 	int chain;
 	u32 regval, value, gpio;
-	static const u32 switch_chain_reg[AR9300_MAX_CHAINS] = {
+	const u32 switch_chain_reg[AR9300_MAX_CHAINS] = {
 			AR_PHY_SWITCH_CHAIN_0,
 			AR_PHY_SWITCH_CHAIN_1,
 			AR_PHY_SWITCH_CHAIN_2,
@@ -3669,7 +3671,8 @@ static void ar9003_hw_ant_ctrl_apply(struct ath_hw *ah, bool is2ghz)
 	if (AR_SREV_9462(ah) || AR_SREV_9565(ah)) {
 		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM,
 				AR_SWITCH_TABLE_COM_AR9462_ALL, value);
-	} else if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
+	} else if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+			   AR_SREV_5502(ah)) {
 		REG_RMW_FIELD(ah, AR_PHY_SWITCH_COM,
 				AR_SWITCH_TABLE_COM_AR9550_ALL, value);
 	} else
@@ -4000,11 +4003,11 @@ void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 			if (!is_pmu_set(ah, AR_PHY_PMU2, reg_pmu_set))
 				return;
 		} else if (AR_SREV_9462(ah) || AR_SREV_9565(ah) ||
-			   AR_SREV_9561(ah)) {
+			   AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 			reg_val = le32_to_cpu(pBase->swreg);
 			REG_WRITE(ah, AR_PHY_PMU1, reg_val);
 
-			if (AR_SREV_9561(ah))
+			if (AR_SREV_9561(ah) || AR_SREV_5502(ah))
 				REG_WRITE(ah, AR_PHY_PMU2, 0x10200000);
 		} else {
 			/* Internal regulator is ON. Write swreg register. */
@@ -4109,7 +4112,8 @@ static void ar9003_hw_xpa_timing_control_apply(struct ath_hw *ah, bool is2ghz)
 	    !AR_SREV_9340(ah) &&
 	    !AR_SREV_9580(ah) &&
 	    !AR_SREV_9531(ah) &&
-	    !AR_SREV_9561(ah))
+	    !AR_SREV_9561(ah) &&
+	    !AR_SREV_5502(ah))
 		return;
 
 	xpa_ctl = ar9003_modal_header(ah, is2ghz)->txFrameToXpaOn;
@@ -4889,7 +4893,8 @@ static void ar9003_hw_power_control_override(struct ath_hw *ah,
 	}
 
 tempslope:
-	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
+	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah) ||
+	    AR_SREV_5502(ah)) {
 		u8 txmask = (eep->baseEepHeader.txrxMask & 0xf0) >> 4;
 
 		/*
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
index b2d53b6c0..ff45abd14 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
@@ -138,12 +138,12 @@ static int ar9003_get_training_power_5g(struct ath_hw *ah)
 static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	static const u32 ctrl0[3] = {
+	const u32 ctrl0[3] = {
 		AR_PHY_PAPRD_CTRL0_B0,
 		AR_PHY_PAPRD_CTRL0_B1,
 		AR_PHY_PAPRD_CTRL0_B2
 	};
-	static const u32 ctrl1[3] = {
+	const u32 ctrl1[3] = {
 		AR_PHY_PAPRD_CTRL1_B0,
 		AR_PHY_PAPRD_CTRL1_B1,
 		AR_PHY_PAPRD_CTRL1_B2
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index dc0e5ea25..7cbe30bc4 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -157,9 +157,9 @@ static int ar9003_hw_set_channel(struct ath_hw *ah, struct ath9k_channel *chan)
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
@@ -182,8 +182,8 @@ static int ar9003_hw_set_channel(struct ath_hw *ah, struct ath9k_channel *chan)
 		/* Set to 2G mode */
 		bMode = 1;
 	} else {
-		if ((AR_SREV_9340(ah) || AR_SREV_9550(ah) ||
-		     AR_SREV_9531(ah) || AR_SREV_9561(ah)) &&
+		if ((AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
+		     AR_SREV_9561(ah) || AR_SREV_5502(ah)) &&
 		    ah->is_clk_25mhz) {
 			channelSel = freq / 75;
 			chan_frac = ((freq % 75) * 0x20000) / 75;
@@ -250,7 +250,7 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 	 */
 
 	if (AR_SREV_9485(ah) || AR_SREV_9340(ah) || AR_SREV_9330(ah) ||
-	    AR_SREV_9550(ah) || AR_SREV_9561(ah)) {
+	    AR_SREV_9550(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 		if (spur_fbin_ptr[0] == 0) /* No spur */
 			return;
 		max_spur_cnts = 5;
@@ -277,7 +277,7 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 
 		negative = 0;
 		if (AR_SREV_9485(ah) || AR_SREV_9340(ah) || AR_SREV_9330(ah) ||
-		    AR_SREV_9550(ah) || AR_SREV_9561(ah))
+		    AR_SREV_9550(ah) || AR_SREV_9561(ah) || AR_SREV_5502(ah))
 			cur_bb_spur = ath9k_hw_fbin2freq(spur_fbin_ptr[i],
 							 IS_CHAN_2GHZ(chan));
 		else
@@ -619,7 +619,7 @@ static void ar9003_hw_set_channel_regs(struct ath_hw *ah,
 	/* Enable 11n HT, 20 MHz */
 	phymode = AR_PHY_GC_HT_EN | AR_PHY_GC_SHORT_GI_40 | enableDacFifo;
 
-	if (!AR_SREV_9561(ah))
+	if (!(AR_SREV_9561(ah) || AR_SREV_5502(ah)))
 		phymode |= AR_PHY_GC_SINGLE_HT_LTF1;
 
 	/* Configure baseband for dynamic 20/40 operation */
@@ -724,7 +724,7 @@ static void ar9003_hw_override_ini(struct ath_hw *ah)
 		ah->enabled_cals &= ~TX_CL_CAL;
 
 	if (AR_SREV_9340(ah) || AR_SREV_9531(ah) || AR_SREV_9550(ah) ||
-	    AR_SREV_9561(ah)) {
+	    AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 		if (ah->is_clk_25mhz) {
 			REG_WRITE(ah, AR_RTC_DERIVED_CLK, 0x17c << 1);
 			REG_WRITE(ah, AR_SLP32_MODE, 0x0010f3d7);
@@ -905,23 +905,25 @@ static int ar9003_hw_process_ini(struct ath_hw *ah,
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
 
@@ -1922,7 +1924,7 @@ void ar9003_hw_attach_phy_ops(struct ath_hw *ah)
 {
 	struct ath_hw_private_ops *priv_ops = ath9k_hw_private_ops(ah);
 	struct ath_hw_ops *ops = ath9k_hw_ops(ah);
-	static const u32 ar9300_cca_regs[6] = {
+	const u32 ar9300_cca_regs[6] = {
 		AR_PHY_CCA_0,
 		AR_PHY_CCA_1,
 		AR_PHY_CCA_2,
@@ -1935,7 +1937,7 @@ void ar9003_hw_attach_phy_ops(struct ath_hw *ah)
 	priv_ops->spur_mitigate_freq = ar9003_hw_spur_mitigate;
 
 	if (AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-	    AR_SREV_9561(ah))
+	    AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		priv_ops->compute_pll_control = ar9003_hw_compute_pll_control_soc;
 	else
 		priv_ops->compute_pll_control = ar9003_hw_compute_pll_control;
@@ -2021,7 +2023,8 @@ bool ar9003_hw_bb_watchdog_check(struct ath_hw *ah)
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
index a171dbb29..4e258d70e 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -20,7 +20,7 @@
 /*
  * Channel Register Map
  */
-#define AR_CHAN_BASE	0x9800
+#define AR_CHAN_BASE	(AR_SREV_5502(ah) ? 0x29800 : 0x9800)
 
 #define AR_PHY_TIMING1      (AR_CHAN_BASE + 0x0)
 #define AR_PHY_TIMING2      (AR_CHAN_BASE + 0x4)
@@ -214,7 +214,7 @@
 /*
  * MRC Register Map
  */
-#define AR_MRC_BASE	0x9c00
+#define AR_MRC_BASE	(AR_SREV_5502(ah) ? 0x29c00 : 0x9c00)
 
 #define AR_PHY_TIMING_3A       (AR_MRC_BASE + 0x0)
 #define AR_PHY_LDPC_CNTL1      (AR_MRC_BASE + 0x4)
@@ -255,12 +255,12 @@
 /*
  * BBB Register Map
  */
-#define AR_BBB_BASE	0x9d00
+#define AR_BBB_BASE	(AR_SREV_5502(ah) ? 0x29d00 : 0x9d00)
 
 /*
  * AGC Register Map
  */
-#define AR_AGC_BASE	0x9e00
+#define AR_AGC_BASE	(AR_SREV_5502(ah) ? 0x29e00 : 0x9e00)
 
 #define AR_PHY_SETTLING         (AR_AGC_BASE + 0x0)
 #define AR_PHY_FORCEMAX_GAINS_0 (AR_AGC_BASE + 0x4)
@@ -448,14 +448,16 @@
 /*
  * SM Register Map
  */
-#define AR_SM_BASE	0xa200
+#define AR_SM_BASE	(AR_SREV_5502(ah) ? 0x2a200 : 0xa200)
 
 #define AR_PHY_D2_CHIP_ID        (AR_SM_BASE + 0x0)
 #define AR_PHY_GEN_CTRL          (AR_SM_BASE + 0x4)
 #define AR_PHY_MODE              (AR_SM_BASE + 0x8)
 #define AR_PHY_ACTIVE            (AR_SM_BASE + 0xc)
-#define AR_PHY_SPUR_MASK_A       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x18 : 0x20))
-#define AR_PHY_SPUR_MASK_B       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x1c : 0x24))
+#define AR_PHY_SPUR_MASK_A                                                     \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x18 : 0x20))
+#define AR_PHY_SPUR_MASK_B                                                     \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x1c : 0x24))
 #define AR_PHY_SPECTRAL_SCAN     (AR_SM_BASE + 0x28)
 #define AR_PHY_RADAR_BW_FILTER   (AR_SM_BASE + 0x2c)
 #define AR_PHY_SEARCH_START_DELAY (AR_SM_BASE + 0x30)
@@ -498,7 +500,8 @@
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A                       0x3FF
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A_S                     0
 
-#define AR_PHY_TEST              (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x15c : 0x160))
+#define AR_PHY_TEST                                                            \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x15c : 0x160))
 
 #define AR_PHY_TEST_BBB_OBS_SEL       0x780000
 #define AR_PHY_TEST_BBB_OBS_SEL_S     19
@@ -509,7 +512,8 @@
 #define AR_PHY_TEST_CHAIN_SEL      0xC0000000
 #define AR_PHY_TEST_CHAIN_SEL_S    30
 
-#define AR_PHY_TEST_CTL_STATUS   (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x160 : 0x164))
+#define AR_PHY_TEST_CTL_STATUS                                                 \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x160 : 0x164))
 #define AR_PHY_TEST_CTL_TSTDAC_EN         0x1
 #define AR_PHY_TEST_CTL_TSTDAC_EN_S       0
 #define AR_PHY_TEST_CTL_TX_OBS_SEL        0x1C
@@ -523,23 +527,32 @@
 #define AR_PHY_TEST_CTL_DEBUGPORT_SEL	  0xe0000000
 #define AR_PHY_TEST_CTL_DEBUGPORT_SEL_S	  29
 
+#define AR_PHY_TSTDAC                                                          \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x164 : 0x168))
 
-#define AR_PHY_TSTDAC            (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x164 : 0x168))
+#define AR_PHY_CHAN_STATUS                                                     \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x168 : 0x16c))
 
-#define AR_PHY_CHAN_STATUS       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x168 : 0x16c))
-
-#define AR_PHY_CHAN_INFO_MEMORY (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x16c : 0x170))
+#define AR_PHY_CHAN_INFO_MEMORY                                                \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x16c : 0x170))
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ	0x00000008
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ_S	3
 
-#define AR_PHY_CHNINFO_NOISEPWR  (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x170 : 0x174))
-#define AR_PHY_CHNINFO_GAINDIFF  (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x174 : 0x178))
-#define AR_PHY_CHNINFO_FINETIM   (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x178 : 0x17c))
-#define AR_PHY_CHAN_INFO_GAIN_0  (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x17c : 0x180))
-#define AR_PHY_SCRAMBLER_SEED    (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x184 : 0x190))
-#define AR_PHY_CCK_TX_CTRL       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x188 : 0x194))
-
-#define AR_PHY_HEAVYCLIP_CTL     (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x198 : 0x1a4))
+#define AR_PHY_CHNINFO_NOISEPWR                                                \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x170 : 0x174))
+#define AR_PHY_CHNINFO_GAINDIFF                                                \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x174 : 0x178))
+#define AR_PHY_CHNINFO_FINETIM                                                 \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x178 : 0x17c))
+#define AR_PHY_CHAN_INFO_GAIN_0                                                \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x17c : 0x180))
+#define AR_PHY_SCRAMBLER_SEED                                                  \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x184 : 0x190))
+#define AR_PHY_CCK_TX_CTRL                                                     \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x188 : 0x194))
+
+#define AR_PHY_HEAVYCLIP_CTL                                                   \
+	(AR_SM_BASE + ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x198 : 0x1a4))
 #define AR_PHY_HEAVYCLIP_20      (AR_SM_BASE + 0x1a8)
 #define AR_PHY_HEAVYCLIP_40      (AR_SM_BASE + 0x1ac)
 #define AR_PHY_HEAVYCLIP_1	 (AR_SM_BASE + 0x19c)
@@ -722,6 +735,10 @@
 #define AR_CH0_TOP2_XPABIASLVL		(AR_SREV_9561(ah) ? 0x1e00 : 0xf000)
 #define AR_CH0_TOP2_XPABIASLVL_S	12
 
+#define AR_CH0_TOP3		0x16288
+#define AR_CH0_TOP3_XPABIASLVL		0xf0000
+#define AR_CH0_TOP3_XPABIASLVL_S	16
+
 #define AR_CH0_XTAL		(AR_SREV_9300(ah) ? 0x16294 : \
 				 ((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16298 : \
 				  (AR_SREV_9561(ah) ? 0x162c0 : 0x16290)))
@@ -730,13 +747,17 @@
 #define AR_CH0_XTAL_CAPOUTDAC	0x00fe0000
 #define AR_CH0_XTAL_CAPOUTDAC_S	17
 
-#define AR_PHY_PMU1		((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16340 : \
-				 (AR_SREV_9561(ah) ? 0x16cc0 : 0x16c40))
+#define AR_PHY_PMU1                                                            \
+	((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ?                              \
+		 0x16340 :                                                     \
+		       ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x16cc0 : 0x16c40))
 #define AR_PHY_PMU1_PWD		0x1
 #define AR_PHY_PMU1_PWD_S	0
 
-#define AR_PHY_PMU2		((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16344 : \
-				 (AR_SREV_9561(ah) ? 0x16cc4 : 0x16c44))
+#define AR_PHY_PMU2                                                            \
+	((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ?                              \
+		 0x16344 :                                                     \
+		       ((AR_SREV_9561(ah) || AR_SREV_5502(ah)) ? 0x16cc4 : 0x16c44))
 #define AR_PHY_PMU2_PGM		0x00200000
 #define AR_PHY_PMU2_PGM_S	21
 
@@ -925,7 +946,7 @@
 /*
  * Channel 1 Register Map
  */
-#define AR_CHAN1_BASE	0xa800
+#define AR_CHAN1_BASE	(AR_SREV_5502(ah) ? 0x2a800 : 0xa800)
 
 #define AR_PHY_EXT_CCA_1            (AR_CHAN1_BASE + 0x30)
 #define AR_PHY_TX_PHASE_RAMP_1      (AR_CHAN1_BASE + 0xd0)
@@ -944,7 +965,7 @@
 /*
  * AGC 1 Register Map
  */
-#define AR_AGC1_BASE	0xae00
+#define AR_AGC1_BASE	(AR_SREV_5502(ah) ? 0x2ae00 : 0xae00)
 
 #define AR_PHY_FORCEMAX_GAINS_1      (AR_AGC1_BASE + 0x4)
 #define AR_PHY_EXT_ATTEN_CTL_1       (AR_AGC1_BASE + 0x18)
@@ -963,7 +984,7 @@
 /*
  * SM 1 Register Map
  */
-#define AR_SM1_BASE	0xb200
+#define AR_SM1_BASE	(AR_SREV_5502(ah) ? 0x2b200 : 0xb200)
 
 #define AR_PHY_SWITCH_CHAIN_1   (AR_SM1_BASE + 0x84)
 #define AR_PHY_FCAL_2_1         (AR_SM1_BASE + 0xd0)
@@ -989,7 +1010,7 @@
 /*
  * Channel 2 Register Map
  */
-#define AR_CHAN2_BASE	0xb800
+#define AR_CHAN2_BASE	(AR_SREV_5502(ah) ? 0x2b800 : 0xb800)
 
 #define AR_PHY_EXT_CCA_2            (AR_CHAN2_BASE + 0x30)
 #define AR_PHY_TX_PHASE_RAMP_2      (AR_CHAN2_BASE + 0xd0)
@@ -1007,7 +1028,7 @@
 /*
  * AGC 2 Register Map
  */
-#define AR_AGC2_BASE	0xbe00
+#define AR_AGC2_BASE	(AR_SREV_5502(ah) ? 0x2be00 : 0xbe00)
 
 #define AR_PHY_FORCEMAX_GAINS_2      (AR_AGC2_BASE + 0x4)
 #define AR_PHY_EXT_ATTEN_CTL_2       (AR_AGC2_BASE + 0x18)
@@ -1024,7 +1045,7 @@
 /*
  * SM 2 Register Map
  */
-#define AR_SM2_BASE	0xc200
+#define AR_SM2_BASE	(AR_SREV_5502(ah) ? 0x2c200 : 0xc200)
 
 #define AR_PHY_SWITCH_CHAIN_2    (AR_SM2_BASE + 0x84)
 #define AR_PHY_FCAL_2_2          (AR_SM2_BASE + 0xd0)
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 047512ce1..c32b201a3 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -834,7 +834,7 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 		REG_RMW_FIELD(ah, AR_CH0_BB_DPLL3,
 			      AR_CH0_BB_DPLL3_PHASE_SHIFT, 0x1);
 	} else if (AR_SREV_9340(ah) || AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-		   AR_SREV_9561(ah)) {
+		   AR_SREV_9561(ah) || AR_SREV_5502(ah)) {
 		u32 regval, pll2_divint, pll2_divfrac, refdiv;
 
 		REG_WRITE(ah, AR_RTC_PLL_CONTROL,
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
@@ -1777,7 +1780,7 @@ static void ath9k_hw_init_desc(struct ath_hw *ah)
 #ifdef __BIG_ENDIAN
 		else if (AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
 			 AR_SREV_9550(ah) || AR_SREV_9531(ah) ||
-			 AR_SREV_9561(ah))
+			 AR_SREV_9561(ah) || AR_SREV_5502(ah))
 			REG_RMW(ah, AR_CFG, AR_CFG_SWRB | AR_CFG_SWTB, 0);
 		else
 			REG_WRITE(ah, AR_CFG, AR_CFG_SWTD | AR_CFG_SWRD);
@@ -2474,6 +2477,9 @@ static void ath9k_gpio_cap_init(struct ath_hw *ah)
 	} else if (AR_SREV_9561(ah)) {
 		pCap->num_gpio_pins = AR9561_NUM_GPIO;
 		pCap->gpio_mask = AR9561_GPIO_MASK;
+	} else if (AR_SREV_5502(ah)) {
+		pCap->num_gpio_pins = AR5502_NUM_GPIO;
+		pCap->gpio_mask = AR5502_GPIO_MASK;
 	} else if (AR_SREV_9565(ah)) {
 		pCap->num_gpio_pins = AR9565_NUM_GPIO;
 		pCap->gpio_mask = AR9565_GPIO_MASK;
@@ -2610,7 +2616,7 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
 		pCap->hw_caps |= ATH9K_HW_CAP_EDMA | ATH9K_HW_CAP_FASTCLOCK;
 		if (!AR_SREV_9330(ah) && !AR_SREV_9485(ah) &&
-		    !AR_SREV_9561(ah) && !AR_SREV_9565(ah))
+		    !AR_SREV_9561(ah) && !AR_SREV_5502(ah) && !AR_SREV_9565(ah))
 			pCap->hw_caps |= ATH9K_HW_CAP_LDPC;
 
 		pCap->rx_hp_qdepth = ATH9K_HW_RX_HP_QDEPTH;
@@ -2627,7 +2633,7 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 	if (AR_SREV_9300_20_OR_LATER(ah))
 		pCap->hw_caps |= ATH9K_HW_CAP_RAC_SUPPORTED;
 
-	if (AR_SREV_9561(ah))
+	if (AR_SREV_9561(ah) || AR_SREV_5502(ah))
 		ah->ent_mode = 0x3BDA000;
 	else if (AR_SREV_9300_20_OR_LATER(ah))
 		ah->ent_mode = REG_READ(ah, AR_ENT_OTP);
diff --git a/drivers/net/wireless/ath/ath9k/mac.c b/drivers/net/wireless/ath/ath9k/mac.c
index 58d02c19b..08f91f558 100644
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
index 0c0624a3b..3299aef65 100644
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
index 5a07cf7d8..d465167ac 100644
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
 
-#define AR9300_SM_BASE				0xa200
+#define AR9300_SM_BASE				(AR_SREV_5502(ah) ? 0x2a200 : 0xa200)
 #define AR9002_PHY_AGC_CONTROL			0x9860
 #define AR9003_PHY_AGC_CONTROL			AR9300_SM_BASE + 0xc4
 #define AR_PHY_AGC_CONTROL			(AR_SREV_9300_20_OR_LATER(ah) ? AR9003_PHY_AGC_CONTROL : AR9002_PHY_AGC_CONTROL)
diff --git a/drivers/net/wireless/ath/ath9k/reg_aic.h b/drivers/net/wireless/ath/ath9k/reg_aic.h
index 955147ab4..abd0370e0 100644
--- a/drivers/net/wireless/ath/ath9k/reg_aic.h
+++ b/drivers/net/wireless/ath/ath9k/reg_aic.h
@@ -17,9 +17,9 @@
 #ifndef REG_AIC_H
 #define REG_AIC_H
 
-#define AR_SM_BASE                              0xa200
-#define AR_SM1_BASE                             0xb200
-#define AR_AGC_BASE                             0x9e00
+#define AR_SM_BASE                              (AR_SREV_5502(ah) ? 0x2a200 : 0xa200)
+#define AR_SM1_BASE                             (AR_SREV_5502(ah) ? 0x2b200 : 0xb200)
+#define AR_AGC_BASE                             (AR_SREV_5502(ah) ? 0x29e00 : 0x9e00)
 
 #define AR_PHY_AIC_CTRL_0_B0                    (AR_SM_BASE + 0x4b0)
 #define AR_PHY_AIC_CTRL_1_B0                    (AR_SM_BASE + 0x4b4)
-- 
2.25.1

