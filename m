Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D847CEBF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhLVJF4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:05:56 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:62064 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbhLVJFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640163955; x=1671699955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Z68mepVh0wkt6OLg4CwFPMFjoEJezoNgBadkCvzhM+Y=;
  b=aDu/iZ+qIW5q7YTmDPYKqN2OeCOHm4Hk5xe48D0IaXr1UMP31KHSCzKt
   1HbeJa/2Yk93jeOT8S81LjY4W7Yph23Nok8gjG7cgdq3qDUETyI/IiHwF
   BmgvsrgrjEKmrUsc43xUTiDpebTtwHm3huA+PBbBHEj5VTVMuNSO94bmJ
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Dec 2021 01:05:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:05:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:54 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:51 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
Subject: [PATCH 6/6] nl80211: add EHT MCS support
Date:   Wed, 22 Dec 2021 14:34:43 +0530
Message-ID: <1640163883-12696-7-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for reporting and calculating EHT bitrates.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/net/cfg80211.h       |  11 ++++
 include/uapi/linux/nl80211.h |  62 ++++++++++++++++++++
 net/wireless/nl80211.c       |  18 ++++++
 net/wireless/util.c          | 131 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index eeb2854..56ead14 100644
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
index b985cb0..76c70fc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3400,6 +3400,56 @@ enum nl80211_he_ru_alloc {
 };
 
 /**
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
+/**
  * enum nl80211_rate_info - bitrate information
  *
  * These attribute types are used with %NL80211_STA_INFO_TXRATE
@@ -3438,6 +3488,13 @@ enum nl80211_he_ru_alloc {
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
@@ -3459,6 +3516,11 @@ enum nl80211_rate_info {
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
index f31a464..10f4fc6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5946,6 +5946,13 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
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
 	}
 
 	if (rate_flg && nla_put_flag(msg, rate_flg))
@@ -5978,6 +5985,17 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
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
index 41ea65d..327257c 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1428,6 +1428,135 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
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
+		409600, /*  66.666666... */
+		204800, /*  33.333333... */
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
@@ -1442,6 +1571,8 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 		return cfg80211_calculate_bitrate_vht(rate);
 	if (rate->flags & RATE_INFO_FLAGS_HE_MCS)
 		return cfg80211_calculate_bitrate_he(rate);
+	if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
+		return cfg80211_calculate_bitrate_eht(rate);
 
 	return rate->legacy;
 }
-- 
2.7.4

