Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445BE4B5630
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356394AbiBNQaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356381AbiBNQaU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027B60AA5
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XKBZGKh+yVVXohnhFJ47laFVg0r30aaURCVK8FrwiOA=;
        t=1644856212; x=1646065812; b=U5fGHCMXgyQ7D9tunSpCdxzeUD5NuIH9rhO99YiyRVOPsEt
        /U0zrN3pSG9QBmTnyGecYlE4EgikVruw4GYeNEjgA6q/nv9++bI3ZmmDCrLqsFR5FJ+erUmC7Xh41
        FbKg8XaRgJ7C/leG/wx7aFRMxjTOC2d4QnFBR3GS3vTc19UUjCDH8VlL8g9wyM4R692qz82tBM4pQ
        2Hxp62y1BTx55v7J3jlJvcFHBiHbfjBoj1xj8gJbq3yKuzxptOXsULGlAw+wtx/icArK8p5b7Ifwn
        cbtVxOlSwDq7can0xovPbRDMDqz1kzGCtLjTPrYd8B14PsLkCJqTrM8aGt4eJ8bA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEs-0011mw-C6;
        Mon, 14 Feb 2022 17:30:10 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Subject: [PATCH v3 08/19] nl80211: add EHT MCS support
Date:   Mon, 14 Feb 2022 17:29:55 +0100
Message-Id: <20220214163009.175289-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>

Add support for reporting and calculating EHT bitrates.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Link: https://lore.kernel.org/r/1640163883-12696-7-git-send-email-quic_vjakkam@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  11 +++
 include/uapi/linux/nl80211.h |  62 +++++++++++++++++
 net/wireless/nl80211.c       |  19 +++++
 net/wireless/util.c          | 131 +++++++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a27f2d699dac..f35ffd81d213 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1595,6 +1595,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
  * @RATE_INFO_FLAGS_HE_MCS: HE MCS information
  * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
  * @RATE_INFO_FLAGS_EXTENDED_SC_DMG: 60GHz extended SC MCS
+ * @RATE_INFO_FLAGS_EHT_MCS: EHT MCS information
  */
 enum rate_info_flags {
 	RATE_INFO_FLAGS_MCS			= BIT(0),
@@ -1604,6 +1605,7 @@ enum rate_info_flags {
 	RATE_INFO_FLAGS_HE_MCS			= BIT(4),
 	RATE_INFO_FLAGS_EDMG			= BIT(5),
 	RATE_INFO_FLAGS_EXTENDED_SC_DMG		= BIT(6),
+	RATE_INFO_FLAGS_EHT_MCS			= BIT(7),
 };
 
 /**
@@ -1618,6 +1620,8 @@ enum rate_info_flags {
  * @RATE_INFO_BW_80: 80 MHz bandwidth
  * @RATE_INFO_BW_160: 160 MHz bandwidth
  * @RATE_INFO_BW_HE_RU: bandwidth determined by HE RU allocation
+ * @RATE_INFO_BW_320: 320 MHz bandwidth
+ * @RATE_INFO_BW_EHT_RU: bandwidth determined by EHT RU allocation
  */
 enum rate_info_bw {
 	RATE_INFO_BW_20 = 0,
@@ -1627,6 +1631,8 @@ enum rate_info_bw {
 	RATE_INFO_BW_80,
 	RATE_INFO_BW_160,
 	RATE_INFO_BW_HE_RU,
+	RATE_INFO_BW_320,
+	RATE_INFO_BW_EHT_RU,
 };
 
 /**
@@ -1644,6 +1650,9 @@ enum rate_info_bw {
  * @he_ru_alloc: HE RU allocation (from &enum nl80211_he_ru_alloc,
  *	only valid if bw is %RATE_INFO_BW_HE_RU)
  * @n_bonded_ch: In case of EDMG the number of bonded channels (1-4)
+ * @eht_gi: EHT guard interval (from &enum nl80211_eht_gi)
+ * @eht_ru_alloc: EHT RU allocation (from &enum nl80211_eht_ru_alloc,
+ *	only valid if bw is %RATE_INFO_BW_EHT_RU)
  */
 struct rate_info {
 	u8 flags;
@@ -1655,6 +1664,8 @@ struct rate_info {
 	u8 he_dcm;
 	u8 he_ru_alloc;
 	u8 n_bonded_ch;
+	u8 eht_gi;
+	u8 eht_ru_alloc;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9e05973f3f56..d0ba70ea5d04 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3392,6 +3392,56 @@ enum nl80211_he_ru_alloc {
 	NL80211_RATE_INFO_HE_RU_ALLOC_2x996,
 };
 
+/**
+ * enum nl80211_eht_gi - EHT guard interval
+ * @NL80211_RATE_INFO_EHT_GI_0_8: 0.8 usec
+ * @NL80211_RATE_INFO_EHT_GI_1_6: 1.6 usec
+ * @NL80211_RATE_INFO_EHT_GI_3_2: 3.2 usec
+ */
+enum nl80211_eht_gi {
+	NL80211_RATE_INFO_EHT_GI_0_8,
+	NL80211_RATE_INFO_EHT_GI_1_6,
+	NL80211_RATE_INFO_EHT_GI_3_2,
+};
+
+/**
+ * enum nl80211_eht_ru_alloc - EHT RU allocation values
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_26: 26-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_52: 52-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_52P26: 52+26-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_106: 106-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_106P26: 106+26 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_242: 242-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_484: 484-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_484P242: 484+242 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_996: 996-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_996P484: 996+484 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242: 996+484+242 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_2x996: 2x996-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484: 2x996+484 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_3x996: 3x996-tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484: 3x996+484 tone RU allocation
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC_4x996: 4x996-tone RU allocation
+ */
+enum nl80211_eht_ru_alloc {
+	NL80211_RATE_INFO_EHT_RU_ALLOC_26,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_52,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_52P26,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_106,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_106P26,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_242,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_484P242,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_996,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_996P484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_2x996,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_3x996,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484,
+	NL80211_RATE_INFO_EHT_RU_ALLOC_4x996,
+};
+
 /**
  * enum nl80211_rate_info - bitrate information
  *
@@ -3431,6 +3481,13 @@ enum nl80211_he_ru_alloc {
  * @NL80211_RATE_INFO_HE_DCM: HE DCM value (u8, 0/1)
  * @NL80211_RATE_INFO_RU_ALLOC: HE RU allocation, if not present then
  *	non-OFDMA was used (u8, see &enum nl80211_he_ru_alloc)
+ * @NL80211_RATE_INFO_320_MHZ_WIDTH: 320 MHz bitrate
+ * @NL80211_RATE_INFO_EHT_MCS: EHT MCS index (u8, 0-15)
+ * @NL80211_RATE_INFO_EHT_NSS: EHT NSS value (u8, 1-8)
+ * @NL80211_RATE_INFO_EHT_GI: EHT guard interval identifier
+ *	(u8, see &enum nl80211_eht_gi)
+ * @NL80211_RATE_INFO_EHT_RU_ALLOC: EHT RU allocation, if not present then
+ *	non-OFDMA was used (u8, see &enum nl80211_eht_ru_alloc)
  * @__NL80211_RATE_INFO_AFTER_LAST: internal use
  */
 enum nl80211_rate_info {
@@ -3452,6 +3509,11 @@ enum nl80211_rate_info {
 	NL80211_RATE_INFO_HE_GI,
 	NL80211_RATE_INFO_HE_DCM,
 	NL80211_RATE_INFO_HE_RU_ALLOC,
+	NL80211_RATE_INFO_320_MHZ_WIDTH,
+	NL80211_RATE_INFO_EHT_MCS,
+	NL80211_RATE_INFO_EHT_NSS,
+	NL80211_RATE_INFO_EHT_GI,
+	NL80211_RATE_INFO_EHT_RU_ALLOC,
 
 	/* keep last */
 	__NL80211_RATE_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 26b03d497fbc..288602c22bde 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5957,6 +5957,14 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 	case RATE_INFO_BW_HE_RU:
 		rate_flg = 0;
 		WARN_ON(!(info->flags & RATE_INFO_FLAGS_HE_MCS));
+		break;
+	case RATE_INFO_BW_320:
+		rate_flg = NL80211_RATE_INFO_320_MHZ_WIDTH;
+		break;
+	case RATE_INFO_BW_EHT_RU:
+		rate_flg = 0;
+		WARN_ON(!(info->flags & RATE_INFO_FLAGS_EHT_MCS));
+		break;
 	}
 
 	if (rate_flg && nla_put_flag(msg, rate_flg))
@@ -5989,6 +5997,17 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 		    nla_put_u8(msg, NL80211_RATE_INFO_HE_RU_ALLOC,
 			       info->he_ru_alloc))
 			return false;
+	} else if (info->flags & RATE_INFO_FLAGS_EHT_MCS) {
+		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_MCS, info->mcs))
+			return false;
+		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_NSS, info->nss))
+			return false;
+		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_GI, info->eht_gi))
+			return false;
+		if (info->bw == RATE_INFO_BW_EHT_RU &&
+		    nla_put_u8(msg, NL80211_RATE_INFO_EHT_RU_ALLOC,
+			       info->eht_ru_alloc))
+			return false;
 	}
 
 	nla_nest_end(msg, rate);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index e02f1702806e..2eda097aee7f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1430,6 +1430,135 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	return result / 10000;
 }
 
+static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
+{
+#define SCALE 6144
+	static const u32 mcs_divisors[16] = {
+		102399, /* 16.666666... */
+		 51201, /*  8.333333... */
+		 34134, /*  5.555555... */
+		 25599, /*  4.166666... */
+		 17067, /*  2.777777... */
+		 12801, /*  2.083333... */
+		 11769, /*  1.851851... */
+		 10239, /*  1.666666... */
+		  8532, /*  1.388888... */
+		  7680, /*  1.250000... */
+		  6828, /*  1.111111... */
+		  6144, /*  1.000000... */
+		  5690, /*  0.926106... */
+		  5120, /*  0.833333... */
+		409600, /* 66.666666... */
+		204800, /* 33.333333... */
+	};
+	static const u32 rates_996[3] =  { 480388888, 453700000, 408333333 };
+	static const u32 rates_484[3] =  { 229411111, 216666666, 195000000 };
+	static const u32 rates_242[3] =  { 114711111, 108333333,  97500000 };
+	static const u32 rates_106[3] =  {  40000000,  37777777,  34000000 };
+	static const u32 rates_52[3]  =  {  18820000,  17777777,  16000000 };
+	static const u32 rates_26[3]  =  {   9411111,   8888888,   8000000 };
+	u64 tmp;
+	u32 result;
+
+	if (WARN_ON_ONCE(rate->mcs > 15))
+		return 0;
+	if (WARN_ON_ONCE(rate->eht_gi > NL80211_RATE_INFO_EHT_GI_3_2))
+		return 0;
+	if (WARN_ON_ONCE(rate->eht_ru_alloc >
+			 NL80211_RATE_INFO_EHT_RU_ALLOC_4x996))
+		return 0;
+	if (WARN_ON_ONCE(rate->nss < 1 || rate->nss > 8))
+		return 0;
+
+	/* Bandwidth checks for MCS 14 */
+	if (rate->mcs == 14) {
+		if ((rate->bw != RATE_INFO_BW_EHT_RU &&
+		     rate->bw != RATE_INFO_BW_80 &&
+		     rate->bw != RATE_INFO_BW_160 &&
+		     rate->bw != RATE_INFO_BW_320) ||
+		    (rate->bw == RATE_INFO_BW_EHT_RU &&
+		     rate->eht_ru_alloc != NL80211_RATE_INFO_EHT_RU_ALLOC_996 &&
+		     rate->eht_ru_alloc != NL80211_RATE_INFO_EHT_RU_ALLOC_2x996 &&
+		     rate->eht_ru_alloc != NL80211_RATE_INFO_EHT_RU_ALLOC_4x996)) {
+			WARN(1, "invalid EHT BW for MCS 14: bw:%d, ru:%d\n",
+			     rate->bw, rate->eht_ru_alloc);
+			return 0;
+		}
+	}
+
+	if (rate->bw == RATE_INFO_BW_320 ||
+	    (rate->bw == RATE_INFO_BW_EHT_RU &&
+	     rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_4x996))
+		result = 4 * rates_996[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484)
+		result = 3 * rates_996[rate->eht_gi] + rates_484[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_3x996)
+		result = 3 * rates_996[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484)
+		result = 2 * rates_996[rate->eht_gi] + rates_484[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_160 ||
+		 (rate->bw == RATE_INFO_BW_EHT_RU &&
+		  rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_2x996))
+		result = 2 * rates_996[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc ==
+		 NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242)
+		result = rates_996[rate->eht_gi] + rates_484[rate->eht_gi]
+			 + rates_242[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_996P484)
+		result = rates_996[rate->eht_gi] + rates_484[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_80 ||
+		 (rate->bw == RATE_INFO_BW_EHT_RU &&
+		  rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_996))
+		result = rates_996[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_484P242)
+		result = rates_484[rate->eht_gi] + rates_242[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_40 ||
+		 (rate->bw == RATE_INFO_BW_EHT_RU &&
+		  rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_484))
+		result = rates_484[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_20 ||
+		 (rate->bw == RATE_INFO_BW_EHT_RU &&
+		  rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_242))
+		result = rates_242[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_106P26)
+		result = rates_106[rate->eht_gi] + rates_26[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_106)
+		result = rates_106[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_52P26)
+		result = rates_52[rate->eht_gi] + rates_26[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_52)
+		result = rates_52[rate->eht_gi];
+	else if (rate->bw == RATE_INFO_BW_EHT_RU &&
+		 rate->eht_ru_alloc == NL80211_RATE_INFO_EHT_RU_ALLOC_26)
+		result = rates_26[rate->eht_gi];
+	else {
+		WARN(1, "invalid EHT MCS: bw:%d, ru:%d\n",
+		     rate->bw, rate->eht_ru_alloc);
+		return 0;
+	}
+
+	/* now scale to the appropriate MCS */
+	tmp = result;
+	tmp *= SCALE;
+	do_div(tmp, mcs_divisors[rate->mcs]);
+	result = tmp;
+
+	/* and take NSS */
+	result = (result * rate->nss) / 8;
+
+	return result / 10000;
+}
+
 u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 {
 	if (rate->flags & RATE_INFO_FLAGS_MCS)
@@ -1444,6 +1573,8 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 		return cfg80211_calculate_bitrate_vht(rate);
 	if (rate->flags & RATE_INFO_FLAGS_HE_MCS)
 		return cfg80211_calculate_bitrate_he(rate);
+	if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
+		return cfg80211_calculate_bitrate_eht(rate);
 
 	return rate->legacy;
 }
-- 
2.34.1

