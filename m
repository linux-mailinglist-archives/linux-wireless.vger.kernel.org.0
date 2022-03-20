Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FA4E1E43
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 00:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiCTXcH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 19:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiCTXcG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 19:32:06 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660086.outbound.protection.outlook.com [40.107.66.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5719132E91
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 16:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCDmvhSVbAYlZ/DVkYXsZr6GNlmRVxLIj1JtD8n1r+XKBMaAWl4DA4Ogq8OfHOix5ES0znWVUtT1Qiavrmyq1EAEXsmAX+KqJU5k1SkzNZm3U0AYhUNHbR9bXWxR0vq1Zm9Jne7U8Eu+8SmPmb7DW1TPfKZdAG96Nl/XO622Kgt0k9NacwYwjOa1Ey7RF7oBTjGqfbln5HqlBrDHXZ6gZZIhnQybQcQRS9gIHWsm4WGyHnRHqkwiN9orrjIK6GkSDtSWKI1SH4nvQCUMmsLuPSaQlzchFT7md1TvPF1WlGSJB+RfSIyYNS6zC3561TDZ0KY/nypA4vFQj7RtI7dDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohiycFmcjE5J95joqMSCU76LfZ7WOkwbrG4bmZqbGPs=;
 b=kuuOgwPmqT6oA2FJrt3uvozf2rrY0Q3hSkz4poCc+P0eTsEg2LEiWME5KzgVfyZC2MHyz7LuE7uVYDvf23cTAh9vD8FjjK0qmjb+YJBf9HYAfUVxnBHFU2UVRtjvTar4jP6lJs2y9RAf8Cy1FwGD75vC1Jw4DTA/3tBblp+3Nvk22i7JuuYXcFFNTCtUiCa+D01OWiXLhXqeACfDlHs+l8Ubp/bZDxXNY33i4rTQLsyxMaYQ1P7QEio7SOs7TfgOUVCORcML3VZVAJr0hmL2bId6XQSpp0/tq1ObHZIqxNxOdHlIZdCYja9mhOz0Uuc9c/LgrhBldpPi8qSx75/Wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sun, 20 Mar
 2022 23:30:40 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 23:30:40 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 6/6] ath9k: add functions to get paprd rate mask
Date:   Sun, 20 Mar 2022 17:30:10 -0600
Message-Id: <20220320233010.123106-7-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320233010.123106-1-wlooi@ucalgary.ca>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fa4179b-ca15-4231-7097-08da0ac9a566
X-MS-TrafficTypeDiagnostic: YTBPR01MB2989:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB2989BB43E5DFCD1F6F57EBCBB2159@YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdMPP3x6bRliCiL3C3ibNfm+6CXd976gIiD0JOVEJ8NzWjiOiZufLvhfwTt2j2aFkDmbLsipiqVxrtV5MmqPDjmvAHysDaJEOYE59koad2+hx/vR8h5IpZAcnnBTquWFr67QSiLZoBhTSqH5injky5GUCVpkKxxvj29XURECpW239eAiYUt7n26fOs4WObOXFPxi6npjvxWFERK6g+zKzpfH2s/+c2qrgOMcwsfAqddcHe5y2LeM1TfekX1VJSkIpYl4f1d4bvKKvm8hl3orfYCVkgakfw7s7QleSKIWB7Zl51NlVueZ3iqDH3+2ryoJkUkHXEZT8ipGRG67OCKTjl/X5uEA8OQGDSs74Tj5bAUD83Szmwiq/uaez7lKrz+FYcPylpieDZSDHnhZO/OBxl0LSgeO2jzHEUx74p269NEyXmYoMOK5zA7Qk1hqD/delN2ycFq198Tbv+WuU/XtjB1JAbQvydrDmn40V9s/eAJ34fWXb+swQ4w/3tMNu+fUgigEzCR9ClflanEI+tRFE4y1zEkrXp9jHdB9c2kfMUnRTmw48co5z84cBowT5iT5RMq8zRqP6ovYcQ0imAAjCUJm4f4kTfRrV6R4g2phXObDeuZ8j4lbPmr1v2v+kK82baEErAWhZBDSwymMpPX7CuS5eiiqD4zvz2GEwr1w+tXEZnum1vS+21p2rJxMAVVyg/xmA8t3MJK8KnMW5jR/Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(83380400001)(66946007)(66556008)(8676002)(19627235002)(66476007)(4326008)(786003)(316002)(6916009)(54906003)(86362001)(508600001)(5660300002)(38100700002)(38350700002)(8936002)(186003)(36756003)(6666004)(26005)(6512007)(2616005)(6506007)(52116002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZW5AV5m+Xe0DB65jPehD4QYAXhjxNEGl1Fqd2DZqpjmYF9EWITc8/LPmU6y?=
 =?us-ascii?Q?3seSz/h7yodiADa8v7LZOENHHYXed21g/LNAZwN5X/WUFMFoK/KRJAQKNx47?=
 =?us-ascii?Q?yZrUaZ+gpo8UTnlocgBKyL0tTwYxx3ncwuU3PXH/8JyyHcGyYqYTvDrEi7/B?=
 =?us-ascii?Q?s1Q6GgYvMdh83N/gPx0JvbQDU5qv+AdZkb6sd1+7aEhifV1yHHPQZi3ciXuK?=
 =?us-ascii?Q?vvSvpsRjd18vRAnegD/eIRuxVLm/zUYNR8owy+nfRA+ZiYG65rT2pVQtk4bj?=
 =?us-ascii?Q?DtqXnZpkHyYByYmjLVJpB1yznQXtgf02WLT+VCO2eOiyfH7cMyC6tlAt2to4?=
 =?us-ascii?Q?7MswQw6WJVBIGEArlA86AvSpbdlBWvhl0+A1A2Z7L2Jb/Sha3s4eAQDaFdie?=
 =?us-ascii?Q?nFiym2dnkn0bS+XG2k9RPYuZOS4EFme03WTKBK2907b1VUTkKjn4X+RzPaTl?=
 =?us-ascii?Q?nKDp26dNE2A90GryEgNO1jl1gxQpSutbqrKMirYYqnCF/N1CVlMJlKjtfdAl?=
 =?us-ascii?Q?uVGFP9getNYbaBEUYQLmyy0aSVL7x4X9WgEkxGgpQJWUpTuUS4hKDWpZ94I5?=
 =?us-ascii?Q?TcXXXfhFpSdfgnu85yE50fdtJ7zgdVWCUYFeuFvkCmEKFYPP8F5trZ02B8r9?=
 =?us-ascii?Q?10kJhElWONc+WaHbIXFLOx12Tqznce3Pbl7ODFhsbHJsKfPscapGe82deMOu?=
 =?us-ascii?Q?78wV9l/BAefB827hsZdx4SoQCtMPdwKXED4FIf0qUhSwjfQYjpavNkICXy3Q?=
 =?us-ascii?Q?yTQhJBKSRHYVlfsRcoiz+llF/4s1939q4E5v3HlxI3R6nslyLcn7wU7Si8wl?=
 =?us-ascii?Q?gYlwQc5Fh9+p0qf/X6c6+PRhWwduWhPfFGIzuLhlluu/0gLV93gXcFzl/eV6?=
 =?us-ascii?Q?xHUjK54LdBvIU68mZIiVBTpDvFO3Cl/HakSLeutZn8puhWRYH/R+4+Q2XIiQ?=
 =?us-ascii?Q?wQh3iBOzH2aDKP915V5NI+zJFeVWrSDunI1iNFJu4EtJoeRt1LGpG32zP2hs?=
 =?us-ascii?Q?u/nNF6nLB/xNNk6P/LyQ/sH7OuGMsiMPUyJkKIdWoMkf6ijkWKw+eOCP2CC0?=
 =?us-ascii?Q?laovK4fKIWt+WEQ8Em524Gygo0i7X4pkyiTk8YFhbXa4HSck38BrI76hxlr7?=
 =?us-ascii?Q?KD0FQ3naXyraiSVBFUuUNklpEXoPz25aUJ4SBGIQLTKZSUywrV3iN/vpRYca?=
 =?us-ascii?Q?4rNi3iTZXfsS1jpc3o7E+oExC7W+drGFtMzonkZfHHs/PaEyKgfWWTOYR5Hl?=
 =?us-ascii?Q?iTILGIZnkQ9iPY6wc8jzAyyCOJnNioddRtCjxNuPlWhCf6KG0rVKn4FhptYl?=
 =?us-ascii?Q?zheYIF5jXK78s3xU0izKl5ATdZzuFB/D++g2mzFnFZnnXo++x9x38wigXmpK?=
 =?us-ascii?Q?lVZV2PKWh1TReMYoAUZK3w2lmKfSQssEzNtANYOWY980Uv50Z31Ms6cCUIYJ?=
 =?us-ascii?Q?MA4+WNdk3XZgzEEyfUggBHy16bdrd1kE?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa4179b-ca15-4231-7097-08da0ac9a566
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 23:30:40.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhHOGI3WzDazsM7tSbhfLuqnQl3LbaZp1qMx8+kbqG/tSMGfPsMyF0ZT6aFfAO+Vek04ElcoeeXcbqRXKW2/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This removes some code duplication with le32_to_cpu. This may also be
required for QCN550x support, to provide an abstraction over the
underlying EEPROM format.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    | 33 ++++++++++---------
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    |  2 ++
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c | 10 +++---
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index a109a44a1..abf12de0e 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -5449,8 +5449,6 @@ static void ath9k_hw_ar9300_set_txpower(struct ath_hw *ah,
 {
 	struct ath_regulatory *regulatory = ath9k_hw_regulatory(ah);
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-	struct ar9300_modal_eep_header *modal_hdr;
 	u8 targetPowerValT2[ar9300RateSize];
 	u8 target_power_val_t2_eep[ar9300RateSize];
 	u8 targetPowerValT2_tpc[ar9300RateSize];
@@ -5465,17 +5463,12 @@ static void ath9k_hw_ar9300_set_txpower(struct ath_hw *ah,
 	ar9003_hw_get_target_power_eeprom(ah, chan, targetPowerValT2);
 
 	if (ar9003_is_paprd_enabled(ah)) {
-		if (IS_CHAN_2GHZ(chan))
-			modal_hdr = &eep->modalHeader2G;
-		else
-			modal_hdr = &eep->modalHeader5G;
-
 		ah->paprd_ratemask =
-			le32_to_cpu(modal_hdr->papdRateMaskHt20) &
+			ar9003_get_paprd_rate_mask_ht20(ah, IS_CHAN_2GHZ(chan)) &
 			AR9300_PAPRD_RATE_MASK;
 
 		ah->paprd_ratemask_ht40 =
-			le32_to_cpu(modal_hdr->papdRateMaskHt40) &
+			ar9003_get_paprd_rate_mask_ht40(ah, IS_CHAN_2GHZ(chan)) &
 			AR9300_PAPRD_RATE_MASK;
 
 		paprd_scale_factor = ar9003_get_paprd_scale_factor(ah, chan);
@@ -5592,23 +5585,33 @@ u8 *ar9003_get_spur_chan_ptr(struct ath_hw *ah, bool is2ghz)
 	return ar9003_modal_header(ah, is2ghz)->spurChans;
 }
 
+u32 ar9003_get_paprd_rate_mask_ht20(struct ath_hw *ah, bool is2ghz)
+{
+	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->papdRateMaskHt20);
+}
+
+u32 ar9003_get_paprd_rate_mask_ht40(struct ath_hw *ah, bool is2ghz)
+{
+	return le32_to_cpu(ar9003_modal_header(ah, is2ghz)->papdRateMaskHt40);
+}
+
 unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
 					   struct ath9k_channel *chan)
 {
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	bool is2ghz = IS_CHAN_2GHZ(chan);
 
-	if (IS_CHAN_2GHZ(chan))
-		return MS(le32_to_cpu(eep->modalHeader2G.papdRateMaskHt20),
+	if (is2ghz)
+		return MS(ar9003_get_paprd_rate_mask_ht20(ah, is2ghz),
 			  AR9300_PAPRD_SCALE_1);
 	else {
 		if (chan->channel >= 5700)
-			return MS(le32_to_cpu(eep->modalHeader5G.papdRateMaskHt20),
+			return MS(ar9003_get_paprd_rate_mask_ht20(ah, is2ghz),
 				  AR9300_PAPRD_SCALE_1);
 		else if (chan->channel >= 5400)
-			return MS(le32_to_cpu(eep->modalHeader5G.papdRateMaskHt40),
+			return MS(ar9003_get_paprd_rate_mask_ht40(ah, is2ghz),
 				  AR9300_PAPRD_SCALE_2);
 		else
-			return MS(le32_to_cpu(eep->modalHeader5G.papdRateMaskHt40),
+			return MS(ar9003_get_paprd_rate_mask_ht40(ah, is2ghz),
 				  AR9300_PAPRD_SCALE_1);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
index e8fda54ac..f8ae20318 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
@@ -363,6 +363,8 @@ u32 ar9003_hw_ant_ctrl_common_2_get(struct ath_hw *ah, bool is2ghz);
 
 u8 *ar9003_get_spur_chan_ptr(struct ath_hw *ah, bool is_2ghz);
 
+u32 ar9003_get_paprd_rate_mask_ht20(struct ath_hw *ah, bool is2ghz);
+u32 ar9003_get_paprd_rate_mask_ht40(struct ath_hw *ah, bool is2ghz);
 unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
 					   struct ath9k_channel *chan);
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
index 34e100940..b2d53b6c0 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
@@ -21,7 +21,7 @@
 void ar9003_paprd_enable(struct ath_hw *ah, bool val)
 {
 	struct ath9k_channel *chan = ah->curchan;
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
+	bool is2ghz = IS_CHAN_2GHZ(chan);
 
 	/*
 	 * 3 bits for modalHeader5G.papdRateMaskHt20
@@ -36,17 +36,17 @@ void ar9003_paprd_enable(struct ath_hw *ah, bool val)
 	 * -- disable PAPRD for lower band 5GHz
 	 */
 
-	if (IS_CHAN_5GHZ(chan)) {
+	if (!is2ghz) {
 		if (chan->channel >= UPPER_5G_SUB_BAND_START) {
-			if (le32_to_cpu(eep->modalHeader5G.papdRateMaskHt20)
+			if (ar9003_get_paprd_rate_mask_ht20(ah, is2ghz)
 								  & BIT(30))
 				val = false;
 		} else if (chan->channel >= MID_5G_SUB_BAND_START) {
-			if (le32_to_cpu(eep->modalHeader5G.papdRateMaskHt20)
+			if (ar9003_get_paprd_rate_mask_ht20(ah, is2ghz)
 								  & BIT(29))
 				val = false;
 		} else {
-			if (le32_to_cpu(eep->modalHeader5G.papdRateMaskHt20)
+			if (ar9003_get_paprd_rate_mask_ht20(ah, is2ghz)
 								  & BIT(28))
 				val = false;
 		}
-- 
2.25.1

