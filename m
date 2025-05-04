Return-Path: <linux-wireless+bounces-22391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77733AA85F4
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36993BA163
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C31A3174;
	Sun,  4 May 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCdtmYEY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1591A83E8
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354420; cv=none; b=h8tq+7Tbwbfl9UzuvsY/ZE+MQ0CGL5TANS/0FcjFWrn01a2i3WH0O9xYfV4x27oYFPd8eV8iUyiBi958tcRb614UBUVUcK4acDWGau09pb052uppfZAEA4meIx9V0zRTwW9nzSxoxO3zqGMxhD2146Buwvev4BmuWCBW2tJp9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354420; c=relaxed/simple;
	bh=UyGObhAV3htOj9Q+YKf288la8+hJ92jnavx2LHM8FYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYjBKHPI/QseQyWM5y5lPWGcf352jirREwfZRyFCI6xCHLYeqNaMxUfK0h4xfOBT4n2kN15jIlyUMTpdDkGc7hin/B/3Z/poJTpCNcvzV02i9narJK5fHqyu6riuSO/v4fMvmVSbrwb90SHwhmdbnMVkmJFGNGZnT16MlyXcH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCdtmYEY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354418; x=1777890418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UyGObhAV3htOj9Q+YKf288la8+hJ92jnavx2LHM8FYg=;
  b=bCdtmYEY+7zMSdwHdDPTu+BqIcERBW8uS2Nzjtg7pXolyOiM5TPQhSTO
   +Of2Q/AD89uAVyszBNSB62LF5fqEqzPpkiY0iPD/fcjXjs7jZ97PjUYjY
   2kFf7BF6EOyXNQrHQgv+3Go2Z+3Nl+cpQS9JFOVUGYgoQKqkV1R0RBcUb
   nLnNbo4UhvgmQh3gVZlVJMPnX8gpciSevR7RQHl2cI2vOwADhoZKaSH7p
   /o+Swik6sam3I2QuMyc/XtWKOhacWsEyMaUgYzSeF6hMwQNvgKP0kCVNk
   7LTQKh2QifM8yjW4sb5JongnKOAhHxoqNsrGYYBEoIwGAPzq6Jef5qq6A
   g==;
X-CSE-ConnectionGUID: zYfviDooRX+HXRUIH0fkuQ==
X-CSE-MsgGUID: iGgk61sCQP+paL7QMnQPFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511488"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511488"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:58 -0700
X-CSE-ConnectionGUID: hiYTm0V3R76uWX6DZ1Hktg==
X-CSE-MsgGUID: jV+mCf9aTjiALxvr7P3p0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778875"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: rename modulation type values
Date: Sun,  4 May 2025 13:26:21 +0300
Message-Id: <20250504132447.aa79635dd4e6.Ie97a01fee1ef4aedf8a2e5447489793ce8c15ca0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The modulation type values aren't masks, they're just values.
Rename them from RATE_MCS_CCK_* to RATE_MCS_MOD_TYPE_*.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 12 +++---
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 42 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 28 ++++++-------
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 15 +++----
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 10 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 16 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 32 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 18 ++++----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  4 +-
 10 files changed, 94 insertions(+), 85 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index df176191d659..86a265aa7e25 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -556,12 +556,12 @@ enum {
  */
 #define RATE_MCS_MOD_TYPE_POS		8
 #define RATE_MCS_MOD_TYPE_MSK		(0x7 << RATE_MCS_MOD_TYPE_POS)
-#define RATE_MCS_CCK_MSK		(0 << RATE_MCS_MOD_TYPE_POS)
-#define RATE_MCS_LEGACY_OFDM_MSK	(1 << RATE_MCS_MOD_TYPE_POS)
-#define RATE_MCS_HT_MSK			(2 << RATE_MCS_MOD_TYPE_POS)
-#define RATE_MCS_VHT_MSK		(3 << RATE_MCS_MOD_TYPE_POS)
-#define RATE_MCS_HE_MSK			(4 << RATE_MCS_MOD_TYPE_POS)
-#define RATE_MCS_EHT_MSK		(5 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_MOD_TYPE_CCK		(0 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_MOD_TYPE_LEGACY_OFDM	(1 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_MOD_TYPE_HT		(2 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_MOD_TYPE_VHT		(3 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_MOD_TYPE_HE		(4 << RATE_MCS_MOD_TYPE_POS)
+#define RATE_MCS_MOD_TYPE_EHT		(5 << RATE_MCS_MOD_TYPE_POS)
 
 /*
  * Legacy CCK rate format for bits 0:3:
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index 9e5603774637..326c2623d076 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -116,7 +116,7 @@ u32 iwl_new_rate_from_v1(u32 rate_v1)
 	if (rate_v1 & RATE_MCS_HT_MSK_V1) {
 		u32 nss = 0;
 
-		rate_v2 |= RATE_MCS_HT_MSK;
+		rate_v2 |= RATE_MCS_MOD_TYPE_HT;
 		rate_v2 |=
 			rate_v1 & RATE_HT_MCS_RATE_CODE_MSK_V1;
 		nss = (rate_v1 & RATE_HT_MCS_MIMO2_MSK) >>
@@ -150,9 +150,9 @@ u32 iwl_new_rate_from_v1(u32 rate_v1)
 			rate_v2 |= he_type << RATE_MCS_HE_TYPE_POS;
 			rate_v2 |= he_106t << RATE_MCS_HE_106T_POS;
 			rate_v2 |= rate_v1 & RATE_HE_DUAL_CARRIER_MODE_MSK;
-			rate_v2 |= RATE_MCS_HE_MSK;
+			rate_v2 |= RATE_MCS_MOD_TYPE_HE;
 		} else {
-			rate_v2 |= RATE_MCS_VHT_MSK;
+			rate_v2 |= RATE_MCS_MOD_TYPE_VHT;
 		}
 	/* if legacy format */
 	} else {
@@ -164,7 +164,7 @@ u32 iwl_new_rate_from_v1(u32 rate_v1)
 
 		rate_v2 |= legacy_rate;
 		if (!(rate_v1 & RATE_MCS_CCK_MSK_V1))
-			rate_v2 |= RATE_MCS_LEGACY_OFDM_MSK;
+			rate_v2 |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
 	}
 
 	/* convert flags */
@@ -197,36 +197,40 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	u32 bw = (rate & RATE_MCS_CHAN_WIDTH_MSK) >>
 		RATE_MCS_CHAN_WIDTH_POS;
 	u32 format = rate & RATE_MCS_MOD_TYPE_MSK;
+	int index = 0;
 	bool sgi;
 
-	if (format == RATE_MCS_CCK_MSK ||
-	    format == RATE_MCS_LEGACY_OFDM_MSK) {
-		int legacy_rate = rate & RATE_LEGACY_RATE_MSK;
-		int index = format == RATE_MCS_CCK_MSK ?
-			legacy_rate :
-			legacy_rate + IWL_FIRST_OFDM_RATE;
+	switch (format) {
+	case RATE_MCS_MOD_TYPE_LEGACY_OFDM:
+		index = IWL_FIRST_OFDM_RATE;
+		fallthrough;
+	case RATE_MCS_MOD_TYPE_CCK:
+		index += rate & RATE_LEGACY_RATE_MSK;
 
 		return scnprintf(buf, bufsz, "Legacy | ANT: %s Rate: %s Mbps",
 				 iwl_rs_pretty_ant(ant),
 				 iwl_rate_mcs(index)->mbps);
-	}
-
-	if (format ==  RATE_MCS_VHT_MSK)
+	case RATE_MCS_MOD_TYPE_VHT:
 		type = "VHT";
-	else if (format ==  RATE_MCS_HT_MSK)
+		break;
+	case RATE_MCS_MOD_TYPE_HT:
 		type = "HT";
-	else if (format == RATE_MCS_HE_MSK)
+		break;
+	case RATE_MCS_MOD_TYPE_HE:
 		type = "HE";
-	else if (format == RATE_MCS_EHT_MSK)
+		break;
+	case RATE_MCS_MOD_TYPE_EHT:
 		type = "EHT";
-	else
+		break;
+	default:
 		type = "Unknown"; /* shouldn't happen */
+	}
 
-	mcs = format == RATE_MCS_HT_MSK ?
+	mcs = format == RATE_MCS_MOD_TYPE_HT ?
 		RATE_HT_MCS_INDEX(rate) :
 		rate & RATE_MCS_CODE_MSK;
 	nss = u32_get_bits(rate, RATE_MCS_NSS_MSK);
-	sgi = format == RATE_MCS_HE_MSK ?
+	sgi = format == RATE_MCS_MOD_TYPE_HE ?
 		iwl_he_is_sgi(rate) :
 		rate & RATE_MCS_SGI_MSK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 7007a43bca4d..0e4cc90fb6fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -410,7 +410,7 @@ iwl_mld_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
 	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK;
 	bool is_lb = band == NL80211_BAND_2GHZ;
 
-	if (format == RATE_MCS_LEGACY_OFDM_MSK)
+	if (format == RATE_MCS_MOD_TYPE_LEGACY_OFDM)
 		return is_lb ? rate + IWL_FIRST_OFDM_RATE : rate;
 
 	/* CCK is not allowed in 5 GHz */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 307e2bd622e3..d95603e6ac78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1176,7 +1176,7 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
 
 	/* set the preamble flag if appropriate */
-	if (format == RATE_MCS_CCK_MSK &&
+	if (format == RATE_MCS_MOD_TYPE_CCK &&
 	    phy_data->phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
 
@@ -1201,7 +1201,7 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 	}
 
 	/* must be before L-SIG data */
-	if (format == RATE_MCS_HE_MSK)
+	if (format == RATE_MCS_MOD_TYPE_HE)
 		iwl_mld_rx_he(mld, skb, phy_data, queue);
 
 	iwl_mld_decode_lsig(skb, phy_data);
@@ -1209,7 +1209,7 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 	rx_status->device_timestamp = phy_data->gp2_on_air_rise;
 
 	/* using TLV format and must be after all fixed len fields */
-	if (format == RATE_MCS_EHT_MSK)
+	if (format == RATE_MCS_MOD_TYPE_EHT)
 		iwl_mld_rx_eht(mld, skb, phy_data, queue);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -1217,28 +1217,28 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 		iwl_mld_add_rtap_sniffer_config(mld, skb);
 #endif
 
-	if (format != RATE_MCS_CCK_MSK && is_sgi)
+	if (format != RATE_MCS_MOD_TYPE_CCK && is_sgi)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 
 	if (rate_n_flags & RATE_MCS_LDPC_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
 
 	switch (format) {
-	case RATE_MCS_HT_MSK:
+	case RATE_MCS_MOD_TYPE_HT:
 		rx_status->encoding = RX_ENC_HT;
 		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		break;
-	case RATE_MCS_VHT_MSK:
-	case RATE_MCS_HE_MSK:
-	case RATE_MCS_EHT_MSK:
-		if (format == RATE_MCS_VHT_MSK) {
+	case RATE_MCS_MOD_TYPE_VHT:
+	case RATE_MCS_MOD_TYPE_HE:
+	case RATE_MCS_MOD_TYPE_EHT:
+		if (format == RATE_MCS_MOD_TYPE_VHT) {
 			rx_status->encoding = RX_ENC_VHT;
-		} else if (format == RATE_MCS_HE_MSK) {
+		} else if (format == RATE_MCS_MOD_TYPE_HE) {
 			rx_status->encoding = RX_ENC_HE;
 			rx_status->he_dcm =
 				!!(rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK);
-		} else if (format == RATE_MCS_EHT_MSK) {
+		} else if (format == RATE_MCS_MOD_TYPE_EHT) {
 			rx_status->encoding = RX_ENC_EHT;
 		}
 
@@ -2032,17 +2032,17 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 	 * may be up to 8 spatial streams.
 	 */
 	switch (format) {
-	case RATE_MCS_VHT_MSK:
+	case RATE_MCS_MOD_TYPE_VHT:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK) + 1;
 		break;
-	case RATE_MCS_HE_MSK:
+	case RATE_MCS_MOD_TYPE_HE:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_HE_NSTS_MSK) + 1;
 		break;
-	case RATE_MCS_EHT_MSK:
+	case RATE_MCS_MOD_TYPE_EHT:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[2],
 				      RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK) + 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 360a6bfbbfb2..f633cb1cf510 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -191,11 +191,12 @@ static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
 		break;
 	}
 
-	if (format == RATE_MCS_CCK_MSK || format == RATE_MCS_LEGACY_OFDM_MSK) {
+	if (format == RATE_MCS_MOD_TYPE_CCK ||
+	    format == RATE_MCS_MOD_TYPE_LEGACY_OFDM) {
 		int rate = u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK);
 
 		/* add the offset needed to get to the legacy ofdm indices */
-		if (format == RATE_MCS_LEGACY_OFDM_MSK)
+		if (format == RATE_MCS_MOD_TYPE_LEGACY_OFDM)
 			rate += IWL_FIRST_OFDM_RATE;
 
 		switch (rate) {
@@ -240,7 +241,7 @@ static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
 
 	rinfo->nss = u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1;
 
-	if (format == RATE_MCS_HT_MSK)
+	if (format == RATE_MCS_MOD_TYPE_HT)
 		rinfo->mcs = RATE_HT_MCS_INDEX(rate_n_flags);
 	else
 		rinfo->mcs = u32_get_bits(rate_n_flags, RATE_MCS_CODE_MSK);
@@ -249,10 +250,10 @@ static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
 		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
 
 	switch (format) {
-	case RATE_MCS_EHT_MSK:
+	case RATE_MCS_MOD_TYPE_EHT:
 		rinfo->flags |= RATE_INFO_FLAGS_EHT_MCS;
 		break;
-	case RATE_MCS_HE_MSK:
+	case RATE_MCS_MOD_TYPE_HE:
 		gi_ltf = u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK);
 
 		rinfo->flags |= RATE_INFO_FLAGS_HE_MCS;
@@ -293,10 +294,10 @@ static void iwl_mld_sta_stats_fill_txrate(struct iwl_mld_sta *mld_sta,
 		if (rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK)
 			rinfo->he_dcm = 1;
 		break;
-	case RATE_MCS_HT_MSK:
+	case RATE_MCS_MOD_TYPE_HT:
 		rinfo->flags |= RATE_INFO_FLAGS_MCS;
 		break;
-	case RATE_MCS_VHT_MSK:
+	case RATE_MCS_MOD_TYPE_VHT:
 		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
 		break;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 208c17d67270..a6e312b1edbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -391,9 +391,9 @@ static u32 iwl_mld_mac80211_rate_idx_to_fw(struct iwl_mld *mld,
 
 	/* Set CCK or OFDM flag */
 	if (rate_idx <= IWL_LAST_CCK_RATE)
-		rate_flags |= RATE_MCS_CCK_MSK;
+		rate_flags |= RATE_MCS_MOD_TYPE_CCK;
 	else
-		rate_flags |= RATE_MCS_LEGACY_OFDM_MSK;
+		rate_flags |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
 
 	/* Legacy rates are indexed:
 	 * 0 - 3 for CCK and 0 - 7 for OFDM
@@ -1008,18 +1008,18 @@ static void iwl_mld_hwrate_to_tx_rate(u32 rate_n_flags,
 	}
 
 	switch (format) {
-	case RATE_MCS_HT_MSK:
+	case RATE_MCS_MOD_TYPE_HT:
 		tx_rate->flags |= IEEE80211_TX_RC_MCS;
 		tx_rate->idx = RATE_HT_MCS_INDEX(rate_n_flags);
 		break;
-	case RATE_MCS_VHT_MSK:
+	case RATE_MCS_MOD_TYPE_VHT:
 		ieee80211_rate_set_vht(tx_rate,
 				       rate_n_flags & RATE_MCS_CODE_MSK,
 				       FIELD_GET(RATE_MCS_NSS_MSK,
 						 rate_n_flags) + 1);
 		tx_rate->flags |= IEEE80211_TX_RC_VHT_MCS;
 		break;
-	case RATE_MCS_HE_MSK:
+	case RATE_MCS_MOD_TYPE_HE:
 		/* mac80211 cannot do this without ieee80211_tx_status_ext()
 		 * but it only matters for radiotap
 		 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fbd16d61d599..d15031f9f38c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6070,12 +6070,12 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		break;
 	}
 
-	if (format == RATE_MCS_CCK_MSK ||
-	    format == RATE_MCS_LEGACY_OFDM_MSK) {
+	if (format == RATE_MCS_MOD_TYPE_CCK ||
+	    format == RATE_MCS_MOD_TYPE_LEGACY_OFDM) {
 		int rate = u32_get_bits(rate_n_flags, RATE_LEGACY_RATE_MSK);
 
 		/* add the offset needed to get to the legacy ofdm indices */
-		if (format == RATE_MCS_LEGACY_OFDM_MSK)
+		if (format == RATE_MCS_MOD_TYPE_LEGACY_OFDM)
 			rate += IWL_FIRST_OFDM_RATE;
 
 		switch (rate) {
@@ -6120,7 +6120,7 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 
 	rinfo->nss = u32_get_bits(rate_n_flags,
 				  RATE_MCS_NSS_MSK) + 1;
-	rinfo->mcs = format == RATE_MCS_HT_MSK ?
+	rinfo->mcs = format == RATE_MCS_MOD_TYPE_HT ?
 		RATE_HT_MCS_INDEX(rate_n_flags) :
 		u32_get_bits(rate_n_flags, RATE_MCS_CODE_MSK);
 
@@ -6128,11 +6128,11 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
 
 	switch (format) {
-	case RATE_MCS_EHT_MSK:
+	case RATE_MCS_MOD_TYPE_EHT:
 		/* TODO: GI/LTF/RU. How does the firmware encode them? */
 		rinfo->flags |= RATE_INFO_FLAGS_EHT_MCS;
 		break;
-	case RATE_MCS_HE_MSK:
+	case RATE_MCS_MOD_TYPE_HE:
 		gi_ltf = u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK);
 
 		rinfo->flags |= RATE_INFO_FLAGS_HE_MCS;
@@ -6173,10 +6173,10 @@ static void iwl_mvm_set_sta_rate(u32 rate_n_flags, struct rate_info *rinfo)
 		if (rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK)
 			rinfo->he_dcm = 1;
 		break;
-	case RATE_MCS_HT_MSK:
+	case RATE_MCS_MOD_TYPE_HT:
 		rinfo->flags |= RATE_INFO_FLAGS_MCS;
 		break;
-	case RATE_MCS_VHT_MSK:
+	case RATE_MCS_MOD_TYPE_VHT:
 		rinfo->flags |= RATE_INFO_FLAGS_VHT_MCS;
 		break;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 358643ae0e42..1cc35c82c392 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1944,7 +1944,7 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 	}
 
 	/* must be before L-SIG data */
-	if (format == RATE_MCS_HE_MSK)
+	if (format == RATE_MCS_MOD_TYPE_HE)
 		iwl_mvm_rx_he(mvm, skb, phy_data, queue);
 
 	iwl_mvm_decode_lsig(skb, phy_data);
@@ -1966,45 +1966,45 @@ static void iwl_mvm_rx_fill_status(struct iwl_mvm *mvm,
 				    phy_data->energy_a, phy_data->energy_b);
 
 	/* using TLV format and must be after all fixed len fields */
-	if (format == RATE_MCS_EHT_MSK)
+	if (format == RATE_MCS_MOD_TYPE_EHT)
 		iwl_mvm_rx_eht(mvm, skb, phy_data, queue);
 
 	if (unlikely(mvm->monitor_on))
 		iwl_mvm_add_rtap_sniffer_config(mvm, skb);
 
-	is_sgi = format == RATE_MCS_HE_MSK ?
+	is_sgi = format == RATE_MCS_MOD_TYPE_HE ?
 		iwl_he_is_sgi(rate_n_flags) :
 		rate_n_flags & RATE_MCS_SGI_MSK;
 
-	if (!(format == RATE_MCS_CCK_MSK) && is_sgi)
+	if (!(format == RATE_MCS_MOD_TYPE_CCK) && is_sgi)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 
 	if (rate_n_flags & RATE_MCS_LDPC_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
 
 	switch (format) {
-	case RATE_MCS_VHT_MSK:
+	case RATE_MCS_MOD_TYPE_VHT:
 		rx_status->encoding = RX_ENC_VHT;
 		break;
-	case RATE_MCS_HE_MSK:
+	case RATE_MCS_MOD_TYPE_HE:
 		rx_status->encoding = RX_ENC_HE;
 		rx_status->he_dcm =
 			!!(rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK);
 		break;
-	case RATE_MCS_EHT_MSK:
+	case RATE_MCS_MOD_TYPE_EHT:
 		rx_status->encoding = RX_ENC_EHT;
 		break;
 	}
 
 	switch (format) {
-	case RATE_MCS_HT_MSK:
+	case RATE_MCS_MOD_TYPE_HT:
 		rx_status->encoding = RX_ENC_HT;
 		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
 		break;
-	case RATE_MCS_VHT_MSK:
-	case RATE_MCS_HE_MSK:
-	case RATE_MCS_EHT_MSK:
+	case RATE_MCS_MOD_TYPE_VHT:
+	case RATE_MCS_MOD_TYPE_HE:
+	case RATE_MCS_MOD_TYPE_EHT:
 		rx_status->nss =
 			u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
@@ -2138,7 +2138,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	/* set the preamble flag if appropriate */
-	if (format == RATE_MCS_CCK_MSK &&
+	if (format == RATE_MCS_MOD_TYPE_CCK &&
 	    phy_data.phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
 
@@ -2412,7 +2412,7 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		phy_data.rx_vec[2] = desc->rx_vec[2];
 		phy_data.rx_vec[3] = desc->rx_vec[3];
 	} else {
-		if (format == RATE_MCS_EHT_MSK)
+		if (format == RATE_MCS_MOD_TYPE_EHT)
 			/* no support for EHT before version 3 API */
 			return;
 	}
@@ -2473,17 +2473,17 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	 * may be up to 8 spatial streams.
 	 */
 	switch (format) {
-	case RATE_MCS_VHT_MSK:
+	case RATE_MCS_MOD_TYPE_VHT:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK) + 1;
 		break;
-	case RATE_MCS_HE_MSK:
+	case RATE_MCS_MOD_TYPE_HE:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[0],
 				      RX_NO_DATA_RX_VEC0_HE_NSTS_MSK) + 1;
 		break;
-	case RATE_MCS_EHT_MSK:
+	case RATE_MCS_MOD_TYPE_EHT:
 		rx_status->nss =
 			le32_get_bits(desc->rx_vec[2],
 				      RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK) + 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 14f9daad4757..ee4b5cfc57d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -285,9 +285,9 @@ static u32 iwl_mvm_convert_rate_idx(struct iwl_mvm *mvm,
 	/* Set CCK or OFDM flag */
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, TX_CMD, 0) > 8) {
 		if (!is_cck)
-			rate_flags |= RATE_MCS_LEGACY_OFDM_MSK;
+			rate_flags |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
 		else
-			rate_flags |= RATE_MCS_CCK_MSK;
+			rate_flags |= RATE_MCS_MOD_TYPE_CCK;
 	} else if (is_cck) {
 		rate_flags |= RATE_MCS_CCK_MSK_V1;
 	}
@@ -1467,7 +1467,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 			       struct ieee80211_tx_rate *r)
 {
 	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
-	u32 rate = format == RATE_MCS_HT_MSK ?
+	u32 rate = format == RATE_MCS_MOD_TYPE_HT ?
 		RATE_HT_MCS_INDEX(rate_n_flags) :
 		rate_n_flags & RATE_MCS_CODE_MSK;
 
@@ -1477,19 +1477,23 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 
 	if (rate_n_flags & RATE_MCS_SGI_MSK)
 		r->flags |= IEEE80211_TX_RC_SHORT_GI;
-	if (format ==  RATE_MCS_HT_MSK) {
+	switch (format) {
+	case RATE_MCS_MOD_TYPE_HT:
 		r->flags |= IEEE80211_TX_RC_MCS;
 		r->idx = rate;
-	} else if (format ==  RATE_MCS_VHT_MSK) {
+		break;
+	case RATE_MCS_MOD_TYPE_VHT:
 		ieee80211_rate_set_vht(r, rate,
 				       FIELD_GET(RATE_MCS_NSS_MSK,
 						 rate_n_flags) + 1);
 		r->flags |= IEEE80211_TX_RC_VHT_MCS;
-	} else if (format == RATE_MCS_HE_MSK) {
+		break;
+	case RATE_MCS_MOD_TYPE_HE:
 		/* mac80211 cannot do this without ieee80211_tx_status_ext()
 		 * but it only matters for radiotap */
 		r->idx = 0;
-	} else {
+		break;
+	default:
 		r->idx = iwl_mvm_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
 							       band);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index dd890dcd1505..33be79e8cd1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -142,7 +142,7 @@ int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
 	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK;
 	bool is_LB = band == NL80211_BAND_2GHZ;
 
-	if (format == RATE_MCS_LEGACY_OFDM_MSK)
+	if (format == RATE_MCS_MOD_TYPE_LEGACY_OFDM)
 		return is_LB ? rate + IWL_FIRST_OFDM_RATE :
 			rate;
 
-- 
2.34.1


